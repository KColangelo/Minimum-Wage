clear all


/*File for estimation of econometric models*/
/*
cd "C:\Users\Kyle\OneDrive\Minimum Wage\SIPP\2014"
*/

cd "C:\Users\gdvia\OneDrive\PhD\Research\Minimum Wage\SIPP\2014"

unzipfile "samples",replace
 
use "sample_14w1",clear
append using "sample_14w2"
append using "sample_14w3"
append using "sample_14w4"

/* Generate ID*/

gen panel=2014
egen pid= group(ssuid pnum)

/*Keep only individuals that have held a job at some point*/
gen working=0
replace working=1 if rwkesr1>=1 & rwkesr1<=3 | rwkesr2>=1 & rwkesr2<=3 | rwkesr3>=1 & rwkesr3<=3 | rwkesr4>=1 & rwkesr4<=3 | rwkesr5>=1 & rwkesr5<=3
by pid,sort: gen ever_working=sum(working)
keep if ever_working>0
drop ever_working working

reshape long rwkesr, i(pid monthcode spanel) j(week)

/*Eliminate information for inexistent weeks*/
drop if week>rwksperm


rename monthcode month
rename spanel year
rename tehc_st tfipsst
destring tfipsst,replace
rename pnum epppnum

gen tpyrate1=tjb1_hourly1
replace tpyrate1=tjb1_hourly2 if tpyrate1==.
replace tpyrate1=tjb1_hourly3 if tpyrate1==.
gen tpyrate2=tjb2_hourly1
replace tpyrate2=tjb2_hourly2 if tpyrate1==.
replace tpyrate2=tjb2_hourly3 if tpyrate1==.

save "long_e2014.dta", replace

erase "samples_emp"

zipfile long_e2014 sample_14w*.dta, saving(samples_emp)

erase "long_2014.dta"
erase "long_e2014.dta"
erase "sample_14w1.dta"
erase "sample_14w2.dta"
erase "sample_14w3.dta"
erase "sample_14w4.dta"
