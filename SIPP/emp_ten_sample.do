
/*Join different SIPP*/
clear all
//cd "C:\Users\Kyle\OneDrive\Minimum Wage\SIPP"


//cd "C:\Users\ksc91\OneDrive\Minimum Wage\SIPP"

cd "C:\Users\gdvia\OneDrive\PhD\Research\Minimum Wage\SIPP"

/*takes about 2 hours*/
timer on 1

import excel using unemployment.xlsx, sh("Sheet1") first clear
save "unemployment", replace

//To use this file first copy long files for 2001,4,8 to the directory.
/*
use "2001\long_2001",clear
save "long_2001"
use "2004\long_2004",clear
save "long_2004"
use "2008\long_2008",clear
save "long_2008"
*/

local longlist long_e2001 long_e2004 long_e2008
/*Set the 2001 sample*/

foreach filename of local longlist{

use `"`filename'"',clear
drop pid

// mpid is used to store the maximum pid generated so far. It is intialized to 
// 0 and replace with the maximum pid after each rotation for each panel year
gen mpid=0
replace mpid=85568 if panel==2004
replace mpid=57638+88535 if panel==2008

rename tfipsst state

gen hours=ejbhrs1*rmwkwjb

//Getting data to long form means wages and incomes are copied into non-working weeks.
replace tpyrate1=0 if rwkesr>=4
// & rmwklkg>=1
replace tpearn=0 if rwkesr>=4
// & rmwklkg>=1 

gen hwage=tpyrate1

//I think the denominator should not have rmwkwjb since tpearn is monthly earnings
// and hours is already defined as monthly hours

replace hwage=tpearn/(hours) if hwage==0 & rmesr==1 & ejobcntr>0
replace hwage=tpearn/(2*hours) if hwage==0 & rmesr>=2 & rmesr<=5 & ejobcntr>0
gen income=tpearn
replace income=tpyrate1*(hours) if tpearn==0 & rmesr==1 & ejobcntr>0
replace income=tpyrate1*hours/2 if hwage==0 & rmesr>=2 & rmesr<=5 & ejobcntr>0

// I replace hwage and income as missing if they are 0 and hours is not known (negative hours)
// Negative hours means hours are missing because -1 in ejbhrs1 is "not in universe"
replace hwage = . if hwage==0 & hours <0
replace tpyrate1 = . if tpyrate1==0 & hours <0
replace income = . if income==0 & hours <0


//save file for 2001 panel
save "spells01",replace

// get the set of levels for srotation (should be 4 for each panel year)
levelsof srotaton

//loop over the 4 different values of rotation (srotaton) for 2001
quietly{
foreach lev in `r(levels)'{

//Each file has 4 rotations, each person is intervied always in the same rotation,
// processing by rotation allows for better running times
keep if srotaton==`lev'
// In case there are observations for inexistent weeks
drop if week>rwksperm

egen date=group(year month week)
egen pid=group(srotaton ssuid epppnum)

//Create count of obs by individual
gen ones=1
bysort pid: egen count_obs=sum(ones)
drop ones

//Create a variable to recover different dates:
gen dateb=date
gen yearb=year
gen monthb=month
gen weekb=week

// Give unique pid's to everyone
replace pid=pid+mpid
drop mpid
egen mpid=max(pid)

egen lobs=max(date)
gen one=1
bysort pid: egen countobs=sum(one)
egen fpid2=min(pid) if lobs==countobs
replace fpid2=0 if fpid2==.
egen fpid=max(fpid2)
drop lobs fpid2 one

savesome dateb yearb monthb weekb if pid==fpid using "date_pairs.dta", replace

if panel==2004{
if srotaton==1{
savesome dateb yearb monthb weekb if pid==57655 | pid==72634 using "date_pairs.dta", replace
}
if srotaton==4{
savesome dateb yearb monthb weekb if pid==124299 | pid==136835 using "date_pairs.dta", replace
}
}
drop dateb yearb monthb weekb
//

// Cross with minimum wage data:
//First get the current minimum wage at every week
merge m:1 state year month using "mw_monthly.dta",keepusing(min_mw max_mw mw_raise week_mw max_fed_mw fake_mw)
rename max_fed_mw fed_mw

gen mw=min_mw
replace mw=max_mw if mw_raise==1 & week>=week_mw

replace mw_raise=0 if week!=week_mw & mw_raise==1

//Some cases are drop: from "Maine, Vermont"; and  "North Dakota, South Dakota, Wyoming"
drop if _merge==2
replace _merge=0 if _merge==3
// make sure to drop all observations from the above individuals:
bysort pid: egen bad=max(_merge)
drop if _merge==1
drop _merge

// Cross with unemployment data:
merge m:1 state year month using "unemployment.dta", keepusing(unemp)
keep if _merge==3
drop _merge

//Generate variable to determine spells:
// First people that are without jobs:
gen looking = 0
replace looking =1 if rwkesr>=4

// then generate a spell variable:
tsset pid date
gen spell= looking
replace spell = cond(L.spell==.,1, L.spell+1) if looking==1
//give spells ids, with respect to individuals
gen spell_id2=0
replace spell_id2=1 if spell==1
bysort pid: gen spell_id=sum(spell_id2[_n-1])
replace spell_id=spell_id+spell_id2
replace spell_id=0 if spell==0
drop spell_id2

/*Identify movers*/
bysort pid: egen mover=mean(state)
replace mover=4 if mover!=state
replace mover=0 if mover==state

//Create unique spell id
egen uniq_spl_id=group(pid spell_id)
replace uniq_spl_id=. if spell==0

// Identify the first time people started looking for work, and correct the spell:
bysort uniq_spl_id: egen min4=min(spell) if rwkesr==4
replace min4=0 if min4==.
bysort uniq_spl_id: egen min42=max(min4)
replace spell=spell-min42+1
replace spell=0 if min42==0
replace spell=0 if spell<0
replace uniq_spl_id=0 if spell==0
replace spell_id=0 if spell==0
drop min4 min42

// Spells need to end if hours become positive during a spell
//bysort uniq_spl_id: egen min4=min(spell) if ejbhrs1>0
//replace min4=0 if min4==.
//replace spell=0 if spell>=min4 & min4>0
//drop min4

//Identify the last week they looked for work:
bysort uniq_spl_id: egen max4=max(spell) if rwkesr==4
replace max4=0 if max4==.
bysort uniq_spl_id: egen lastlook=max(max4)
drop max4

// Get indicator for time during the spell spent looking
bysort uniq_spl_id: egen mean_srch=mean(rwkesr)
replace mean_srch=0 if spell_id==0

//Total time not working:
gen notwk=0
replace notwk=1 if rwkesr==4 | rwkesr==5
bysort pid: gen ttnotwk=sum(notwk)
drop notwk

tsset pid date
gen dead=0
bysort pid: replace dead=1 if F.spell<=spell & spell>0

//Identify spell lengths
bysort uniq_spl_id: egen spell_length=max(spell)

//Identify spells for which mw changes
gen min_mw1=mw if spell==1
replace min_mw1=min_mw if spell==1 & mw_raise==1

bysort uniq_spl_id: egen mnm_mw=max(min_mw1)
gen min_mw2=mw if spell==spell_length
bysort uniq_spl_id: egen mxm_mw=max(min_mw2)

gen delta_mw=100*mxm_mw/mnm_mw-100
replace delta_mw=0 if spell==0
drop min_mw1 min_mw2 mnm_mw mxm_mw

//Identify spells for which fake_mw changes
gen min_mw1=fake_mw if spell==1
bysort uniq_spl_id: egen mnm_mw=max(min_mw1)
gen min_mw2=fake_mw if spell==spell_length
bysort uniq_spl_id: egen mxm_mw=max(min_mw2)

gen fake_delta_mw=100*mxm_mw/mnm_mw-100
replace fake_delta_mw=0 if spell==0
drop min_mw1 min_mw2 mnm_mw mxm_mw


//Lets flag months with mw changes anywhere:
egen year_month=group(year month)
bysort year_month: egen raised_anyw=max(mw_raise)
// Getting hwage for a year later on those months:
tsset pid date
bysort pid: gen hwage_1yaft3=F52.hwage
egen month_date=group(pid year month)
// And get hwage for a year after the mw was changed:
bysort month_date: egen hwage_1yaft2=max(hwage_1yaft3)
replace hwage_1yaft2=. if raised_anyw==0 | spell==0
bysort uniq_spl_id: egen hwage_1yaft=max(hwage_1yaft2)
replace hwage_1yaft=0 if spell==0
drop hwage_1yaft2 hwage_1yaft3 month_date year_month

//Divorce or Separation:
bysort pid: egen divorced2=min(date) if ems>=4 & ems<=5
replace divorced2=0 if divorced2==.
bysort pid: egen divorced=max(divorced2)
drop divorced2




//gen negdate = -date
//tsset pid negdate

//Generate hourly wage variables
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


gen time_delta2=0
tsset pid date
bysort pid: replace time_delta2=cond(L.mw!=mw,spell,cond(L.date==.,0,time_delta2))
bysort pid: replace time_delta2=cond(L.date==.,0,time_delta2)
replace time_delta2=0 if time_delta2==.
replace time_delta2=0 if spell==0
replace time_delta2=300 if time_delta2==0
bysort uniq_spl_id: egen time_delta=min(time_delta2)
replace time_delta=0 if time_delta==300
drop time_delta2

//Create variables about future conditions:
tsset pid date
forval i=4 8:160{
/*Estimations without imputations:*/
bysort pid: gen tpyrate1_f`i'w = F`i'.tpyrate1
//Estimations with Imputations:
/*Imputing wages using monthly earnings:*/
bysort pid: gen hwage_f`i'w = F`i'.hwage

bysort pid: gen income_f`i'w = F`i'.income
bysort pid: gen hours_f`i'w = F`i'.hours
bysort pid: gen unemp_f`i'w = F`i'.unemp
bysort pid: gen mw_f`i'w = F`i'.mw
}

//Get date for minimum wage change
tsset pid date
bysort pid: gen date_mw=cond(L.mw!=mw,cond(L.date!=.,date,0),0)

// Get unemployment the month minimum wage was changed:
merge m:1 state year month using "unemployment",keepusing(unempb)
keep if _merge==3
drop _merge
rename unempb unemp2
replace unemp2=0 if mw_raise==0

bysort uniq_spl_id: egen unemp_mw=max(unemp2)
drop unemp2

//Create variables for date when spell started
gen dateb=0
replace dateb=date-spell+1 if spell>=1

//Get date for beginning of spell
merge m:1 dateb using "date_pairs.dta"
drop _merge

//Get unemployment at beginning of spell
merge m:1 state yearb monthb using "unemployment.dta", keepusing(unempb)
drop if _merge==2
drop _merge

//Create variables for information a year after the mw is changed:
local futvars tpyrate1 hwage income hours unemp mw

foreach var of local futvars{
tsset pid date
bysort pid: gen `var'_f1y2=F52.`var'
replace `var'_f1y2=0 if unemp_mw==0
bysort uniq_spl_id: egen `var'_f1y=max(`var'_f1y2)
drop `var'_f1y2
}


//Get rid of non-spell observations:
drop if spell==0

gen chng_mw=0
replace chng_mw=1 if delta_mw>0

keep if mean_srch!=5

save "spells`lev'.dta",replace


use "spells01",clear
if `lev'==1{
replace mpid=14483 if panel==2001
replace mpid=57638+21775 if panel==2004
replace mpid=57638+88535+22660 if panel==2008
}
if `lev'==2{
replace mpid=29018 if panel==2001
replace mpid=57638+43904 if panel==2004
replace mpid=57638+88535+45870 if panel==2008
}
if `lev'==3{
replace mpid=43144 if panel==2001
replace mpid=57638+66565 if panel==2004
replace mpid=57638+88535+68484 if panel==2008
}
}
}
use "spells1",clear

append using "spells2"
append using "spells3"
append using "spells4"

if panel<2008{
save `"`filename'"',replace
}

