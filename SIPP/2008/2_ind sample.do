/* Combining waves*/

/*
cd "C:\Users\Kyle\OneDrive\Minimum Wage\SIPP\2014"
*/

cd "C:\Users\gdvia\OneDrive\PhD\Research\Minimum Wage\SIPP\2008"

unzipfile "waves_unemp",replace

clear all

use "wave1.dta"

foreach v of varlist _all {
capture rename `v' `=lower("`v'")'
}

gen panel=2008
egen pid=group(ssuid epppnum)

reshape long rwkesr, i(pid rhcalmn rhcalyr) j(week)

/*Eliminate information for inexistent weeks and people not in the universe*/
drop if rwkesr==-1

rename rhcalmn month
rename rhcalyr year

save "long_2008.dta", replace

local wvlist wave2 wave3 wave4 wave5 wave6 wave7 wave8 wave9 wave10

foreach filename of local wvlist{

use `"`filename'"'

foreach v of varlist _all {
capture rename `v' `=lower("`v'")'
}

gen panel=2008
egen pid=group(ssuid epppnum)

reshape long rwkesr, i(pid rhcalmn rhcalyr) j(week)

/*Eliminate information for inexistent weeks*/
drop if rwkesr==-1

rename rhcalmn month
rename rhcalyr year

append using "long_2008.dta"
save "long_2008.dta",replace
}

drop pid
egen pid=group(ssuid epppnum)

/*Keep only individuals that have held a job at some point*/
gen working=0
replace working=1 if rwkesr<=3
by pid,sort: egen ever_working=sum(working)
keep if ever_working>0
drop ever_working working

/*Keep only individuals that have looked for a job at some point*/
gen looking=0
replace looking=1 if rwkesr==4
by pid,sort: egen ever_looking=sum(looking)
keep if ever_looking>0
drop looking ever_looking

save "long_2008",replace

erase "waves_unemp.zip"

zipfile long_2008.dta wave*.dta, saving(waves_unemp)

local filelist wave1.dta wave2.dta wave3.dta wave4.dta wave5.dta wave6.dta wave7.dta wave8.dta wave9.dta wave10.dta long_2008.dta

foreach filename of local filelist{

erase `"`filename'"'
}
