//9/18/2020: lines 109,335,547,757; to fix that spells were losing their first week.

/*	Join different SIPP*/
clear all
/*
cd "C:\Users\Kyle\OneDrive\Minimum Wage\SIPP"

cd "C:\Users\ksc91\OneDrive\Minimum Wage\SIPP"

*/
cd "C:\Users\gdvia\OneDrive\PhD\Research\Minimum Wage\SIPP"

/*takes about 70 minutes*/
timer on 1

import excel using unemployment.xlsx, sh("Sheet1") first clear
save "unemployment", replace


/*Set the 2001 sample*/

use "2001/long_2001.dta",clear

drop pid
// mpid is used to store the maximum pid generated so far. It is intialized to 
// 0 and replace with the maximum pid after each rotation for each panel year
	gen mpid=0
rename tfipsst state
gen hours=ejbhrs1*rmwkwjb
//duplicates drop

gen ave_hwage=tpyrate1
replace ave_hwage=tpearn/(rmwkwjb*hours) if ave_hwage==0 & rmesr==1 & ejobcntr>0
replace ave_hwage=tpearn/(2*rmwkwjb*hours) if ave_hwage==0 & rmesr>=2 & rmesr<=5 & ejobcntr>0
gen income=tpearn
replace income=tpyrate1*(rmwkwjb*hours) if tpearn==0 & rmesr==1 & ejobcntr>0
replace income=tpyrate1*rmwkwjb*hours/2 if ave_hwage==0 & rmesr>=2 & rmesr<=5 & ejobcntr>0

//Create UI eligibility variable
gen ui_elig=0
replace ui_elig=1 if ersend1>1 & ersend1<9
replace ui_elig=1 if ersend1>11

//save file for 2001 panel
save "spells01",replace

// get the set of levels for srotation (should be 4 for each panel year)
levelsof srotaton

//loop over the 4 different values of rotation (srotaton) for 2001
foreach lev in `r(levels)'{

keep if srotaton==`lev'
//keep if srotaton==1. Date corresponds to the date at the time the observation
//is taken. Since dead=1 at the end of the spell, we have the date at the end.
drop if week>rwksperm

egen date=group(year month week)

egen pid=group(srotaton ssuid epppnum)
// add mpid so that the new pid's are distinct from the previous rotations
replace pid=pid+mpid
drop mpid
egen mpid=max(pid)

//Some cases lost because of state: "Maine, Vermont"; a"North Dakota, South Dakota, Wyoming"
merge m:1 state year month using "mw_monthly.dta",keepusing(min_mw)
rename min_mw mw
keep if _merge==3
drop _merge

merge m:1 state year month using "unemployment.dta", keepusing(unemp)
keep if _merge==3
sort pid date
drop _merge


gen looking = 0
replace looking =1 if rwkesr>=4

gen spell= looking
tsset pid date
replace spell = cond(L.spell==.,1, L.spell+1) if looking==1

gen spell_id2=0
replace spell_id2=1 if spell==1
tsset pid date
by pid: gen spell_id=sum(spell_id2[_n-1])
replace spell_id=0 if spell==0
replace spell_id=spell_id+spell_id2 if spell_id2==1
drop spell_id2

/*Identify movers*/
bysort pid: egen mover=mean(state)
replace mover=4 if mover!=state
replace mover=0 if mover==state

/*Want to know whether people were mostly looking or mostly out of LF*/

egen uniq_spl_id=group(pid spell_id)
replace uniq_spl_id=. if spell==0

bysort uniq_spl_id: egen min4=min(spell) if rwkesr==4
replace min4=0 if min4==.
bysort uniq_spl_id: egen min42=max(min4)
replace spell=spell-min42+1
replace spell=0 if spell<0
replace spell=0 if rwkesr<4
replace uniq_spl_id=0 if spell==0
replace spell_id=0 if spell==0
drop min4 min42

bysort uniq_spl_id: egen max4=max(spell) if rwkesr==4
replace max4=0 if max4==.
bysort uniq_spl_id: egen lastlook=max(max4)
drop max4

bysort uniq_spl_id: egen mean_srch=mean(rwkesr)
replace mean_srch=0 if spell_id==0

gen cut_srch=0
replace cut_srch=1 if spell>=10
gen end_rwkesr=rwkesr*cut_srch

