
/*Join different SIPP*/
/*9/19/20: added points 9.6 and 9.7*/

clear all

//cd "C:\Users\Kyle\OneDrive\Minimum Wage\SIPP"

//cd "C:\Users\ksc91\OneDrive\Minimum Wage\SIPP"



cd "C:\Users\gdvia\OneDrive\PhD\Research\Minimum Wage\SIPP"

/*
use "mw_monthly",clear

gen runvar=0
tsset state monthly_date
forval  i=1/5{
bysort state: replace runvar=cond(F`i'.mw_raise==1,-`i',runvar)
bysort state: replace runvar=cond(L`i'.mw_raise==1,`i',runvar)
}

save "mw_monthly",replace
*/

use "spells.dta",clear

merge m:1 state year using "ui_data.dta", keepusing(weeks_uiben max_wuiben)
keep if _merge==3
drop _merge

// Create necessary measures
{
//1. 2014 has missing value for srotaton, fix:
replace srotaton=1 if srotaton==.
//2. create a unique id for each spell:
egen univ_id=group(panel srotaton uniq_spl_id)

//3. We do not need some observations
//3.1 people older than 65:
bysort univ_id: egen maxage=max(tage)
keep if maxage<66
drop maxage

//3. Some models cannot work with the actual weights
//3.1 constant weights by spell:
bysort univ_id: egen av_wgt=mean(wpfinwgt)
//3.2 integer spells:
gen rwgt=round(wpfinwgt)

//4. fixes for variables
//4.1 eeducate sometimes goes down instead of up, fixing that:
tsset univ_id spell
bysort univ_id: replace eeducate=cond(L.eeducate>eeducate & L.eeducate!=.,L.eeducate,eeducate)
//4.2 Missing information for number of kids under 18, replace with 0:
replace rfnkids=0 if rfnkids==.
//4.3 Reason to stop working is only declared the first month:
gen reasstpwk2=.
replace reasstpwk2=ejb1_rsend if spell==1
replace reasstpwk2=1 if ersend1==9 & spell==1 & reasstpwk2==. | ersend1==10 & spell==1 & reasstpwk2==.
replace reasstpwk2=2 if ersend1==13 & spell==1 & reasstpwk2==.
replace reasstpwk2=3 if ersend1==1 & spell==1 & reasstpwk2==.
replace reasstpwk2=4 if ersend1==11 & spell==1 & reasstpwk2==.
replace reasstpwk2=5 if ersend1==8 & spell==1 & reasstpwk2==.
replace reasstpwk2=7 if ersend1==12 & spell==1 & reasstpwk2==.
replace reasstpwk2=8 if ersend1==14 & spell==1 & reasstpwk2==.
replace reasstpwk2=9 if ersend1==15 & spell==1 & reasstpwk2==.
replace reasstpwk2=10 if ersend1==2 & spell==1 & reasstpwk2==.
replace reasstpwk2=11 if ersend1==3 & spell==1 & reasstpwk2==.
replace reasstpwk2=12 if ersend1==4 & spell==1 & reasstpwk2==.
replace reasstpwk2=13 if ersend1==5 & spell==1 & reasstpwk2==.
replace reasstpwk2=14 if ersend1==6 & spell==1 & reasstpwk2==.
replace reasstpwk2=15 if ersend1==7 & spell==1 & reasstpwk2==.
bysort univ_id: egen reasstpwk=max(reasstpwk2)
// 4.3.1 Some are missing, maybe left censored:
replace reasstpwk=99 if reasstpwk==-1 | reasstpwk==.
drop reasstpwk2
//4.3.2 Create fired and quit variables
gen fired =0
replace fired = 1 if reasstpwk==5
gen quit = 0 
replace quit = 1 if reasstpwk>=7 & reasstpwk<=16
// 4.4 Replace negative incomes/hours with missing
replace last_wage=. if last_wage<0
replace next_wage=. if next_wage<0
replace next_hours=. if next_wage==. | next_wage==0 | next_hours<=0


//5. Covariates to value at spell==1, to control by initial conditions:
//5.1 Age:
gen tageb2=0
replace tageb2= tage if spell==1
bysort univ_id: egen tageb=max(tageb2)
//5.1.1 its sqare:
gen tagesq=tage*tage
gen tagebsq=tageb*tageb
drop tageb2
//5.2 education:
gen eeducateb2=0
replace eeducateb2=eeducate if spell==1
bysort univ_id: egen eeducateb=max(eeducateb2)
drop eeducateb2
// 5.2.1 educ when spell started
gen educb=0
replace educb=1 if eeducateb<39
replace educb=. if eeducateb==.
//5.3 Number of children under 18
gen rfnkidsb2=0
replace rfnkidsb2=rfnkids if spell==1
bysort univ_id: egen rfnkidsb=max(rfnkidsb2)
drop rfnkidsb2


//6. Create dependent variables:
//6.1 Search intensity [0,1]
gen intens=(5-mean_srch)
//6.2 log of last and next wage
gen lnext_wage=ln(next_wage)
gen llast_wage=ln(last_wage)
gen lnext_hours=ln(next_hours+1)
//6.3 Quit looking for a job
gen quit_srch=0
replace quit_srch=1 if spell_length-lastlook>8

//7. Generate inputs for geo-specific time covariants
//7.1 MW tiers
gen tier_mw2=.
replace tier_mw2=1 if mw==7.25 & year==2015
replace tier_mw2=2 if mw>7.25 & mw<8.5 & year==2015
replace tier_mw2=3 if mw>=8.5 & year==2015
bysort state: egen tier_mw=max(tier_mw)
drop tier_mw2
//7.1. Region and Division
gen division=1
replace division=2 if state==34 | state==36 | state==42
replace division=3 if state==18 | state==17 | state==26 | state==39 | state==55
replace division=4 if state==19 | state==20 | state==27 | state==29 | state==31 | state==38 | state==46
replace division=5 if state==10 | state==11 | state==12 | state==13 | state==24 | state==37 | state==45 | state==51 | state==54
replace division=6 if state==1 | state==21 | state==28 | state==47
replace division=7 if state==5 | state==22 | state==40 | state==48
replace division=8 if state==4 | state==8 | state==16 | state==35 | state==30 | state==49 | state==32 | state==56
replace division=9 if state==2 | state==6 | state==15 | state==41 | state==53
gen region=3
replace region=2 if division==3 | division==4
replace region=1 if division==1 | division==2
replace region=4 if division>=8

//8. Create time covariates
//8.1 month of year date:
egen month_year=group(year month)
egen month_yearb=group(yearb monthb)
//8.2 geo-specific time covariates
egen tier_time=group(tier_mw month_year)
egen region_time=group(region month_year)
egen div_time=group(division month_year)
//8.2.1 initial values for geo-specific time covariates
egen tier_timeb=group(tier_mw month_yearb)
egen region_timeb=group(region month_yearb)
egen div_timeb=group(division month_yearb)

//9. Generate other covariates
//9.1 Real minimum wage
merge m:1 year month using "cpi_all", keepusing(cpi)
keep if _merge==3
drop _merge
//9.1.1 real:
gen rmw=mw/cpi
gen lrmw=ln(rmw)
//9.2 Initial minimum wage
gen imw2=mw if spell==1
bysort univ_id: egen imw=max(imw2)
drop imw2
gen limw=ln(imw)
//9.2.1 real:
gen rimw=imw/cpi
gen lrimw=ln(rimw)
//9.3 binary delta_mw categorization
gen delta_mw_bin=0
replace delta_mw_bin=1 if delta_mw!=0
gen fake_delta_mw_bin=0
replace fake_delta_mw_bin=1 if fake_delta_mw!=0
//9.4 Real hourly wage
gen rnext_wage=next_wage/cpi
gen lrnext_wage=ln(rnext_wage)
gen rlast_wage=last_wage/cpi
gen lrlast_wage=ln(rlast_wage)
//9.5 normalized UI max weekly benefits:
gen nmax_wuiben=max_wuiben*weeks_uiben/26
//9.6 Get unempb to assume the same value for all values of each spell
bysort univ_id: egen unempb2=max(unempb)
replace unempb=unempb2
drop unempb2
//9.7 Get month_yearb to assume the same value for all values of each spell
bysort univ_id: egen month_yearb2=max(month_yearb)
replace month_yearb=month_yearb2
drop month_yearb2

//10 Filters:
//10.1 Movers
bysort pid: egen moverflag=max(mover)
replace moverflag=0 if moverflag<4
replace moverflag=1 if moverflag>=4
//10.1.1 spells that encompass a move to another state:
 bysort univ_id: egen maxstate=max(state)
bysort univ_id: egen minstate=min(state)
gen splmoverflag=0
replace splmoverflag=1 if maxstate!=minstate
replace splmoverflag=0 if moverflag==0
drop maxstate minstate
//10.2 minimum and maximum minimum wage for the year
bysort year: egen miny_mw=min(mw)
bysort year: egen maxy_mw=max(mw)
// Dead variable to use with quitting search
gen deadq=dead
replace deadq=1 if spell==spell_length & dead==0
replace deadq=0 if dead==0 & spell_length<53

//11 Interactions:
//11.1 Delta mw ranges (based on quantiles):
gen delta_mw_rng=4
replace delta_mw_rng=3 if delta_mw<11.54
replace delta_mw_rng=2 if delta_mw<=8
replace delta_mw_rng=1 if delta_mw<3.226
replace delta_mw_rng=0 if delta_mw_bin==0
//11.2 Education attainment <=HS v. >HS
gen educ=0
replace educ=1 if eeducate<39
replace educ=. if eeducate==.
//11.3 Teenagers:
gen teen=0
replace teen=1 if tageb<20
//11.4 1st decile
gen decile=0
replace decile=1 if year==2000 & last_wage<=5.15
replace decile=1 if year==2001 & last_wage<=5.65
replace decile=1 if year==2002 & last_wage<=5.75
replace decile=1 if year==2003 & last_wage<=5.75
replace decile=1 if year==2004 & last_wage<=6
replace decile=1 if year==2005 & last_wage<=6
replace decile=1 if year==2006 & last_wage<=6.5
replace decile=1 if year==2007 & last_wage<=6.5
replace decile=1 if year==2008 & last_wage<=7
replace decile=1 if year==2009 & last_wage<=7.25
replace decile=1 if year==2010 & last_wage<=7.5
replace decile=1 if year==2011 & last_wage<=7.5
replace decile=1 if year==2014 & last_wage<=7.65
replace decile=1 if year==2015 & last_wage<=8

replace decile=. if last_wage==.
replace decile=. if last_wage<3
replace decile=. if dead==0
//11.5 Federal mw change:
gen federal2=0
replace federal2=1 if year>=2007 & year<=2009 & month==7 & week==4
bysort univ_id: egen federal=max(federal2)
drop federal2
//11.6 low income worker according to last wage
gen lowinc=0
replace lowinc=1 if last_wage<=1.2*imw
replace lowinc=. if last_wage==. | last_wage<=3
table lowinc if next_wage>4 & next_wage<300
//11.7 Ratio next_wage/mw for quantile regression:
gen dist_mw=next_wage/mw
replace dist_mw=. if next_wage<.8*mw | next_wage>300
//12. Variables of interest
drop delta_mw
gen delta_mw=ln(mw)-ln(imw)

//12.2 delta_mw for hazard with federal interaction:
gen var_mwfed=var_mw*delta_fed
gen lvar_mwfed=ln(var_mwfed)
//12.2.1 real:
gen var_rmwfed=var_rmw*delta_fed
gen lvar_rmwfed=ln(var_rmwfed)

//13. Create a variable to figure out impact of policy by income level.
//13.1 times_mmw: how many times the minimum monthly mw is/was earn(ed)
//13.1.1 for last_wage:
bysort month_yearb: egen min_mmw=min(imw)
gen times_mmw_lw=last_wage/min_mmw
gen ltimes_mmw_lw=ln(times_mmw_lw)
//13.1.2 for next_wage
bysort month_year: egen min_mmw2=min(mw)
gen times_mmw_nw=next_wage/min_mmw2
gen ltimes_mmw_nw=ln(times_mmw_nw)
drop min_mmw min_mmw2

gen uncensored2=0
replace uncensored2=dead if spell==spell_length
bysort univ_id: egen uncensored=max(uncensored2)
drop uncensored2
}