if panel==2008{
drop mover
rename tmovrflg mover
save `"`filename'"',replace
}
erase "spells1.dta"
erase "spells2.dta"
erase "spells3.dta"
erase "spells4.dta"
}

use "long_e2014.dta",clear

drop pid

gen mpid=57638+88535+91224

//Hours per month
gen hours=tmwkhrs*rmwkwjb

gen mover=tmover
replace mover=rmover if year==2013

egen date=group(year month week)
egen pid=group(ssuid epppnum)
//Add mpid so that the IDs are unique compared with previous panels.
replace pid=pid+mpid

//Drop movers
bysort pid: egen moved_ever=max(mover)
keep if moved_ever<4

//Getting data to long form means wages and incomes are copied into non-working weeks.
replace tpyrate1=0 if rwkesr>=4
// & rmwklkg>=1
replace tpearn=0 if rwkesr>=4
//& rmwklkg>=1

gen hwage=tpyrate1

//I think the denominator should not have rmwkwjb since tpearn is monthly earnings
// and hours is already defined as monthly hours
replace hwage=tpearn/(hours) if hwage==0 & rmesr==1 & rmnumjobs>0
replace hwage=tpearn/(2*hours) if hwage==0 & rmesr>=2 & rmesr<=5 & rmnumjobs>0
gen income=tpearn
replace income=tpyrate1*(hours) if tpearn==0 & rmesr==1 & rmnumjobs>0
replace income=tpyrate1*hours/2 if hwage==0 & rmesr>=2 & rmesr<=5 & rmnumjobs>0