bysort uniq_spl_id: egen mean_srch_aftmode=mean(end_rwkesr)
replace end_rwkesr=0 if spell_id==0

drop cut_srch end_rwkesr

/*Identify spell lengths*/

bysort uniq_spl_id: egen spell_length=max(spell)

gen cut_srch=0
replace cut_srch=1 if spell>=spell_length/2
gen end_rwkesr=rwkesr*cut_srch

bysort uniq_spl_id: egen mean_srch_2half=mean(end_rwkesr)
replace end_rwkesr=0 if spell_id==0
drop cut_srch end_rwkesr

//Divorce or Separation:
bysort pid: egen divorced2=min(date) if ems>=4 & ems<=5
replace divorced2=0 if divorced2==.
bysort pid: egen divorced=max(divorced2)
drop divorced2


//Total time not working:

gen notwk=0
replace notwk=1 if rwkesr==4 | rwkesr==5
bysort pid: gen ttnotwk=sum(notwk)
drop notwk

tsset pid date
gen dead=0
bysort pid: replace dead=1 if F.spell==0 & spell>0

/*Identify spells for which mw changes*/

bysort uniq_spl_id: egen min_mw=min(mw)
bysort uniq_spl_id: egen max_mw=max(mw)

gen delta_mw=100*max_mw/min_mw-100
replace delta_mw=0 if spell==0

/*Generate hourly wage variables*/

tsset pid date
bysort pid: gen hwage = cond(ave_hwage==0,L.ave_hwage,ave_hwage)
gen time_delta2=0
bysort pid: replace time_delta2=cond(L.mw!=mw,spell,L.time_delta2)
replace time_delta2=300 if time_delta2==0
bysort pid: egen time_delta=min(time_delta2)
drop time_delta2

tsset pid date
bysort pid: gen last_wage = cond(hwage==0,L.hwage,hwage)
bysort pid: replace last_wage = cond(last_wage==0 | last_wage==.,L.last_wage,last_wage)
bysort pid: gen next_wage = cond(hwage==0,F.hwage,hwage)
local i=1
while `i'<100{
bysort pid: replace next_wage = cond(next_wage==0 | next_wage==.,F.next_wage,next_wage)
local i=`i'+1
}

//Generate Hours variables
gen weekly_hours = hours/rwksperm

bysort pid: gen next_hours = cond(weekly_hours==0,F.weekly_hours,weekly_hours)
local i=1
while `i'<100{
bysort pid: replace next_hours = cond(next_hours==0 | next_hours==.,F.next_hours,next_hours)
local i=`i'+1
}

forval i=4 8:160{
/*Estimations without imputations:*/
bysort pid: gen tpyrate1_f`i'w = F`i'.tpyrate1
/*Estimations with Imputations:
Assuming wage at any future period is exactly last wage:*/
bysort pid: gen hwage_f`i'w = F`i'.hwage
/*Imputing wages using monthly earnings:*/
bysort pid: gen ave_hwage_f`i'w = F`i'.ave_hwage

bysort pid: gen income_f`i'w = F`i'.income
bysort pid: gen hours_f`i'w = F`i'.hours
bysort pid: gen unemp_f`i'w = F`i'.unemp
}

//Create variables for date of end of spell

gen date2=0
replace date2=date-spell+1 if spell==1

/*
gen dateb=date
gen yearb=year
gen monthb=month
gen weekb=week

savesome dateb yearb monthb weekb using "date_pairs.dta", replace

drop dateb yearb monthb weekb
*/

rename date2 dateb
/*merge m:m dateb using "date_pairs.dta"*/
merge m:1 dateb using "date_pairs01_`lev'.dta"
drop _merge

merge m:1 state yearb monthb using "unemployment.dta", keepusing(unempb)
keep if _merge!=2
drop _merge

drop if spell==0

gen chng_mw=0
replace chng_mw=1 if delta_mw>0

keep if mean_srch!=5

save "spells`lev'.dta",replace