//Figure 1: trends by mw level - panels 2001-04 only:

gen round_imw=round(imw)

table round_imw if spell==1 & moverflag==0 & spell_length>1  & panel<2008 [aw=wpfinwgt], c(mean educb mean teen mean unempb sum spell)

reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb mw delta_mw spell_length if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt], robust

//Table 1: correlation analysis for mw

eststo bal1: quietly reg limw i.state i.month_yearb tageb educb teen unempb rfnkidsb fired quit if moverflag==0 & spell==1 & spell_length>1 & spell_length<41 [w=wpfinwgt], cluster(state)
eststo bal2: quietly reg limw i.state i.month_yearb tageb educb teen unempb rfnkidsb fired quit if moverflag==0 & deadq==1 & spell_length>1 & spell_length<41 [w=wpfinwgt], cluster(state)
eststo bal3: quietly reg limw i.state i.month_yearb tageb educb teen unempb rfnkidsb fired quit if next_wage>4 & next_wage<300 & moverflag==0 & dead==1 & spell_length<41 & spell_length>1 [w=wpfinwgt], cluster(state)
esttab bal*, se keep(educb teen unempb fired quit)

//Table 2: summary statistics
gen bal_groups=0 if spell_length==1
replace bal_groups=1 if moverflag==1 & spell==1 & bal_groups!=0
gen test=2 if spell==spell_length & dead==0
bysort univ_id: egen fix=max(test)
replace bal_groups=2 if spell==1 & fix==2 & bal_groups==.
drop test fix
gen test=3 if spell==spell_length & dead==1
bysort univ_id: egen fix=max(test)
replace bal_groups=3 if spell==1 & fix==3 & bal_groups==.
drop test fix
label define bal_groups 0 "spell=1" 1 "movers" 2 "censored" 3 "uncensored"
label values bal_groups bal_groups

table bal_groups [aw=wpfinwgt], c(mean tageb sd tageb mean esex sd esex n tageb)
table bal_groups [aw=wpfinwgt], c(mean educb sd educb mean teen sd teen n educb)
table bal_groups [aw=wpfinwgt], c(mean unempb sd unempb mean fired sd fired n unempb)
table bal_groups [aw=wpfinwgt], c(mean mw sd mw mean imw sd imw)
table bal_groups [aw=wpfinwgt], c(mean intens sd intens mean spell_length sd spell_length n intens)
table bal_groups [aw=wpfinwgt] if delta_mw_bin==1, c(mean delta_mw sd delta_mw)
table bal_groups if rlast_wage>3 & rlast_wage!=. [aw=wpfinwgt], c(mean last_wage sd last_wage n delta_mw)
table erace bal_groups [aw=wpfinwgt]

//Where are people with within spell variation going to in terms of mw:
summ delta_mw if delta_mw_bin!=0 & moverflag==1 & spell==1, detail
summ delta_mw if delta_mw_bin!=0 & moverflag==1 & spell==1 & delta_mw<0
summ delta_mw if delta_mw_bin!=0 & moverflag==1 & spell==1 & delta_mw>0


//Figure 2: spell started before or ended before a mw change:
merge m:1 state monthb yearb using "mw_monthly", keepusing(runvar)
keep if _merge==3
drop _merge

rename runvar runvarb

gen categb=0
replace categb=1 if runvarb!=0

forval i=1/5{
replace runvarb=-`i' if monthb==13-`i' & runvarb==0 & yearb!=2007 & yearb!=2008 & yearb!=2009
replace runvarb=`i' if monthb==1+`i' & runvarb==0 & yearb!=2007 & yearb!=2008 & yearb!=2009
replace runvarb=-`i' if monthb==7-`i' & runvarb==0 & yearb>=2007 & yearb<=2009
replace runvarb=`i' if monthb==7+`i' & runvarb==0 & yearb>=2007 & yearb<=2009
}

merge m:1 state month year using "mw_monthly", keepusing(runvar)
keep if _merge==3
drop _merge

gen categ=0
replace categ=1 if runvar!=0

forval i=1/5{
replace runvar=-`i' if month==13-`i' & runvar==0 & year!=2007 & year!=2008 & year!=2009
replace runvar=`i' if month==1+`i' & runvar==0 & year!=2007 & year!=2008 & year!=2009
replace runvar=-`i' if month==7-`i' & runvar==0 & year>=2007 & year<=2009
replace runvar=`i' if month==7+`i' & runvar==0 & year>=2007 & year<=2009
}

table runvarb categb if runvarb!=0 & spell<=52 & spell_length>1 & moverflag==0 [w=rwgt]
table runvar categ if runvar!=0 & spell<=52 & spell_length>1 & moverflag==0 [w=rwgt]

// Heterogeneity considerations

//gen educ2=educ
//replace educ2=1 if eeducate==39
//table eeducate educ2 if spell==1

bysort teen: summ rlast_wage if moverflag==0 & spell_length>1 & dead==1 & rlast_wage>3 & rlast_wage!=. [w=wpfinwgt],detail
bysort erace: summ rlast_wage if moverflag==0 & spell_length>1 & dead==1 & rlast_wage>3 & rlast_wage!=. [w=wpfinwgt],detail
bysort educ: summ rlast_wage if moverflag==0 & spell_length>1 & dead==1 & rlast_wage>3 & rlast_wage!=. [w=wpfinwgt],detail
bysort esex: summ educ rlast_wage tage if moverflag==0 & spell_length>1 & dead==1 & rlast_wage>3 & rlast_wage!=. [w=wpfinwgt],detail

