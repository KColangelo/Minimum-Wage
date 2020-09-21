*/************************************************/
*/*   Please scroll down to the INFIX step for    */
*/* instructions related to providing full path  */
*/* name for the input data file.                */
*/************************************************/
*/ then scoll to the end of the file and provide the */
*/ path for where to store the data when finished */

/* Combining waves*/

/*
cd "C:\Users\Kyle\OneDrive\Minimum Wage\SIPP\2014"
*/

cd "C:\Users\gdvia\OneDrive\PhD\Research\Minimum Wage\SIPP\2001"

clear all

local allfiles: dir . files "*.asc",respectcase

foreach file of local allfiles{

#delimit ;
clear ;

label define FM0X
-1  "Not in Universe"
1  "On layoff (temporary or indefinite)"
2  "Slack work or business conditions"
3  "Own injury"
4  "Own illness/injury/medical problems"
5  "Pregnancy/childbirth"
6  "Taking care of children"
7  "On vacation/personal days"
8  "Bad weather"
9  "Labor Dispute"
10  "New job to begin within 30 days"
11  "Participated in a job-sharing arrangement"
12  "Other"
;
label define FM1X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM2X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM3X
-1  "Not in Universe"
31  "Less Than 1st Grade"
32  "1st, 2nd, 3rd or 4th grade"
33  "5th Or 6th Grade"
34  "7th Or 8th Grade"
35  "9th Grade"
36  "10th Grade"
37  "11th Grade"
38  "12th grade"
39  "High school graduate-high school diploma or equivalent (for ex: GED)"
40  "Some College But No Degree"
41  "Diploma or cert from voc, tech, trade or bus school beyond high school"
42  "Associate degree in college - Occupational/vocational program"
43  "Associate Degree in college - Academic program"
44  "Bachelors degree (For example: BA, AB, BS)"
45  "Master''s degree (For example: MA, MS, MEng, MSW, MBA)"
46  "Professional School Degree (For example: MD,DDS,DVM,LLB,JD)"
47  "Doctorate degree (For example: PhD, EdD)"
;
label define FM4X
-1  "Not in Universe"
;
label define FM5X
-1  "Not in Universe"
;
label define FM8X
-1  "Not in Universe"
;
label define FM9X
-1  "Not in Universe"
;
label define FM10X
-1  "Not in Universe"
10  "Agricultural production, crops (01)"
11  "Agricultural Production, livestock (02)"
12  "Veterinary services (074)"
20  "Landscape and horticultural services (078)"
30  "Agricultural services, n.e.c. (071, 072, 075, 076)"
31  "Forestry (08)"
32  "Fishing, hunting, and trapping (09)"
40  "Metal mining (10)"
41  "Coal mining (12)"
42  "Oil and gas extraction (13)"
50  "Nonmetallic mining and quarrying, except fuel (14)"
60  "CONSTRUCTION (15, 16, 17)"
100  "Meat products (201)"
101  "Dairy products (202)"
102  "Canned, frozen and preserved fruits and vegetables (203)"
110  "Grain mill products (204)"
111  "Bakery products (205)"
112  "Sugar and confectionery products (206)"
120  "Beverage industries (208)"
121  "Miscellaneous food preparations and kindred products (207, 209)"
122  "Not specified food industries"
130  "Tobacco manufactures (21)"
132  "Knitting mills (225)"
140  "Dyeing and finishing textiles, except wool and knit goods (226)"
141  "Carpets and rugs (227)"
142  "Yarn, thread, and fabric mills (221-224, 228)"
150  "Miscellaneous textile mill products (229)"
151  "Apparel and accessories, except knit (231-238)"
152  "Miscellaneous fabricated textile products (239)"
160  "Pulp, paper, and paperboard mills (261-263)"
161  "Miscellaneous paper and pulp products (267)"
162  "Paperboard containers and boxes (265)"
171  "Newspaper publishing and printing (271)"
172  "Printing, publishing, and allied industries, except newspapers (272-279)"
180  "Plastics, synthetics, and resins (282)"
181  "Drugs (283)"
182  "Soaps and cosmetics (284)"
190  "Paints, varnishes, and related products (285)"
191  "Agricultural chemicals (287)"
192  "Industrial and miscellaneous chemicals (281, 286, 289)"
200  "Petroleum refining (291)"
201  "Miscellaneous petroleum and coal products (295, 299)"
210  "Tires and inner tubes (301)"
211  "Other rubber products, and plastics footwear and belting (302-306)"
212  "Miscellaneous plastics products (308)"
220  "Leather tanning and finishing (311)"
221  "Footwear, except rubber and plastic (313, 314)"
222  "Leather products, except footwear (315-317, 319)"
230  "Logging (241)"
231  "Sawmills, planing mills, and millwork (242, 243)"
232  "Wood buildings and mobile homes (245)"
241  "Miscellaneous wood products (244, 249)"
242  "Furniture and fixtures (25)"
250  "Glass and glass products (321-323)"
251  "Cement, concrete, gypsum, and plaster products (324, 327)"
252  "Structural clay products (325)"
261  "Pottery and related products (326)"
262  "Miscellaneous nonmetallic mineral and stone products (328, 329)"
270  "Blast furnaces, steelworks, rolling and finishing mills (331)"
271  "Iron and steel foundries (332)"
272  "Primary aluminum industries (3334, part 334, 3353-3355, 3363, 3365)"
280  "Other primary metal industries (3331, 3339,part 334, 3351, 3356-57, 3364, 3366, 3369, 339)"
281  "Cutlery, handtools, and general hardware (342)"
282  "Fabricated structural metal products (344)"
290  "Screw machine products (345)"
291  "Metal forgings and stampings (346)"
292  "Ordnance (348)"
300  "Misc fabricated metal products (341, 343, 347, 349)"
301  "Not specified metal industries"
310  "Engines and turbines (351)"
311  "Farm machinery and equipment (352)"
312  "Construction and material handling machines (353)"
320  "Metalworking machinery (354)"
321  "Office and accounting machines (3578, 3579)"
322  "Computers and related equipment (3571-3577)"
331  "Machinery, except electrical, n.e.c. (355, 356, 358, 359)"
332  "Not specified machinery"
340  "Household appliances (363)"
341  "Radio, TV, and communication equipment (365, 366)"
342  "Electrical machinery, equipment, and supplies, n.e.c. (361, 362, 364, 367, 369)"
350  "Not specified electrical machinery, equipment, and supplies"
351  "Motor vehicles and motor vehicle equipment (371)"
352  "Aircraft and parts (372)"
360  "Ship and boat building and repairing (373)"
361  "Railroad locomotives and equipment (374)"
362  "Guided missiles, space vehicles, and parts (376)"
370  "Cycles and miscellaneous transportation equipment (375, 379)"
371  "Scientific and controlling instruments (381, 382 except 3827)"
372  "Medical, dental, and optical instruments and supplies (3827, 384, 385)"
380  "Photographic equipment and supplies (386)"
381  "Watches, clocks, and clockwork operated devices (387)"
390  "Toys, amusement, and sporting goods (394)"
391  "Miscellaneous manufacturing industries (39 except 394)"
392  "Not spec manufacturing industries"
400  "Railroads (40)"
401  "Bus service and urban transit (41, except 412)"
402  "Taxicab service (412)"
410  "Trucking service (421, 423)"
411  "Warehousing and storage (422)"
412  "U.S. Postal Service (43)"
420  "Water transportation (44)"
421  "Air transportation (45)"
422  "Pipe lines, except natural gas (46)"
432  "Services incidental to transportation (47)"
440  "Radio and television broadcasting and cable (483, 484)"
441  "Telephone communications (481)"
442  "Telegraph and miscellaneous communications services (482, 489)"
450  "Electric light and power (491)"
451  "Gas and steam supply systems (492, 496)"
452  "Electric and gas, and other combinations (493)"
470  "Water supply and irrigation (494, 497)"
471  "Sanitary services (495)"
472  "Not specified utilities"
500  "Motor vehicles and equipment (501)"
501  "Furniture and home furnishings (502)"
502  "Lumber and construction materials (503)"
510  "Professional and commercial equipment and supplies (504)"
511  "Metals and minerals, except petroleum (505)"
512  "Electrical goods (506)"
521  "Hardware, plumbing and heating supplies (507)"
530  "Machinery, equipment, and supplies (508)"
531  "Scrap and waste materials (5093)"
532  "Miscellaneous wholesale, durable goods (509 except 5093)"
540  "Paper and paper products (511)"
541  "Drugs, chemicals and allied products (512, 516)"
542  "Apparel, fabrics, and notions (513)"
550  "Groceries and related products (514)"
551  "Farm-product raw materials (515)"
552  "Petroleum products (517)"
560  "Alcoholic beverages (518)"
561  "Farm supplies (5191)"
562  "Misc wholesale, nondurable goods (5192-5199)"
571  "Not specified wholesale trade"
580  "Lumber and building material retailing (521, 523)"
581  "Hardware stores (525)"
582  "Stores, Retail nurseries and garden (526)"
590  "Mobile home dealers (527)"
591  "Department stores (531)"
592  "Variety stores (533)"
600  "Stores, misc general merchandise (539)"
601  "Grocery stores (541)"
602  "Stores, dairy products (545)"
610  "Retail bakeries (546)"
611  "Food stores, n.e.c. (542, 543, 544, 549)"
612  "Motor vehicle dealers (551, 552)"
620  "Stores, Auto and home supply (553)"
621  "Gasoline service stations (554)"
622  "Miscellaneous vehicle dealers (555, 556, 557, 559)"
623  "Stores, apparel and accessory, except shoe (56, except 566)"
630  "Shoe stores (566)"
631  "Stores, furniture and home furnishings (571)"
632  "Stores, household appliance (572)"
633  "Stores, radio, TV, and computer (5731, 5734)"
640  "Music stores (5735, 5736)"
641  "Eating and drinking places (58)"
642  "Drug stores (591)"
650  "Liquor stores (592)"
651  "Stores, sporting goods, bicycles, and hobby (5941, 5945, 5946)"
652  "Stores, Book and stationery (5942, 5943)"
660  "Jewelry stores (5944)"
661  "Gift, novelty, and souvenir shops (5947)"
662  "Sewing, needlework and piece goods stores (5949)"
663  "Catalog and mail order houses (5961)"
670  "Vending machine operators (5962)"
671  "Direct selling establishments (5963)"
672  "Fuel dealers (598)"
681  "Retail florists (5992)"
682  "Stores, Miscellaneous retail (593, 5948, 5993-5995, 5999)"
691  "Not specified retail trade"
700  "Banking (60 except 603 and 606)"
701  "Savings institutions, including credit unions (603, 606)"
702  "Credit agencies, n.e.c. (61)"
710  "Security, commodity brokerage, and investment companies (62, 67)"
711  "Insurance (63, 64)"
712  "Real estate, including real estate-insurance offices (65)"
721  "Advertising (731)"
722  "Services to dwellings and other buildings (734)"
731  "Personnel supply services (736)"
732  "Computer and data processing services (737)"
740  "Detective and protective services (7381, 7382)"
741  "Business services, n.e.c. (732, 733, 735, 7383-7389)"
742  "Automotive rental and leasing, w/out drivers (751)"
750  "Automotive parking and carwashes (752, 7542)"
751  "Automotive repair and rel. services (753, 7549)"
752  "Electrical repair shops (762, 7694)"
760  "Miscellaneous repair services (763, 764, 7692, 7699)"
761  "PRIVATE HOUSEHOLDS (88)"
762  "Hotels and motels (701)"
770  "Lodging places, except hotels and motels (702, 703, 704)"
771  "Laundry, cleaning, and garment services (721 except part 7219)"
772  "Beauty shops (723)"
780  "Barber shops (724)"
781  "Funeral service and crematories (726)"
782  "Shoe repair shops (725)"
790  "Dressmaking shops (part 7219)"
791  "Misc personal services (722, 729)"
800  "Theaters and motion pictures (781-783, 792)"
801  "Video tape rental (784)"
802  "Bowling centers (793)"
810  "Miscellaneous entertainment and recreation services (791, 794, 799)"
812  "Physicians offices and clinics (801, 803)"
820  "Dentists offices and clinics (802)"
821  "Chiropractors offices and clinics (8041)"
822  "Optometrists offices and clinics (8042)"
830  "Health practitioners offices and clinics, n.e.c. (8043, 8049)"
831  "HOSPITALS (806)"
832  "Nursing and personal care facilities (805)"
840  "Health services, n.e.c. (807, 808, 809)"
841  "Legal services (81)"
842  "Elementary and secondary schools (821)"
850  "Colleges and universities (822)"
851  "Vocational schools (824)"
852  "Libraries (823)"
860  "Educational services, n.e.c. (829)"
861  "Job training and vocational rehabilitation services (833)"
862  "Child day care services (part 835)"
863  "Family child care homes (part 835)"
870  "Residential care facilities, without nursing (836)"
871  "Social services, n.e.c. (832, 839)"
872  "Museums, art galleries, and zoos (84)"
873  "Labor unions (863)"
880  "Religious organizations (866)"
881  "Membership organizations, n.e.c. (861, 862, 864, 865, 869)"
882  "Engineering, architectural, and surveying services (871)"
890  "Accounting, auditing, and bookkeeping services (872)"
891  "Research, development, and testing services (873)"
892  "Management and public relations services (874)"
893  "Miscellaneous professional and related services (899)"
900  "Executive and legislative offices (911-913)"
901  "General government, n.e.c. (919)"
910  "Justice, public order, and safety (92)"
921  "Public finance, taxation, and monetary policy (93)"
922  "Human resources programs administration(94)"
930  "Environmental quality and housing programs administration(95)"
931  "Economic programs administration(96)"
932  "National security and international affairs (97)"
991  "Persons whose labor force status is unemployed and whose last job was Armed Forces"
;
label define FM11X
-1  "Not in Universe"
10  "Agricultural production, crops (01)"
11  "Agricultural Production, livestock (02)"
12  "Veterinary services (074)"
20  "Landscape and horticultural services (078)"
30  "Agricultural services, n.e.c. (071, 072, 075, 076)"
31  "Forestry (08)"
32  "Fishing, hunting, and trapping (09)"
40  "Metal mining (10)"
41  "Coal mining (12)"
42  "Oil and gas extraction (13)"
50  "Nonmetallic mining and quarrying, except fuel (14)"
60  "CONSTRUCTION (15, 16, 17)"
100  "Meat products (201)"
101  "Dairy products (202)"
102  "Canned, frozen and preserved fruits and vegetables (203)"
110  "Grain mill products (204)"
111  "Bakery products (205)"
112  "Sugar and confectionery products (206)"
120  "Beverage industries (208)"
121  "Miscellaneous food preparations and kindred products (207, 209)"
122  "Not specified food industries"
130  "Tobacco manufactures (21)"
132  "Knitting mills (225)"
140  "Dyeing and finishing textiles, except wool and knit goods (226)"
141  "Carpets and rugs (227)"
142  "Yarn, thread, and fabric mills (221-224, 228)"
150  "Miscellaneous textile mill products (229)"
151  "Apparel and accessories, except knit (231-238)"
152  "Miscellaneous fabricated textile products (239)"
160  "Pulp, paper, and paperboard mills (261-263)"
161  "Miscellaneous paper and pulp products (267)"
162  "Paperboard containers and boxes (265)"
171  "Newspaper publishing and printing (271)"
172  "Printing, publishing, and allied industries, except newspapers (272-279)"
180  "Plastics, synthetics, and resins (282)"
181  "Drugs (283)"
182  "Soaps and cosmetics (284)"
190  "Paints, varnishes, and related products (285)"
191  "Agricultural chemicals (287)"
192  "Industrial and miscellaneous chemicals (281, 286, 289)"
200  "Petroleum refining (291)"
201  "Miscellaneous petroleum and coal products (295, 299)"
210  "Tires and inner tubes (301)"
211  "Other rubber products, and plastics footwear and belting (302-306)"
212  "Miscellaneous plastics products (308)"
220  "Leather tanning and finishing (311)"
221  "Footwear, except rubber and plastic (313, 314)"
222  "Leather products, except footwear (315-317, 319)"
230  "Logging (241)"
231  "Sawmills, planing mills, and millwork (242, 243)"
232  "Wood buildings and mobile homes (245)"
241  "Miscellaneous wood products (244, 249)"
242  "Furniture and fixtures (25)"
250  "Glass and glass products (321-323)"
251  "Cement, concrete, gypsum, and plaster products (324, 327)"
252  "Structural clay products (325)"
261  "Pottery and related products (326)"
262  "Miscellaneous nonmetallic mineral and stone products (328, 329)"
270  "Blast furnaces, steelworks, rolling and finishing mills (331)"
271  "Iron and steel foundries (332)"
272  "Primary aluminum industries (3334, part 334, 3353-3355, 3363, 3365)"
280  "Other primary metal industries (3331, 3339,part 334, 3351, 3356-57, 3364, 3366, 3369, 339)"
281  "Cutlery, handtools, and general hardware (342)"
282  "Fabricated structural metal products (344)"
290  "Screw machine products (345)"
291  "Metal forgings and stampings (346)"
292  "Ordnance (348)"
300  "Misc fabricated metal products (341, 343, 347, 349)"
301  "Not specified metal industries"
310  "Engines and turbines (351)"
311  "Farm machinery and equipment (352)"
312  "Construction and material handling machines (353)"
320  "Metalworking machinery (354)"
321  "Office and accounting machines (3578, 3579)"
322  "Computers and related equipment (3571-3577)"
331  "Machinery, except electrical, n.e.c. (355, 356, 358, 359)"
332  "Not specified machinery"
340  "Household appliances (363)"
341  "Radio, TV, and communication equipment (365, 366)"
342  "Electrical machinery, equipment, and supplies, n.e.c. (361, 362, 364, 367, 369)"
350  "Not specified electrical machinery, equipment, and supplies"
351  "Motor vehicles and motor vehicle equipment (371)"
352  "Aircraft and parts (372)"
360  "Ship and boat building and repairing (373)"
361  "Railroad locomotives and equipment (374)"
362  "Guided missiles, space vehicles, and parts (376)"
370  "Cycles and miscellaneous transportation equipment (375, 379)"
371  "Scientific and controlling instruments (381, 382 except 3827)"
372  "Medical, dental, and optical instruments and supplies (3827, 384, 385)"
380  "Photographic equipment and supplies (386)"
381  "Watches, clocks, and clockwork operated devices (387)"
390  "Toys, amusement, and sporting goods (394)"
391  "Miscellaneous manufacturing industries (39 except 394)"
392  "Not spec manufacturing industries"
400  "Railroads (40)"
401  "Bus service and urban transit (41, except 412)"
402  "Taxicab service (412)"
410  "Trucking service (421, 423)"
411  "Warehousing and storage (422)"
412  "U.S. Postal Service (43)"
420  "Water transportation (44)"
421  "Air transportation (45)"
422  "Pipe lines, except natural gas (46)"
432  "Services incidental to transportation (47)"
440  "Radio and television broadcasting and cable (483, 484)"
441  "Telephone communications (481)"
442  "Telegraph and miscellaneous communications services (482, 489)"
450  "Electric light and power (491)"
451  "Gas and steam supply systems (492, 496)"
452  "Electric and gas, and other combinations (493)"
470  "Water supply and irrigation (494, 497)"
471  "Sanitary services (495)"
472  "Not specified utilities"
500  "Motor vehicles and equipment (501)"
501  "Furniture and home furnishings (502)"
502  "Lumber and construction materials (503)"
510  "Professional and commercial equipment and supplies (504)"
511  "Metals and minerals, except petroleum (505)"
512  "Electrical goods (506)"
521  "Hardware, plumbing and heating supplies (507)"
530  "Machinery, equipment, and supplies (508)"
531  "Scrap and waste materials (5093)"
532  "Miscellaneous wholesale, durable goods (509 except 5093)"
540  "Paper and paper products (511)"
541  "Drugs, chemicals and allied products (512, 516)"
542  "Apparel, fabrics, and notions (513)"
550  "Groceries and related products (514)"
551  "Farm-product raw materials (515)"
552  "Petroleum products (517)"
560  "Alcoholic beverages (518)"
561  "Farm supplies (5191)"
562  "Misc wholesale, nondurable goods (5192-5199)"
571  "Not specified wholesale trade"
580  "Lumber and building material retailing (521, 523)"
581  "Hardware stores (525)"
582  "Stores, Retail nurseries and garden (526)"
590  "Mobile home dealers (527)"
591  "Department stores (531)"
592  "Variety stores (533)"
600  "Stores, misc general merchandise (539)"
601  "Grocery stores (541)"
602  "Stores, dairy products (545)"
610  "Retail bakeries (546)"
611  "Food stores, n.e.c. (542, 543, 544, 549)"
612  "Motor vehicle dealers (551, 552)"
620  "Stores, Auto and home supply (553)"
621  "Gasoline service stations (554)"
622  "Miscellaneous vehicle dealers (555, 556, 557, 559)"
623  "Stores, apparel and accessory, except shoe (56, except 566)"
630  "Shoe stores (566)"
631  "Stores, furniture and home furnishings (571)"
632  "Stores, household appliance (572)"
633  "Stores, radio, TV, and computer (5731, 5734)"
640  "Music stores (5735, 5736)"
641  "Eating and drinking places (58)"
642  "Drug stores (591)"
650  "Liquor stores (592)"
651  "Stores, sporting goods, bicycles, and hobby (5941, 5945, 5946)"
652  "Stores, Book and stationery (5942, 5943)"
660  "Jewelry stores (5944)"
661  "Gift, novelty, and souvenir shops (5947)"
662  "Sewing, needlework and piece goods stores (5949)"
663  "Catalog and mail order houses (5961)"
670  "Vending machine operators (5962)"
671  "Direct selling establishments (5963)"
672  "Fuel dealers (598)"
681  "Retail florists (5992)"
682  "Stores, Miscellaneous retail (593, 5948, 5993-5995, 5999)"
691  "Not specified retail trade"
700  "Banking (60 except 603 and 606)"
701  "Savings institutions, including credit unions (603, 606)"
702  "Credit agencies, n.e.c. (61)"
710  "Security, commodity brokerage, and investment companies (62, 67)"
711  "Insurance (63, 64)"
712  "Real estate, including real estate-insurance offices (65)"
721  "Advertising (731)"
722  "Services to dwellings and other buildings (734)"
731  "Personnel supply services (736)"
732  "Computer and data processing services (737)"
740  "Detective and protective services (7381, 7382)"
741  "Business services, n.e.c. (732, 733, 735, 7383-7389)"
742  "Automotive rental and leasing, w/out drivers (751)"
750  "Automotive parking and carwashes (752, 7542)"
751  "Automotive repair and related services (753, 7549)"
752  "Electrical repair shops (762, 7694)"
760  "Miscellaneous repair services (763, 764, 7692, 7699)"
761  "PRIVATE HOUSEHOLDS (88)"
762  "Hotels and motels (701)"
770  "Lodging places, except hotels and motels (702, 703, 704)"
771  "Laundry, cleaning, and garment services (721 except part 7219)"
772  "Beauty shops (723)"
780  "Barber shops (724)"
781  "Funeral service and crematories (726)"
782  "Shoe repair shops (725)"
790  "Dressmaking shops (part 7219)"
791  "Misc personal services (722, 729)"
800  "Theaters and motion pictures (781-783, 792)"
801  "Video tape rental (784)"
802  "Bowling centers (793)"
810  "Miscellaneous entertainment and recreation services (791, 794, 799)"
812  "Physicians offices and clinics (801, 803)"
820  "Dentists offices and clinics (802)"
821  "Chiropractors offices and clinics (8041)"
822  "Optometrists offices and clinics (8042)"
830  "Health practitioners offices and clinics, n.e.c. (8043, 8049)"
831  "HOSPITALS (806)"
832  "Nursing and personal care facilities (805)"
840  "Health services, n.e.c. (807, 808, 809)"
841  "Legal services (81)"
842  "Elementary and secondary schools (821)"
850  "Colleges and universities (822)"
851  "Vocational schools (824)"
852  "Libraries (823)"
860  "Educational services, n.e.c. (829)"
861  "Job training and vocational rehabilitation services (833)"
862  "Child day care services (part 835)"
863  "Family child care homes (part 835)"
870  "Residential care facilities, without nursing (836)"
871  "Social services, n.e.c. (832, 839)"
872  "Museums, art galleries, and zoos (84)"
873  "Labor unions (863)"
880  "Religious organizations (866)"
881  "Membership organizations, n.e.c. (861, 862, 864, 865, 869)"
882  "Engineering, architectural, and surveying services (871)"
890  "Accounting, auditing, and bookkeeping services (872)"
891  "Research, development, and testing services (873)"
892  "Management and public relations services (874)"
893  "Miscellaneous professional and related services (899)"
900  "Executive and legislative offices (911-913)"
901  "General government, n.e.c. (919)"
910  "Justice, public order, and safety (92)"
921  "Public finance, taxation, and monetary policy (93)"
922  "Human resources programs administration(94)"
930  "Environmental quality and housing programs administration(95)"
931  "Economic programs administration(96)"
932  "National security and international affairs (97)"
991  "Persons whose labor force status is unemployed and whose last job was Armed Forces"
;
label define FM12X
-1  "Not in Universe"
0  "Contingent workers"
;
label define FM13X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM14X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM15X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM16X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM17X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM18X
-1  "Not universe"
1  "Yes"
2  "No"
;
label define FM19X
-1  "Not universe"
1  "Yes"
2  "No"
;
label define FM20X
1  "Married, spouse present"
2  "Married, spouse absent"
3  "Widowed"
4  "Divorced"
5  "Separated"
6  "Never Married"
;
label define FM21X
1  "Canadian"
2  "Dutch"
3  "English"
4  "French"
5  "French-Canadian"
6  "German"
7  "Hungarian"
8  "Irish"
9  "Italian"
10  "Polish"
11  "Russian"
12  "Scandinavian"
13  "Scotch-Irish"
14  "Scottish"
15  "Slovak"
16  "Welsh"
17  "Other European"
20  "Mexican"
21  "Mexican-American"
22  "Chicano"
23  "Puerto Rican"
24  "Cuban"
25  "Central American"
26  "South American"
27  "Dominican Republic"
28  "Other Hispanic"
30  "African-American or Afro-American"
31  "American Indian, Eskimo, or Aleut"
32  "Arab"
33  "Asian"
34  "Pacific Islander"
35  "West Indian"
39  "Another group not listed"
40  "American"
;
label define FM22X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM23X
9999  "Spouse not in household or person not married"
;
label define FM24X
1  "Interview (self)"
2  "Interview (proxy)"
3  "Noninterview - Type Z"
4  "Noninterview - pseudo Type Z.  Left sample during the reference period"
5  "Children under 15 during reference period"
;
label define FM26X
-1  "Not in Universe"
1  "Could not find full-time job"
2  "Wanted to work part time"
3  "Temporarily unable to work full-time because of injury"
4  "Temporarily not able to work full-time because of illness"
5  "Unable to work full-time due to chronic health condition/disability"
6  "Taking care of children/other persons"
7  "Full-time workweek is less than 35 hours"
8  "Slack work or material shortage"
9  "Participated in a job sharing arrangement"
10  "On vacation"
11  "In school"
12  "Other"
;
label define FM27X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM28X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM29X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM30X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM31X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM32X
1  "White"
2  "Black"
3  "American Indian, Aleut, or Eskimo"
4  "Asian or Pacific Islander"
;
label define FM33X
-1  "Not in Universe"
1  "On Layoff"
2  "Retirement or old age"
3  "Childcare problems"
4  "Other family/personal obligations"
5  "Own illness"
6  "Own injury"
7  "School/Training"
8  "Discharged/fired"
9  "Employer bankrupt"
10  "Employer sold business"
11  "Job was temporary and ended"
12  "Quit to take another job"
13  "Slack work or business conditions"
14  "Unsatisfactory work arrangements (hours, pay, etc)"
15  "Quit for some other reason"
;
label define FM34X
-1  "Not in Universe"
1  "On Layoff"
2  "Retirement or old age"
3  "Childcare problems"
4  "Other family/personal obligations"
5  "Own illness"
6  "Own injury"
7  "School/Training"
8  "Discharged/fired"
9  "Employer bankrupt"
10  "Employer sold business"
11  "Job was temporary and ended"
12  "Quit to take another job"
13  "Slack work or business conditions"
14  "Unsatisfactory work arrangements (hours, pay, etc)"
15  "Quit for some other reason"
;
label define FM35X
-1  "Not in Universe"
1  "Temporarily unable to work because of an injury"
2  "Temporarily not able to work because of an illness"
3  "Unable to work because of chronic health condition or disablity"
4  "Retired"
5  "Pregnancy/childbirth"
6  "Taking care of children/other persons"
7  "Going to school"
8  "Unable to find work"
9  "On layoff (temporary or indefinite)"
10  "Not interested in working at a job"
11  "Other"
;
label define FM36X
1  "Male"
2  "Female"
;
label define FM37X
-1  "Not in Universe"
;
label define FM38X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM39X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM40X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM41X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM42X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM45X
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
label define FM47X
1  "Family hh - Married couple"
2  "Family hh - Male householder"
3  "Family hh - Female householder"
4  "Nonfamily hh - Male householder nonfamily household"
5  "Nonfamily hh - Female householder nonfamily householder"
6  "Group Quarters"
;
label define FM48X
-1  "Not in Universe"
1  "With a job entire month, worked all weeks."
2  "With a job all month, absent from work without pay 1+ weeks, absence not due to layoff"
3  "With job all month, absent from work without pay 1+ weeks, absence due to layoff"
4  "With a job at least 1 but not all weeks, no time on layoff and no time looking for work"
5  "With job at least 1 but not all weeks, some weeks on layoff or looking for work"
6  "No job all month, on layoff or looking for work all weeks."
7  "No job, at least one but not all weeks on layoff or looking for work"
8  "No job, no time on layoff and no time looking for work."
;
label define FM49X
-1  "Not in Universe"
0  "Did not work"
1  "All weeks 35+"
2  "All weeks 1-34 hours"
3  "Some weeks 35+ and some weeks less than 35, all weeks equal to or greater than 1"
4  "Some weeks 35+, some 1-34 hours, some 0 hours"
5  "At least 1, but not all, weeks 35+ hours, all other weeks 0 hours"
6  "At least 1 week, but not all weeks, 1 to 34 hours; all other weeks 0 hours"
;
label define FM50X
-1  "Not in Universe"
0  "0 weeks (that is, did not look for work or not on layoff)"
1  "1 week"
2  "2 weeks"
3  "3 weeks"
4  "4 weeks"
5  "5 weeks (if applicable)"
;
label define FM51X
-1  "Not in Universe"
0  "0 weeks (that is, not absent without pay from a job)"
1  "1 week"
2  "2 weeks"
3  "3 weeks"
4  "4 weeks"
5  "5 weeks (if applicable)"
;
label define FM52X
-1  "Not in Universe"
0  "0 weeks (that is, did not have a job)"
1  "1 week"
2  "2 weeks"
3  "3 weeks"
4  "4 weeks"
5  "5 weeks (if applicable)"
;
label define FM53X
-1  "Not in Universe"
0  "Not reported"
1  "Waiting for a new job to begin"
2  "Own Temporary Illness"
3  "School"
4  "OTHER"
;
label define FM54X
-1  "Not in Universe"
1  "Once a week"
2  "Once every two weeks"
3  "Once a month"
4  "Twice a month"
5  "Unpaid in a family business or farm"
6  "On commission"
7  "Some other way"
8  "Not reported"
;
label define FM55X
-1  "Not in Universe"
1  "Once a week"
2  "Once every two weeks"
3  "Once a month"
4  "Twice a month"
5  "Unpaid in a family business or farm"
6  "On commission"
7  "Some other way"
8  "Not reported"
;
label define FM56X
-1  "Not in Universe"
;
label define FM57X
-1  "Not in Universe"
0  "Not reported"
1  "Yes"
2  "No"
;
label define FM58X
-1  "Not in Universe"
1  "Disability"
3  "Suvivor"
5  "Disability and Suvivor"
8  "No payment"
;
label define FM59X
-1  "Not in Universe"
1  "With job/bus - working"
2  "With job/bus - not on layoff, absent without pay"
3  "With job/bus - on layoff, absent without pay"
4  "No job/bus - looking for work or on layoff"
5  "No job/bus - not looking and not on layoff"
;
label define FM60X
-1  "Not in Universe"
1  "With job/bus - working"
2  "With job/bus - not on layoff, absent without pay"
3  "With job/bus - on layoff, absent without pay"
4  "No job/bus - looking for work or on layoff"
5  "No job/bus - not looking and not on layoff"
;
label define FM61X
-1  "Not in Universe"
1  "With job/bus - working"
2  "With job/bus - not on layoff, absent without pay"
3  "With job/bus - on layoff, absent without pay"
4  "No job/bus - looking for work or on layoff"
5  "No job/bus - not looking and not on layoff"
;
label define FM62X
-1  "Not in Universe"
1  "With job/bus - working"
2  "With job/bus - not on layoff, absent without pay"
3  "With job/bus - on layoff, absent without pay"
4  "No job/bus - looking for work or on layoff"
5  "No job/bus - not looking and not on layoff"
;
label define FM63X
-1  "Not in Universe"
1  "With job/bus - working"
2  "With job/bus - not on layoff, absent without pay"
3  "With job/bus - on layoff, absent without pay"
4  "No job/bus - looking for work or on layoff"
5  "No job/bus - not looking and not on layoff"
;
label define FM64X
-1  "Not in Universe"
4  "Four weeks"
5  "Five weeks"
;
label define FM65X
2001  "Panel Year"
;
label define FM66X
1  "First Reference month"
2  "Second Reference month"
3  "Third Reference month"
4  "Fourth Reference month"
;
label define FM70X
0  "None or not in universe"
;
label define FM71X
0  "None or not in universe"
;
label define FM72X
0  "None or not in universe"
;
label define FM73X
0  "None or not in universe"
;
label define FM74X
0  "None or not in universe"
;
label define FM75X
-1  "Not in Universe"
;
label define FM76X
-1  "Not in Universe"
;
label define FM78X
01  "Alabama"
02  "Alaska"
04  "Arizona"
05  "Arkansas"
06  "California"
08  "Colorado"
09  "Connecticut"
10  "Delaware"
11  "D.C."
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
39  "Ohio"
40  "Oklahoma"
41  "Oregon"
42  "Pennsylvania"
44  "Rhode Island"
45  "South Carolina"
47  "Tennessee"
48  "Texas"
49  "Utah"
51  "Virginia"
53  "Washington"
54  "West Virginia"
55  "Wisconsin"
61  "Maine, Vermont"
62  "North Dakota, South Dakota, Wyoming"
;
label define FM82X
-1  "Not in Universe"
4  "chief executives and general administrators, public administration (112)"
5  "administrators and officials, public administration (1132-1139)"
6  "administrators, protective services (1131)"
7  "financial managers (122)"
8  "personnel and labor relations managers (123)"
9  "purchasing managers (124)"
13  "managers, marketing, advertising, and public relations (125)"
14  "Admin, education and related fields (128)"
15  "managers, medicine and health (131)"
17  "managers, food serving and lodging establishments (1351)"
18  "managers, properties and real estate (1353)"
19  "funeral directors (part 1359)"
21  "managers, service organizations, n.e.c. (127, 1352, 1354, part 1359)"
22  "managers and administrators, n.e.c. (121, 126, 132-1343, 136-139)"
23  "accountants and auditors (1412)"
24  "underwriters (1414)"
25  "other financial officers (1415, 1419)"
26  "management analysts (142)"
27  "personnel, training, and labor relations specialists (143)"
28  "purchasing agents and buyers, farm products (1443)"
29  "buyers, wholesale and retail trade except farm products (1442)"
33  "purch. agents and buyers, n.e.c. (1449)"
34  "business and promotion agents (145)"
35  "construction inspectors (1472)"
36  "inspectors and compliance officers, except construction (1473)"
37  "Management related occupations, n.e.c. (149)"
43  "architects (161)"
44  "aerospace engineers(1622)"
45  "metallurgical and materials engineers (1623)"
46  "mining engineers (1624)"
47  "petroleum engineers (1625)"
48  "chemical engineers (1626)"
49  "nuclear engineers (1627)"
53  "civil engineers (1628)"
54  "agricultural engineers (1632)"
55  "Engineers, electrical and electronic (1633, 1636)"
56  "Engineers, industrial (1634)"
57  "Engineers, mechanical (1635)"
58  "marine and naval architects (1637)"
59  "engineers, n.e.c. (1639)"
63  "surveyors and mapping scientists (164)"
64  "computer systems analysts and scientists (171)"
65  "operations and systems researchers and analysts (172)"
66  "Actuaries (1732)"
67  "Statisticians (1733)"
68  "Mathematical scientists, n.e.c. (1739)"
69  "Physicists and astronomers (1842, 1843)"
73  "Chemists, except biochemists (1845)"
74  "Atmospheric and space scientists (1846)"
75  "Geologists and geodesists (1847)"
76  "Physical scientists, n.e.c. (1849)"
77  "Agricultural and food scientists (1853)"
78  "Biological and life scientists (1854)"
79  "Forestry and conservation scientists (1852)"
83  "Medical scientists (1855)"
84  "Physicians (261)"
85  "Dentists (262)"
86  "Veterinarians (27)"
87  "Optometrists (281)"
88  "Podiatrists (283)"
89  "Health diagnosing practitioners, n.e.c. (289)"
95  "Registered nurses (29)"
96  "Pharmacists (301)"
97  "Dietitians (302)"
98  "Respiratory therapists (3031)"
99  "Occupational therapists (3032)"
103  "Physical therapists (3033)"
104  "Speech therapists (3034)"
105  "Therapists, n.e.c. (3039)"
106  "Physicians'' assistants (304)"
113  "Earth, environmental, and marine science teachers (2212)"
114  "Biological science teachers (2213)"
115  "Chemistry teachers (2214)"
116  "Physics teachers (2215)"
117  "Natural science teachers, n.e.c. (2216)"
118  "Psychology teachers (2217)"
119  "Economics teachers (2218)"
123  "History teachers (2222)"
124  "Political science teachers (2223)"
125  "Sociology teachers (2224)"
126  "Social science teachers, n.e.c. (2225)"
127  "Engineering teachers (2226)"
128  "Math. science teachers (2227)"
129  "Computer science teachers (2228)"
133  "Medical science teachers (2231)"
134  "Health specialties teachers (2232)"
135  "Business, commerce, and marketing teachers (2233)"
136  "Agriculture and forestry teachers (2234)"
137  "Art, drama, and music teachers (2235)"
138  "Physical education teachers (2236)"
139  "Education teachers (2237)"
143  "English teachers (2238)"
144  "Foreign language teachers (2242)"
145  "Law teachers (2243)"
146  "Social work teachers (2244)"
147  "Theology teachers (2245)"
148  "Trade and industrial teachers (2246)"
149  "Home economics teachers (2247)"
153  "Teachers, postsecondary, n.e.c. (2249)"
154  "Postsecondary teachers, subject not specified"
155  "Teachers, prekindergarten and kindergarten (231)"
156  "Teachers, elementary school (232)"
157  "Teachers, secondary school (233)"
158  "Teachers, special education (235)"
159  "Teachers, n.e.c. (236, 239)"
163  "Counselors, Educational and Vocational (24)"
164  "Librarians (251)"
165  "Archivists and curators (252)"
166  "Economists (1912)"
167  "Psychologists (1915)"
168  "Sociologists (1916)"
169  "Social scientists, n.e.c. (1913, 1914, 1919)"
173  "Urban planners (192)"
174  "Social workers (2032)"
175  "Recreation workers (2033)"
176  "Clergy (2042)"
177  "Religious workers, n.e.c. (2049)"
178  "Lawyers and Judges (211, 212)"
183  "Authors (321)"
184  "Technical writers (398)"
185  "Designers (322)"
186  "Musicians and composers (323)"
187  "Actors and directors (324)"
188  "Painters, sculptors, craft-artists, and artist printmakers (325)"
189  "Photographers (326)"
193  "Dancers (327)"
194  "Artists, performers, and related workers, n.e.c. (328,329)"
195  "Editors and reporters (331)"
197  "Public relations specialists (332)"
198  "Announcers (333)"
199  "Athletes (34)"
203  "Clinical laboratory technologists and technicians (362)"
204  "Dental hygienists (363)"
205  "Health record technologists and technicians (364)"
206  "Radiologic technicians (365)"
207  "Licensed practical nurses (366)"
208  "Health technologists and technicians, n.e.c. (369)"
213  "Electrical and electronic technicians (3711)"
214  "Industrial engineering technicians (3712)"
215  "Mechanical engineering technicians (3713)"
216  "Engineering technicians, n.e.c. (3719)"
217  "Drafting occupations (372)"
218  "Surveying and mapping technicians (373)"
223  "Biological technicians (382)"
224  "Chemical technicians (3831)"
225  "Science technicians, n.e.c. (3832, 3833, 384, 389)"
226  "Airplane pilots and navigators (825)"
227  "Air traffic controllers (392)"
228  "Broadcast equipment operators (393)"
229  "Computer programmers (3971, 3972)"
233  "Tool programmers, numerical control (3974)"
234  "Legal assistants (396)"
235  "Technicians, n.e.c. (399)"
243  "Supervisors and Proprietors, Sales Occupations (40)"
253  "Insurance sales occupations (4122)"
254  "Real estate sales occupations (4123)"
255  "Securities and financial services sales occupations (4124)"
256  "Advertising and related sales occupations (4153)"
257  "Sales occupations, other business services (4152)"
258  "Sales engineers (421)"
259  "Sales representatives, mining, manufacturing, and wholesale (423, 424)"
263  "Sales workers, motor vehicles and boats (4342, 4344)"
264  "Sales workers, apparel (4346)"
265  "Sales workers, shoes (4351)"
266  "Sales workers, furniture and home furnishings (4348)"
267  "Sales workers, radio, Tv, hi-fi, and appliances (4343, 4352)"
268  "Sales workers, hardware and building supplies (4353)"
269  "Sales workers, parts (4367)"
274  "Sales workers, other commodities (4345, 4347, 4354, 4356, 4359, 4362, 4369)"
275  "Sales counter clerks (4363)"
276  "Cashiers (4364)"
277  "Street and door-to-door sales workers (4366)"
278  "News vendors (4365)"
283  "Demonstrators, promoters and models, sales (445)"
284  "Auctioneers (447)"
285  "Sales support occupations, n.e.c. (444, 446, 449)"
303  "Supervisors, general office (4511, 4513, 4514, 4516, 4519, 4529)"
304  "Supervisors, computer equipment operators (4512)"
305  "Supervisors, financial records processing (4521)"
306  "Chief communications operators (4523)"
307  "Supervisors, distribution, scheduling, and adjusting clerks (4522, 4524-4528)"
308  "Computer operators (4612)"
309  "Peripheral equipment operators (4613)"
313  "Secretaries (4622)"
314  "Stenographers (4623)"
315  "Typists (4624)"
316  "Interviewers (4642)"
317  "Hotel clerks (4643)"
318  "Transportation ticket and reservation agents (4644)"
319  "Receptionists (4645)"
323  "Information clerks, n.e.c. (4649)"
325  "Classified-ad clerks (4662)"
326  "Correspondence clerks (4663)"
327  "Order clerks (4664)"
328  "Personnel clerks, except payroll and timekeeping (4692)"
329  "Library clerks (4694)"
335  "File clerks (4696)"
336  "Records clerks (4699)"
337  "Bookkeepers, accounting, and auditing clerks (4712)"
338  "Payroll and timekeeping clerks (4713)"
339  "Billing clerks (4715)"
343  "Cost and rate clerks (4716)"
344  "Billing, posting, and calculating machine operators (4718)"
345  "Duplicating machine operators (4722)"
346  "Mail preparing and paper handling machine operators (4723)"
347  "Office machine operators, n.e.c. (4729)"
348  "Telephone operators (4732)"
353  "Communications equipment operators, n.e.c. (4733, 4739)"
354  "Postal clerks, except mail carriers (4742)"
355  "Mail carriers, postal service (4743)"
356  "Mail clerks, except postal service (4744)"
357  "Messengers (4745)"
359  "Dispatchers (4751)"
363  "Production coordinators (4752)"
364  "Traffic, shipping, and receiving clerks (4753)"
365  "Stock and inventory clerks (4754)"
366  "Meter readers (4755)"
368  "Weighers, measurers, checkers, and samplers (4756, 4757)"
373  "Expediters (4758)"
374  "Material recording, scheduling, and distributing clerks, n.e.c. (4759)"
375  "Insurance adjusters, examiners, and investigators (4782)"
376  "Investigators and adjusters, except insurance (4783)"
377  "Eligibility clerks, social welfare (4784)"
378  "Bill and account collectors (4786)"
379  "General office clerks (463)"
383  "Bank tellers (4791)"
384  "Proofreaders (4792)"
385  "Data-entry keyers (4793)"
386  "Statistical clerks (4794)"
387  "Teachers'' aides (4795)"
389  "Administrative support occupations, n.e.c. (4787, 4799)"
403  "Launderers and ironers (503)"
404  "Cooks, private household (504)"
405  "Housekeepers and butlers (505)"
406  "Child care workers, private household (506)"
407  "Private household cleaners and servants (502, 507, 509)"
413  "Supervisors, firefighting and fire prevention occupations(5111)"
414  "Supervisors, police and detectives (5112)"
415  "Supervisors, guards (5113)"
416  "Fire inspection and fire prevention occupations (5122)"
417  "Firefighting occupations (5123)"
418  "Police and detectives, public service (5132)"
423  "Sheriffs, bailiffs, and other law enforcement officers(5134)"
424  "Correctional institution officers (5133)"
425  "Crossing guards (5142)"
426  "Guards and police, except public service (5144)"
427  "Protective service occupations, n.e.c. (5149)"
433  "Supervisors, food preparation and service occupations (5211)"
434  "Bartenders (5212)"
435  "Waiters and waitresses (5213)"
436  "Cooks (5214, 5215)"
438  "Food counter, fountain and related occupations (5216)"
439  "Kitchen workers, food preparation (5217)"
443  "Waiters''/waitresses'' assistants (5218)"
444  "Miscellaneous food preparation occupations (5219)"
445  "Dental assistants (5232)"
446  "Health aides, except nursing (5233)"
447  "Nursing aides, orderlies, and attendants (5236)"
448  "Supervisors, cleaning and building service workers (5241)"
449  "Maids and housemen (5242, 5249)"
453  "Janitors and cleaners (5244)"
454  "Elevator operators (5245)"
455  "Pest control occupations (5246)"
456  "Supervisors, personal service occupations (5251)"
457  "Barbers (5252)"
458  "Hairdressers and cosmetologists (5253)"
459  "Attendants, amusement and recreation facilities (5254)"
461  "Guides (5255)"
462  "Ushers (5256)"
463  "Public transportation attendants (5257)"
464  "Baggage porters and bellhops (5262)"
465  "Welfare service aides (5263)"
466  "Family child care providers (part 5264)"
467  "Early childhood teacher''s assistants (part 5264)"
468  "Child care workers, n.e.c. (part 5264)"
469  "Personal service occupations, n.e.c. (5258, 5269)"
473  "Farmers, except horticultural (5512-5514)"
474  "Horticultural specialty farmers (5515)"
475  "Managers, farms, except horticultural (5522-5524)"
476  "Managers, horticultural specialty farms (5525)"
477  "Supervisors, farm workers (5611)"
479  "Farm workers (5612-5617)"
483  "Marine life cultivation workers (5618)"
484  "Nursery workers (5619)"
485  "Supervisors, related agricultural occupations (5621)"
486  "Groundskeepers and gardeners, except farm (5622)"
487  "Animal caretakers, except farm (5624)"
488  "Graders and sorters, agricultural products (5625)"
489  "Inspectors, agricultural products (5627)"
494  "Supervisors, forestry and logging workers (571)"
495  "Forestry workers, except logging (572)"
496  "Timber cutting and logging occupations (573, 579)"
497  "Captains and other officers, fishing vessels (part 8241)"
498  "Fishers (583)"
499  "Hunters and trappers (584)"
503  "Supervisors, mechanics and repairers (60)"
505  "Automobile mechanics (part 6111)"
506  "Auto mechanic apprentices (part 6111)"
507  "Bus, truck, and stationary engine mechanics (6112)"
508  "Aircraft engine mechanics (6113)"
509  "Small engine repairers (6114)"
514  "Automobile body and related repairers (6115)"
515  "Aircraft mechanics, except engine (6116)"
516  "Heavy equipment mechanics (6117)"
517  "Farm equipment mechanics (6118)"
518  "Industrial machinery repairers (613)"
519  "Machinery maintenance occupations (614)"
523  "Electronic repairers, communications and industrial equipment (6151, 6153, 6155)"
525  "Data processing equipment repairers (6154)"
526  "Hhld appliance and power tool repairers (6156)"
527  "Telephone line installers and repairers (6157)"
529  "Telephone installers and repairers (6158)"
533  "Miscellaneous electrical and electronic equipment repairers (6152, 6159)"
534  "Heating, air conditioning, and refrigeration mechanics (616)"
535  "Camera, watch, and musical instrument repairers (6171, 6172)"
536  "Locksmiths and safe repairers (6173)"
538  "Office machine repairers (6174)"
539  "Mechanical controls and valve repairers (6175)"
543  "Elevator installers and repairers (6176)"
544  "Millwrights (6178)"
547  "Specified mechanics and repairers, n.e.c. (6177, 6179)"
549  "Not specified mechanics and repairers"
553  "Supervisors, brickmasons, stonemasons, and tile setters (6312)"
554  "Supervisors, carpenters and related workers (6313)"
555  "Supervisors, electricians and power transmission installers (6314)"
556  "Supervisors, painters, paperhangers, and plasterers (6315)"
557  "Supervisors, plumbers, pipefitters, and steamfitters (6316)"
558  "Supervisors, construction, n.e.c. (6311, 6318)"
563  "Brickmasons and stonemasons (part 6412, part 6413)"
564  "Brickmason and stonemason apprentices (part 6412, part 6413)"
565  "Tile setters, hard and soft (part 6414, part 6462)"
566  "Carpet installers (part 6462)"
567  "Carpenters (part 6422)"
569  "Carpenter apprentices (part 6422)"
573  "Drywall installers (6424)"
575  "Electricians (part 6432)"
576  "Electrician apprentices (part 6432)"
577  "Electrical power installers and repairers (6433)"
579  "Painters, construction and maintenance (6442)"
583  "Paperhangers (6443)"
584  "Plasterers (6444)"
585  "Plumbers, pipefitters, and steamfitters (part 645)"
587  "Plumber, pipefitter, and steamfitter apprentices (part 645)"
588  "Concrete and terrazzo finishers (6463)"
589  "Glaziers (6464)"
593  "Insulation workers (6465)"
594  "Paving, surfacing, and tamping equipment operators (6466)"
595  "Roofers (6468)"
596  "Sheetmetal duct installers (6472)"
597  "Structural metal workers (6473)"
598  "Drillers, earth (6474)"
599  "Construction trades, n.e.c. (6467, 6475, 6476, 6479)"
613  "Supervisors, extractive occupations (632)"
614  "Drillers, oil well (652)"
615  "Explosives workers (653)"
616  "Mining machine operators (654)"
617  "Mining occupations, n.e.c. (656)"
628  "Supervisors, production occupations (67, 71)"
634  "Tool and die makers (part 6811)"
635  "Tool and die mkr apprentices (part 6811)"
636  "Precision assemblers, metal (6812)"
637  "Machinists (part 6813)"
639  "Machinist apprentices (part 6813)"
643  "Boilermakers (6814)"
644  "Precision grinders, filers, and tool sharpeners (6816)"
645  "Patternmakers and model makers, metal (6817)"
646  "Lay-out workers (6821)"
647  "Precious stones and metals workers (Jewelers) (6822, 6866)"
649  "Engravers, metal (6823)"
653  "Sheet metal workers (part 6824)"
654  "Sheet metal wrker apprentices (part 6824)"
655  "Misc precision metal workers (6829)"
656  "Patternmkrs and model makers, wood (6831)"
657  "Cabinet makers and bench carpenters (6832)"
658  "Furniture and wood finishers (6835)"
659  "Misc precision woodworkers (6839)"
666  "Dressmakers (part 6852, part 7752)"
667  "Tailors (part 6852)"
668  "Upholsterers (6853)"
669  "Shoe repairers (6854)"
674  "Misc precision apparel and fabric workers (6856, 6859, part 7752)"
675  "Hand molders and shapers, except jewelers (6861)"
676  "Patternmakers, lay-out workers, and cutters (6862)"
677  "Optical goods workers (6864, part 7477, part 7677)"
678  "Dental laboratory and medical appliance technicians (6865)"
679  "Bookbinders (6844)"
683  "Electrical/electronic equipment assemblers (6867)"
684  "Msc precision workers, n.e.c. (6869)"
686  "Butchers and meat cutters (6871)"
687  "Bakers (6872)"
688  "Food batchmakers (6873, 6879)"
689  "Inspectors, testers, and graders (6881, 828)"
693  "Adjusters and calibrators (6882)"
694  "Water and sewage treatment plant operators (691)"
695  "Power plant operators (part 693)"
696  "Stationary engineers (part 693, 7668)"
699  "Miscellaneous plant and system operators (692, 694, 695, 696)"
703  "Set-up operators, lathe and turning machine (7312)"
704  "Operators, lathe and turning machine (7512)"
705  "Milling and planing machine operators (7313, 7513)"
706  "Punching and stamping press machine operators (7314, 7317, 7514, 7517)"
707  "Rolling machine operators (7316, 7516)"
708  "Drilling and boring machine operators (7318, 7518)"
709  "Grinding, abrading, buffing, and polishing machine operators (7322, 7324, 7522)"
713  "Forging machine operators (7319, 7519)"
714  "Numerical control machine operators (7326)"
715  "Miscellaneous metal, plastic, stone, and glass working machine operators (7329, 7529)"
717  "Fabricating machine operators, n.e.c. (7339, 7539)"
719  "Molding and casting machine operators (7315, 7342, 7515, 7542)"
723  "Metal plating machine operators (7343, 7543)"
724  "Heat treating equipment operators (7344, 7544)"
725  "Misc metal and plastic processing machine operators (7349, 7549)"
726  "Wood lathe, routing, and planing machine operators (7431, 7432, 7631, 7632)"
727  "Sawing machine operators (7433, 7633)"
728  "Shaping and joining machine operators (7435, 7635)"
729  "Nailing and tacking machine operators (7636)"
733  "Miscellaneous woodworking machine operators (7434, 7439, 7634, 7639)"
734  "Printing press operators (7443, 7643)"
735  "Photoengravers and lithographers (6842, 7444, 7644)"
736  "Typesetters and compositors (6841, 7642)"
737  "Miscellaneous printing machine operators (6849, 7449, 7649)"
738  "Winding and twisting machine operators (7451, 7651)"
739  "Knitting, looping, taping, and weaving machine operators (7452, 7652)"
743  "Textile cutting machine operators (7654)"
744  "Textile sewing machine operators (7655)"
745  "Shoe machine operators (7656)"
747  "Pressing machine operators (7657)"
748  "Laundering and dry cleaning machine operators (6855, 7658)"
749  "Miscellaneous textile machine operators (7459, 7659)"
753  "Cementing and gluing machine operators (7661)"
754  "Packaging and filling machine operators (7462, 7662)"
755  "Extruding and forming machine operators (7463, 7663)"
756  "Mixing and blending machine operators (7664)"
757  "Separating, filtering, and clarifying machine operators (7476, 7666, 7676)"
758  "Compressing and compacting machine operators (7467, 7667)"
759  "Painting and paint spraying machine operators (7669)"
763  "Roasting and baking machine operators, food (7472, 7672)"
764  "Washing, cleaning, and pickling machine operators (7673)"
765  "Folding machine operators (7474, 7674)"
766  "Furnace, kiln, and oven operators, except food (7675)"
768  "Crushing and grinding machine operators (part 7477, part 7677)"
769  "Slicing and cutting machine operators (7478, 7678)"
773  "Motion picture projectionists (part 7479)"
774  "Photographic process machine operators (6863, 6868, 7671)"
777  "Miscellaneous machine operators, n.e.c. (part 7479, 7665, 7679)"
779  "Machine operators, not specified"
783  "Welders and cutters (7332, 7532, 7714)"
784  "Solderers and brazers (7333, 7533, 7717)"
785  "Assemblers (772, 774)"
786  "Hand cutting and trimming occupations (7753)"
787  "Hand molding, casting, and forming occupations (7754, 7755)"
789  "Hand painting, coating, and decorating occupations (7756)"
793  "Hand engraving and printing occupations (7757)"
795  "Miscellaneous hand working occupations (7758, 7759)"
796  "Production inspectors, checkers, and examiners (782, 787)"
797  "Production testers (783)"
798  "Production samplers and weighers (784)"
799  "Graders and sorters, except agricultural (785)"
803  "Supervisors, motor vehicle operators (8111)"
804  "Truck drivers (8212-8214)"
806  "Driver-sales workers (8218)"
808  "Bus drivers (8215)"
809  "Taxicab drivers and chauffeurs (8216)"
813  "Parking lot attendants (874)"
814  "Motor transportation occupations, n.e.c. (8219)"
823  "Railroad conductors and yardmasters (8113)"
824  "Locomotive operating occupations (8232)"
825  "Railroad brake, signal, and switch operators (8233)"
826  "Rail vehicle operators, n.e.c. (8239)"
828  "Ship captains and mates, except fishing boats (part 8241, 8242)"
829  "Sailors and deckhands (8243)"
833  "Marine engineers (8244)"
834  "Bridge, lock, and lighthouse tenders (8245)"
843  "Supervisors, material moving equipment operators (812)"
844  "Operating engineers (8312)"
845  "Longshore equipment operators (8313)"
848  "Hoist and winch operators (8314)"
849  "Crane and tower operators (8315)"
853  "Excavating and loading machine operators (8316)"
855  "Grader, dozer, and scraper operators (8317)"
856  "Industrial truck and tractor equipment operators (8318)"
859  "Misc material moving equipment operators (8319)"
864  "Supervisors, handlers, equipment cleaners, and laborers, n.e.c. (85)"
865  "Helpers, mechanics, and repairers (863)"
866  "Helpers, construction trades (8641-8645, 8648)"
867  "Helpers, surveyor (8646)"
868  "Helpers, extractive occupations (865)"
869  "Construction laborers (871)"
874  "Production helpers (861, 862)"
875  "Garbage collectors (8722)"
876  "Stevedores (8723)"
877  "Stock handlers and baggers (8724)"
878  "Machine feeders and offbearers (8725)"
883  "Freight, stock, and material handlers, n.e.c. (8726)"
885  "Garage and service station related occupations (873)"
887  "Vehicle washers and equipment cleaners (875)"
888  "Hand packers and packagers (8761)"
889  "Laborers, except construction (8769)"
905  "Persons whose current labor force status is unemployed and last job was Armed Forces"
;
label define FM83X
-1  "Not in Universe"
4  "chief executives and general administrators, public administration (112)"
5  "administrators and officials, public administration (1132-1139)"
6  "administrators, protective services (1131)"
7  "financial managers (122)"
8  "personnel and labor relations managers (123)"
9  "purchasing managers (124)"
13  "managers, marketing, advertising, and public relations (125)"
14  "Admin, education and related fields (128)"
15  "managers, medicine and health (131)"
17  "managers, food serving and lodging establishments (1351)"
18  "managers, properties and real estate (1353)"
19  "funeral directors (part 1359)"
21  "managers, service organizations, n.e.c. (127, 1352, 1354, part 1359)"
22  "managers and administrators, n.e.c. (121, 126, 132-1343, 136-139)"
23  "accountants and auditors (1412)"
24  "underwriters (1414)"
25  "other financial officers (1415, 1419)"
26  "management analysts (142)"
27  "personnel, training, and labor relations specialists (143)"
28  "purchasing agents and buyers, farm products (1443)"
29  "buyers, wholesale and retail trade except farm products (1442)"
33  "purch. agents and buyers, n.e.c. (1449)"
34  "business and promotion agents (145)"
35  "construction inspectors (1472)"
36  "inspectors and compliance officers, except construction (1473)"
37  "Management related occupations, n.e.c. (149)"
43  "architects (161)"
44  "aerospace engineers(1622)"
45  "metallurgical and materials engineers (1623)"
46  "mining engineers (1624)"
47  "petroleum engineers (1625)"
48  "chemical engineers (1626)"
49  "nuclear engineers (1627)"
53  "civil engineers (1628)"
54  "agricultural engineers (1632)"
55  "Engineers, electrical and electronic (1633, 1636)"
56  "Engineers, industrial (1634)"
57  "Engineers, mechanical (1635)"
58  "marine and naval architects (1637)"
59  "engineers, n.e.c. (1639)"
63  "surveyors and mapping scientists (164)"
64  "computer systems analysts and scientists (171)"
65  "operations and systems researchers and analysts (172)"
66  "Actuaries (1732)"
67  "Statisticians (1733)"
68  "Mathematical scientists, n.e.c. (1739)"
69  "Physicists and astronomers (1842, 1843)"
73  "Chemists, except biochemists (1845)"
74  "Atmospheric and space scientists (1846)"
75  "Geologists and geodesists (1847)"
76  "Physical scientists, n.e.c. (1849)"
77  "Agricultural and food scientists (1853)"
78  "Biological and life scientists (1854)"
79  "Forestry and conservation scientists (1852)"
83  "Medical scientists (1855)"
84  "Physicians (261)"
85  "Dentists (262)"
86  "Veterinarians (27)"
87  "Optometrists (281)"
88  "Podiatrists (283)"
89  "Health diagnosing practitioners, n.e.c. (289)"
95  "Registered nurses (29)"
96  "Pharmacists (301)"
97  "Dietitians (302)"
98  "Respiratory therapists (3031)"
99  "Occupational therapists (3032)"
103  "Physical therapists (3033)"
104  "Speech therapists (3034)"
105  "Therapists, n.e.c. (3039)"
106  "Physicians'' assistants (304)"
113  "Earth, environmental, and marine science teachers (2212)"
114  "Biological science teachers (2213)"
115  "Chemistry teachers (2214)"
116  "Physics teachers (2215)"
117  "Natural science teachers, n.e.c. (2216)"
118  "Psychology teachers (2217)"
119  "Economics teachers (2218)"
123  "History teachers (2222)"
124  "Political science teachers (2223)"
125  "Sociology teachers (2224)"
126  "Social science teachers, n.e.c. (2225)"
127  "Engineering teachers (2226)"
128  "Math. science teachers (2227)"
129  "Computer science teachers (2228)"
133  "Medical science teachers (2231)"
134  "Health specialties teachers (2232)"
135  "Business, commerce, and marketing teachers (2233)"
136  "Agriculture and forestry teachers (2234)"
137  "Art, drama, and music teachers (2235)"
138  "Physical education teachers (2236)"
139  "Education teachers (2237)"
143  "English teachers (2238)"
144  "Foreign language teachers (2242)"
145  "Law teachers (2243)"
146  "Social work teachers (2244)"
147  "Theology teachers (2245)"
148  "Trade and industrial teachers (2246)"
149  "Home economics teachers (2247)"
153  "Teachers, postsecondary, n.e.c. (2249)"
154  "Postsecondary teachers, subject not specified"
155  "Teachers, prekindergarten and kindergarten (231)"
156  "Teachers, elementary school (232)"
157  "Teachers, secondary school (233)"
158  "Teachers, special education (235)"
159  "Teachers, n.e.c. (236, 239)"
163  "Counselors, Educational and Vocational (24)"
164  "Librarians (251)"
165  "Archivists and curators (252)"
166  "Economists (1912)"
167  "Psychologists (1915)"
168  "Sociologists (1916)"
169  "Social scientists, n.e.c. (1913, 1914, 1919)"
173  "Urban planners (192)"
174  "Social workers (2032)"
175  "Recreation workers (2033)"
176  "Clergy (2042)"
177  "Religious workers, n.e.c. (2049)"
178  "Lawyers and Judges (211, 212)"
183  "Authors (321)"
184  "Technical writers (398)"
185  "Designers (322)"
186  "Musicians and composers (323)"
187  "Actors and directors (324)"
188  "Painters, sculptors, craft-artists, and artist printmakers (325)"
189  "Photographers (326)"
193  "Dancers (327)"
194  "Artists, performers, and related workers, n.e.c. (328, 329)"
195  "Editors and reporters (331)"
197  "Public relations specialists (332)"
198  "Announcers (333)"
199  "Athletes (34)"
203  "Clinical laboratory technologists and technicians (362)"
204  "Dental hygienists (363)"
205  "Health record technologists and technicians (364)"
206  "Radiologic technicians (365)"
207  "Licensed practical nurses (366)"
208  "Health technologists and technicians, n.e.c. (369)"
213  "Electrical and electronic technicians (3711)"
214  "Industrial engineering technicians (3712)"
215  "Mechanical engineering technicians (3713)"
216  "Engineering technicians, n.e.c. (3719)"
217  "Drafting occupations (372)"
218  "Surveying and mapping technicians (373)"
223  "Biological technicians (382)"
224  "Chemical technicians (3831)"
225  "Science technicians, n.e.c. (3832, 3833, 384, 389)"
226  "Airplane pilots and navigators (825)"
227  "Air traffic controllers (392)"
228  "Broadcast equipment operators (393)"
229  "Computer programmers (3971, 3972)"
233  "Tool programmers, numerical control (3974)"
234  "Legal assistants (396)"
235  "Technicians, n.e.c. (399)"
243  "Supervisors and Proprietors, Sales Occupations (40)"
253  "Insurance sales occupations (4122)"
254  "Real estate sales occupations (4123)"
255  "Securities and financial services sales occupations (4124)"
256  "Advertising and related sales occupations (4153)"
257  "Sales occupations, other business services (4152)"
258  "Sales engineers (421)"
259  "Sales representatives, mining, manufacturing, and wholesale (423, 424)"
263  "Sales workers, motor vehicles and boats (4342, 4344)"
264  "Sales workers, apparel (4346)"
265  "Sales workers, shoes (4351)"
266  "Sales workers, furniture and home furnishings (4348)"
267  "Sales workers, radio, Tv, hi-fi, and appliances (4343, 4352)"
268  "Sales workers, hardware and building supplies (4353)"
269  "Sales workers, parts (4367)"
274  "Sales workers, other commodities (4345, 4347, 4354, 4356, 4359, 4362, 4369)"
275  "Sales counter clerks (4363)"
276  "Cashiers (4364)"
277  "Street and door-to-door sales workers (4366)"
278  "News vendors (4365)"
283  "Demonstrators, promoters and models, sales (445)"
284  "Auctioneers (447)"
285  "Sales support occupations, n.e.c. (444, 446, 449)"
303  "Supervisors, general office (4511, 4513, 4514, 4516, 4519, 4529)"
304  "Supervisors, computer equipment operators (4512)"
305  "Supervisors, financial records processing (4521)"
306  "Chief communications operators (4523)"
307  "Supervisors, distribution, scheduling, and adjusting clerks (4522, 4524-4528)"
308  "Computer operators (4612)"
309  "Peripheral equipment operators (4613)"
313  "Secretaries (4622)"
314  "Stenographers (4623)"
315  "Typists (4624)"
316  "Interviewers (4642)"
317  "Hotel clerks (4643)"
318  "Transportation ticket and reservation agents (4644)"
319  "Receptionists (4645)"
323  "Information clerks, n.e.c. (4649)"
325  "Classified-ad clerks (4662)"
326  "Correspondence clerks (4663)"
327  "Order clerks (4664)"
328  "Personnel clerks, except payroll and timekeeping (4692)"
329  "Library clerks (4694)"
335  "File clerks (4696)"
336  "Records clerks (4699)"
337  "Bookkeepers, accounting, and auditing clerks (4712)"
338  "Payroll and timekeeping clerks (4713)"
339  "Billing clerks (4715)"
343  "Cost and rate clerks (4716)"
344  "Billing, posting, and calculating machine operators (4718)"
345  "Duplicating machine operators (4722)"
346  "Mail preparing and paper handling machine operators (4723)"
347  "Office machine operators, n.e.c. (4729)"
348  "Telephone operators (4732)"
353  "Communications equipment operators, n.e.c. (4733, 4739)"
354  "Postal clerks, except mail carriers (4742)"
355  "Mail carriers, postal service (4743)"
356  "Mail clerks, except postal service (4744)"
357  "Messengers (4745)"
359  "Dispatchers (4751)"
363  "Production coordinators (4752)"
364  "Traffic, shipping, and receiving clerks (4753)"
365  "Stock and inventory clerks (4754)"
366  "Meter readers (4755)"
368  "Weighers, measurers, checkers, and samplers (4756, 4757)"
373  "Expediters (4758)"
374  "Material recording, scheduling, and distributing clerks, n.e.c. (4759)"
375  "Insurance adjusters, examiners, and investigators (4782)"
376  "Investigators and adjusters, except insurance (4783)"
377  "Eligibility clerks, social welfare (4784)"
378  "Bill and account collectors (4786)"
379  "General office clerks (463)"
383  "Bank tellers (4791)"
384  "Proofreaders (4792)"
385  "Data-entry keyers (4793)"
386  "Statistical clerks (4794)"
387  "Teachers'' aides (4795)"
389  "Administrative support occupations, n.e.c. (4787, 4799)"
403  "Launderers and ironers (503)"
404  "Cooks, private household (504)"
405  "Housekeepers and butlers (505)"
406  "Child care workers, private household (506)"
407  "Private household cleaners and servants (502, 507, 509)"
413  "Supervisors, firefighting and fire prevention occupations(5111)"
414  "Supervisors, police and detectives (5112)"
415  "Supervisors, guards (5113)"
416  "Fire inspection and fire prevention occupations (5122)"
417  "Firefighting occupations (5123)"
418  "Police and detectives, public service (5132)"
423  "Sheriffs, bailiffs, and other law enforcement officers(5134)"
424  "Correctional institution officers (5133)"
425  "Crossing guards (5142)"
426  "Guards and police, except public service (5144)"
427  "Protective service occupations, n.e.c. (5149)"
433  "Supervisors, food preparation and service occupations (5211)"
434  "Bartenders (5212)"
435  "Waiters and waitresses (5213)"
436  "Cooks (5214, 5215)"
438  "Food counter, fountain and related occupations (5216)"
439  "Kitchen workers, food preparation (5217)"
443  "Waiters''/waitresses'' assistants (5218)"
444  "Miscellaneous food preparation occupations (5219)"
445  "Dental assistants (5232)"
446  "Health aides, except nursing (5233)"
447  "Nursing aides, orderlies, and attendants (5236)"
448  "Supervisors, cleaning and building service workers (5241)"
449  "Maids and housemen (5242, 5249)"
453  "Janitors and cleaners (5244)"
454  "Elevator operators (5245)"
455  "Pest control occupations (5246)"
456  "Supervisors, personal service occupations (5251)"
457  "Barbers (5252)"
458  "Hairdressers and cosmetologists (5253)"
459  "Attendants, amusement and recreation facilities (5254)"
461  "Guides (5255)"
462  "Ushers (5256)"
463  "Public transportation attendants (5257)"
464  "Baggage porters and bellhops (5262)"
465  "Welfare service aides (5263)"
466  "Family child care providers (part 5264)"
467  "Early childhood teacher''s assistants (part 5264)"
468  "Child care workers, n.e.c. (part 5264)"
469  "Personal service occupations, n.e.c. (5258, 5269)"
473  "Farmers, except horticultural (5512-5514)"
474  "Horticultural specialty farmers (5515)"
475  "Managers, farms, except horticultural (5522-5524)"
476  "Managers, horticultural specialty farms (5525)"
477  "Supervisors, farm workers (5611)"
479  "Farm workers (5612-5617)"
483  "Marine life cultivation workers (5618)"
484  "Nursery workers (5619)"
485  "Supervisors, related agricultural occupations (5621)"
486  "Groundskeepers and gardeners, except farm (5622)"
487  "Animal caretakers, except farm (5624)"
488  "Graders and sorters, agricultural products (5625)"
489  "Inspectors, agricultural products (5627)"
494  "Supervisors, forestry and logging workers (571)"
495  "Forestry workers, except logging (572)"
496  "Timber cutting and logging occupations (573, 579)"
497  "Captains and other officers, fishing vessels (part 8241)"
498  "Fishers (583)"
499  "Hunters and trappers (584)"
503  "Supervisors, mechanics and repairers (60)"
505  "Automobile mechanics (part 6111)"
506  "Auto mechanic apprentices (part 6111)"
507  "Bus, truck, and stationary engine mechanics (6112)"
508  "Aircraft engine mechanics (6113)"
509  "Small engine repairers (6114)"
514  "Automobile body and related repairers (6115)"
515  "Aircraft mechanics, except engine (6116)"
516  "Heavy equipment mechanics (6117)"
517  "Farm equipment mechanics (6118)"
518  "Industrial machinery repairers (613)"
519  "Machinery maintenance occupations (614)"
523  "Electronic repairers, communications and industrial equipment (6151, 6153, 6155)"
525  "Data processing equipment repairers (6154)"
526  "Hhld appliance and power tool repairers (6156)"
527  "Telephone line installers and repairers (6157)"
529  "Telephone installers and repairers (6158)"
533  "Miscellaneous electrical and electronic equipment repairers (6152, 6159)"
534  "Heating, air conditioning, and refrigeration mechanics (616)"
535  "Camera, watch, and musical instrument repairers (6171, 6172)"
536  "Locksmiths and safe repairers (6173)"
538  "Office machine repairers (6174)"
539  "Mechanical controls and valve repairers (6175)"
543  "Elevator installers and repairers (6176)"
544  "Millwrights (6178)"
547  "Specified mechanics and repairers, n.e.c. (6177, 6179)"
549  "Not specified mechanics and repairers"
553  "Supervisors, brickmasons, stonemasons, and tile setters (6312)"
554  "Supervisors, carpenters and related workers (6313)"
555  "Supervisors, electricians and power transmission installers (6314)"
556  "Supervisors, painters, paperhangers, and plasterers (6315)"
557  "Supervisors, plumbers, pipefitters, and steamfitters (6316)"
558  "Supervisors, construction, n.e.c. (6311, 6318)"
563  "Brickmasons and stonemasons (part 6412, part 6413)"
564  "Brickmason and stonemason apprentices (part 6412, part 6413)"
565  "Tile setters, hard and soft (part 6414, part 6462)"
566  "Carpet installers (part 6462)"
567  "Carpenters (part 6422)"
569  "Carpenter apprentices (part 6422)"
573  "Drywall installers (6424)"
575  "Electricians (part 6432)"
576  "Electrician apprentices (part 6432)"
577  "Electrical power installers and repairers (6433)"
579  "Painters, construction and maintenance (6442)"
583  "Paperhangers (6443)"
584  "Plasterers (6444)"
585  "Plumbers, pipefitters, and steamfitters (part 645)"
587  "Plumber, pipefitter, and steamfitter apprentices (part 645)"
588  "Concrete and terrazzo finishers (6463)"
589  "Glaziers (6464)"
593  "Insulation workers (6465)"
594  "Paving, surfacing, and tamping equipment operators (6466)"
595  "Roofers (6468)"
596  "Sheetmetal duct installers (6472)"
597  "Structural metal workers (6473)"
598  "Drillers, earth (6474)"
599  "Construction trades, n.e.c. (6467, 6475, 6476, 6479)"
613  "Supervisors, extractive occupations (632)"
614  "Drillers, oil well (652)"
615  "Explosives workers (653)"
616  "Mining machine operators (654)"
617  "Mining occupations, n.e.c. (656)"
628  "Supervisors, production occupations (67, 71)"
634  "Tool and die makers (part 6811)"
635  "Tool and die mkr apprentices (part 6811)"
636  "Precision assemblers, metal (6812)"
637  "Machinists (part 6813)"
639  "Machinist apprentices (part 6813)"
643  "Boilermakers (6814)"
644  "Precision grinders, filers, and tool sharpeners (6816)"
645  "Patternmakers and model makers, metal (6817)"
646  "Lay-out workers (6821)"
647  "Precious stones and metals workers (Jewelers) (6822, 6866)"
649  "Engravers, metal (6823)"
653  "Sheet metal workers (part 6824)"
654  "Sheet metal wrker apprentices (part 6824)"
655  "Misc precision metal workers (6829)"
656  "Patternmkrs and model makers, wood (6831)"
657  "Cabinet makers and bench carpenters (6832)"
658  "Furniture and wood finishers (6835)"
659  "Misc precision woodworkers (6839)"
666  "Dressmakers (part 6852, part 7752)"
667  "Tailors (part 6852)"
668  "Upholsterers (6853)"
669  "Shoe repairers (6854)"
674  "Misc precision apparel and fabric workers (6856, 6859, part 7752)"
675  "Hand molders and shapers, except jewelers (6861)"
676  "Patternmakers, lay-out workers, and cutters (6862)"
677  "Optical goods workers (6864, part 7477, part 7677)"
678  "Dental laboratory and medical appliance technicians (6865)"
679  "Bookbinders (6844)"
683  "Electrical/electronic equipment assemblers (6867)"
684  "Msc precision workers, n.e.c. (6869)"
686  "Butchers and meat cutters (6871)"
687  "Bakers (6872)"
688  "Food batchmakers (6873, 6879)"
689  "Inspectors, testers, and graders (6881, 828)"
693  "Adjusters and calibrators (6882)"
694  "Water and sewage treatment plant operators (691)"
695  "Power plant operators (part 693)"
696  "Stationary engineers (part 693, 7668)"
699  "Miscellaneous plant and system operators (692, 694, 695, 696)"
703  "Set-up operators, lathe and turning machine (7312)"
704  "Operators, lathe and turning machine (7512)"
705  "Milling and planing machine operators (7313, 7513)"
706  "Punching and stamping press machine operators (7314, 7317, 7514, 7517)"
707  "Rolling machine operators (7316, 7516)"
708  "Drilling and boring machine operators (7318, 7518)"
709  "Grinding, abrading, buffing, and polishing machine operators (7322, 7324, 7522)"
713  "Forging machine operators (7319, 7519)"
714  "Numerical control machine operators (7326)"
715  "Miscellaneous metal, plastic, stone, and glass working machine operators (7329, 7529)"
717  "Fabricating machine operators, n.e.c. (7339, 7539)"
719  "Molding and casting machine operators (7315, 7342, 7515, 7542)"
723  "Metal plating machine operators (7343, 7543)"
724  "Heat treating equipment operators (7344, 7544)"
725  "Misc metal and plastic processing machine operators (7349, 7549)"
726  "Wood lathe, routing, and planing machine operators (7431, 7432, 7631, 7632)"
727  "Sawing machine operators (7433, 7633)"
728  "Shaping and joining machine operators (7435, 7635)"
729  "Nailing and tacking machine operators (7636)"
733  "Miscellaneous woodworking machine operators (7434, 7439, 7634, 7639)"
734  "Printing press operators (7443, 7643)"
735  "Photoengravers and lithographers (6842, 7444, 7644)"
736  "Typesetters and compositors (6841, 7642)"
737  "Miscellaneous printing machine operators (6849, 7449, 7649)"
738  "Winding and twisting machine operators (7451, 7651)"
739  "Knitting, looping, taping, and weaving machine operators (7452, 7652)"
743  "Textile cutting machine operators (7654)"
744  "Textile sewing machine operators (7655)"
745  "Shoe machine operators (7656)"
747  "Pressing machine operators (7657)"
748  "Laundering and dry cleaning machine operators (6855, 7658)"
749  "Miscellaneous textile machine operators (7459, 7659)"
753  "Cementing and gluing machine operators (7661)"
754  "Packaging and filling machine operators (7462, 7662)"
755  "Extruding and forming machine operators (7463, 7663)"
756  "Mixing and blending machine operators (7664)"
757  "Separating, filtering, and clarifying machine operators (7476, 7666, 7676)"
758  "Compressing and compacting machine operators (7467, 7667)"
759  "Painting and paint spraying machine operators (7669)"
763  "Roasting and baking machine operators, food (7472, 7672)"
764  "Washing, cleaning, and pickling machine operators (7673)"
765  "Folding machine operators (7474, 7674)"
766  "Furnace, kiln, and oven operators, except food (7675)"
768  "Crushing and grinding machine operators (part 7477, part 7677)"
769  "Slicing and cutting machine operators (7478, 7678)"
773  "Motion picture projectionists (part 7479)"
774  "Photographic process machine operators (6863, 6868, 7671)"
777  "Miscellaneous machine operators, n.e.c. (part 7479, 7665, 7679)"
779  "Machine operators, not specified"
783  "Welders and cutters (7332, 7532, 7714)"
784  "Solderers and brazers (7333, 7533, 7717)"
785  "Assemblers (772, 774)"
786  "Hand cutting and trimming occupations (7753)"
787  "Hand molding, casting, and forming occupations (7754, 7755)"
789  "Hand painting, coating, and decorating occupations (7756)"
793  "Hand engraving and printing occupations (7757)"
795  "Miscellaneous hand working occupations (7758, 7759)"
796  "Production inspectors, checkers, and examiners (782, 787)"
797  "Production testers (783)"
798  "Production samplers and weighers (784)"
799  "Graders and sorters, except agricultural (785)"
803  "Supervisors, motor vehicle operators (8111)"
804  "Truck drivers (8212-8214)"
806  "Driver-sales workers (8218)"
808  "Bus drivers (8215)"
809  "Taxicab drivers and chauffeurs (8216)"
813  "Parking lot attendants (874)"
814  "Motor transportation occupations, n.e.c. (8219)"
823  "Railroad conductors and yardmasters (8113)"
824  "Locomotive operating occupations (8232)"
825  "Railroad brake, signal, and switch operators (8233)"
826  "Rail vehicle operators, n.e.c. (8239)"
828  "Ship captains and mates, except fishing boats (part 8241, 8242)"
829  "Sailors and deckhands (8243)"
833  "Marine engineers (8244)"
834  "Bridge, lock, and lighthouse tenders (8245)"
843  "Supervisors, material moving equipment operators (812)"
844  "Operating engineers (8312)"
845  "Longshore equipment operators (8313)"
848  "Hoist and winch operators (8314)"
849  "Crane and tower operators (8315)"
853  "Excavating and loading machine operators (8316)"
855  "Grader, dozer, and scraper operators (8317)"
856  "Industrial truck and tractor equipment operators (8318)"
859  "Misc material moving equipment operators (8319)"
864  "Supervisors, handlers, equipment cleaners, and laborers, n.e.c. (85)"
865  "Helpers, mechanics, and repairers (863)"
866  "Helpers, construction trades (8641-8645, 8648)"
867  "Helpers, surveyor (8646)"
868  "Helpers, extractive occupations (865)"
869  "Construction laborers (871)"
874  "Production helpers (861, 862)"
875  "Garbage collectors (8722)"
876  "Stevedores (8723)"
877  "Stock handlers and baggers (8724)"
878  "Machine feeders and offbearers (8725)"
883  "Freight, stock, and material handlers, n.e.c. (8726)"
885  "Garage and service station related occupations (873)"
887  "Vehicle washers and equipment cleaners (875)"
888  "Hand packers and packagers (8761)"
889  "Laborers, except construction (8769)"
905  "Persons whose current labor force status is unemployed and last job was Armed Forces"
;
label define FM84X
0  "None or not in universe"
;
label define FM85X
0  "None or not in universe"
;
label define FM86X
0  "None or not in universe"
;
label define FM87X
0  "None or not in universe"
;
label define FM88X
0  "None or not in universe"
;
label define FM89X
0  "None or not in universe"
;
label define FM90X
0  "Not in universe or none"
;
label define FM91X
0  "Not in universe or none"
;
label define FM92X
-1  "Not in Universe"
;
label define FM93X
-1  "Not in Universe"
;
label define FM94X
0  "None or not in universe"
;
label define FM97X
0  "Less than 1 full year old"
;
/************************************************/
/*    You will need to change the "using"   */
/* statement at the end of the "infix" command  */
/* statement to include the full directory path */
/* of the directory where you saved the ASCII   */
/* data file.  For example:                     */
/* infix...                                     */
/*  using "C:\My Documents\bearhardlo5u2ic1.asc";*/
/********************************************************/

infix
EABRE 1 - 9
EAWOP 10 - 18
ECNTRC1 19 - 27
EEDUCATE 28 - 36
EENO1 37 - 45
EENO2 46 - 54
EFNP 55 - 63
EHHNUMPP 64 - 72
EJBHRS1 73 - 81
EJBHRS2 82 - 90
EJBIND1 91 - 99
EJBIND2 100 - 108
EJOBCNTR 109 - 117
ELAYOFF 118 - 126
ELKWRK 127 - 135
ELMPTYP2 136 - 144
ELMPTYP3 145 - 153
EMOONLIT 154 - 162
EMRTJNT 163 - 171
EMRTOWN 172 - 180
EMS 181 - 189
EORIGIN 190 - 198
EPDJBTHN 199 - 207
EPNSPOUS 208 - 216
EPPINTVW 217 - 225
EPPPNUM 226 - 234
EPTRESN 235 - 243
EPTWRK 244 - 252
ER05 253 - 261
ER07 262 - 270
ER10 271 - 279
ER15 280 - 288
ERACE 289 - 297
ERSEND1 298 - 306
ERSEND2 307 - 315
ERSNOWRK 316 - 324
ESEX 325 - 333
ESFNP 334 - 342
ESTLEMP1 343 - 351
ESTLEMP2 352 - 360
ESVOAST 361 - 369
EUECTYP5 370 - 378
EUECTYP7 379 - 387
RFID 388 - 396
RFNKIDS 397 - 405
RHCALMN 406 - 414
RHCALYR 415 - 423
RHTYPE 424 - 432
RMESR 433 - 441
RMHRSWK 442 - 450
RMWKLKG 451 - 459
RMWKSAB 460 - 468
RMWKWJB 469 - 477
RNOTAKE 478 - 486
RPYPER1 487 - 495
RPYPER2 496 - 504
RSID 505 - 513
RTAKJOB 514 - 522
RWCMPRSN 523 - 531
RWKESR1 532 - 540
RWKESR2 541 - 549
RWKESR3 550 - 558
RWKESR4 559 - 567
RWKESR5 568 - 576
RWKSPERM 577 - 585
SPANEL 586 - 594
SREFMON 595 - 603
SROTATON 604 - 612
SSUSEQ 613 - 621
SWAVE 622 - 630
T05AMT 631 - 639
T07AMT 640 - 648
T10AMT 649 - 657
T15AMT 658 - 666
T75AMT 667 - 675
TEJDATE1 676 - 685
TEJDATE2 686 - 695
TFEARN 696 - 704
TFIPSST 705 - 713
TFTOTINC 714 - 722
THEARN 723 - 731
THTOTINC 732 - 740
TJBOCC1 741 - 749
TJBOCC2 750 - 758
TMIOWN 759 - 767
TMTHRNT 768 - 776
TPEARN 777 - 785
TPMSUM1 786 - 794
TPMSUM2 795 - 803
TPTOTINC 804 - 812
TPYRATE1 813 - 821
TPYRATE2 822 - 830
TSJDATE1 831 - 840
TSJDATE2 841 - 850
TSTOTINC 851 - 859
WHFNWGT 860 - 870
WPFINWGT 871 - 881
TAGE 882 - 890
EENTAID 891 - 899
str13 SSUID 900 - 912

using `"`file'"';

label variable EABRE "LF: Main reason for being absent without pay";
label variable EAWOP "LF: Had full-week unpaid absences from work";
label variable ECNTRC1 "JB: Coverage by union or employee association contract";
label variable EEDUCATE "ED: Highest Degree received or grade completed";
label variable EENO1 "JB: Across-wave employer index/number";
label variable EENO2 "JB: Across-wave employer index/number";
label variable EFNP "FA: Number of persons in this family or pseudo family";
label variable EHHNUMPP "HH: Total number of persons in this household in this month";
label variable EJBHRS1 "JB: Usual hours worked per week at this job";
label variable EJBHRS2 "JB: Usual hours worked per week at this job";
label variable EJBIND1 "JB: Industry code";
label variable EJBIND2 "JB: Industry code";
label variable EJOBCNTR "LF: Number of jobs held during the reference period";
label variable ELAYOFF "LF: Spent time on layoff from a job";
label variable ELKWRK "LF: Spent time looking for work";
label variable ELMPTYP2 "GI: Receipt of severance pay (ISS Code 15)";
label variable ELMPTYP3 "GI: Receipt of other type of lump sum payment";
label variable EMOONLIT "LF: Income from additional work";
label variable EMRTJNT "AS: Mortgage owned jointly with spouse";
label variable EMRTOWN "AS: Mortgages held in own name";
label variable EMS "PE: Marital status";
label variable EORIGIN "PE: Origin of this person";
label variable EPDJBTHN "LF: Paid job during the reference period";
label variable EPNSPOUS "PE: Person number of spouse";
label variable EPPINTVW "PE: Person''s interview status";
label variable EPPPNUM "PE: Person number";
label variable EPTRESN "LF: Main reason for working less than 35 hours";
label variable EPTWRK "LF: Worked less than 35 hours some weeks";
label variable ER05 "GI: Receipt of State Unemployment Comp. (ISS Code 5)";
label variable ER07 "GI: Receipt of Other Unemployment Comp. (ISS Code 7)";
label variable ER10 "GI: Receipt of Workers Compensation (ISS Code 10)";
label variable ER15 "GI: Receipt of Severance Pay (ISS Code 15)";
label variable ERACE "PE: Race of this person";
label variable ERSEND1 "JB: Main reason stopped working for employer";
label variable ERSEND2 "JB: Main reason stopped working for employer";
label variable ERSNOWRK "LF: Main reason for not working during the ref. period";
label variable ESEX "PE: Sex of this person";
label variable ESFNP "SF: Number of persons in this related subfamily";
label variable ESTLEMP1 "JB: Still working for this employer";
label variable ESTLEMP2 "JB: Still working for this employer";
label variable ESVOAST "AS: Ownership of solely held savings account";
label variable EUECTYP5 "GI: Receipt of State unemployment comp. (ISS Code 5)";
label variable EUECTYP7 "GI: Receipt of other unemployment comp. (ISS Code 7)";
label variable RFID "FA: Family ID Number for this month";
label variable RFNKIDS "FA: Total number of children under 18 in family";
label variable RHCALMN "SU: Calendar month for this reference month.";
label variable RHCALYR "SU: Calendar year for this reference month";
label variable RHTYPE "HH: Household type";
label variable RMESR "LF: Employment status recode for month";
label variable RMHRSWK "LF: Usual hours worked per week recode in month";
label variable RMWKLKG "LF: Number of weeks looking for work/on layoff in month";
label variable RMWKSAB "LF: Number of weeks absent without pay from job in month";
label variable RMWKWJB "LF: Number of weeks with a job in month";
label variable RNOTAKE "LF: Reason couldn''t start job";
label variable RPYPER1 "JB: Frequency of payment at job";
label variable RPYPER2 "JB: Frequency of payment at job";
label variable RSID "FA: Related or unrelated subfamily ID Number for this month";
label variable RTAKJOB "LF: Could ... have started a job during missing weeks?";
label variable RWCMPRSN "GI: Reason for receipt of workers'' compensation";
label variable RWKESR1 "LF: Employment Status Recode for Week 1";
label variable RWKESR2 "LF: Employment Status Recode for Week 2";
label variable RWKESR3 "LF: Employment Status Recode for Week 3";
label variable RWKESR4 "LF: Employment Status Recode for Week 4";
label variable RWKESR5 "LF: Employment Status Recode for Week 5";
label variable RWKSPERM "LF: Number of weeks in this month";
label variable SPANEL "SU: Sample Code - Indicates Panel Year";
label variable SREFMON "SU: Reference month of this record";
label variable SROTATON "SU: Rotation of data collection";
label variable SSUSEQ "SU: Sequence Number of Sample Unit - Primary Sort Key";
label variable SWAVE "SU: Wave of data collection";
label variable T05AMT "GI: Amount of State unemployment compensation";
label variable T07AMT "GI: Amount of other unemployment compensation";
label variable T10AMT "GI: Amount of workers'' compensation (ISS Code 10)";
label variable T15AMT "GI: Amount of severance pay (ISS Code 15)";
label variable T75AMT "GI: Amount of other government income (ISS Code 75)";
label variable TEJDATE1 "JB: Ending date of job";
label variable TEJDATE2 "JB: Ending date of job";
label variable TFEARN "FA: Total family earned income for this month";
label variable TFIPSST "HH: FIPS State Code";
label variable TFTOTINC "FA: Total family income for this month";
label variable THEARN "HH: Total household earned income";
label variable THTOTINC "HH: Total household income";
label variable TJBOCC1 "JB: Occupation classification code";
label variable TJBOCC2 "JB: Occupational classification code";
label variable TMIOWN "AS: Amount of interest paid on own mortgage";
label variable TMTHRNT "HH: Amount of monthly rent";
label variable TPEARN "PE: Total person''s earned income for the reference month";
label variable TPMSUM1 "JB: Earnings from job received in this month";
label variable TPMSUM2 "JB: Earnings from job received in this month.";
label variable TPTOTINC "PE: Total person''s income for the reference month";
label variable TPYRATE1 "JB: Regular hourly pay rate";
label variable TPYRATE2 "JB: Regular hourly pay rate";
label variable TSJDATE1 "JB: Starting date of job";
label variable TSJDATE2 "JB: Starting date of job";
label variable TSTOTINC "SF: Total related subfamily income for this month";
label variable WHFNWGT "WW: Household weight";
label variable WPFINWGT "WW: Person weight";
label variable TAGE "PE: Age as of last birthday";
label variable EENTAID "PE: Address ID of hhld where person entered sample";
label variable SSUID "SU: Sample Unit Identifier";
label values EABRE FM0X;
label values EAWOP FM1X;
label values ECNTRC1 FM2X;
label values EEDUCATE FM3X;
label values EENO1 FM4X;
label values EENO2 FM5X;
label values EJBHRS1 FM8X;
label values EJBHRS2 FM9X;
label values EJBIND1 FM10X;
label values EJBIND2 FM11X;
label values EJOBCNTR FM12X;
label values ELAYOFF FM13X;
label values ELKWRK FM14X;
label values ELMPTYP2 FM15X;
label values ELMPTYP3 FM16X;
label values EMOONLIT FM17X;
label values EMRTJNT FM18X;
label values EMRTOWN FM19X;
label values EMS FM20X;
label values EORIGIN FM21X;
label values EPDJBTHN FM22X;
label values EPNSPOUS FM23X;
label values EPPINTVW FM24X;
label values EPTRESN FM26X;
label values EPTWRK FM27X;
label values ER05 FM28X;
label values ER07 FM29X;
label values ER10 FM30X;
label values ER15 FM31X;
label values ERACE FM32X;
label values ERSEND1 FM33X;
label values ERSEND2 FM34X;
label values ERSNOWRK FM35X;
label values ESEX FM36X;
label values ESFNP FM37X;
label values ESTLEMP1 FM38X;
label values ESTLEMP2 FM39X;
label values ESVOAST FM40X;
label values EUECTYP5 FM41X;
label values EUECTYP7 FM42X;
label values RHCALMN FM45X;
label values RHTYPE FM47X;
label values RMESR FM48X;
label values RMHRSWK FM49X;
label values RMWKLKG FM50X;
label values RMWKSAB FM51X;
label values RMWKWJB FM52X;
label values RNOTAKE FM53X;
label values RPYPER1 FM54X;
label values RPYPER2 FM55X;
label values RSID FM56X;
label values RTAKJOB FM57X;
label values RWCMPRSN FM58X;
label values RWKESR1 FM59X;
label values RWKESR2 FM60X;
label values RWKESR3 FM61X;
label values RWKESR4 FM62X;
label values RWKESR5 FM63X;
label values RWKSPERM FM64X;
label values SPANEL FM65X;
label values SREFMON FM66X;
label values T05AMT FM70X;
label values T07AMT FM71X;
label values T10AMT FM72X;
label values T15AMT FM73X;
label values T75AMT FM74X;
label values TEJDATE1 FM75X;
label values TEJDATE2 FM76X;
label values TFIPSST FM78X;
label values TJBOCC1 FM82X;
label values TJBOCC2 FM83X;
label values TMIOWN FM84X;
label values TMTHRNT FM85X;
label values TPEARN FM86X;
label values TPMSUM1 FM87X;
label values TPMSUM2 FM88X;
label values TPTOTINC FM89X;
label values TPYRATE1 FM90X;
label values TPYRATE2 FM91X;
label values TSJDATE1 FM92X;
label values TSJDATE2 FM93X;
label values TSTOTINC FM94X;
label values TAGE FM97X;

gettoken filename:file, parse(".");
save `"`filename'.dta"',replace;

};