// I replace hwage and income as missing if they are 0 and hours is not known (negative hours)
// Negative hours means hours are missing because -1 in ejbhrs1 is "not in universe"
replace hwage = . if hwage==0 & hours <0
replace tpyrate1 = . if tpyrate1==0 & hours <0
replace income = . if income==0 & hours <0

rename tfipsst state
rename eeduc eeducate
rename rfpersons efnp
rename rfrelu18 rfnkids
rename rhnumper ehhnumpp

drop if week>rwksperm


//Create a variable to recover different dates:
gen dateb=date
gen yearb=year
gen monthb=month
gen weekb=week

egen lobs=max(date)
gen one=1
bysort pid: egen countobs=sum(one)
egen fpid2=min(pid) if lobs==countobs
replace fpid2=0 if fpid2==.
egen fpid=max(fpid2)
drop lobs fpid2 one

savesome dateb yearb monthb weekb if pid==fpid using "date_pairs.dta", replace
drop dateb yearb monthb weekb
//

// Cross with minimum wage data:
merge m:1 state year month using "mw_monthly.dta",keepusing(min_mw max_mw mw_raise week_mw max_fed_mw fake_mw)
rename max_fed_mw fed_mw

gen mw=min_mw
replace mw=max_mw if mw_raise==1 & week>=week_mw