//table diffs between men and women
bysort esex: summ educ tage if moverflag==0 & spell_length>1 & dead==1 & spell_length<53 [w=wpfinwgt]
bysort esex: summ rlast_wage if moverflag==0 & spell_length>1 & dead==1 & rlast_wage>3 & rlast_wage!=. [w=wpfinwgt]
bysort esex: summ quit_srch spell_length if moverflag==0 & spell_length>1 & deadq==1 & rlast_wage>3 & rlast_wage!=. & delta_mw==0 [w=wpfinwgt]

//Regressions

gen months_since_change2 = 0

bysort univ_id: replace months_since_change2 = cond(spell!=1, L.months_since_change2,months_since_change)



//Create indicators for when the change took place
// Groups for less than two months and more than 2 months. 
// Less than 2 months indicator excludes those that have
// A change which occurred during the spell. This is only
// an indicator for changes that occurred before a spell
/*
gen last_change_when = 0
replace last_change_when = 1 if months_since_change <=2 & lchange==0
replace last_change_when = 2 if months_since_change>2
gen inter = 0
replace inter = last_change*months_since_change



gen one_over = 1/months_since_change2
replace one_over=1 if months_since_change2==0
gen test=months_since_change2
replace test=4 if months_since_change2>=4
replace test=1 if test==0
xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw lchange i.test if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
*/



merge m:1 state month year week using "mw_monthly", keepusing(fake_change)
bysort univ_id: replace fake_change = fake_change[_n-1] if fake_change==0 & fake_change[_n-1]!=.
replace fake_change=0 if fake_change==.

timer on 1
estimates clear
stset spell [pweight=av_wgt], id(univ_id) failure(dead==1)
xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw fake_change if spell<=14 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster pid)

correlate fake_change2 delta_mw if spell<=52 & spell_length>1 & moverflag==0 & dead==1

eststo length1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp max_wuiben i.esex i.eeducate limw delta_mw if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster pid)
eststo length2: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp max_wuiben i.esex i.eeducate c.limw##educ c.delta_mw##educ if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster pid)
eststo length3: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp max_wuiben i.eeducate c.limw##i.esex c.delta_mw##i.esex if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster pid)
eststo length4: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp max_wuiben i.esex i.eeducate c.limw##teen c.delta_mw##teen if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster pid)
eststo length5: quietly xi: streg i.month_year i.state i.reasstpwk tage tagesq rfnkids unemp max_wuiben i.esex i.eeducate c.limw##i.erace c.delta_mw##i.erace if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster pid)
eststo length6: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp max_wuiben i.esex i.eeducate c.limw##c.lrlast_wage c.delta_mw##c.lrlast_wage if spell<=52 & spell_length>1 & moverflag==0 & last_wage>3 & last_wage!=., distribution(lognormal) vce(cluster pid)
eststo length7: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp max_wuiben i.eeducate c.limw##i.esex##educ c.delta_mw##i.esex##educ if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster pid)

eststo intens1:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb delta_mw limw if moverflag==0 & deadq==1 & spell_length>1 [w=wpfinwgt], cluster(pid)
eststo intens2:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##educ c.limw##educ if moverflag==0 & deadq==1 & spell_length>1 [w=wpfinwgt], cluster(pid)
eststo intens3:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb max_wuiben unempb c.delta_mw##i.esex c.limw##i.esex if moverflag==0 & deadq==1 & spell_length>1 [w=wpfinwgt], cluster(pid)
eststo intens4:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##teen c.limw##teen if moverflag==0 & deadq==1 & spell_length>1 [w=wpfinwgt], cluster(pid)
eststo intens5:quietly reg intens i.state i.month_yearb i.reasstpwk tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##i.erace c.limw##i.erace if moverflag==0 & deadq==1 & spell_length>1 [w=wpfinwgt], cluster(pid)
eststo intens6:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##c.lrlast_wage c.limw##c.lrlast_wage if moverflag==0 & deadq==1 & spell_length>1 & last_wage>3 & last_wage!=. [w=wpfinwgt], cluster(pid)

eststo quit1: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb delta_mw limw if moverflag==0 & deadq==1 & spell_length>1 [w=rwgt], cluster(pid)
eststo quit2: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##educ c.limw##educ if moverflag==0 & deadq==1 & spell_length>1 [w=rwgt], cluster(pid)
eststo quit3: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb max_wuiben unempb c.delta_mw##i.esex c.limw##i.esex if moverflag==0 & deadq==1 & spell_length>1 [w=rwgt], cluster(pid)
eststo quit4: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##teen c.limw##teen if moverflag==0 & deadq==1 & spell_length>1 [w=rwgt], cluster(pid)
eststo quit5: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb max_wuiben unempb c.delta_mw##i.erace c.limw##i.erace if moverflag==0 & deadq==1 & spell_length>1 [w=rwgt], cluster(pid)
eststo quit6: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##c.lrlast_wage c.limw##c.lrlast_wage if moverflag==0 & deadq==1 & spell_length>1 & last_wage>3 & last_wage!=. [w=rwgt], cluster(pid)

eststo nextw1: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb delta_mw limw if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo nextw2: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##educ c.limw##educ if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo nextw3: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb max_wuiben unempb c.delta_mw##i.esex c.limw##i.esex if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo nextw4: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##teen c.limw##teen if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo nextw5: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##i.erace c.limw##i.erace if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt], cluster(pid)
eststo nextw6: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##c.lrlast_wage c.limw##c.lrlast_wage if spell_length<=52 & moverflag==0 & dead==1 & last_wage>3 & spell_length>1 & last_wage!=. [w=wpfinwgt], cluster(pid)

eststo nexth1: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb delta_mw limw if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo nexth2: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##educ c.limw##educ if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo nexth3: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb max_wuiben unempb c.delta_mw##i.esex c.limw##i.esex if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo nexth4: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##teen c.limw##teen if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo nexth5: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##i.erace c.limw##i.erace if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt], cluster(pid)
eststo nexth6: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##c.lrlast_wage c.limw##c.lrlast_wage if spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 & last_wage>3 & last_wage!=. [w=wpfinwgt], cluster(pid)

esttab using "results 09_04_20.csv",replace
timer off 1
timer list

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


// Testing whether people that lost their job within one month AFTER a mw change are affected too:

drop week_mw
gen month_aft=month
gen year_aft=year
merge m:1 state month_aft year_aft using "mw_monthly",keepusing(min_mw max_mw week_mw)
drop if _merge==2
drop _merge

gen mw_aft=min_mw
replace mw_aft=max_mw if week>=week_mw

gen imw_aft2=mw_aft if spell==1
replace imw_aft2=0 if imw_aft2==.
bysort univ_id: egen imw_aft=max(imw_aft2)

gen limw_aft=ln(imw_aft)
// option 2(b)
gen delta_mw_aft_b=ln(mw_aft)-ln(imw_aft)

//option 1
gen delta_mw_aft=delta_mw
replace delta_mw_aft=delta_mw_aft_b if delta_mw_aft==0

////

// Testing for two months after:

drop week_mw
gen month_2aft=month
gen year_2aft=year
merge m:1 state month_2aft year_2aft using "mw_monthly",keepusing(min_mw max_mw week_mw)
drop if _merge==2
drop _merge

gen mw_2aft=min_mw
replace mw_2aft=max_mw if week>=week_mw

gen imw_2aft2=mw_2aft if spell==1
replace imw_2aft2=0 if imw_2aft2==.
bysort univ_id: egen imw_2aft=max(imw_2aft2)

gen limw_2aft=ln(imw_2aft)
//option 2(b)
gen delta_mw_2aft_b=ln(mw_2aft)-ln(imw_2aft)

//option 1
gen delta_mw_2aft=delta_mw
replace delta_mw_2aft=delta_mw_2aft_b if delta_mw_2aft==0


drop min_mw max_mw week_mw imw_2aft2


// Testing for three months after:

gen month_3aft=month
gen year_3aft=year
merge m:1 state month_3aft year_3aft using "mw_monthly",keepusing(min_mw max_mw week_mw)
drop if _merge==2
drop _merge

gen mw_3aft=min_mw
replace mw_3aft=max_mw if week>=week_mw

gen imw_3aft2=mw_3aft if spell==1
replace imw_3aft2=0 if imw_3aft2==.
bysort univ_id: egen imw_3aft=max(imw_3aft2)

gen limw_3aft=ln(imw_3aft)
//option 2(b)
gen delta_mw_3aft_b=ln(mw_3aft)-ln(imw_3aft)

//option 1
gen delta_mw_3aft=delta_mw
replace delta_mw_3aft=delta_mw_3aft_b if delta_mw_3aft==0

drop min_mw max_mw week_mw imw_3aft2


// Testing for one month BEFORE (as counterfactual):

drop week_mw
gen month_bef=month
gen year_bef=year
merge m:1 state month_bef year_bef using "mw_monthly",keepusing(min_mw max_mw week_mw)
drop if _merge==2
drop _merge

