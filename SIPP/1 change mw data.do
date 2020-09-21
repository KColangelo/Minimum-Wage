/*Run only after all surveys have been transformed to long from wide*/
//need to install sdecode
clear all


/*File for estimation of econometric models*/

//cd "C:\Users\Kyle\OneDrive\Minimum Wage\SIPP"

//cd "C:\Users\ksc91\OneDrive\Minimum Wage\SIPP\2014"

cd "C:\Users\gdvia\OneDrive\PhD\Research\Minimum Wage\SIPP"

use "VZ_state_monthly.dta", clear

sdecode monthly_date, gen(date)
gen mon=substr(date,6,.)
destring mon, replace
gen y=substr(date,1,4)
rename mon month
rename y year
destring year, replace
gen week=1
drop date

#delimit ;
label define FM22X
01  "Alabama"
02  "Alaska"
04  "Arizona"
05  "Arkansas"
06  "California"
08  "Colorado"
09  "Connecticut"
10  "Delaware"
11  "DC"
12  "Florida"
13  "Georgia"
15  "Hawaii"
16  "Idaho"
17  "Illinois"
18  "Indiana"
19  "Iowa"
20  "Kansas"
21  "Kentucky"
22  "Louisiana"
23  "Maine"
24  "Maryland"
25  "Massachusetts"
26  "Michigan"
27  "Minnesota"
28  "Mississippi"
29  "Missouri"
30  "Montana"
31  "Nebraska"
32  "Nevada"
33  "New Hampshire"
34  "New Jersey"
35  "New Mexico"
36  "New York"
37  "North Carolina"
38  "North Dakota"
39  "Ohio"
40  "Oklahoma"
41  "Oregon"
42  "Pennsylvania"
44  "Rhode Island"
45  "South Carolina"
46  "South Dakota"
47  "Tennessee"
48  "Texas"
49  "Utah"
50  "Vermont"
51  "Virginia"
53  "Washington"
54  "West Virginia"
55  "Wisconsin"
56  "Wyoming"
;
label define FM27X
1  "January"
2  "February"
3  "March"
4  "April"
5  "May"
6  "June"
7  "July"
8  "August"
9  "September"
10  "October"
11  "November"
12  "December"
;

label values month FM27X;
label values statefips FM22X;
rename statefips state;

/*Create variables to store the last date mw was changed, how much it was
changed, and when it will be changed next (and by how much)*/

sort state year month;
tsset state monthly_date;

egen date=group(year month week);
gen date_lastmw=0;
by state: replace date_lastmw=cond(L.max_mw == max_mw,L.date_lastmw,date);

gen chng_mw=0;
by state: replace chng_mw = cond(L.max_mw == max_mw,L.chng_mw,(min_mw/L.min_mw-1)*100);

gen negmonthly_date=-monthly_date;
sort state negmonthly_date;
tsset state negmonthly_date;
gen date_futmw=0;
by state: replace date_futmw=
cond(L.max_mw == max_mw,L.date_futmw,L.date);

gen fchng_mw=0;
by state: replace fchng_mw = 
cond(L.max_mw == max_mw,L.fchng_mw,(L.min_mw/min_mw-1)*100);

drop negmonthly_date;

egen maxdate=max(date_lastmw);
replace date_futmw=0 if date_futmw==maxdate;
drop maxdate;
replace date_lastmw=0 if date_lastmw==1;

// variables for last_change and time since last change in months
tsset state date;
gen last_change = 0;
by state: replace last_change = cond(L.max_mw == max_mw,L.last_change,ln(max_mw)-ln(L.max_mw));

gen months_since_change = date-date_lastmw;

//
gen mw_raise = 0;
bysort state: replace mw_raise = 1 if max_mw!=L.max_mw & L.max_mw!=.;
gen fake_mw = 0;

//
gen month_aft=month+1;
gen year_aft=year;
replace year_aft=year+1 if month_aft==13;
replace month_aft=1 if month_aft==13;

gen month_2aft=month+2;
gen year_2aft=year;
replace year_2aft=year+1 if month_aft>=13;
replace month_2aft=1 if month_2aft==13;
replace month_2aft=2 if month_2aft==14;

gen month_3aft=month+3;
gen year_3aft=year;
replace year_3aft=year+1 if month_aft>=13;
replace month_3aft=1 if month_3aft==13;
replace month_3aft=2 if month_3aft==14;
replace month_3aft=3 if month_3aft==15;

gen month_bef=month-1;
gen year_bef=year;
replace year_bef=year-1 if month_bef==0;
replace month_bef=12 if month_bef==0;

gen week_mw=1;
replace week_mw=2 if statename=="Delaware" & year==1996 & month==4 | statename=="Missouri" & year==2015 & month==11 | statename=="North Dakota" & year==1989 & month==8;
replace week_mw=3 if statename=="California" & year==1976 & month==10 | statename=="District of Columbia" & year==1980 & month==3 | statename=="District of Columbia" & year==1987 & month==12;
replace week_mw=4 if month==7 & year>2006 & year<2010 | statename=="DC" & year==1981 & month==10 | statename=="Nevada" & year==2006 & month==11 | statename=="New York" & year>=2013 & year<=2015 & month==12 | statename=="Kentucky" & year==2007 & month==6;
replace week_mw=1 if mw_raise==0;


save "mw_monthly.dta", replace;



use "mw_monthly.dta",clear
drop if year<1998
//drop fake_change
gen run =0
bysort state: replace run = run[_n-1] + 1 if last_change==last_change[_n-1]
gen fake_change = 0
bysort state: replace fake_change=last_change if run==0

set seed 4356
//set seed 3589
gen double shuffle = runiform()
sort shuffle 
gen long which = _n 
sort state year month week

gen fake_change2 = fake_change[which]
order fake_change2

replace fake_change = fake_change2
drop fake_change2
drop shuffle
drop which
drop run


bysort state: egen nmw_change=sum(mw_raise) if year==2000 & month>10 | year==2001 | year==2002 | year==2003 & month<8
bysort state: egen nmw_change2=sum(mw_raise) if year==2004 & month>10 | year==2005 | year==2006 | year==2007 & month<12
bysort state: egen nmw_change3=sum(mw_raise) if year>=2008 & month>5 | year==2009 | year==2010 | year==2011 & month<11
bysort state: egen nmw_change4=sum(mw_raise) if year==2013 & month>1 | year==2014 | year==2015 | year==2016 & month<7

table nmw_change if year==2001, c(max nmw_change)
table nmw_change2 if year==2005, c(max nmw_change2)
table nmw_change3 if year==2009, c(max nmw_change3)
table nmw_change4 if year==2014, c(max nmw_change4)

drop nmw_change nmw_change2 nmw_change3 nmw_change4


save "mw_monthly.dta", replace