replace mw_raise=0 if week!=week_mw & mw_raise==1

//Some cases are drop: from "Maine, Vermont"; and  "North Dakota, South Dakota, Wyoming"
drop if _merge==2
replace _merge=0 if _merge==3
bysort pid: egen bad=max(_merge)
drop if _merge==1
drop _merge

// Cross with unemployment data:
merge m:1 state year month using "unemployment.dta", keepusing(unemp)
keep if _merge==3
drop _merge

//Generate variable to determine spells:
gen looking = 0
replace looking =1 if rwkesr>=4

// then generate a spell variable:
tsset pid date
gen spell= looking
replace spell = cond(L.spell==.,1, L.spell+1) if looking==1
//give spells ids, with respect to individuals
gen spell_id2=0
replace spell_id2=1 if spell==1
bysort pid: gen spell_id=sum(spell_id2[_n-1])
replace spell_id=spell_id+spell_id2
replace spell_id=0 if spell==0
drop spell_id2

//Create unique spell id
egen uniq_spl_id=group(pid spell_id)
replace uniq_spl_id=. if spell==0

// Identify the first time people started looking for work, and correct the spell:
bysort uniq_spl_id: egen min4=min(spell) if rwkesr==4
replace min4=0 if min4==.
bysort uniq_spl_id: egen min42=max(min4)
replace spell=spell-min42+1
replace spell=0 if min42==0
replace spell=0 if spell<0
replace uniq_spl_id=0 if spell==0
replace spell_id=0 if spell==0
drop min4 min42

// Spells need to end if hours become positive during a spell
//bysort uniq_spl_id: egen min4=min(spell) if tmwkhrs>0
//replace min4=0 if min4==.
//replace spell=0 if spell>=min4 & min4>0
//drop min4

//Identify the last week they looked for work:
bysort uniq_spl_id: egen max4=max(spell) if rwkesr==4
replace max4=0 if max4==.
bysort uniq_spl_id: egen lastlook=max(max4)
drop max4

// Get indicator for time during the spell spent looking
bysort uniq_spl_id: egen mean_srch=mean(rwkesr)
replace mean_srch=0 if spell_id==0

//Total time not working:
gen notwk=0
replace notwk=1 if rwkesr==4 | rwkesr==5
bysort pid: gen ttnotwk=sum(notwk)
drop notwk

tsset pid date
gen dead=0
bysort pid: replace dead=1 if F.spell<=spell & spell>0

//Identify spell lengths
bysort uniq_spl_id: egen spell_length=max(spell)

//Identify spells for which mw changes
gen min_mw1=mw if spell==1
replace min_mw1=min_mw if spell==1 & mw_raise==1

bysort uniq_spl_id: egen mnm_mw=max(min_mw1)
gen min_mw2=mw if spell==spell_length
bysort uniq_spl_id: egen mxm_mw=max(min_mw2)