gen mw_bef=min_mw
replace mw_bef=max_mw if week>=week_mw

gen imw_bef2=mw_bef if spell==1
replace imw_bef2=0 if imw_bef2==.
bysort univ_id: egen imw_bef=max(imw_bef2)

gen limw_bef=ln(imw_bef)
// option 2(b)
gen delta_mw_bef_b=ln(mw_bef)-ln(imw_bef)

//option 1
gen delta_mw_bef=delta_mw
replace delta_mw_bef=delta_mw_bef_b if delta_mw_bef==0

drop min_mw max_mw week_mw imw_bef2

// Add them all to the regression:

gen delta_mw_bef1=delta_mw_bef
replace delta_mw_bef1=0 if delta_mw!=0
gen delta_mw_aft1=delta_mw_aft
replace delta_mw_aft1=0 if delta_mw!=0
gen delta_mw_2aft1=delta_mw_2aft
replace delta_mw_2aft1=0 if delta_mw!=0
gen delta_mw_3aft1=delta_mw_3aft
replace delta_mw_3aft1=0 if delta_mw!=0

summ delta_mw delta_mw_bef1 delta_mw_aft1 delta_mw_2aft1 delta_mw_3aft1 if moverflag==0 & spell_length>1 & spell==spell_length & spell<53

summ delta_mw_bef1 if delta_mw_bef1!=0 & spell==spell_length
summ delta_mw_aft1 if delta_mw_aft1!=0 & spell==spell_length
summ delta_mw_2aft1 if delta_mw_2aft1!=0 & spell==spell_length
summ delta_mw_3aft1 if delta_mw_3aft1!=0 & spell==spell_length

gen delta_mw_2aft2=delta_mw_2aft1
replace delta_mw_2aft2=0 if delta_mw_aft1!=0
summ delta_mw_2aft2 if delta_mw_2aft1!=0 & delta_mw_2aft2==0 & spell==spell_length
gen delta_mw_3aft2=delta_mw_3aft1
replace delta_mw_3aft2=0 if delta_mw_aft1!=0 | delta_mw_2aft1!=0
summ delta_mw_3aft2 if delta_mw_2aft1!=0 & delta_mw_2aft1!=0 & delta_mw_3aft==0 & spell==spell_length

gen delta_mw_aft2=delta_mw_aft1
replace delta_mw_aft2=delta_mw_2aft1 if delta_mw_aft2==0 & delta_mw_2aft1!=0

stset spell [pweight=av_wgt], id(univ_id) failure(dead==1)
eststo length_spill1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw delta_mw_bef1 delta_mw_aft1 delta_mw_2aft1 delta_mw_3aft1 if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo length_spill2: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_bef1 delta_mw_aft1 delta_mw_2aft1 delta_mw_3aft1 if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo length_spill3: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw delta_mw_bef1 delta_mw_aft1 delta_mw_2aft2 delta_mw_3aft2 if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo length_spill4: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_bef1 delta_mw_aft1 delta_mw_2aft2 delta_mw_3aft2 if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo length_spill5: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw delta_mw_bef1 delta_mw_aft2 delta_mw_3aft2 if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo length_spill6: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw delta_mw_bef1 delta_mw_aft delta_mw_2aft2 delta_mw_3aft2 if spell<=52 & spell_length>1 & spell_length<=24 & moverflag==0, distribution(lognormal) vce(cluster state)
esttab length_spill*,se keep(limw delta_mw delta_mw_bef1 delta_mw_aft1 delta_mw_2aft1 delta_mw_3aft1 delta_mw_2aft2 delta_mw_3aft2 delta_mw_aft2)

stset spell [pweight=av_wgt], id(univ_id) failure(dead==1)
eststo length_befaft_a1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_bef if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo length_befaft_a2: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_aft if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo length_befaft_a3: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_2aft if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo length_befaft_a4: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_3aft if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
esttab length_befaft_a*,se keep(limw delta_mw_bef delta_mw_aft delta_mw_2aft delta_mw_3aft)

stset spell [pweight=av_wgt], id(univ_id) failure(dead==1)
eststo length_befaft_b1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_bef_b if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo length_befaft_b2: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_aft_b if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo length_befaft_b3: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_2aft_b if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo length_befaft_b4: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_3aft_b if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
esttab length_befaft_b*,se keep(limw delta_mw_bef_b delta_mw_aft_b delta_mw_2aft_b delta_mw_3aft_b)
//option 1: limw: -0.137 and delta_mw_aft: 1.322*** | option 2: limw -0.191 and delta_mw_aft: 1.185**


estimates clear
stset spell [pweight=av_wgt], id(univ_id) failure(dead==1)
eststo length2aft1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_2aft if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
esttab length2aft1,se keep(limw delta_mw_2aft)
//option 1: limw: -0.187 and delta_mw_2aft: 1.277*** | option 2: limw -0.191 and delta_mw_2aft:

estimates clear
stset spell [pweight=av_wgt], id(univ_id) failure(dead==1)
eststo length3aft1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_3aft if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
esttab length3aft1,se keep(limw delta_mw_3aft)
//option 1: limw: -0.214 and delta_mw_3aft: 1.008*** | option 2: limw -0.263* and delta_mw_3aft: 1.114***





estimates clear
stset spell [pweight=av_wgt], id(univ_id) failure(dead==1)
eststo lengthbef1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_bef if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
esttab lengthbef1,se keep(limw delta_mw_bef)
//option 1: limw: -0.164 and delta_mw_bef: 0.976** | option 2: limw -0.191 and delta_mw_bef: 




////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


//Propensity score weighting
merge m:1 state month year week using "mw_monthly", keepusing(fake_change)
bysort univ_id: replace fake_change = fake_change[_n-1] if fake_change==0 & fake_change[_n-1]!=.
replace fake_change=0 if fake_change==.


gen change_freq=0.396766
replace change_freq=1.523605 if panel==2004
replace change_freq=2.085809 if panel==2008
replace change_freq=1.185286 if panel==2014

gen survey_length=139
replace survey_length=209 if panel==2004
replace survey_length=174 if panel==2008
replace survey_length=186 if panel==2014

gen prop_scr=change_freq*spell_length/(survey_length-spell_length)
replace prop_scr=. if spell_length>52

gen ips=prop_scr/(1-prop_scr)

gen wips=ips*wpfinwgt
replace wips=wpfinwgt if delta_mw!=0
replace wips=0 if wips<0
bysort univ_id: egen av_wips=mean(wips)

gen rwips=round(wips)
gen rav_wips=round(av_wips)

// Select either the min between the last observation and the 35th observation per spell:
gen selected=0
replace selected=1 if spell==spell_length
replace selected=0 if spell>35
replace selected=1 if selected==0 & spell==35

bysort univ_id: egen complete=sum(dead)
// Weighted results