use "spells01",clear
if `lev'==1{
replace mpid=14483
}
if `lev'==2{
replace mpid=29018
}
if `lev'==3{
replace mpid=43144
}
}

use "spells1",clear

append using "spells2"
append using "spells3"
append using "spells4"

save "spells01",replace

erase "spells1.dta"
erase "spells2.dta"
erase "spells3.dta"
erase "spells4.dta"

/*Set the 2004 sample*/

use "2004/long_2004.dta",clear

gen mpid=57638
drop pid

rename tfipsst state
gen hours=ejbhrs1*rmwkwjb

gen ave_hwage=tpyrate1
replace ave_hwage=tpearn/(rmwkwjb*hours) if ave_hwage==0 & rmesr==1 & ejobcntr>0
replace ave_hwage=tpearn/(2*rmwkwjb*hours) if ave_hwage==0 & rmesr>=2 & rmesr<=5 & ejobcntr>0
gen income=tpearn
replace income=tpyrate1*(rmwkwjb*hours) if tpearn==0 & rmesr==1 & ejobcntr>0
replace income=tpyrate1*rmwkwjb*hours/2 if ave_hwage==0 & rmesr>=2 & rmesr<=5 & ejobcntr>0


//Create UI eligibility variable
gen ui_elig=0
replace ui_elig=1 if ersend1>1 & ersend1<9
replace ui_elig=1 if ersend1>11

save "spells04",replace

levelsof srotaton

foreach lev in `r(levels)'{

keep if srotaton==`lev'

drop if week>rwksperm

egen date=group(year month week)

egen pid=group(srotaton ssuid epppnum)
replace pid=pid+mpid
drop mpid
egen mpid=max(pid)

merge m:1 state year month using "mw_monthly.dta",keepusing(min_mw)
rename min_mw mw
keep if _merge==3

drop _merge
merge m:1 state year month using "unemployment.dta", keepusing(unemp)
keep if _merge==3
sort pid date
drop _merge

gen looking = 0
replace looking =1 if rwkesr>=4

tsset pid date
gen spell= looking
replace spell = cond(L.spell==.,1, L.spell+1) if looking==1

gen spell_id2=0
replace spell_id2=1 if spell==1
by pid: gen spell_id=sum(spell_id2[_n-1])
replace spell_id=0 if spell==0
replace spell_id=spell_id+spell_id2 if spell_id2==1
drop spell_id2

/*Identify movers*/
bysort pid: egen mover=mean(state)
replace mover=4 if mover!=state
replace mover=0 if mover==state

/*Want to know whether people were mostly looking or mostly out of LF*/

egen uniq_spl_id=group(pid spell_id)
replace uniq_spl_id=. if spell==0

bysort uniq_spl_id: egen min4=min(spell) if rwkesr==4
replace min4=0 if min4==.
bysort uniq_spl_id: egen min42=max(min4)
replace spell=spell-min42+1
replace spell=0 if spell<0
replace spell=0 if rwkesr<4
replace uniq_spl_id=0 if spell==0
replace spell_id=0 if spell==0
drop min4 min42

bysort uniq_spl_id: egen max4=max(spell) if rwkesr==4
replace max4=0 if max4==.
bysort uniq_spl_id: egen lastlook=max(max4)
drop max4

bysort uniq_spl_id: egen mean_srch=mean(rwkesr)
replace mean_srch=0 if spell_id==0

gen cut_srch=0
replace cut_srch=1 if spell>=10
gen end_rwkesr=rwkesr*cut_srch

bysort uniq_spl_id: egen mean_srch_aftmode=mean(end_rwkesr)
replace end_rwkesr=0 if spell_id==0

drop cut_srch end_rwkesr

/*Identify spell lengths*/

bysort uniq_spl_id: egen spell_length=max(spell)

gen cut_srch=0
replace cut_srch=1 if spell>=spell_length/2
gen end_rwkesr=rwkesr*cut_srch

bysort uniq_spl_id: egen mean_srch_2half=mean(end_rwkesr)
replace end_rwkesr=0 if spell_id==0
drop cut_srch end_rwkesr

//Divorce or Separation:
bysort pid: egen divorced2=min(date) if ems>=4 & ems<=5
replace divorced2=0 if divorced2==.
bysort pid: egen divorced=max(divorced2)
drop divorced2

//Total time not working:

gen notwk=0
replace notwk=1 if rwkesr==4 | rwkesr==5
bysort pid: gen ttnotwk=sum(notwk)
drop notwk

tsset pid date
gen dead=0
bysort pid: replace dead=1 if F.spell==0 & spell>0

/*Identify spells for which mw changes*/

bysort uniq_spl_id: egen min_mw=min(mw)
bysort uniq_spl_id: egen max_mw=max(mw)

gen delta_mw=100*max_mw/min_mw-100
replace delta_mw=0 if spell==0

/*Generate hourly wage variables*/

tsset pid date
bysort pid: gen hwage = cond(ave_hwage==0,L.ave_hwage,ave_hwage)
gen time_delta2=0
bysort pid: replace time_delta2=cond(L.mw!=mw,spell,L.time_delta2)
replace time_delta2=300 if time_delta2==0
bysort pid: egen time_delta=min(time_delta2)
drop time_delta2

tsset pid date
bysort pid: gen last_wage = cond(hwage==0,L.hwage,hwage)
bysort pid: replace last_wage = cond(last_wage==0 | last_wage==.,L.last_wage,last_wage)
bysort pid: gen next_wage = cond(hwage==0,F.hwage,hwage)
local i=1
while `i'<100{
bysort pid: replace next_wage = cond(next_wage==0 | next_wage==.,F.next_wage,next_wage)
local i=`i'+1
}

//Generate Hours variables
gen weekly_hours = hours/rwksperm

bysort pid: gen next_hours = cond(weekly_hours==0,F.weekly_hours,weekly_hours)
local i=1
while `i'<100{
bysort pid: replace next_hours = cond(next_hours==0 | next_hours==.,F.next_hours,next_hours)
local i=`i'+1
}
forval i=4 8:160{
bysort pid: gen hwage_f`i'w = F`i'.hwage
bysort pid: gen tpyrate1_f`i'w = F`i'.tpyrate1
bysort pid: gen ave_hwage_f`i'w = F`i'.ave_hwage
bysort pid: gen income_f`i'w = F`i'.income
bysort pid: gen hours_f`i'w = F`i'.hours
bysort pid: gen unemp_f`i'w = F`i'.unemp
}