gen delta_mw=100*mxm_mw/mnm_mw-100
replace delta_mw=0 if spell==0
drop min_mw1 min_mw2 mnm_mw mxm_mw

//Identify spells for which fake_mw changes
gen min_mw1=fake_mw if spell==1
bysort uniq_spl_id: egen mnm_mw=max(min_mw1)
gen min_mw2=fake_mw if spell==spell_length
bysort uniq_spl_id: egen mxm_mw=max(min_mw2)

gen fake_delta_mw=100*mxm_mw/mnm_mw-100
replace fake_delta_mw=0 if spell==0
drop min_mw1 min_mw2 mnm_mw mxm_mw

//Lets flag months with mw changes anywhere:
egen year_month=group(year month)
bysort year_month: egen raised_anyw=max(mw_raise)
// Getting hwage for a year later on those months:
tsset pid date
bysort pid: gen hwage_1yaft3=F52.hwage
egen month_date=group(pid year month)
// And get hwage for a year after the mw was changed:
bysort month_date: egen hwage_1yaft2=max(hwage_1yaft3)
replace hwage_1yaft2=. if raised_anyw==0 | spell==0
bysort uniq_spl_id: egen hwage_1yaft=max(hwage_1yaft2)
replace hwage_1yaft=0 if spell==0
drop hwage_1yaft2 hwage_1yaft3 month_date year_month

//Divorce or Separation:
bysort pid: egen divorced2=min(date) if ems>=4 & ems<=5
replace divorced2=0 if divorced2==.
bysort pid: egen divorced=max(divorced2)
drop divorced2

//Gen last and next wage variables
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


gen time_delta2=0
tsset pid date
bysort pid: replace time_delta2=cond(L.mw!=mw,spell,cond(L.date==.,0,time_delta2))
bysort pid: replace time_delta2=cond(L.date==.,0,time_delta2)
replace time_delta2=0 if time_delta2==.
replace time_delta2=0 if spell==0
replace time_delta2=300 if time_delta2==0
bysort uniq_spl_id: egen time_delta=min(time_delta2)
replace time_delta=0 if time_delta==300
drop time_delta2

//Create variables about future conditions:
tsset pid date
forval i=4 8:160{
/*Estimations without imputations:*/
bysort pid: gen tpyrate1_f`i'w = F`i'.tpyrate1
//Estimations with Imputations:
/*Imputing wages using monthly earnings:*/
bysort pid: gen hwage_f`i'w = F`i'.hwage

bysort pid: gen income_f`i'w = F`i'.income
bysort pid: gen hours_f`i'w = F`i'.hours
bysort pid: gen unemp_f`i'w = F`i'.unemp
bysort pid: gen mw_f`i'w = F`i'.mw
}

//Get date for minimum wage change
tsset pid date
bysort pid: gen date_mw=cond(L.mw!=mw,cond(L.date!=.,date,0),0)

// Get unemployment the month minimum wage was changed:
merge m:1 state year month using "unemployment",keepusing(unempb)
keep if _merge==3
drop _merge
rename unempb unemp2
replace unemp2=0 if mw_raise==0

bysort uniq_spl_id: egen unemp_mw=max(unemp2)
drop unemp2

//Create variables for date when spell started
gen dateb=0
replace dateb=date-spell+1 if spell>=1

//Get date for beginning of spell
merge m:1 dateb using "date_pairs.dta"
drop _merge

//Get unemployment at beginning of spell
merge m:1 state yearb monthb using "unemployment.dta", keepusing(unempb)
drop if _merge==2
drop _merge

//Create variables for information a year after the mw is changed:
local futvars tpyrate1 hwage income hours unemp mw

foreach var of local futvars{
tsset pid date
bysort pid: gen `var'_f1y2=F52.`var'
replace `var'_f1y2=0 if unemp_mw==0
bysort uniq_spl_id: egen `var'_f1y=max(`var'_f1y2)
drop `var'_f1y2
}

//Get rid of non-spell observations:
drop if spell==0

gen chng_mw=0
replace chng_mw=1 if delta_mw>0

keep if mean_srch!=5

save "long_2014"

use "long_2001"
append using "long_2004"
append using "long_2008"
append using "long_2014"

replace time_delta=0 if time_delta==300

save "spells.dta",replace

erase "long_2001.dta"
erase "long_2004.dta"
erase "long_2008.dta"
erase "long_2014.dta"
erase "date_pairs.dta"
erase "spells01.dta"

timer off 1
timer list
