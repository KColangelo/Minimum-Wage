clear all


/*File for estimation of econometric models*/
/*
cd "C:\Users\Kyle\OneDrive\Minimum Wage\SIPP\2014"
*/

cd "C:\Users\gdvia\OneDrive\PhD\Research\Minimum Wage\SIPP\2014"

unzipfile "pu2014w1",replace
 
#delimit ;
use eawbmort eawbsafe ebornus ecert ecitizen eclub edinrop edinrpar eeduc
egrndpr ejb1_clwrk ejb1_startwk ejb1_strtmon ejb2_startwk ejb1_endwk 
ejb2_strtmon empf ems epar_scrnr erace esex monthcode pnum rany5 rfpersons 
rfrelu18 rwkesr1 rwkesr2 rwkesr3 rwkesr4 rwkesr5 spanel ssuid swave tage 
tdebt_ed tehc_st tjb1_occ tjb1_strtyr tjb2_strtyr tmwkhrs toeddebtval tpearn
trace tyear_fb wpfinwgt tjb1_msum tjb2_msum tjb3_msum tjb4_msum tjb5_msum
tjb6_msum tjb7_msum rmover euc1mnyn euc2mnyn tjb1_hourly1 tjb1_hourly2
 tjb1_hourly3 tjb2_hourly1 tjb2_hourly2 tjb2_hourly3 rwksperm rhnumper
 rmesr rmnumjobs rmwkwjb ejb1_rsend ejb2_rsend using "pu2014w1.dta",  clear;

replace spanel=2013;

save "sample_14w1.dta",replace;
erase "pu2014w1.dta",clear;

unzipfile "pu2014w2",replace;
#delimit ;
use eawbmort eawbsafe ebornus ecert ecitizen eclub edinrop edinrpar eeduc 
egrndpr ejb1_clwrk ejb1_startwk ejb1_strtmon ejb2_startwk ejb1_endwk 
ejb2_strtmon empf ems epar_scrnr erace esex monthcode pnum rany5 rfpersons 
rfrelu18 rwkesr1 rwkesr2 rwkesr3 rwkesr4 rwkesr5 spanel ssuid swave tage 
tdebt_ed tehc_st tjb1_occ tjb1_strtyr tjb2_strtyr tmwkhrs toeddebtval tpearn 
trace tyear_fb wpfinwgt tjb1_msum tjb2_msum tjb3_msum tjb4_msum tjb5_msum
tjb6_msum tjb7_msum tmover euc1mnyn euc2mnyn tjb1_hourly1 tjb1_hourly2
 tjb1_hourly3 tjb2_hourly1 tjb2_hourly2 tjb2_hourly3 rwksperm rhnumper
 rmesr rmnumjobs rmwkwjb ejb1_rsend ejb2_rsend  using "pu2014w2.dta", clear;


save "sample_14w2.dta",replace;
erase "pu2014w2.dta",clear;

unzipfile "pu2014w3",replace;

#delimit ;
use eawbmort eawbsafe ebornus ecert ecitizen eclub edinrop edinrpar eeduc 
egrndpr ejb1_clwrk ejb1_startwk ejb1_strtmon ejb2_startwk ejb1_endwk 
ejb2_strtmon empf ems epar_scrnr erace esex monthcode pnum rany5 rfpersons 
rfrelu18 rwkesr1 rwkesr2 rwkesr3 rwkesr4 rwkesr5 spanel ssuid swave tage 
tdebt_ed tehc_st tjb1_occ tjb1_strtyr tjb2_strtyr tmwkhrs toeddebtval tpearn 
trace tyear_fb wpfinwgt tjb1_msum tjb2_msum tjb3_msum tjb4_msum tjb5_msum
tjb6_msum tjb7_msum tmover euc1mnyn euc2mnyn tjb1_hourly1 tjb1_hourly2
 tjb1_hourly3 tjb2_hourly1 tjb2_hourly2 tjb2_hourly3 rwksperm rhnumper
 rmesr rmnumjobs rmwkwjb ejb1_rsend ejb2_rsend  using "pu2014w3.dta", clear;

replace spanel=2015;

save "sample_14w3.dta",replace;
erase "pu2014w3.dta",clear;

unzipfile "pu2014w4",replace;

#delimit ;
use eawbmort eawbsafe ebornus ecert ecitizen eclub edinrop edinrpar eeduc 
egrndpr ejb1_clwrk ejb1_startwk ejb1_strtmon ejb2_startwk ejb1_endwk 
ejb2_strtmon empf ems epar_scrnr erace esex monthcode pnum rany5 rfpersons 
rfrelu18 rwkesr1 rwkesr2 rwkesr3 rwkesr4 rwkesr5 spanel ssuid swave tage 
tdebt_ed tehc_st tjb1_occ tjb1_strtyr tjb2_strtyr tmwkhrs toeddebtval tpearn 
trace tyear_fb wpfinwgt tjb1_msum tjb2_msum tjb3_msum tjb4_msum tjb5_msum
tjb6_msum tjb7_msum tmover euc1mnyn euc2mnyn tjb1_hourly1 tjb1_hourly2
 tjb1_hourly3 tjb2_hourly1 tjb2_hourly2 tjb2_hourly3 rwksperm rhnumper
 rmesr rmnumjobs rmwkwjb ejb1_rsend ejb2_rsend  using "pu2014w4.dta", clear;

replace spanel=2016;

save "sample_14w4.dta",replace;
erase "pu2014w4.dta",clear;

#delimit 
append using "sample_14w3.dta"
append using "sample_14w2.dta"
append using "sample_14w1.dta"

/* Generate ID*/

gen panel=2014
egen pid= group(ssuid pnum)

/*Keep only individuals that have held a job at some point*/
gen working=0
replace working=1 if rwkesr1>=1 & rwkesr1<=3 | rwkesr2>=1 & rwkesr2<=3 | rwkesr3>=1 & rwkesr3<=3 | rwkesr4>=1 & rwkesr4<=3 | rwkesr5>=1 & rwkesr5<=3
by pid,sort: gen ever_working=sum(working)
keep if ever_working>0
drop ever_working working

/*Keep only individuals that have looked for a job at some point*/
gen looking=0
replace looking=1 if rwkesr1==4 | rwkesr2==4 | rwkesr3==4 | rwkesr4==4 | rwkesr5==4
by pid,sort: gen ever_looking=sum(looking)
keep if ever_looking>0
drop looking ever_looking

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

save "long_2014.dta", replace

erase "samples_unemp.zip"

zipfile long_2014 sample_14w*.dta, saving(samples_unemp)

erase "long_2014.dta"
erase "sample_14w1.dta"
erase "sample_14w2.dta"
erase "sample_14w3.dta"
erase "sample_14w4.dta"