//Create variables for date of end of spell

gen date2=0
replace date2=date-spell+1 if spell==1

/*
gen dateb=date
gen yearb=year
gen monthb=month
gen weekb=week

savesome dateb yearb monthb weekb using "date_pairs.dta", replace

drop dateb yearb monthb weekb
*/

rename date2 dateb
/*merge m:m dateb using "date_pairs.dta"*/
merge m:1 dateb using "date_pairs04_`lev'.dta"
drop _merge

merge m:1 state yearb monthb using "unemployment.dta", keepusing(unempb)
keep if _merge!=2
drop _merge

drop if spell==0

gen chng_mw=0
replace chng_mw=1 if delta_mw>0

keep if mean_srch!=5

save "spells`lev'.dta",replace

use "spells04",clear
if `lev'==1{
replace mpid=57638+21775
}
if `lev'==2{
replace mpid=57638+43904
}
if `lev'==3{
replace mpid=57638+66565
}
}

use "spells1",clear

append using "spells2"
append using "spells3"
append using "spells4"

save "spells04",replace

erase "spells1.dta"
erase "spells2.dta"
erase "spells3.dta"
erase "spells4.dta"

/*Set the 2008 sample*/

use "2008/long_2008.dta",clear
drop pid _merge

gen mpid=57638+88535
rename tfipsst state
rename tmovrflg mover
gen hours=ejbhrs1*rmwkwjb

gen ave_hwage=tpyrate1
replace ave_hwage=tpearn/(rmwkwjb*hours) if ave_hwage==0 & rmesr==1 & ejobcntr>0
replace ave_hwage=tpearn/(2*rmwkwjb*hours) if ave_hwage==0 & rmesr>=2 & rmesr<=5 & ejobcntr>0
gen income=tpearn
replace income=tpyrate1*(rmwkwjb*hours) if tpearn==0 & rmesr==1 & ejobcntr>0
replace income=tpyrate1*rmwkwjb*hours/2 if ave_hwage==0 & rmesr>=2 & rmesr<=5 & ejobcntr>0

//Create UI eligibility variable
gen ui_elig=0
replace ui_elig=1 if ersend1>1 & ersend1<9
replace ui_elig=1 if ersend1>11

save "spells08",replace

levelsof srotaton

foreach lev in `r(levels)'{