estimates clear
stset spell [pweight=av_wips], id(univ_id) failure(dead==1)
eststo length1: quietly xi: streg i.month_yearb i.state i.reasstpwk i.erace tageb tagebsq rfnkidsb max_wuiben unempb i.esex i.eeducateb limw delta_mw if spell_length<=52 & moverflag==0 & dead==1, distribution(lognormal) vce(cluster pid)
eststo length2: quietly xi: streg i.month_yearb i.state i.reasstpwk i.erace tageb tagebsq rfnkidsb max_wuiben unempb i.esex i.eeducateb c.limw##educ c.delta_mw##educ if spell_length<=52 & moverflag==0 & dead==1, distribution(lognormal) vce(cluster pid)
eststo length3: quietly xi: streg i.month_yearb i.state i.reasstpwk i.erace tageb tagebsq rfnkidsb max_wuiben unempb i.eeducateb c.limw##i.esex c.delta_mw##i.esex if spell_length<=52 & moverflag==0 & dead==1, distribution(lognormal) vce(cluster pid)
eststo length4: quietly xi: streg i.month_yearb i.state i.reasstpwk i.erace tageb tagebsq rfnkidsb max_wuiben unempb i.esex i.eeducateb c.limw##teen c.delta_mw##teen if spell_length<=52 &  moverflag==0 & dead==1, distribution(lognormal) vce(cluster pid)
eststo length5: quietly xi: streg i.month_yearb i.state i.reasstpwk tageb tagebsq rfnkidsb max_wuiben unempb i.esex i.eeducateb c.limw##i.erace c.delta_mw##i.erace if spell_length<=52 &  moverflag==0 & dead==1, distribution(lognormal) vce(cluster pid)
eststo length6: quietly xi: streg i.month_yearb i.state i.reasstpwk i.erace tageb tagebsq rfnkidsb max_wuiben unempb i.esex i.eeducateb c.limw##c.lrlast_wage c.delta_mw##c.lrlast_wage if spell_length<=52 & moverflag==0 & dead==1 & last_wage>3 & last_wage!=., distribution(lognormal) vce(cluster pid)
//eststo length7: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unempb i.eeducate c.limw##i.esex##educ c.delta_mw##i.esex##educ if spell_length<=52 & moverflag==0 & dead==1, distribution(lognormal) vce(cluster pid)
esttab length*,se keep(limw delta_mw 1.educ#c.limw 1.educ#c.delta_mw 2.esex#c.limw 2.esex#c.delta_mw 1.teen#c.limw 1.teen#c.delta_mw 2.erace#c.limw  2.erace#c.delta_mw 3.erace#c.limw 3.erace#c.delta_mw 4.erace#c.limw 4.erace#c.delta_mw c.limw#c.lrlast_wage c.delta_mw#c.lrlast_wage)

eststo intens1:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb delta_mw limw if spell_length<=52 & moverflag==0 & deadq==1 [w=wips], cluster(pid)
eststo intens2:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##educ c.limw##educ if spell_length<=52 & moverflag==0 & deadq==1 [w=wips], cluster(pid)
eststo intens3:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb max_wuiben unempb c.delta_mw##i.esex c.limw##i.esex if spell_length<=52 & moverflag==0 & deadq==1 [w=wips], cluster(pid)
eststo intens4:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##teen c.limw##teen if spell_length<=52 & moverflag==0 & deadq==1 [w=wips], cluster(pid)
eststo intens5:quietly reg intens i.state i.month_yearb i.reasstpwk tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##i.erace c.limw##i.erace if spell_length<=52 & moverflag==0 & deadq==1 [w=wips], cluster(pid)
eststo intens6:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##c.lrlast_wage c.limw##c.lrlast_wage if spell_length<=52 & moverflag==0 & deadq==1 & last_wage>3 & last_wage!=. [w=wips], cluster(pid)

eststo quit1: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb delta_mw limw if spell_length<=52 & moverflag==0 & deadq==1 & dead==1 [w=rwips], cluster(pid)
eststo quit2: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##educ c.limw##educ if spell_length<=52 & moverflag==0 & deadq==1 & dead==1 [w=rwips], cluster(pid)
eststo quit3: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb max_wuiben unempb c.delta_mw##i.esex c.limw##i.esex if spell_length<=52 & moverflag==0 & deadq==1 & dead==1 [w=rwips], cluster(pid)
eststo quit4: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##teen c.limw##teen if spell_length<=52 & moverflag==0 & deadq==1 & dead==1 [w=rwips], cluster(pid)
eststo quit5: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb max_wuiben unempb c.delta_mw##i.erace c.limw##i.erace if spell_length<=52 & moverflag==0 & deadq==1 & dead==1 [w=rwips], cluster(pid)
eststo quit6: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##c.lrlast_wage c.limw##c.lrlast_wage if spell_length<=52 & moverflag==0 & deadq==1 & dead==1 & last_wage>3 & last_wage!=. [w=rwips], cluster(pid)

eststo nextw1: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb delta_mw limw if spell_length<=52 & moverflag==0 & dead==1 & next_wage>4 & next_wage<300 [w=wips],cluster(pid)
eststo nextw2: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##educ c.limw##educ if spell_length<=52 & moverflag==0 & dead==1 & next_wage>4 & next_wage<300 [w=wips],cluster(pid)
eststo nextw3: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb max_wuiben unempb c.delta_mw##i.esex c.limw##i.esex if spell_length<=52 & moverflag==0 & dead==1 & next_wage>4 & next_wage<300 [w=wips],cluster(pid)
eststo nextw4: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##teen c.limw##teen if spell_length<=52 & moverflag==0 & dead==1 & next_wage>4 & next_wage<300 [w=wips],cluster(pid)
eststo nextw5: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##i.erace c.limw##i.erace if spell_length<=52 & moverflag==0 & dead==1 & next_wage>4 & next_wage<300 [w=wips],cluster(pid)
eststo nextw6: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##c.lrlast_wage c.limw##c.lrlast_wage if spell_length<=52 & moverflag==0 & dead==1 & next_wage>4 & next_wage<300 & last_wage>3 & last_wage!=. [w=wips], cluster(pid)

eststo nexth1: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb delta_mw limw if spell_length<=52 & moverflag==0 & dead==1 & next_wage>4 & next_wage<300 [w=wips],cluster(pid)
eststo nexth2: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##educ c.limw##educ if spell_length<=52 & moverflag==0 & dead==1 & next_wage>4 & next_wage<300 [w=wips],cluster(pid)
eststo nexth3: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb max_wuiben unempb c.delta_mw##i.esex c.limw##i.esex if spell_length<=52 & moverflag==0 & dead==1 & next_wage>4 & next_wage<300 [w=wips],cluster(pid)
eststo nexth4: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##teen c.limw##teen if spell_length<=52 & moverflag==0 & dead==1 & next_wage>4 & next_wage<300 [w=wips],cluster(pid)
eststo nexth5: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##i.erace c.limw##i.erace if spell_length<=52 & moverflag==0 & dead==1 & next_wage>4 & next_wage<300 [w=wips],cluster(pid)
eststo nexth6: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##c.lrlast_wage c.limw##c.lrlast_wage if spell_length<=52 & moverflag==0 & dead==1 & next_wage>4 & next_wage<300 & last_wage>3 & last_wage!=. [w=wips], cluster(pid)

set matsize 10000
esttab using "results 09_04_20 wips52w.csv",replace

//Testing whether indexing is different: Arizona(4), Colorado(8), Florida(12), Missouri(29), Montana(30), Ohio(39), Oregon(41), Vermont(50), and Washington(53)
gen st_indexing=0
replace st_indexing=1 if state==4 & yearb>=2010 | state==8 & yearb>=2010 | state==12 & yearb>=2010 | state==29 & yearb>=2013 | state==30 & yearb>=2010 | state==39 & yearb>=2010 | state==41 & yearb>=2010 | state==50 & yearb>=2010 | state==53 & yearb>=2010
gen large_delta=delta_mw
replace large_delta=0 if small_delta!=0
estimates clear
stset spell [pweight=av_wgt], id(univ_id) failure(dead==1)
eststo length1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate limw delta_mw_bin if spell<=52 & moverflag==0, distribution(lognormal) vce(cluster pid)
esttab length1,se keep(limw delta_mw 1.st_indexing#c.delta_mw 1.st_indexing)
eststo intens1:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##st_indexing limw if spell_length<=52 & moverflag==0 & deadq==1 & dead==1 [w=wpfinwgt], cluster(pid)
eststo intens2:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb max_wuiben unempb c.delta_mw##st_indexing limw if spell_length<=52 & moverflag==0 & deadq==1 & dead==1 [w=wpfinwgt], cluster(pid)
esttab intens*,se keep(limw delta_mw 1.st_indexing#c.delta_mw 1.st_indexing)

// Interpreting coefficients from logistic regression:

merge m:1 state using "logit state coef", keepusing(state_coef)
drop _merge
merge m:1 eeducateb using "logit educ coef", keepusing(educ_coef)
drop _merge
merge m:1 month_yearb using "logit time coef", keepusing(date_coef)
drop _merge
merge m:1 erace using "logit erace coef", keepusing(race_coef)
drop _merge
merge m:1 reasstpwk using "logit reasstpwk coef", keepusing(reasstpwk_coef)
drop _merge

gen coef_esex=0
replace coef_esex=.334 if esex==2

gen xbeta=.
replace xbeta=-3.475+state_coef+educ_coef+date_coef+race_coef-.12*tageb+.000162*tagebsq-0.0593*rfnkidsb+coef_esex+4.553*unempb+10.62*delta_mw+1.998*limw if spell_length>1 & moverflag==0 & deadq==1
gen f_xbeta=logisticden(xbeta) if xbeta!=.

egen mean_fxb=wtmean(f_xbeta),weight(wpfinwgt)

gen est_effect=1.998*mean_fxb
gen est_effect_delta=10.62*mean_fxb

codebook est_effect est_effect_delta


// Wage regressions

// Effects on future Wages - All Workers

estimates clear
forval i=4 8:80{
eststo: quietly regress hwage_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.esex i.eeducateb max_wuiben unempb unemp_f`i'w delta_mw limw if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt]
}
suest est*,cluster(pid)
test [est1_mean]limw=[est2_mean]limw=[est3_mean]limw=[est4_mean]limw=[est5_mean]limw=[est6_mean]limw=[est7_mean]limw=[est8_mean]limw=[est9_mean]limw=[est10_mean]limw=[est11_mean]limw=[est12_mean]limw=[est13_mean]limw=[est14_mean]limw=[est15_mean]limw=[est16_mean]limw=[est17_mean]limw=[est18_mean]limw=[est19_mean]limw=[est20_mean]limw
test [est1_mean]delta_mw=[est2_mean]delta_mw=[est3_mean]delta_mw=[est4_mean]delta_mw=[est5_mean]delta_mw=[est6_mean]delta_mw=[est7_mean]delta_mw=[est8_mean]delta_mw=[est9_mean]delta_mw=[est10_mean]delta_mw=[est11_mean]delta_mw=[est12_mean]delta_mw=[est13_mean]delta_mw=[est14_mean]delta_mw=[est15_mean]delta_mw=[est16_mean]delta_mw=[est17_mean]delta_mw=[est18_mean]delta_mw=[est19_mean]delta_mw=[est20_mean]delta_mw

estimates clear
forval i=4 8:80{
eststo: quietly regress hours_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.esex i.eeducateb max_wuiben unempb unemp_f`i'w delta_mw limw if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt]
}
suest est*,cluster(pid)
test [est	1_mean]limw=[est2_mean]limw=[est3_mean]limw=[est4_mean]limw=[est5_mean]limw=[est6_mean]limw=[est7_mean]limw=[est8_mean]limw=[est9_mean]limw=[est10_mean]limw=[est11_mean]limw=[est12_mean]limw=[est13_mean]limw=[est14_mean]limw=[est15_mean]limw=[est16_mean]limw=[est17_mean]limw=[est18_mean]limw=[est19_mean]limw=[est20_mean]limw
test [est1_mean]delta_mw=[est2_mean]delta_mw=[est3_mean]delta_mw=[est4_mean]delta_mw=[est5_mean]delta_mw=[est6_mean]delta_mw=[est7_mean]delta_mw=[est8_mean]delta_mw=[est9_mean]delta_mw=[est10_mean]delta_mw=[est11_mean]delta_mw=[est12_mean]delta_mw=[est13_mean]delta_mw=[est14_mean]delta_mw=[est15_mean]delta_mw=[est16_mean]delta_mw=[est17_mean]delta_mw=[est18_mean]delta_mw=[est19_mean]delta_mw=[est20_mean]delta_mw


estimates clear
forval i=4 8:80{
eststo: quietly regress hwage_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.esex i.eeducateb max_wuiben unempb unemp_f`i'w c.delta_mw##educ c.limw##educ if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt], cluster(state)
}
suest est*,cluster(pid)
test [est1_mean]1.educ#c.limw=[est2_mean]1.educ#c.limw=[est3_mean]1.educ#c.limw=[est4_mean]1.educ#c.limw=[est5_mean]1.educ#c.limw=[est6_mean]1.educ#c.limw=[est7_mean]1.educ#c.limw=[est8_mean]1.educ#c.limw=[est9_mean]1.educ#c.limw=[est10_mean]1.educ#c.limw=[est11_mean]1.educ#c.limw=[est12_mean]1.educ#c.limw=[est13_mean]1.educ#c.limw=[est14_mean]1.educ#c.limw=[est15_mean]1.educ#c.limw=[est16_mean]1.educ#c.limw=[est17_mean]1.educ#c.limw=[est18_mean]1.educ#c.limw=[est19_mean]1.educ#c.limw=[est20_mean]1.educ#c.limw
test [est1_mean]1.educ#c.delta_mw=[est2_mean]1.educ#c.delta_mw=[est3_mean]1.educ#c.delta_mw=[est4_mean]1.educ#c.delta_mw=[est5_mean]1.educ#c.delta_mw=[est6_mean]1.educ#c.delta_mw=[est7_mean]1.educ#c.delta_mw=[est8_mean]1.educ#c.delta_mw=[est9_mean]1.educ#c.delta_mw=[est10_mean]1.educ#c.delta_mw=[est11_mean]1.educ#c.delta_mw=[est12_mean]1.educ#c.delta_mw=[est13_mean]1.educ#c.delta_mw=[est14_mean]1.educ#c.delta_mw=[est15_mean]1.educ#c.delta_mw=[est16_mean]1.educ#c.delta_mw=[est17_mean]1.educ#c.delta_mw=[est18_mean]1.educ#c.delta_mw=[est19_mean]1.educ#c.delta_mw=[est20_mean]1.educ#c.delta_mw


estimates clear
forval i=4 8:144{
eststo: quietly regress hwage_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.esex i.eeducateb max_wuiben unempb unemp_f`i'w delta_mw limw if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt], cluster(pid)
}
esttab,se keep(limw delta_mw) nostar compress

// Effects on future Wages by Education attainment

estimates clear
forval i=4 8:144{
eststo: quietly regress hwage_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.esex i.eeducateb max_wuiben unempb unemp_f`i'w c.delta_mw##educ c.limw##educ if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt], cluster(pid)
nlcom (_b[limw]+_b[1.educ#c.limw]) //levels for low education
nlcom (_b[delta_mw]+_b[1.educ#c.delta_mw]) //changes for low education
}
esttab,se keep(limw delta_mw) nostar compress

// Effects on future Wages by Teen/Adult
estimates clear
forval i=4 8:144{
eststo: quietly regress hwage_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.esex i.eeducateb max_wuiben unempb unemp_f`i'w c.delta_mw##teen c.limw##teen if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt], cluster(pid)
nlcom (_b[limw]+_b[1.teen#c.limw]) //levels for teenagers
nlcom (_b[delta_mw]+_b[1.teen#c.delta_mw]) //changes for teenagers
}
esttab,se keep(limw delta_mw) nostar compress

// Effects on future Wages by Sex
estimates clear
forval i=4 8:144{
	eststo: quietly regress hwage_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.eeducateb max_wuiben unempb unemp_f`i'w c.delta_mw##i.esex c.limw##i.esex if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt], cluster(pid)
nlcom (_b[limw]+_b[2.esex#c.limw]) //levels for teenagers
nlcom (_b[delta_mw]+_b[2.esex#c.delta_mw]) //changes for teenagers
}
esttab,se keep(limw delta_mw) nostar compress

// Effects on future Wages conditional on Last Wage
estimates clear
forval i=4 8:144{
eststo: quietly regress hwage_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.esex i.eeducateb max_wuiben unempb unemp_f`i'w c.delta_mw##c.lrlast_wage c.limw##c.lrlast_wage if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt], cluster(pid)
nlcom (_b[limw]+_b[c.limw#c.lrlast_wage]) //levels for teenagers
nlcom (_b[delta_mw]+_b[c.delta_mw#c.lrlast_wage]) //changes for teenagers
}
esttab,se keep(limw c.limw#c.lrlast_wage delta_mw c.delta_mw#c.lrlast_wage) compress

// same for hours

estimates clear
forval i=4 8:144{
eststo: quietly regress hours_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.esex i.eeducateb max_wuiben unempb unemp_f`i'w delta_mw limw if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt], cluster(pid)
}
esttab,se keep(limw delta_mw) nostar compress

// Effects on future Hours by Education attainment

estimates clear
forval i=4 8:144{
eststo: quietly regress hours_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.esex i.eeducateb max_wuiben unempb unemp_f`i'w c.delta_mw##educ c.limw##educ if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt], cluster(pid)
nlcom (_b[limw]+_b[1.educ#c.limw]) //levels for low education
nlcom (_b[delta_mw]+_b[1.educ#c.delta_mw]) //changes for low education
}
esttab,se keep(limw delta_mw) nostar compress

// Effects on future Hours by Teen/Adult
estimates clear
forval i=4 8:144{
eststo: quietly regress hours_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.esex i.eeducateb max_wuiben unempb unemp_f`i'w c.delta_mw##teen c.limw##teen if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt], cluster(pid)
nlcom (_b[limw]+_b[1.teen#c.limw]) //levels for teenagers
nlcom (_b[delta_mw]+_b[1.teen#c.delta_mw]) //changes for teenagers
}
esttab,se keep(limw delta_mw) nostar compress

// Effects on future Hours by Sex
estimates clear
forval i=4 8:144{
eststo: quietly regress hours_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.eeducateb max_wuiben unempb unemp_f`i'w c.delta_mw##i.esex c.limw##i.esex if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt], cluster(pid)
nlcom (_b[limw]+_b[2.esex#c.limw]) //levels for teenagers
nlcom (_b[delta_mw]+_b[2.esex#c.delta_mw]) //changes for teenagers
}
esttab,se keep(limw delta_mw) nostar compress

// Effects on future Hours conditional on Last Wage
estimates clear
forval i=4 8:144{
eststo: quietly regress hours_f`i'w i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq i.esex i.eeducateb max_wuiben unempb unemp_f`i'w c.delta_mw##c.lrlast_wage c.limw##c.lrlast_wage if hwage_f`i'w>=0 & hwage_f`i'w<300 & spell_length<=52 & spell_length>1 & moverflag==0 & dead==1 [w=wpfinwgt], cluster(pid)
nlcom (_b[limw]+_b[c.limw#c.lrlast_wage]) //levels for teenagers
nlcom (_b[delta_mw]+_b[c.delta_mw#c.lrlast_wage]) //changes for teenagers
}
esttab,se keep(limw c.limw#c.lrlast_wage delta_mw c.delta_mw#c.lrlast_wage) nostar compress

//ROBUSTNESS

// division time trends for each outcome:
stset spell [pweight=av_wgt], id(univ_id) failure(dead==1)
eststo robdlength1: quietly xi: streg i.div_time i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo robdintens1:quietly reg intens i.state i.div_timeb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if moverflag==0 & deadq==1 & spell_length>1 [w=wpfinwgt], cluster(state)
eststo robdquit1: quietly logit quit_srch i.state i.div_timeb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if moverflag==0 & deadq==1 & spell_length>1 [w=rwgt], cluster(state)
eststo robdnextw1: quietly reg lnext_wage i.state i.div_timeb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt],cluster(state)
eststo robdnexth1: quietly reg lnext_hours i.state i.div_timeb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt],cluster(state)
//esttab robd*, se keep(limw lchange delta_mw)

//Federal interaction
stset spell [pweight=av_wgt], id(univ_id) failure(dead==1)
gen fedlchange=federal*delta_mw
//gen fed_imw=0
//replace fed_imw=1 if yearb==2007 |  yearb==2008 |  yearb==2009
eststo robflength1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw fedlchange if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo robfintens1:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb c.delta_mw##federal c.limw if moverflag==0 & deadq==1 [w=wpfinwgt], cluster(state)
eststo robfquit1: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb c.delta_mw##federal c.limw if moverflag==0 & deadq==1 [w=rwgt], cluster(state)
eststo robfnextw1: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb c.delta_mw##federal c.limw if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 [w=wpfinwgt],cluster(state)
eststo robfnexth1: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb c.delta_mw##federal c.limw if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 [w=wpfinwgt],cluster(state)
//esttab robf*, se keep(lchange 1.federal#c.lchange delta_mw 1.federal#c.delta_mw)

eststo robedflength1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducateb c.limw##fed_imw##educ c.lchange##federal##educ if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo robedfintens1:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb c.delta_mw##federal##educ c.limw##fed_imw##educ if moverflag==0 & deadq==1 [w=wpfinwgt], cluster(state)
eststo robedfquit1: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb c.delta_mw##federal##educ c.limw##fed_imw##educ if moverflag==0 & deadq==1 [w=rwgt], cluster(state)
eststo robedfnextw1: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb c.delta_mw##federal##educ c.limw##fed_imw##educ if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 [w=wpfinwgt],cluster(state)
eststo robedfnexth1: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb c.delta_mw##federal##educ c.limw##fed_imw##educ if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 [w=wpfinwgt],cluster(state)
//esttab robedf*, se keep(1.federal#c.lchange 1.federal#1.educ#c.lchange 1.federal#c.delta_mw 1.federal#1.educ#c.delta_mw)


//Spells started in April, or October for 2007,2008,2009
drop date_filter
gen date_filter=0
replace date_filter=1 if yearb!=2007 & yearb!=2008 & yearb!=2009 & monthb==12 | yearb>=2007 & yearb<=2009 & monthb==6
stset spell [pweight=av_wgt], id(univ_id) failure(dead==1)
//Although the effect is no longer significant overall, it is still very significant p=.003 (z=2.98, se=.46) for high school dropouts, albeit smaller than the original (1.37 v. 2.1)
eststo robmlength1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw if spell_length<=40 & spell_length>1 & moverflag==0 & date_filter==1 & dead==1, distribution(lognormal) vce(cluster state)
eststo robmlength2: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate c.limw##educ c.delta_mw##educ if spell<=52 & spell_length>1 & moverflag==0 & date_filter==1 & dead==1, distribution(lognormal) vce(cluster state)
eststo robmintens1:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if moverflag==0 & deadq==1 & date_filter==1 [w=wpfinwgt], cluster(state)
eststo robmquit1: quietly logit quit_srch i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if moverflag==0 & deadq==1 & date_filter==1 [w=rwgt], cluster(state)
eststo robmnextw1: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & date_filter==1 [w=wpfinwgt],cluster(state)
eststo robmnexth1: quietly reg lnext_hours i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & date_filter==1 [w=wpfinwgt],cluster(state)
//esttab robm*, se keep(limw delta_mw 1.educ#c.limw 1.educ#c.delta_mw)

//quit_srch10
gen quit_srch10=0
replace quit_srch10=1 if spell_length-lastlook>10
eststo quit10r1: quietly logit quit_srch10 i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if moverflag==0 & deadq==1 [w=rwgt], cluster(state)
eststo quit10r2: quietly logit quit_srch10 i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb c.delta_mw##educ c.limw##educ if moverflag==0 & deadq==1 [w=rwgt], cluster(state)
eststo quit10r3: quietly logit quit_srch10 i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb unempb c.delta_mw##i.esex c.limw##i.esex if moverflag==0 & deadq==1 [w=rwgt], cluster(state)
eststo quit10r4: quietly logit quit_srch10 i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb c.delta_mw##teen c.limw##teen if moverflag==0 & deadq==1 [w=rwgt], cluster(state)
eststo quit10r5: quietly logit quit_srch10 i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb unempb c.delta_mw##i.erace c.limw##i.erace if moverflag==0 & deadq==1 [w=rwgt], cluster(state)
esttab quit10r*, se keep(limw delta_mw 1.educ#c.limw 1.educ#c.delta_mw 2.esex#c.limw 2.esex#c.delta_mw 1.teen#c.limw 1.teen#c.delta_mw 2.erace#c.limw 3.erace#c.limw 4.erace#c.limw 2.erace#c.delta_mw 3.erace#c.delta_mw 4.erace#c.delta_mw)

//quit_srch12
gen quit_srch12=0
replace quit_srch12=1 if spell_length-lastlook>12
eststo quit12r1: quietly logit quit_srch10 i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if moverflag==0 & deadq==1 [w=rwgt], cluster(state)
eststo quit12r2: quietly logit quit_srch10 i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb c.delta_mw##educ c.limw##educ if moverflag==0 & deadq==1 [w=rwgt], cluster(state)
eststo quit12r3: quietly logit quit_srch10 i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb unempb c.delta_mw##i.esex c.limw##i.esex if moverflag==0 & deadq==1 [w=rwgt], cluster(state)
eststo quit12r4: quietly logit quit_srch10 i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb c.delta_mw##teen c.limw##teen if moverflag==0 & deadq==1 [w=rwgt], cluster(state)
eststo quit12r5: quietly logit quit_srch10 i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.eeducateb unempb c.delta_mw##i.erace c.limw##i.erace if moverflag==0 & deadq==1 [w=rwgt], cluster(state)
esttab quit12r*, se keep(limw delta_mw 1.educ#c.limw 1.educ#c.delta_mw 2.esex#c.limw 2.esex#c.delta_mw 1.teen#c.limw 1.teen#c.delta_mw 2.erace#c.limw 3.erace#c.limw 4.erace#c.limw 2.erace#c.delta_mw 3.erace#c.delta_mw 4.erace#c.delta_mw)




merge m:1 state month year week using "mw_monthly", keepusing(fake_change)
bysort univ_id: replace fake_change = fake_change[_n-1] if fake_change==0 & fake_change[_n-1]!=.
replace fake_change=0 if fake_change==.

stset spell [pweight=av_wips], id(univ_id) failure(dead==1)
eststo ips_length6: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw if spell_length<=36 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
esttab ips_length*,se keep(limw delta_mw)
//fake1 with 26, fake2 with 26, fake2 with 36, fake2 with 36 and dead==1, delta_mw with 36 and dead==1, delta_mw with 36 all.


stset spell [pweight=av_wips], id(univ_id) failure(dead==1)
eststo ips_length1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_bin if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo ips_length2: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate c.limw##educ delta_mw_bin##educ if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo ips_length3: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.eeducate c.limw##i.esex delta_mw_bin##i.esex if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo ips_length4: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate c.limw##teen delta_mw_bin##teen if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo ips_length5: quietly xi: streg i.month_year i.state i.reasstpwk tage tagesq rfnkids unemp i.esex i.eeducate c.limw##i.erace delta_mw_bin##i.erace if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo ips_length6: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate c.limw##c.lrlast_wage delta_mw_bin##c.lrlast_wage if spell<=52 & spell_length>1 & moverflag==0 & last_wage>3 & last_wage!=., distribution(lognormal) vce(cluster state)
eststo ips_length7: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.eeducate c.limw##i.esex##educ delta_mw_bin##i.esex##educ if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
esttab ips_length*,se keep(limw delta_mw_bin)

stset spell [pweight=av_wgt], id(univ_id) failure(dead==1)
eststo blength1: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate limw delta_mw_bin if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo blength2: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate c.limw##educ delta_mw_bin##educ if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo blength3: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.eeducate c.limw##i.esex delta_mw_bin##i.esex if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo blength4: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate c.limw##teen delta_mw_bin##teen if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo blength5: quietly xi: streg i.month_year i.state i.reasstpwk tage tagesq rfnkids unemp i.esex i.eeducate c.limw##i.erace delta_mw_bin##i.erace if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)
eststo blength6: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.esex i.eeducate c.limw##c.lrlast_wage delta_mw_bin##c.lrlast_wage if spell<=52 & spell_length>1 & moverflag==0 & last_wage>3 & last_wage!=., distribution(lognormal) vce(cluster state)
eststo blength7: quietly xi: streg i.month_year i.state i.reasstpwk i.erace tage tagesq rfnkids unemp i.eeducate c.limw##i.esex##educ delta_mw_bin##i.esex##educ if spell<=52 & spell_length>1 & moverflag==0, distribution(lognormal) vce(cluster state)

eststo intens1:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if moverflag==0 & deadq==1 & spell_length>1 [w=wpfinwgt], cluster(state)
eststo intens1_ips:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if moverflag==0 & deadq==1 & spell_length>1 [w=wips], cluster(state)
eststo intens1b:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw_bin limw if moverflag==0 & deadq==1 & spell_length>1 [w=wpfinwgt], cluster(state)
eststo intens1b_ips:quietly reg intens i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw_bin limw if moverflag==0 & deadq==1 & spell_length>1 [w=wips], cluster(state)
esttab intens*, se keep(limw delta_mw delta_mw_bin)

eststo nextw1: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt],cluster(state)
eststo nextw1_ips: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw limw if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wips],cluster(state)
eststo nextw1b: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw_bin limw if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wpfinwgt],cluster(state)
eststo nextw1b_ips: quietly reg lnext_wage i.state i.month_yearb i.reasstpwk i.erace tageb tagebsq rfnkidsb i.esex i.eeducateb unempb delta_mw_bin limw if next_wage>4 & next_wage<300 & spell_length<=52 & moverflag==0 & dead==1 & spell_length>1 [w=wips],cluster(state)
esttab nextw*, se keep(limw delta_mw delta_mw_bin)

gen unemployed=5-rwkesr
tsset univ_id spell
bysort univ_id: gen week1_chng=cond(L.mw<mw,1,0)
bysort univ_id: gen week2_chng=cond(L.week1_chng==1 & spell!=1,1,0)
bysort univ_id: gen week3_chng=cond(L.week2_chng==1 & spell!=1,1,0)
bysort univ_id: gen week4_chng=cond(L.week3_chng==1 & spell!=1,1,0)
bysort univ_id: gen week5_chng=cond(L.week4_chng==1 & spell!=1,1,0)
bysort univ_id: gen week6_chng=cond(L.week5_chng==1 & spell!=1,1,0)
bysort univ_id: gen week7_chng=cond(L.week6_chng==1 & spell!=1,1,0)
bysort univ_id: gen week8_chng=cond(L.week7_chng==1 & spell!=1,1,0)
bysort univ_id: gen week9_chng=cond(L.week8_chng==1 & spell!=1,1,0)
bysort univ_id: gen week10_chng=cond(L.week9_chng==1 & spell!=1,1,0)
bysort univ_id: gen week11_chng=cond(L.week10_chng==1 & spell!=1,1,0)
bysort univ_id: gen week12_chng=cond(L.week11_chng==1 & spell!=1,1,0)
bysort univ_id: gen week13_chng=cond(L.week12_chng==1 & spell!=1,1,0)
bysort univ_id: gen week14_chng=cond(L.week13_chng==1 & spell!=1,1,0)
bysort univ_id: gen week15_chng=cond(L.week14_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm1_chng=cond(F.week1_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm2_chng=cond(F.weekm1_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm3_chng=cond(F.weekm2_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm4_chng=cond(F.weekm3_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm5_chng=cond(F.weekm4_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm6_chng=cond(F.weekm5_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm7_chng=cond(F.weekm6_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm8_chng=cond(F.weekm7_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm9_chng=cond(F.weekm8_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm10_chng=cond(F.weekm9_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm11_chng=cond(F.weekm10_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm12_chng=cond(F.weekm11_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm13_chng=cond(F.weekm12_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm14_chng=cond(F.weekm13_chng==1 & spell!=1,1,0)
bysort univ_id: gen weekm15_chng=cond(F.weekm14_chng==1 & spell!=1,1,0)

gen runningv=week1_chng
replace runningv=2 if week2_chng==1
replace runningv=3 if week3_chng==1
replace runningv=4 if week4_chng==1
replace runningv=5 if week5_chng==1
replace runningv=6 if week6_chng==1
replace runningv=7 if week7_chng==1
replace runningv=8 if week8_chng==1
replace runningv=9 if week9_chng==1
replace runningv=10 if week10_chng==1
replace runningv=11 if week11_chng==1
replace runningv=12 if week12_chng==1
replace runningv=13 if week13_chng==1
replace runningv=14 if week14_chng==1
replace runningv=15 if week15_chng==1
replace runningv=-1 if weekm1_chng==1
replace runningv=-2 if weekm2_chng==1
replace runningv=-3 if weekm3_chng==1
replace runningv=-4 if weekm4_chng==1
replace runningv=-5 if weekm5_chng==1
replace runningv=-6 if weekm6_chng==1
replace runningv=-7 if weekm7_chng==1
replace runningv=-8 if weekm8_chng==1
replace runningv=-9 if weekm9_chng==1
replace runningv=-10 if weekm10_chng==1
replace runningv=-11 if weekm11_chng==1
replace runningv=-12 if weekm12_chng==1
replace runningv=-13 if weekm13_chng==1
replace runningv=-14 if weekm14_chng==1
replace runningv=-15 if weekm15_chng==1

gen timelkg_befchng2=0
bysort univ_id: replace timelkg_befchng2=sum(unemployed) if spell<time_delta
bysort univ_id: egen timelkg_befchng=max(timelkg_befchng2)
replace timelkg_befchng=0 if delta_mw_bin==0
drop timelkg_befchng2

table runningv if moverflag==0 & spell_length>1 & spell<=52 & delta_mw_bin==1 & runningv!=0 [w=rwgt], c(mean unemployed)
table runningv if moverflag==0 & spell_length>1 & spell<=52 & delta_mw_bin==1 & runningv!=0, c(count unemployed)
table runningv if moverflag==0 & spell_length>1 & spell<=52 & delta_mw_bin==1 & runningv!=0 & timelkg_befchng>6 [w=rwgt], c(mean unemployed)
table runningv if moverflag==0 & spell_length>1 & spell<=52 & delta_mw_bin==1 & runningv!=0 & timelkg_befchng>4, c(count unemployed)


eststo test1: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate week1_chng if spell<=52 & moverflag==0 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo test2: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate week2_chng if spell<=52 & moverflag==0 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo test3: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate week3_chng if spell<=52 & moverflag==0 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo test4: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate week4_chng if spell<=52 & moverflag==0 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo test5: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate week5_chng if spell<=52 & moverflag==0 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo test6: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate week6_chng if spell<=52 & moverflag==0 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo test7: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate week7_chng if spell<=52 & moverflag==0 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo test8: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate week8_chng if spell<=52 & moverflag==0 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo test9: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate week9_chng if spell<=52 & moverflag==0 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo test10: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate week10_chng if spell<=52 & moverflag==0 & spell_length>1 [w=wpfinwgt],cluster(pid)
eststo difftest: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate weekm15_chng weekm14_chng weekm13_chng weekm12_chng weekm11_chng weekm10_chng weekm9_chng weekm8_chng weekm7_chng weekm6_chng weekm5_chng weekm4_chng weekm3_chng weekm2_chng weekm1_chng week1_chng week2_chng week3_chng week4_chng week5_chng week6_chng week7_chng week8_chng week9_chng week10_chng week11_chng week12_chng week13_chng week14_chng week15_chng if spell<=52 & moverflag==0 & spell_length>1 & delta_mw_bin==1 [w=wpfinwgt],cluster(pid)

esttab test*,se keep(week*) compress

table spell delta_mw_bin if moverflag==0 & spell_length>1 [w=rwgt], c(mean unemployed)
table spell delta_mw_bin if moverflag==0 & spell_length>1 & panel==2014 [w=rwgt], c(mean unemployed)

table spell round_imw if moverflag==0 & spell_length>1 & delta_mw_bin==0 [w=rwgt], c(mean unemployed)
eststo difftest2: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate c.round_imw##i.panel if spell<=52 & moverflag==0 & spell_length>1 & delta_mw_bin==0 [w=wpfinwgt],cluster(pid)
esttab difftest2, se keep(round_imw* 2004.panel#c.round_imw 2008.panel#c.round_imw 2014.panel#c.round_imw)

gen f10wks=0
replace f10wks=1 if spell<11

eststo difftest3: quietly reg unemployed i.reasstpwk i.erace tage tagesq rfnkids max_wuiben unemp i.esex i.eeducate c.round_imw##f10wks if spell<=52 & moverflag==0 & spell_length>1 & delta_mw_bin==0 [w=wpfinwgt],cluster(pid)
esttab difftest3, se keep(round_imw 1.f10wks#c.round_imw)