keep if srotaton==`lev'

drop if week>rwksperm

egen date=group(year month week)

egen pid=group(srotaton ssuid epppnum)
replace pid=pid+mpid
drop mpid
egen mpid=max(pid)

merge m:1 state year month using "mw_monthly.dta",keepusing(min_mw)
rename min_mw mw
keep if _merge==3
drop _merge

merge m:1 state year month using "unemployment.dta", keepusing(unemp)
keep if _merge==3
sort pid date
drop _merge

gen looking = 0
replace looking =1 if rwkesr>=4

tsset pid date
gen spell= looking
replace spell = cond(L.spell==.,1, L.spell+1) if looking==1

gen spell_id2=0
replace spell_id2=1 if spell==1
by pid: gen spell_id=sum(spell_id2[_n-1])
replace spell_id=0 if spell==0
replace spell_id=spell_id+spell_id2 if spell_id2==1
drop spell_id2

/*Want to know whether people were mostly looking or mostly out of LF*/

egen uniq_spl_id=group(pid spell_id)
replace uniq_spl_id=. if spell==0

bysort uniq_spl_id: egen min4=min(spell) if rwkesr==4
replace min4=0 if min4==.
bysort uniq_spl_id: egen min42=max(min4)
replace spell=spell-min42+1
replace spell=0 if spell<0
replace spell=0 if rwkesr<4
replace uniq_spl_id=0 if spell==0
replace spell_id=0 if spell==0
drop min4 min42

bysort uniq_spl_id: egen max4=max(spell) if rwkesr==4
replace max4=0 if max4==.
bysort uniq_spl_id: egen lastlook=max(max4)
drop max4

bysort uniq_spl_id: egen mean_srch=mean(rwkesr)
replace mean_srch=0 if spell_id==0

gen cut_srch=0
replace cut_srch=1 if spell>=10
gen end_rwkesr=rwkesr*cut_srch

bysort uniq_spl_id: egen mean_srch_aftmode=mean(end_rwkesr)
replace end_rwkesr=0 if spell_id==0

drop cut_srch end_rwkesr

/*Identify spell lengths*/

bysort uniq_spl_id: egen spell_length=max(spell)

gen cut_srch=0
replace cut_srch=1 if spell>=spell_length/2
gen end_rwkesr=rwkesr*cut_srch

bysort uniq_spl_id: egen mean_srch_2half=mean(end_rwkesr)
replace end_rwkesr=0 if spell_id==0
drop cut_srch end_rwkesr

//Divorce or Separation:
bysort pid: egen divorced2=min(date) if ems>=4 & ems<=5
replace divorced2=0 if divorced2==.
bysort pid: egen divorced=max(divorced2)
drop divorced2

//Total time not working:

gen notwk=0
replace notwk=1 if rwkesr==4 | rwkesr==5
bysort pid: gen ttnotwk=sum(notwk)
drop notwk

tsset pid date
gen dead=0
bysort pid: replace dead=1 if F.spell==0 & spell>0

/*Identify spells for which mw changes*/

bysort uniq_spl_id: egen min_mw=min(mw)
bysort uniq_spl_id: egen max_mw=max(mw)

gen delta_mw=100*max_mw/min_mw-100
replace delta_mw=0 if spell==0

/*Generate hourly wage variables*/

tsset pid date
bysort pid: gen hwage = cond(ave_hwage==0,L.ave_hwage,ave_hwage)
gen time_delta2=0
bysort pid: replace time_delta2=cond(L.mw!=mw,spell,L.time_delta2)
replace time_delta2=300 if time_delta2==0
bysort pid: egen time_delta=min(time_delta2)
drop time_delta2

tsset pid date
bysort pid: gen last_wage = cond(hwage==0,L.hwage,hwage)
bysort pid: replace last_wage = cond(last_wage==0 | last_wage==.,L.last_wage,last_wage)
bysort pid: gen next_wage = cond(hwage==0,F.hwage,hwage)
local i=1
while `i'<100{
bysort pid: replace next_wage = cond(next_wage==0 | next_wage==.,F.next_wage,next_wage)
local i=`i'+1
}

//Generate Hours variables
gen weekly_hours = hours/rwksperm

bysort pid: gen next_hours = cond(weekly_hours==0,F.weekly_hours,weekly_hours)
local i=1
while `i'<100{
bysort pid: replace next_hours = cond(next_hours==0 | next_hours==.,F.next_hours,next_hours)
local i=`i'+1
}

forval i=4 8:160{
bysort pid: gen hwage_f`i'w = F`i'.hwage
bysort pid: gen tpyrate1_f`i'w = F`i'.tpyrate1
bysort pid: gen ave_hwage_f`i'w = F`i'.ave_hwage
bysort pid: gen income_f`i'w = F`i'.income
bysort pid: gen hours_f`i'w = F`i'.hours
bysort pid: gen unemp_f`i'w = F`i'.unemp
}

//Create variables for date of end of spell

gen date2=0
replace date2=date-spell+1 if spell==1

/*
gen dateb=date
gen yearb=year
gen monthb=month
gen weekb=week

savesome dateb yearb monthb weekb using "date_pairs.dta", replace

drop dateb yearb monthb weekb
*/

rename date2 dateb
/*merge m:m dateb using "date_pairs.dta"*/
merge m:1 dateb using "date_pairs08_`lev'.dta"
drop _merge

merge m:1 state yearb monthb using "unemployment.dta", keepusing(unempb)
keep if _merge!=2
drop _merge

drop if spell==0

gen chng_mw=0
replace chng_mw=1 if delta_mw>0

keep if mean_srch!=5

save "spells`lev'.dta",replace

use "spells08",clear
if `lev'==1{
replace mpid=57638+88535+22660
}
if `lev'==2{
replace mpid=57638+88535+45870
}
if `lev'==3{
replace mpid=57638+88535+68484
}
}

use "spells1",clear

append using "spells2"
append using "spells3"
append using "spells4"

save "spells08",replace

erase "spells1.dta"
erase "spells2.dta"
erase "spells3.dta"
erase "spells4.dta"

/*Set the 2014 sample*/

use "2014/long_2014.dta",clear

drop pid

gen mpid=57638+88535+91224
gen hours=tmwkhrs*rmwkwjb

gen mover=tmover
replace mover=rmover if year==2014

gen ave_hwage=tpyrate1
replace ave_hwage=tpearn/(rmwkwjb*hours) if ave_hwage==0 & rmesr==1 & rmnumjobs>0
replace ave_hwage=tpearn/(2*rmwkwjb*hours) if ave_hwage==0 & rmesr>=2 & rmesr<=5 & rmnumjobs>0
gen income=tpearn
replace income=tpyrate1*(rmwkwjb*hours) if tpearn==0 & rmesr==1 & rmnumjobs>0
replace income=tpyrate1*rmwkwjb*hours/2 if ave_hwage==0 & rmesr>=2 & rmesr<=5 & rmnumjobs>0


//Create UI eligibility variable
gen ui_elig=0
replace ui_elig=1 if  ejb1_rsend>1 & ejb1_rsend<9
replace ui_elig=1 if ejb1_rsend>11

egen pid=group(ssuid epppnum)
replace pid=pid+mpid

rename tfipsst state
rename eeduc eeducate
rename rfpersons efnp
rename rfrelu18 rfnkids
rename rhnumper ehhnumpp

drop if week>rwksperm

egen date=group(year month week)

merge m:1 state year month using "mw_monthly.dta",keepusing(min_mw)
rename min_mw mw
keep if _merge==3
drop _merge

merge m:1 state year month using "unemployment.dta", keepusing(unemp)
keep if _merge==3
drop _merge
sort pid date

gen looking = 0
replace looking =1 if rwkesr>=4

gen spell= looking
tsset pid date
replace spell = cond(L.spell==.,1, L.spell+1) if looking==1

gen spell_id2=0
replace spell_id2=1 if spell==1
by pid: gen spell_id=sum(spell_id2[_n-1])
replace spell_id=0 if spell==0
replace spell_id=spell_id+spell_id2 if spell_id2==1
drop spell_id2

/*Want to know whether people were mostly looking or mostly out of LF*/

egen uniq_spl_id=group(pid spell_id)
replace uniq_spl_id=. if spell==0

bysort uniq_spl_id: egen min4=min(spell) if rwkesr==4
replace min4=0 if min4==.
bysort uniq_spl_id: egen min42=max(min4)
replace spell=spell-min42+1
replace spell=0 if spell<0
replace spell=0 if rwkesr<4
replace uniq_spl_id=0 if spell==0
replace spell_id=0 if spell==0
drop min4 min42

bysort uniq_spl_id: egen max4=max(spell) if rwkesr==4
replace max4=0 if max4==.
bysort uniq_spl_id: egen lastlook=max(max4)
drop max4

bysort uniq_spl_id: egen mean_srch=mean(rwkesr)
replace mean_srch=0 if spell_id==0

gen cut_srch=0
replace cut_srch=1 if spell>=10
gen end_rwkesr=rwkesr*cut_srch

bysort uniq_spl_id: egen mean_srch_aftmode=mean(end_rwkesr)
replace end_rwkesr=0 if spell_id==0

drop cut_srch end_rwkesr

/*Identify spell lengths*/

bysort uniq_spl_id: egen spell_length=max(spell)

gen cut_srch=0
replace cut_srch=1 if spell>=spell_length/2
gen end_rwkesr=rwkesr*cut_srch

bysort uniq_spl_id: egen mean_srch_2half=mean(end_rwkesr)
replace end_rwkesr=0 if spell_id==0
drop cut_srch end_rwkesr

//Divorce or Separation:
bysort pid: egen divorced2=min(date) if ems>=4 & ems<=5
replace divorced2=0 if divorced2==.
bysort pid: egen divorced=max(divorced2)
drop divorced2


//Total time not working:

gen notwk=0
replace notwk=1 if rwkesr==4 | rwkesr==5
bysort pid: gen ttnotwk=sum(notwk)
drop notwk

tsset pid date
gen dead=0
bysort pid: replace dead=1 if F.spell==0 & spell>0

/*Identify spells for which mw changes*/

bysort uniq_spl_id: egen min_mw=min(mw)
bysort uniq_spl_id: egen max_mw=max(mw)

gen delta_mw=100*max_mw/min_mw-100
replace delta_mw=0 if spell==0

/*Generate hourly wage variables*/

tsset pid date
bysort pid: gen hwage = cond(ave_hwage==0,L.ave_hwage,ave_hwage)
gen time_delta2=0
bysort pid: replace time_delta2=cond(L.mw!=mw,spell,L.time_delta2)
replace time_delta2=300 if time_delta2==0
bysort pid: egen time_delta=min(time_delta2)
drop time_delta2

tsset pid date
bysort pid: gen last_wage = cond(hwage==0,L.hwage,hwage)
bysort pid: replace last_wage = cond(last_wage==0 | last_wage==.,L.last_wage,last_wage)
bysort pid: gen next_wage = cond(hwage==0,F.hwage,hwage)
local i=1
while `i'<100{
bysort pid: replace next_wage = cond(next_wage==0 | next_wage==.,F.next_wage,next_wage)
local i=`i'+1
}

//Generate Hours variables
gen weekly_hours = hours/rwksperm

bysort pid: gen next_hours = cond(weekly_hours==0,F.weekly_hours,weekly_hours)
local i=1
while `i'<100{
bysort pid: replace next_hours = cond(next_hours==0 | next_hours==.,F.next_hours,next_hours)
local i=`i'+1
}

forval i=4 8:160{
bysort pid: gen hwage_f`i'w = F`i'.hwage
bysort pid: gen tpyrate1_f`i'w = F`i'.tpyrate1
bysort pid: gen ave_hwage_f`i'w = F`i'.ave_hwage
bysort pid: gen income_f`i'w = F`i'.income
bysort pid: gen hours_f`i'w = F`i'.hours
bysort pid: gen unemp_f`i'w = F`i'.unemp
}

//Create variables for date of end of spell

gen date2=0
replace date2=date-spell+1 if spell==1

/*
gen dateb=date
gen yearb=year
gen monthb=month
gen weekb=week

savesome dateb yearb monthb weekb using "date_pairs.dta", replace

drop dateb yearb monthb weekb
*/
rename date2 dateb
/*merge m:m dateb using "date_pairs.dta", keepusing(dateb yearb monthb weekb)*/
merge m:1 dateb using "date_pairs14.dta", keepusing(dateb yearb monthb weekb)
drop _merge

merge m:1 state yearb monthb using "unemployment.dta", keepusing(unempb)
drop if _merge==2
drop _merge

drop if spell==0

gen chng_mw=0
replace chng_mw=1 if delta_mw>0

keep if mean_srch!=5

append using "spells01"
append using "spells04"
append using "spells08"

save "spells.dta",replace

erase "spells01.dta"
erase "spells04.dta"
erase "spells08.dta"

timer off 1
timer list

/*Add mw, there's some problem with FIPS state codes 60, 'Maine, Vermont', and
'North Dakota, South Dakota, Wyoming', just drop them?*/
