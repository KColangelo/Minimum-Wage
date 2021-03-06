*/************************************************/
*/*   Please scroll down to the INFIX step for    */
*/* instructions related to providing full path  */
*/* name for the input data file.                */
*/************************************************/
*/ then scoll to the end of the file and provide the */
*/ path for where to store the data when finished */

/*File for estimation of econometric models*/
/*
cd "C:\Users\Kyle\OneDrive\Minimum Wage\SIPP\2014"
*/

cd "C:\Users\gdvia\OneDrive\PhD\Research\Minimum Wage\SIPP\2004"

#delimit ;
clear ;

label define FM0X
-1  "Not in Universe"
1  "On layoff (temporary or indefinite)"
2  "Slack work or business conditions"
3  "Own injury"
4  "Own illness/medical problems"
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
38  "12th grade, no diploma"
39  "High School Graduate - (diploma or GED or equivalent)"
40  "Some college, but no degree"
41  "Diploma or certificate from a vocational, technical, trade or business school beyond high"
43  "Associate (2-yr) college degree (include academic/occupational degree)"
44  "Bachelor''s degree (for example: BA, AB, BS)"
45  "Master''s degree (For example: MA, MS, MEng, MEd, MSW, MBA)"
46  "Professional School degree (for example: MD,(doctor),DDS (dentist),JD(lawyer)"
47  "Doctorate degree (for example: Ph.D., Ed.D)"
;
label define FM4X
-1  "Not in Universe"
;
label define FM5X
-1  "Not in Universe"
;
label define FM8X
-8  "Hours vary"
-1  "Not in Universe"
;
label define FM9X
-8  "Hours vary"
-1  "Not in Universe"
;
label define FM10X
-1  "Not in Universe"
0170  "Crop production (111)"
0180  "Animal production (112)"
0190  "Forestry except logging (1131,1132)"
0270  "Logging (1133)"
0280  "Fishing, hunting, and trapping (114)"
0290  "Support activities for agriculture and forestry (115)"
0370  "Oil and gas extraction (211)"
0380  "Coal mining (2121)"
0390  "Metal ore mining (2122)"
0470  "Nonmetallic mineral mining and quarrying (2123)"
0480  "Not specified type of mining (Part 21)"
0490  "Support activities for mining (213)"
0570  "Electric power generation, transmission and distribution (2211)"
0580  "Natural gas distribution (2212)"
0590  "Electric and gas, and other combinations (Parts 2211, 2212)"
0670  "Water, steam, air-conditioning, and irrigation systems (22131,22133)"
0680  "Sewage treatment facilities (22132)"
0690  "Not specified utilities (Part 22)"
0770  "Construction (23)"
1070  "Animal food, grain and oilseed milling (3111, 3112)"
1080  "Sugar and confectionery products (3113)"
1090  "Fruit and vegetable preserving and specialty food manufacturing (3114)"
1170  "Dairy product manufacturing (3115)"
1180  "Animal slaughtering and processing (3116)"
1190  "Retail bakeries (311811)"
1270  "Bakeries, except retail  (3118 exc. 311811)"
1280  "Seafood and other miscellaneous foods, n.e.c. (3117, 3119)"
1290  "Not specified food industries (Part 311)"
1370  "Beverage manufacturing (3121)"
1390  "Tobacco manufacturing (3122)"
1470  "Fiber, yarn, and thread mills (3131)"
1480  "Fabric mills, except knitting (3132 except 31324)"
1490  "Textile and fabric finishing and coating mills (3133)"
1570  "Carpet and rug mills (31411)"
1590  "Textile product mills, except carpets and rugs (314 except 31411)"
1670  "Knitting mills (31324, 3151)"
1680  "Cut and sew apparel manufacturing (3152)"
1690  "Apparel accessories and other apparel manufacturing (3159)"
1770  "Footwear manufacturing (3162)"
1790  "Leather tanning and products, except footwear manufacturing (3161, 3169)"
1870  "Pulp, paper, and paperboard mills (3221)"
1880  "Paperboard containers and boxes (32221)"
1890  "Miscellaneous paper and pulp products  (32222, 32223, 32229)"
1990  "Printing and related support activities (3231)"
2070  "Petroleum refining (32411)"
2090  "Miscellaneous petroleum and coal products (32419)"
2170  "Resin, synthetic rubber and fibers, and filaments manufacturing (3252)"
2180  "Agricultural chemical manufacturing  (3253)"
2190  "Pharmaceutical and medicine manufacturing (3254)"
2270  "Paint, coating, and adhesive manufacturing (3255)"
2280  "Soap, cleaning compound, and cosmetics manufacturing (3256)"
2290  "Industrial and miscellaneous chemicals (3251, 3259)"
2370  "Plastics product manufacturing (3261)"
2380  "Tire manufacturing (32621)"
2390  "Rubber products, except tires, manufacturing (32622, 32629)"
2470  "Pottery, ceramics, and related products manufacturing  (32711)"
2480  "Structural clay product manufacturing (32712)"
2490  "Glass and glass product manufacturing  (3272)"
2570  "Cement, concrete, lime, and gypsum product manufacturing (3273, 3274)"
2590  "Miscellaneous nonmetallic mineral product manufacturing (3279)"
2670  "Iron and steel mills and steel product manufacturing  (3311, 3312)"
2680  "Aluminum production and processing  (3313)"
2690  "Nonferrous metal, except aluminum, production and processing (3314)"
2770  "Foundries (3315)"
2780  "Metal forgings and stampings (3321)"
2790  "Cutlery and hand tool manufacturing  (3322)"
2870  "Structural metals, and tank and shipping container manufacturing (3323, 3324)"
2880  "Machine shops; turned product; screw, nut and bolt manufacturing  (3327)"
2890  "Coating, engraving, heat treating and allied activities (3328)"
2970  "Ordnance (332992, 332993, 332994, 332995  )"
2980  "Miscellaneous fabricated metal products manufacturing (3325, 3326, 3329 except 332992, 3"
2990  "Not specified metal industries (Part 331 and 332)"
3070  "Agricultural implement manufacturing (33311)"
3080  "Construction, mining and oil field machinery manufacturing (33312, 33313)"
3090  "Commercial and service industry machinery manufacturing (3333)"
3170  "Metalworking machinery manufacturing (3335)"
3180  "Engines, turbines, and power transmission equipment manufacturing (3336)"
3190  "Machinery manufacturing, n.e.c. (3332, 3334, 3339)"
3290  "Not specified machinery manufacturing (Part 333)"
3360  "Computer and peripheral equipment manufacturing (3341)"
3370  "Communications, audio, and video equipment manufacturing (3342, 3343)"
3380  "Navigational, measuring, electromedical, and control instruments manufacturing (3345)"
3390  "Electronic component and product manufacturing, n.e.c. (3344, 3346)"
3470  "Household appliance manufacturing (3352)"
3490  "Electrical lighting, equipment, and supplies manufacturing, n.e.c. (3351, 3353, 3359)"
3570  "Motor vehicles and motor vehicle equipment manufacturing (3361, 3362, 3363)"
3580  "Aircraft and parts manufacturing (336411, 336412, 336413)"
3590  "Aerospace products and parts manufacturing (336414, 336415, 336419)"
3670  "Railroad rolling stock manufacturing (3365)"
3680  "Ship and boat building (3366)"
3690  "Other transportation equipment manufacturing (3369)"
3770  "Sawmills and wood preservation (3211)"
3780  "Veneer, plywood, and engineered wood products (3212)"
3790  "Prefabricated wood buildings and mobile homes (321991, 321992)"
3870  "Miscellaneous wood products (3219 except 321991, 321992)"
3890  "Furniture and related product manufacturing (337)"
3960  "Medical equipment and supplies manufacturing (3391)"
3970  "Toys, amusement, and sporting goods manufacturing (33992, 33993)"
3980  "Miscellaneous manufacturing, n.e.c.  (3399 except 33992, 33993)"
3990  "Not specified manufacturing industries (Part 31, 32, 33)"
4070  "Motor vehicles, parts and supplies, merchant wholesalers  (4231)"
4080  "Furniture and home furnishing, merchant wholesalers (4232 )"
4090  "Lumber and other construction materials, merchant wholesalers (4233)"
4170  "Professional and commercial equipment and supplies, merchant wholesalers (4234)"
4180  "Metals and minerals, except petroleum, merchant wholesalers (4235)"
4190  "Electrical goods, merchant wholesalers (4236)"
4260  "Hardware, plumbing and heating equipment, and supplies, merchant wholesalers (4237)"
4270  "Machinery, equipment, and supplies, merchant wholesalers  (4238)"
4280  "Recyclable material, merchant wholesalers (42393)"
4290  "Miscellaneous durable goods, merchant wholesalers (4239 except 42393)"
4370  "Paper and paper products, merchant wholesalers (4241)"
4380  "Drugs, sundries, and chemical and allied products, merchant wholesalers (4242, 4246)"
4390  "Apparel, fabrics, and notions, merchant wholesalers (4243)"
4470  "Groceries and related products, merchant wholesalers (4244)"
4480  "Farm product raw materials, merchant wholesalers (4245)"
4490  "Petroleum and petroleum products, merchant wholesalers (4247)"
4560  "Alcoholic beverages, merchant wholesalers (4248)"
4570  "Farm supplies, merchant wholesalers (42491)"
4580  "Miscellaneous nondurable goods, merchant wholesalers (4249 except 42491)"
4585  "Wholesale electronic markets, agents and brokers (4251)"
4590  "Not specified wholesale trade (Part 42)"
4670  "Automobile dealers (4411)"
4680  "Other motor vehicle dealers (4412)"
4690  "Auto parts, accessories, and tire stores  (4413)"
4770  "Furniture and home furnishings stores (442)"
4780  "Household appliance stores (443111)"
4790  "Radio, TV, and computer stores (443112, 44312)"
4870  "Building material and supplies dealers  (4441 except 44413)"
4880  "Hardware stores (44413)"
4890  "Lawn and garden equipment and supplies stores (4442)"
4970  "Grocery stores (4451)"
4980  "Specialty food stores (4452)"
4990  "Beer, wine, and liquor stores (4453)"
5070  "Pharmacies and drug stores (4461)"
5080  "Health and personal care, except drug, stores (446 except 44611)"
5090  "Gasoline stations (447)"
5170  "Clothing and accessories, except shoe, stores (448 except 44821, 4483)"
5180  "Shoe stores (44821)"
5190  "Jewelry, luggage, and leather goods stores (4483)"
5270  "Sporting goods, camera, and hobby and toy stores (44313, 45111, 45112)"
5280  "Sewing, needlework, and piece goods stores (45113)"
5290  "Music stores (45114, 45122)"
5370  "Book stores and news dealers (45121)"
5380  "Department stores and discount stores (45211)"
5390  "Miscellaneous general merchandise stores (4529)"
5470  "Retail florists (4531)"
5480  "Office supplies and stationery stores (45321)"
5490  "Used merchandise stores (4533)"
5570  "Gift, novelty, and souvenir shops (45322)"
5580  "Miscellaneous retail stores (4539)"
5590  "Electronic shopping   (454111)"
5591  "Electronic auctions   (454112)"
5592  "Mail order houses (454113)"
5670  "Vending machine operators (4542)"
5680  "Fuel dealers (45431)"
5690  "Other direct selling establishments (45439)"
5790  "Not specified retail trade (Part 44, 45)"
6070  "Air transportation (481)"
6080  "Rail transportation (482)"
6090  "Water transportation (483)"
6170  "Truck transportation (484)"
6180  "Bus service and urban transit (4851, 4852, 4854, 4855, 4859)"
6190  "Taxi and limousine service (4853)"
6270  "Pipeline transportation (486)"
6280  "Scenic and sightseeing transportation (487)"
6290  "Services incidental to transportation (488)"
6370  "Postal Service (491)"
6380  "Couriers and messengers (492)"
6390  "Warehousing and storage (493)"
6470  "Newspaper publishers (51111)"
6480  "Publishing, except newspapers and software (5111 except 51111)"
6490  "Software publishing (5112)"
6570  "Motion pictures and video industries (5121)"
6590  "Sound recording industries (5122)"
6670  "Radio and television broadcasting and cable (5151, 5152, 5175)"
6675  "Internet publishing and broadcasting (5161)"
6680  "Wired telecommunications carriers (5171)"
6690  "Other telecommunications services (517 except 5171, 5175)"
6692  "Internet service providers (5181)"
6695  "Data processing, hosting, and related services (5182)"
6770  "Libraries and archives (51912)"
6780  "Other information services (5191 except 51912)"
6870  "Banking and related activities (521, 52211,52219)"
6880  "Savings institutions, including credit unions (52212, 52213)"
6890  "Non-depository credit and related activities (5222, 5223)"
6970  "Securities, commodities, funds, trusts, and other financial investments (523, 525)"
6990  "Insurance carriers and related activities (524)"
7070  "Real estate (531)"
7080  "Automotive equipment rental and leasing (5321)"
7170  "Video tape and disk rental (53223)"
7180  "Other consumer goods rental (53221, 53222, 53229, 5323)"
7190  "Commercial, industrial, and other intangible assets rental and leasing (5324, 533)"
7270  "Legal services (5411)"
7280  "Accounting, tax preparation, bookkeeping, and payroll services (5412)"
7290  "Architectural, engineering, and related services (5413)"
7370  "Specialized design services (5414)"
7380  "Computer systems design and related services (5415)"
7390  "Management, scientific, and technical consulting services (5416)"
7460  "Scientific research and development services (5417)"
7470  "Advertising and related services (5418)"
7480  "Veterinary services (54194)"
7490  "Other professional, scientific, and technical services (5419 except 54194)"
7570  "Management of companies and enterprises (551)"
7580  "Employment services (5613)"
7590  "Business support services (5614)"
7670  "Travel arrangements and reservation services (5615)"
7680  "Investigation and security services (5616)"
7690  "Services to buildings and dwellings (except cleaning during construction and immediately"
7770  "Landscaping services (56173)"
7780  "Other administrative and other support services (5611, 5612, 5619)"
7790  "Waste management and remediation services (562)"
7860  "Elementary and secondary schools (6111)"
7870  "Colleges and universities, including junior colleges (6112, 6113)"
7880  "Business, technical, and trade schools and training (6114, 6115)"
7890  "Other schools, instruction, and educational services (6116, 6117)"
7970  "Offices of physicians (6211)"
7980  "Offices of dentists (6212)"
7990  "Offices of chiropractors (62131)"
8070  "Offices of optometrists (62132)"
8080  "Offices of other health practitioners (6213 except 62131, 62132)"
8090  "Outpatient care centers (6214)"
8170  "Home health care services (6216)"
8180  "Other health care services (6215, 6219)"
8190  "Hospitals (622)"
8270  "Nursing care facilities (6231)"
8290  "Residential care facilities, without nursing (6232, 6233, 6239)"
8370  "Individual and family services (6241)"
8380  "Community food and housing, and emergency services (6242)"
8390  "Vocational rehabilitation services (6243)"
8470  "Child day care services (6244)"
8560  "Independent artists, performing arts, spectator sports, and related industries (711)"
8570  "Museums, art galleries, historical sites, and similar institutions (712)"
8580  "Bowling centers (71395)"
8590  "Other amusement, gambling, and recreation industries (713 except 71395)"
8660  "Traveler accommodation (7211)"
8670  "Recreational vehicle parks and camps, and rooming and boarding houses (7212, 7213)"
8680  "Restaurants and other food services (722 except 7224)"
8690  "Drinking places, alcoholic beverages (7224)"
8770  "Automotive repair and maintenance (8111 except 811192)"
8780  "Car washes (811192)"
8790  "Electronic and precision equipment repair and maintenance (8112)"
8870  "Commercial and industrial machinery and equipment repair and maintenance (8113)"
8880  "Personal and household goods repair and maintenance (8114 except 81143)"
8890  "Footwear and leather goods repair (81143)"
8970  "Barber shops (812111)"
8980  "Beauty salons (812112)"
8990  "Nail salons and other personal care services  (812113, 81219)"
9070  "Drycleaning and laundry services (8123)"
9080  "Funeral homes, cemeteries, and crematories (8122)"
9090  "Other personal services (8129)"
9160  "Religious organizations (8131)"
9170  "Civic, social, advocacy organizations, and grantmaking and giving services (8132, 8133,"
9180  "Labor unions (81393)"
9190  "Business, professional, political, and similar organizations (8139 except 81393)"
9290  "Private households (814)"
9370  "Executive offices and legislative bodies (92111, 92112, 92114, part 92115)"
9380  "Public finance activities (92113)"
9390  "Other general government and support (92119)"
9470  "Justice, public order, and safety activities (922, part 92115)"
9480  "Administration of human resource programs  (923)"
9490  "Administration of environmental quality and housing programs (924, 925)"
9570  "Administration of economic programs and space research (926, 927)"
9590  "National security and international affairs (928)"
9890  "Persons whose last job was Armed Forces"
;
label define FM11X
-1  "Not in Universe"
0170  "Crop production (111)"
0180  "Animal production (112)"
0190  "Forestry except logging (1131,1132)"
0270  "Logging (1133)"
0280  "Fishing, hunting, and trapping (114)"
0290  "Support activities for agriculture and forestry (115)"
0370  "Oil and gas extraction (211)"
0380  "Coal mining (2121)"
0390  "Metal ore mining (2122)"
0470  "Nonmetallic mineral mining and quarrying (2123)"
0480  "Not specified type of mining (Part 21)"
0490  "Support activities for mining (213)"
0570  "Electric power generation, transmission and distribution (2211)"
0580  "Natural gas distribution (2212)"
0590  "Electric and gas, and other combinations (Parts 2211, 2212)"
0670  "Water, steam, air-conditioning, and irrigation systems (22131,22133)"
0680  "Sewage treatment facilities (22132)"
0690  "Not specified utilities (Part 22)"
0770  "Construction (23)"
1070  "Animal food, grain and oilseed milling (3111, 3112)"
1080  "Sugar and confectionery products (3113)"
1090  "Fruit and vegetable preserving and specialty food manufacturing (3114)"
1170  "Dairy product manufacturing (3115)"
1180  "Animal slaughtering and processing (3116)"
1190  "Retail bakeries (311811)"
1270  "Bakeries, except retail  (3118 exc. 311811)"
1280  "Seafood and other miscellaneous foods, n.e.c. (3117, 3119)"
1290  "Not specified food industries (Part 311)"
1370  "Beverage manufacturing (3121)"
1390  "Tobacco manufacturing (3122)"
1470  "Fiber, yarn, and thread mills (3131)"
1480  "Fabric mills, except knitting (3132 except 31324)"
1490  "Textile and fabric finishing and coating mills (3133)"
1570  "Carpet and rug mills (31411)"
1590  "Textile product mills, except carpets and rugs (314 except 31411)"
1670  "Knitting mills (31324, 3151)"
1680  "Cut and sew apparel manufacturing (3152)"
1690  "Apparel accessories and other apparel manufacturing (3159)"
1770  "Footwear manufacturing (3162)"
1790  "Leather tanning and products, except footwear manufacturing (3161, 3169)"
1870  "Pulp, paper, and paperboard mills (3221)"
1880  "Paperboard containers and boxes (32221)"
1890  "Miscellaneous paper and pulp products  (32222, 32223, 32229)"
1990  "Printing and related support activities (3231)"
2070  "Petroleum refining (32411)"
2090  "Miscellaneous petroleum and coal products (32419)"
2170  "Resin, synthetic rubber and fibers, and filaments manufacturing (3252)"
2180  "Agricultural chemical manufacturing  (3253)"
2190  "Pharmaceutical and medicine manufacturing (3254)"
2270  "Paint, coating, and adhesive manufacturing (3255)"
2280  "Soap, cleaning compound, and cosmetics manufacturing (3256)"
2290  "Industrial and miscellaneous chemicals (3251, 3259)"
2370  "Plastics product manufacturing (3261)"
2380  "Tire manufacturing (32621)"
2390  "Rubber products, except tires, manufacturing (32622, 32629)"
2470  "Pottery, ceramics, and related products manufacturing  (32711)"
2480  "Structural clay product manufacturing (32712)"
2490  "Glass and glass product manufacturing  (3272)"
2570  "Cement, concrete, lime, and gypsum product manufacturing (3273, 3274)"
2590  "Miscellaneous nonmetallic mineral product manufacturing (3279)"
2670  "Iron and steel mills and steel product manufacturing  (3311, 3312)"
2680  "Aluminum production and processing  (3313)"
2690  "Nonferrous metal, except aluminum, production and processing (3314)"
2770  "Foundries (3315)"
2780  "Metal forgings and stampings (3321)"
2790  "Cutlery and hand tool manufacturing  (3322)"
2870  "Structural metals, and tank and shipping container manufacturing (3323, 3324)"
2880  "Machine shops; turned product; screw, nut and bolt manufacturing  (3327)"
2890  "Coating, engraving, heat treating and allied activities (3328)"
2970  "Ordnance (332992, 332993, 332994, 332995  )"
2980  "Miscellaneous fabricated metal products manufacturing (3325, 3326, 3329 except 332992, 3"
2990  "Not specified metal industries (Part 331 and 332)"
3070  "Agricultural implement manufacturing (33311)"
3080  "Construction, mining and oil field machinery manufacturing (33312, 33313)"
3090  "Commercial and service industry machinery manufacturing (3333)"
3170  "Metalworking machinery manufacturing (3335)"
3180  "Engines, turbines, and power transmission equipment manufacturing (3336)"
3190  "Machinery manufacturing, n.e.c. (3332, 3334, 3339)"
3290  "Not specified machinery manufacturing (Part 333)"
3360  "Computer and peripheral equipment manufacturing (3341)"
3370  "Communications, audio, and video equipment manufacturing (3342, 3343)"
3380  "Navigational, measuring, electromedical, and control instruments manufacturing (3345)"
3390  "Electronic component and product manufacturing, n.e.c. (3344, 3346)"
3470  "Household appliance manufacturing (3352)"
3490  "Electrical lighting, equipment, and supplies manufacturing, n.e.c. (3351, 3353, 3359)"
3570  "Motor vehicles and motor vehicle equipment manufacturing (3361, 3362, 3363)"
3580  "Aircraft and parts manufacturing (336411, 336412, 336413)"
3590  "Aerospace products and parts manufacturing (336414, 336415, 336419)"
3670  "Railroad rolling stock manufacturing (3365)"
3680  "Ship and boat building (3366)"
3690  "Other transportation equipment manufacturing (3369)"
3770  "Sawmills and wood preservation (3211)"
3780  "Veneer, plywood, and engineered wood products (3212)"
3790  "Prefabricated wood buildings and mobile homes (321991, 321992)"
3870  "Miscellaneous wood products (3219 except 321991, 321992)"
3890  "Furniture and related product manufacturing (337)"
3960  "Medical equipment and supplies manufacturing (3391)"
3970  "Toys, amusement, and sporting goods manufacturing (33992, 33993)"
3980  "Miscellaneous manufacturing, n.e.c.  (3399 except 33992, 33993)"
3990  "Not specified manufacturing industries (Part 31, 32, 33)"
4070  "Motor vehicles, parts and supplies, merchant wholesalers (4231)"
4080  "Furniture and home furnishing, merchant wholesalers (4232 )"
4090  "Lumber and other construction materials, merchant wholesalers (4233)"
4170  "Professional and commercial equipment and supplies, merchant wholesalers (4234)"
4180  "Metals and minerals, except petroleum, merchant wholesalers (4235)"
4190  "Electrical goods, merchant wholesalers (4236)"
4260  "Hardware, plumbing and heating equipment, and supplies, merchant wholesalers (4237)"
4270  "Machinery, equipment, and supplies, merchant wholesalers (4238)"
4280  "Recyclable material, merchant wholesalers (42393)"
4290  "Miscellaneous durable goods, merchant wholesalers (4239 except 42393)"
4370  "Paper and paper products, merchant wholesalers (4241)"
4380  "Drugs, sundries, and chemical and allied products, merchant wholesalers (4242, 4246)"
4390  "Apparel, fabrics, and notions, merchant wholesalers (4243)"
4470  "Groceries and related products, merchant wholesalers (4244)"
4480  "Farm product raw materials, merchant wholesalers (4245)"
4490  "Petroleum and petroleum products, merchant wholesalers (4247)"
4560  "Alcoholic beverages, merchant wholesalers (4248)"
4570  "Farm supplies, merchant wholesalers (42491)"
4580  "Miscellaneous nondurable goods, merchant wholesalers (4249 except 42491)"
4585  "Wholesale electronic markets, agents and brokers (4251)"
4590  "Not specified wholesale trade (Part 42)"
4670  "Automobile dealers (4411)"
4680  "Other motor vehicle dealers (4412)"
4690  "Auto parts, accessories, and tire stores  (4413)"
4770  "Furniture and home furnishings stores (442)"
4780  "Household appliance stores (443111)"
4790  "Radio, TV, and computer stores (443112, 44312)"
4870  "Building material and supplies dealers  (4441 except 44413)"
4880  "Hardware stores (44413)"
4890  "Lawn and garden equipment and supplies stores (4442)"
4970  "Grocery stores (4451)"
4980  "Specialty food stores (4452)"
4990  "Beer, wine, and liquor stores (4453)"
5070  "Pharmacies and drug stores (4461)"
5080  "Health and personal care, except drug, stores (446 except 44611)"
5090  "Gasoline stations (447)"
5170  "Clothing and accessories, except shoe, stores (448 except 44821, 4483)"
5180  "Shoe stores (44821)"
5190  "Jewelry, luggage, and leather goods stores (4483)"
5270  "Sporting goods, camera, and hobby and toy stores (44313, 45111, 45112)"
5280  "Sewing, needlework, and piece goods stores (45113)"
5290  "Music stores (45114, 45122)"
5370  "Book stores and news dealers (45121)"
5380  "Department stores and discount stores (45211)"
5390  "Miscellaneous general merchandise stores (4529)"
5470  "Retail florists (4531)"
5480  "Office supplies and stationery stores (45321)"
5490  "Used merchandise stores (4533)"
5570  "Gift, novelty, and souvenir shops (45322)"
5580  "Miscellaneous retail stores (4539)"
5590  "Electronic shopping (454111)"
5591  "Electronic auctions (454112)"
5592  "Mail order houses (454113)"
5670  "Vending machine operators (4542)"
5680  "Fuel dealers (45431)"
5690  "Other direct selling establishments (45439)"
5790  "Not specified retail trade (Part 44, 45)"
6070  "Air transportation (481)"
6080  "Rail transportation (482)"
6090  "Water transportation (483)"
6170  "Truck transportation (484)"
6180  "Bus service and urban transit (4851, 4852, 4854, 4855, 4859)"
6190  "Taxi and limousine service (4853)"
6270  "Pipeline transportation (486)"
6280  "Scenic and sightseeing transportation (487)"
6290  "Services incidental to transportation (488)"
6370  "Postal Service (491)"
6380  "Couriers and messengers (492)"
6390  "Warehousing and storage (493)"
6470  "Newspaper publishers (51111)"
6480  "Publishing, except newspapers and software (5111 except 51111)"
6490  "Software publishing (5112)"
6570  "Motion pictures and video industries (5121)"
6590  "Sound recording industries (5122)"
6670  "Radio and television broadcasting and cable (5151, 5152, 5175)"
6675  "Internet publishing and broadcasting (5161)"
6680  "Wired telecommunications carriers (5171)"
6690  "Other telecommunications services (517 except 5171, 5175)"
6692  "Internet service providers (5181)"
6695  "Data processing, hosting, and related services (5182)"
6770  "Libraries and archives (51912)"
6780  "Other information services (5191 except 51912)"
6870  "Banking and related activities (521, 52211,52219)"
6880  "Savings institutions, including credit unions (52212, 52213)"
6890  "Non-depository credit and related activities (5222, 5223)"
6970  "Securities, commodities, funds, trusts, and other financial investments (523, 525)"
6990  "Insurance carriers and related activities (524)"
7070  "Real estate (531)"
7080  "Automotive equipment rental and leasing (5321)"
7170  "Video tape and disk rental (53223)"
7180  "Other consumer goods rental (53221, 53222, 53229, 5323)"
7190  "Commercial, industrial, and other intangible assets rental and leasing (5324, 533)"
7270  "Legal services (5411)"
7280  "Accounting, tax preparation, bookkeeping, and payroll services (5412)"
7290  "Architectural, engineering, and related services (5413)"
7370  "Specialized design services (5414)"
7380  "Computer systems design and related services (5415)"
7390  "Management, scientific, and technical consulting services (5416)"
7460  "Scientific research and development services (5417)"
7470  "Advertising and related services (5418)"
7480  "Veterinary services (54194)"
7490  "Other professional, scientific, and technical services (5419 except 54194)"
7570  "Management of companies and enterprises (551)"
7580  "Employment services (5613)"
7590  "Business support services (5614)"
7670  "Travel arrangements and reservation services (5615)"
7680  "Investigation and security services (5616)"
7690  "Services to buildings and dwellings (except cleaning during construction and immediately"
7770  "Landscaping services (56173)"
7780  "Other administrative and other support services (5611, 5612, 5619)"
7790  "Waste management and remediation services (562)"
7860  "Elementary and secondary schools (6111)"
7870  "Colleges and universities, including junior colleges (6112, 6113)"
7880  "Business, technical, and trade schools and training (6114, 6115)"
7890  "Other schools, instruction, and educational services (6116, 6117)"
7970  "Offices of physicians (6211)"
7980  "Offices of dentists (6212)"
7990  "Offices of chiropractors (62131)"
8070  "Offices of optometrists (62132)"
8080  "Offices of other health practitioners (6213 except 62131, 62132)"
8090  "Outpatient care centers (6214)"
8170  "Home health care services (6216)"
8180  "Other health care services (6215, 6219)"
8190  "Hospitals (622)"
8270  "Nursing care facilities (6231)"
8290  "Residential care facilities, without nursing (6232, 6233, 6239)"
8370  "Individual and family services (6241)"
8380  "Community food and housing, and emergency services (6242)"
8390  "Vocational rehabilitation services (6243)"
8470  "Child day care services (6244)"
8560  "Independent artists, performing arts, spectator sports, and related industries (711)"
8570  "Museums, art galleries, historical sites, and similar institutions (712)"
8580  "Bowling centers (71395)"
8590  "Other amusement, gambling, and recreation industries (713 except 71395)"
8660  "Traveler accommodation (7211)"
8670  "Recreational vehicle parks and camps, and rooming and boarding houses (7212,7213)"
8680  "Restaurants and other food services (722 except 7224)"
8690  "Drinking places, alcoholic beverages (7224)"
8770  "Automotive repair and maintenance (8111 except 811192)"
8780  "Car washes (811192)"
8790  "Electronic and precision equipment repair and maintenance (8112)"
8870  "Commercial and industrial machinery and equipment repair and maintenance (8113)"
8880  "Personal and household goods repair and maintenance (8114 except 81143)"
8890  "Footwear and leather goods repair (81143)"
8970  "Barber shops (812111)"
8980  "Beauty salons (812112)"
8990  "Nail salons and other personal care services  (812113, 81219)"
9070  "Drycleaning and laundry services (8123)"
9080  "Funeral homes, cemeteries, and crematories (8122)"
9090  "Other personal services (8129)"
9160  "Religious organizations (8131)"
9170  "Civic, social, advocacy organizations, and grantmaking and giving services (8132,8133, 8"
9180  "Labor unions (81393)"
9190  "Business, professional, political, and similar organizations (8139 except 81393)"
9290  "Private households (814)"
9370  "Executive offices and legislative bodies (92111, 92112, 92114, part 92115)"
9380  "Public finance activities (92113)"
9390  "Other general government and support (92119)"
9470  "Justice, public order, and safety activities (922, part 92115)"
9480  "Administration of human resource programs  (923)"
9490  "Administration of environmental quality and housing programs (924, 925)"
9570  "Administration of economic programs and space research (926, 927)"
9590  "National security and international affairs (928)"
9890  "Persons whose last job was Armed Forces"
;
label define FM12X
-1  "Not in Universe"
0  "Contingent worker"
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
;
label define FM18X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM19X
-1  "Not universe"
1  "Yes"
2  "No"
;
label define FM20X
-1  "Not universe"
1  "Yes"
2  "No"
;
label define FM21X
1  "Married, spouse present"
2  "Married, spouse absent"
3  "Widowed"
4  "Divorced"
5  "Separated"
6  "Never Married"
;
label define FM22X
1  "Yes"
2  "No"
;
label define FM23X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM24X
9999  "Spouse not in household or person not married"
;
label define FM25X
1  "Interview (self)"
2  "Interview (proxy)"
3  "Noninterview - Type Z"
4  "Noninterview - pseudo Type Z.  Left sample during the reference period"
5  "Children under 15 during reference period"
;
label define FM27X
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
1  "White alone"
2  "Black alone"
3  "Asian alone"
4  "Residual"
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
2  "Temporarily unable to work because of an illness"
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
1  "Owned or being bought by ... or someone in ...''s household"
2  "Rented"
3  "Occupied without payment of cash rent"
;
label define FM41X
-1  "Not in Universe"
1  "Yes"
2  "No"
;
label define FM44X
-1  "Not in Universe"
1  "Yes (GED)"
2  "No (Graduated from high school)"
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
5  "Nonfamily hh - Female householder nonfamily household"
6  "Group Quarters"
;
label define FM48X
-1  "Not in Universe"
1  "With a job entire month, worked all weeks."
2  "With a job all month, absent from work without pay 1+ weeks, absence not due to layoff"
3  "With a job all month, absent from work without pay 1+ weeks, absence due to layoff"
4  "With a job at least 1 but not all weeks, no time on layoff and no time looking for work"
5  "With a job at least 1 but not all weeks, some weeks on layoff or looking for work"
6  "No job all month, on layoff or looking for work all weeks."
7  "No job all month, at least one but not all weeks on layoff or looking for work"
8  "No job all month, no time on layoff and no time looking for work."
;
label define FM49X
-1  "Not in Universe"
0  "Did not work (did not have a job, or was absent without pay from a job all weeks in month)"
1  "All weeks 35+"
2  "All weeks 1-34 hours"
3  "Some weeks 35+ and some weeks less than 35, all weeks equal to or greater than 1"
4  "Some weeks 35+, some 1-34 hours, some 0 hours"
5  "At least 1 but not all weeks 35+ hours, all other weeks 0 hours"
6  "At least 1 week but not all weeks 1 to 34 hours, all other weeks 0 hours"
;
label define FM50X
-1  "Not in Universe"
0  "0 weeks (that is, did not look for work, and was not on layoff)"
1  "1 week"
2  "2 weeks"
3  "3 weeks"
4  "4 weeks"
5  "5 weeks (if applicable)"
;
label define FM51X
-1  "Not in Universe"
0  "0 weeks (that is, did not have a job, or not absent without pay from a job)"
1  "1 week"
2  "2 weeks"
3  "3 weeks"
4  "4 weeks"
5  "5 weeks (if applicable)"
;
label define FM52X
-1  "Not in Universe"
0  "0 weeks (that is, did not look for work, and was not on layoff)"
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
2004  "Panel Year"
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
0  "Less than 1 full year old"
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
label define FM82X
-1  "Not in Universe"
0010  "Chief executives (11-1011)"
0020  "General and operations managers (11-1021)"
0040  "Advertising and promotions managers (11-2011)"
0050  "Marketing and sales managers (11-2020)"
0060  "Public relations managers (11-2031)"
0100  "Administrative services managers (11-3011)"
0110  "Computer and information systems managers (11-3021)"
0120  "Financial managers (11-3031)"
0130  "Human resources managers (11-3040)"
0140  "Industrial production managers(11-3051)"
0150  "Purchasing managers (11-3061)"
0160  "Transportation, storage, and distribution managers (11-3071)"
0200  "Farm, ranch, and other agricultural managers (11-9011)"
0210  "Farmers and ranchers (11-9012)"
0220  "Construction managers (11-9021)"
0230  "Education administrators (11-9030)"
0300  "Engineering managers (11-9041)"
0310  "Food service managers (11-9051)"
0320  "Funeral directors (11-9061)"
0330  "Gaming managers (11-9071)"
0340  "Lodging managers (11-9081)"
0350  "Medical and health services managers (11-9111)"
0360  "Natural sciences managers (11-9121)"
0410  "Property, real estate, and community association managers (11-9141)"
0420  "Social and community service managers (11-9151)"
0430  "Managers, all other (11-9199)"
0500  "Agents and business managers of artists, performers, and athletes (13-1011)"
0510  "Purchasing agents and buyers, farm products (13-1021)"
0520  "Wholesale and retail buyers, except farm products (13-1022)"
0530  "Purchasing agents, except wholesale, retail, and farm products (13-1023)"
0540  "Claims adjusters, appraisers, examiners, and investigators (13-1030)"
0560  "Compliance officers, except agriculture, construction, health and safety, and transporta"
0600  "Cost estimators (13-1051)"
0620  "Human resources, training, and labor relations specialists (13-1070)"
0700  "Logisticians (13-1081)"
0710  "Management analysts (13-1111)"
0720  "Meeting and convention planners (13-1121)"
0730  "Other business operations specialists (13-11XX)"
0800  "Accountants and auditors (13-2011)"
0810  "Appraisers and assessors of real estate (13-2021)"
0820  "Budget analysts (13-2031)"
0830  "Credit analysts (13-2041)"
0840  "Financial analysts (13-2051)"
0850  "Personal financial advisors (13-2052)"
0860  "Insurance underwriters (13-2053)"
0900  "Financial examiners (13-2061)"
0910  "Loan counselors and officers (13-2070)"
0930  "Tax examiners, collectors, and revenue agents (13-2081)"
0940  "Tax preparers (13-2082)"
0950  "Financial specialists, all other (13-2099)"
1000  "Computer scientists and systems analysts (15-10XX)"
1010  "Computer programmers (15-1021)"
1020  "Computer software engineers (15-1030)"
1040  "Computer support specialists (15-1041)"
1060  "Database administrators (15-1061)"
1100  "Network and computer systems administrators (15-1071)"
1110  "Network systems and data communications analysts (15-1081)"
1200  "Actuaries (15-2011)"
1210  "Mathematicians (15-2021)"
1220  "Operations research analysts (15-2031)"
1230  "Statisticians (15-2041)"
1240  "Miscellaneous mathematical science occupations (15-2090)"
1300  "Architects, except naval (17-1010)"
1310  "Surveyors, cartographers, and photogrammetrists (17-1020)"
1320  "Aerospace engineers (17-2011)"
1330  "Agricultural engineers (17-2021)"
1340  "Biomedical engineers (17-2031)"
1350  "Chemical engineers (17-2041)"
1360  "Civil engineers (17-2051)"
1400  "Computer hardware engineers (17-2061)"
1410  "Electrical and electronic engineers (17-2070)"
1420  "Environmental engineers (17-2081)"
1430  "Industrial engineers, including health and safety (17-2110)"
1440  "Marine engineers and naval architects (17-2121)"
1450  "Materials engineers (17-2131)"
1460  "Mechanical engineers (17-2141)"
1500  "Mining and geological engineers, including mining safety engineers (17-2151)"
1510  "Nuclear engineers (17-2161)"
1520  "Petroleum engineers (17-2171)"
1530  "Engineers, all other (17-2199)"
1540  "Drafters (17-3010)"
1550  "Engineering technicians, except drafters (17-3020)"
1560  "Surveying and mapping technicians (17-3031)"
1600  "Agricultural and food scientists (19-1010)"
1610  "Biological scientists (19-1020)"
1640  "Conservation scientists and foresters (19-1030)"
1650  "Medical scientists (19-1040)"
1700  "Astronomers and physicists (19-2010)"
1710  "Atmospheric and space scientists (19-2021)"
1720  "Chemists and materials scientists (19-2030)"
1740  "Environmental scientists and geoscientists (19-2040)"
1760  "Physical scientists, all other (19-2099)"
1800  "Economists (19-3011)"
1810  "Market and survey researchers (19-3020)"
1820  "Psychologists (19-3030)"
1830  "Sociologists (19-3041)"
1840  "Urban and regional planners (19-3051)"
1860  "Miscellaneous social scientists and related workers (19-3090)"
1900  "Agricultural and food science technicians (19-4011)"
1910  "Biological technicians (19-4021)"
1920  "Chemical technicians (19-4031)"
1930  "Geological and petroleum technicians (19-4041)"
1940  "Nuclear technicians (19-4051)"
1960  "Other life, physical, and social science technicians (19-40XX)"
2000  "Counselors (21-1010)"
2010  "Social workers (21-1020)"
2020  "Miscellaneous community and social service specialists (21-1090)"
2040  "Clergy (21-2011)"
2050  "Directors, religious activities and education (21-2021)"
2060  "Religious workers, all other (21-2099)"
2100  "Lawyers (23-1011)"
2140  "Paralegals and legal assistants (23-2011)"
2150  "Miscellaneous legal support workers (23-2090)"
2200  "Postsecondary teachers (25-1000)"
2300  "Preschool and kindergarten teachers (25-2010)"
2310  "Elementary and middle school teachers (25-2020)"
2320  "Secondary school teachers (25-2030)"
2330  "Special education teachers (25-2040)"
2340  "Other teachers and instructors (25-3000)"
2400  "Archivists, curators, and museum technicians (25-4010)"
2430  "Librarians (25-4021)"
2440  "Library technicians (25-4031)"
2540  "Teacher assistants (25-9041)"
2550  "Other education, training, and library workers (25-90XX)"
2600  "Artists and related workers (27-1010)"
2630  "Designers (27-1020)"
2700  "Actors (27-2011)"
2710  "Producers and directors (27-2012)"
2720  "Athletes, coaches, umpires, and related workers (27-2020)"
2740  "Dancers and choreographers (27-2030)"
2750  "Musicians, singers, and related workers (27-2040)"
2760  "Entertainers and performers, sports and related workers, all other (27-2099)"
2800  "Announcers (27-3010)"
2810  "News analysts, reporters and correspondents (27-3020)"
2820  "Public relations specialists (27-3031)"
2830  "Editors (27-3041)"
2840  "Technical writers (27-3042)"
2850  "Writers and authors (27-3043)"
2860  "Miscellaneous media and communication workers (27-3090)"
2900  "Broadcast and sound engineering technicians and radio operators (27-4010)"
2910  "Photographers (27-4021)"
2920  "Television, video, and motion picture camera operators and editors (27-4030)"
2960  "Media and communication equipment workers, all other (27-4099)"
3000  "Chiropractors (29-1011)"
3010  "Dentists (29-1020)"
3030  "Dietitians and nutritionists (29-1031)"
3040  "Optometrists (29-1041)"
3050  "Pharmacists (29-1051)"
3060  "Physicians and surgeons (29-1060)"
3110  "Physician assistants (29-1071)"
3120  "Podiatrists (29-1081)"
3130  "Registered nurses (29-1111)"
3140  "Audiologists (29-1121)"
3150  "Occupational therapists (29-1122)"
3160  "Physical therapists (29-1123)"
3200  "Radiation therapists (29-1124)"
3210  "Recreational therapists (29-1125)"
3220  "Respiratory therapists (29-1126)"
3230  "Speech-language pathologists (29-1127)"
3240  "Therapists, all other (29-1129)"
3250  "Veterinarians (29-1131)"
3260  "Health diagnosing and treating practitioners, all other (29-1199)"
3300  "Clinical laboratory technologists and technicians (29-2010)"
3310  "Dental hygienists (29-2021)"
3320  "Diagnostic related technologists and technicians (29-2030)"
3400  "Emergency medical technicians and paramedics (29-2041)"
3410  "Health diagnosing and treating practitioner support technicians (29-2050)"
3500  "Licensed practical and licensed vocational nurses (29-2061)"
3510  "Medical records and health information technicians (29-2071)"
3520  "Opticians, dispensing (29-2081)"
3530  "Miscellaneous health technologists and technicians (29-2090)"
3540  "Other healthcare practitioners and technical occupations (29-9000)"
3600  "Nursing, psychiatric, and home health aides (31-1010)"
3610  "Occupational therapist assistants and aides (31-2010)"
3620  "Physical therapist assistants and aides (31-2020)"
3630  "Massage therapists (31-9011)"
3640  "Dental assistants (31-9091)"
3650  "Medical assistants and other healthcare support occupations (31-909X)"
3700  "First-line supervisors/managers of correctional officers (33-1011)"
3710  "First-line supervisors/managers of police and detectives (33-1012)"
3720  "First-line supervisors/managers of fire fighting and prevention workers (33-1021)"
3730  "Supervisors, protective service workers, all other (33-1099)"
3740  "Fire fighters (33-2011)"
3750  "Fire inspectors (33-2020)"
3800  "Bailiffs, correctional officers, and jailers (33-3010)"
3820  "Detectives and criminal investigators (33-3021)"
3830  "Fish and game wardens (33-3031)"
3840  "Parking enforcement workers (33-3041)"
3850  "Police and sheriff''s patrol officers(33-3051)"
3860  "Transit and railroad police (33-3052)"
3900  "Animal control workers (33-9011)"
3910  "Private detectives and investigators (33-9021)"
3920  "Security guards and gaming surveillance officers (33-9030)"
3940  "Crossing guards (33-9091)"
3950  "Lifeguards and other protective service workers (33-909X)"
4000  "Chefs and head cooks (35-1011)"
4010  "First-line supervisors/managers of food preparation and serving workers (35-1012)"
4020  "Cooks (35-2010)"
4030  "Food preparation workers (35-2021)"
4040  "Bartenders (35-3011)"
4050  "Combined food preparation and serving workers, including fast food (35-3021)"
4060  "Counter attendants, cafeteria, food concession, and coffee shop (35-3022)"
4110  "Waiters and waitresses (35-3031)"
4120  "Food servers, nonrestaurant (35-3041)"
4130  "Dining room and cafeteria attendants and bartender helpers (35-9011)"
4140  "Dishwashers (35-9021)"
4150  "Hosts and hostesses, restaurant, lounge, and coffee shop (35-9031)"
4160  "Food preparation and serving related workers, all other (35-9099)"
4200  "First-line supervisors/managers of housekeeping and janitorial workers (37-1011)"
4210  "First-line supervisors/managers of landscaping, lawn service, and groundskeeping workers"
4220  "Janitors and building cleaners (37-201X)"
4230  "Maids and housekeeping cleaners (37-2012)"
4240  "Pest control workers (37-2021)"
4250  "Grounds maintenance workers (37-3010)"
4300  "First-line supervisors/managers of gaming workers (39-1010)"
4320  "First-line supervisors/managers of personal service workers (39-1021)"
4340  "Animal trainers (39-2011)"
4350  "Nonfarm animal caretakers (39-2021)"
4400  "Gaming services workers (39-3010)"
4410  "Motion picture projectionists (39-3021)"
4420  "Ushers, lobby attendants, and ticket takers (39-3031)"
4430  "Miscellaneous entertainment attendants and related workers (39-3090)"
4460  "Funeral service workers (39-4000)"
4500  "Barbers (39-5011)"
4510  "Hairdressers, hairstylists, and cosmetologists (39-5012)"
4520  "Miscellaneous personal appearance workers (39-5090)"
4530  "Baggage porters, bellhops, and concierges (39-6010)"
4540  "Tour and travel guides (39-6020)"
4550  "Transportation attendants (39-6030)"
4600  "Child care workers (39-9011)"
4610  "Personal and home care aides (39-9021)"
4620  "Recreation and fitness workers (39-9030)"
4640  "Residential advisors (39-9041)"
4650  "Personal care and service workers, all other (39-9099)"
4700  "First-line supervisors/managers of retail sales workers (41-1011)"
4710  "First-line supervisors/managers of non-retail sales workers (41-1012)"
4720  "Cashiers (41-2010)"
4740  "Counter and rental clerks (41-2021)"
4750  "Parts salespersons (41-2022)"
4760  "Retail salespersons (41-2031)"
4800  "Advertising sales agents (41-3011)"
4810  "Insurance sales agents (41-3021)"
4820  "Securities, commodities, and financial services sales agents (41-3031)"
4830  "Travel agents (41-3041)"
4840  "Sales representatives, services, all other (41-3099)"
4850  "Sales representatives, wholesale and manufacturing (41-4010)"
4900  "Models, demonstrators, and product promoters (41-9010)"
4920  "Real estate brokers and sales agents (41-9020)"
4930  "Sales engineers (41-9031)"
4940  "Telemarketers (41-9041)"
4950  "Door-to-door sales workers, news and street vendors, and related workers (41-9091)"
4960  "Sales and related workers, all other (41-9099)"
5000  "First-line supervisors/managers of office and administrative support workers (43-1011)"
5010  "Switchboard operators, including answering service (43-2011)"
5020  "Telephone operators (43-2021)"
5030  "Communications equipment operators, all other (43-2099)"
5100  "Bill and account collectors (43-3011)"
5110  "Billing and posting clerks and machine operators (43-3021)"
5120  "Bookkeeping, accounting, and auditing clerks (43-3031)"
5130  "Gaming cage workers (43-3041)"
5140  "Payroll and timekeeping clerks (43-3051)"
5150  "Procurement clerks (43-3061)"
5160  "Tellers (43-3071)"
5200  "Brokerage clerks (43-4011)"
5210  "Correspondence clerks (43-4021)"
5220  "Court, municipal, and license clerks (43-4031)"
5230  "Credit authorizers, checkers, and clerks (43-4041)"
5240  "Customer service representatives (43-4051)"
5250  "Eligibility interviewers, government programs (43-4061)"
5260  "File Clerks (43-4071)"
5300  "Hotel, motel, and resort desk clerks (43-4081)"
5310  "Interviewers, except eligibility and loan (43-4111)"
5320  "Library assistants, clerical (43-4121)"
5330  "Loan interviewers and clerks (43-4131)"
5340  "New accounts clerks (43-4141)"
5350  "Order clerks (43-4151)"
5360  "Human resources assistants, except payroll and timekeeping (43-4161)"
5400  "Receptionists and information clerks (43-4171)"
5410  "Reservation and transportation ticket agents and travel clerks (43-4181)"
5420  "Information and record clerks, all other (43-4199)"
5500  "Cargo and freight agents (43-5011)"
5510  "Couriers and messengers (43-5021)"
5520  "Dispatchers (43-5030)"
5530  "Meter readers, utilities (43-5041)"
5540  "Postal service clerks (43-5051)"
5550  "Postal service mail carriers (43-5052)"
5560  "Postal service mail sorters, processors, and processing machine operators (43-5053)"
5600  "Production, planning, and expediting clerks (43-5061)"
5610  "Shipping, receiving, and traffic clerks (43-5071)"
5620  "Stock clerks and order fillers (43-5081)"
5630  "Weighers, measurers, checkers, and samplers, recordkeeping (43-5111)"
5700  "Secretaries and administrative assistants (43-6010)"
5800  "Computer operators (43-9011)"
5810  "Data entry keyers (43-9021)"
5820  "Word processors and typists (43-9022)"
5830  "Desktop publishers (43-9031)"
5840  "Insurance claims and policy processing clerks (43-9041)"
5850  "Mail clerks and mail machine operators, except postal service (43-9051)"
5860  "Office clerks, general (43-9061)"
5900  "Office machine operators, except computer (43-9071)"
5910  "Proofreaders and copy markers (43-9081)"
5920  "Statistical assistants (43-9111)"
5930  "Office and administrative support workers, all other (43-9199)"
6000  "First-line supervisors/managers of farming, fishing, and forestry workers (45-1010)"
6010  "Agricultural inspectors (45-2011)"
6020  "Animal breeders (45-2021)"
6040  "Graders and sorters, agricultural products (45-2041)"
6050  "Miscellaneous agricultural workers (45-2090)"
6100  "Fishers and related fishing workers (45-3011)"
6110  "Hunters and trappers (45-3021)"
6120  "Forest and conservation workers (45-4011)"
6130  "Logging workers (45-4020)"
6200  "First-line supervisors/managers of construction trades and extraction workers (47-1011)"
6210  "Boilermakers (47-2011)"
6220  "Brickmasons, blockmasons, and stonemasons (47-2020)"
6230  "Carpenters (47-2031)"
6240  "Carpet, floor, and tile installers and finishers (47-2040)"
6250  "Cement masons, concrete finishers, and terrazzo workers (47-2050)"
6260  "Construction laborers (47-2061)"
6300  "Paving, surfacing, and tamping equipment operators (47-2071)"
6310  "Pile-driver operators (47-2072)"
6320  "Operating engineers and other construction equipment operators (47-2073)"
6330  "Drywall installers, ceiling tile installers, and tapers (47-2080)"
6350  "Electricians (47-2111)"
6360  "Glaziers (47-2121)"
6400  "Insulation workers (47-2130)"
6420  "Painters, construction and maintenance (47-2141)"
6430  "Paperhangers (47-2142)"
6440  "Pipelayers, plumbers, pipefitters, and steamfitters (47-2150)"
6460  "Plasterers and stucco masons (47-2161)"
6500  "Reinforcing iron and rebar workers (47-2171)"
6510  "Roofers (47-2181)"
6520  "Sheet metal workers (47-2211)"
6530  "Structural iron and steel workers (47-2221)"
6600  "Helpers, construction trades (47-3010)"
6660  "Construction and building inspectors (47-4011)"
6700  "Elevator installers and repairers (47-4021)"
6710  "Fence erectors (47-4031)"
6720  "Hazardous materials removal workers (47-4041)"
6730  "Highway maintenance workers (47-4051)"
6740  "Rail-track laying and maintenance equipment operators (47-4061)"
6750  "Septic tank servicers and sewer pipe cleaners (47-4071)"
6760  "Miscellaneous construction and related workers (47-4090)"
6800  "Derrick, rotary drill, and service unit operators, oil, gas, and mining (47-5010)"
6820  "Earth drillers, except oil and gas (47-5021)"
6830  "Explosives workers, ordnance handling experts, and blasters (47-5031)"
6840  "Mining machine operators (47-5040)"
6910  "Roof bolters, mining (47-5061)"
6920  "Roustabouts, oil and gas (47-5071)"
6930  "Helpers--extraction workers (47-5081)"
6940  "Other extraction workers (47-50XX)"
7000  "First-line supervisors/managers of mechanics, installers, and repairers (49-1011)"
7010  "Computer, automated teller, and office machine repairers (49-2011)"
7020  "Radio and telecommunications equipment installers and repairers (49-2020)"
7030  "Avionics technicians (49-2091)"
7040  "Electric motor, power tool, and related repairers (49-2092)"
7050  "Electrical and electronics installers and repairers, transportation equipment (49-2093)"
7100  "Electrical and electronics repairers, industrial and utility (49-209X)"
7110  "Electronic equipment installers and repairers, motor vehicles (49-2096)"
7120  "Electronic home entertainment equipment installers and repairers (49-2097)"
7130  "Security and fire alarm systems installers (49-2098)"
7140  "Aircraft mechanics and service technicians (49-3011)"
7150  "Automotive body and related repairers (49-3021)"
7160  "Automotive glass installers and repairers (49-3022)"
7200  "Automotive service technicians and mechanics (49-3023)"
7210  "Bus and truck mechanics and diesel engine specialists (49-3031)"
7220  "Heavy vehicle and mobile equipment service technicians and mechanics (49-3040)"
7240  "Small engine mechanics (49-3050)"
7260  "Miscellaneous vehicle and mobile equipment mechanics, installers, and repairers (49-3090"
7300  "Control and valve installers and repairers (49-9010)"
7310  "Heating, air conditioning, and refrigeration mechanics and installers (49-9021)"
7320  "Home appliance repairers (49-9031)"
7330  "Industrial and refractory machinery mechanics (49-904X)"
7340  "Maintenance and repair workers, general (49-9042)"
7350  "Maintenance workers, machinery (49-9043)"
7360  "Millwrights (49-9044)"
7410  "Electrical power-line installers and repairers (49-9051)"
7420  "Telecommunications line installers and repairers (49-9052)"
7430  "Precision instrument and equipment repairers (49-9060)"
7510  "Coin, vending, and amusement machine servicers and repairers (49-9091)"
7520  "Commercial divers (49-9092)"
7540  "Locksmiths and safe repairers (49-9094)"
7550  "Manufactured building and mobile home installers (49-9095)"
7560  "Riggers (49-9096)"
7600  "Signal and track switch repairers (49-9097)"
7610  "Helpers--installation, maintenance, and repair workers (49-9098)"
7620  "Other installation, maintenance, and repair workers (49-909X)"
7700  "First-line supervisors/managers of production and operating workers (51-1011)"
7710  "Aircraft structure, surfaces, rigging, and systems assemblers (51-2011)"
7720  "Electrical, electronics, and electromechanical assemblers (51-2020)"
7730  "Engine and other machine assemblers (51-2031)"
7740  "Structural metal fabricators and fitters (51-2041)"
7750  "Miscellaneous assemblers and fabricators (51-2090)"
7800  "Bakers (51-3011)"
7810  "Butchers and other meat, poultry, and fish processing workers (51-3020)"
7830  "Food and tobacco roasting, baking, and drying machine operators and tenders (51-3091)"
7840  "Food batchmakers (51-3092)"
7850  "Food cooking machine operators and tenders (51-3093)"
7900  "Computer control programmers and operators (51-4010)"
7920  "Extruding and drawing machine setters, operators, and tenders, metal and plastic (51-402"
7930  "Forging machine setters, operators, and tenders, metal and plastic (51-4022)"
7940  "Rolling machine setters, operators, and tenders, metal and plastic (51-4023)"
7950  "Cutting, punching, and press machine setters, operators, and tenders, metal and plastic"
7960  "Drilling and boring machine tool setters, operators, and tenders, metal and plastic (51-"
8000  "Grinding, lapping, polishing, and buffing machine tool setters, operators, and tenders,"
8010  "Lathe and turning machine tool setters, operators, and tenders, metal and plastic (51-40"
8020  "Milling and planing machine setters, operators, and tenders, metal and plastic (51-4035)"
8030  "Machinists (51-4041)"
8040  "Metal furnace and kiln operators and tenders (51-4050)"
8060  "Model makers and patternmakers, metal and plastic (51-4060)"
8100  "Molders and molding machine setters, operators, and tenders, metal and plastic (51-4070)"
8120  "Multiple machine tool setters, operators, and tenders, metal and plastic (51-4081)"
8130  "Tool and die makers (51-4111)"
8140  "Welding, soldering, and brazing workers (51-4120)"
8150  "Heat treating equipment setters, operators, and tenders, metal and plastic (51-4191)"
8160  "Lay-out workers, metal and plastic (51-4192)"
8200  "Plating and coating machine setters, operators, and tenders, metal and plastic (51-4193)"
8210  "Tool grinders, filers, and sharpeners (51-4194)"
8220  "Metalworkers and plastic workers, all other (51-4199)"
8230  "Bookbinders and bindery workers (51-5010)"
8240  "Job printers (51-5021)"
8250  "Prepress technicians and workers (51-5022)"
8260  "Printing machine operators (51-5023)"
8300  "Laundry and dry-cleaning workers (51-6011)"
8310  "Pressers, textile, garment, and related materials (51-6021)"
8320  "Sewing machine operators (51-6031)"
8330  "Shoe and leather workers and repairers (51-6041)"
8340  "Shoe machine operators and tenders (51-6042)"
8350  "Tailors, dressmakers, and sewers (51-6050)"
8360  "Textile bleaching and dyeing machine operators and tenders (51-6061)"
8400  "Textile cutting machine setters, operators, and tenders (51-6062)"
8410  "Textile knitting and weaving machine setters, operators, and tenders (51-6063)"
8420  "Textile winding, twisting, and drawing out machine setters, operators, and tenders (51-6"
8430  "Extruding and forming machine setters, operators, and tenders, synthetic and glass fiber"
8440  "Fabric and apparel patternmakers (51-6092)"
8450  "Upholsterers (51-6093)"
8460  "Textile, apparel, and furnishings workers, all other (51-6099)"
8500  "Cabinetmakers and bench carpenters (51-7011)"
8510  "Furniture finishers (51-7021)"
8520  "Model makers and patternmakers, wood (51-7030)"
8530  "Sawing machine setters, operators, and tenders, wood (51-7041)"
8540  "Woodworking machine setters, operators, and tenders, except sawing (51-7042)"
8550  "Woodworkers, all other (51-7099)"
8600  "Power plant operators, distributors, and dispatchers (51-8010)"
8610  "Stationary engineers and boiler operators (51-8021)"
8620  "Water and liquid waste treatment plant and system operators (51-8031)"
8630  "Miscellaneous plant and system operators (51-8090)"
8640  "Chemical processing machine setters, operators, and tenders (51-9010)"
8650  "Crushing, grinding, polishing, mixing, and blending workers (51-9020)"
8710  "Cutting workers (51-9030)"
8720  "Extruding, forming, pressing, and compacting machine setters, operators, and tenders (51"
8730  "Furnace, kiln, oven, drier, and kettle operators and tenders (51-9051)"
8740  "Inspectors, testers, sorters, samplers, and weighers (51-9061)"
8750  "Jewelers and precious stone and metal workers (51-9071)"
8760  "Medical, dental, and ophthalmic laboratory technicians (51-9080)"
8800  "Packaging and filling machine operators and tenders (51-9111)"
8810  "Painting workers (51-9120)"
8830  "Photographic process workers and processing machine operators (51-9130)"
8840  "Semiconductor processors (51-9141)"
8850  "Cementing and gluing machine operators and tenders (51-9191)"
8860  "Cleaning, washing, and metal pickling equipment operators and tenders (51-9192)"
8900  "Cooling and freezing equipment operators and tenders (51-9193)"
8910  "Etchers and engravers (51-9194)"
8920  "Molders, shapers, and casters, except metal and plastic (51-9195)"
8930  "Paper goods machine setters, operators, and tenders (51-9196)"
8940  "Tire builders (51-9197)"
8950  "Helpers--production workers (51-9198)"
8960  "Production workers, all other (51-9199)"
9000  "Supervisors, transportation and material moving workers (53-1000)"
9030  "Aircraft pilots and flight engineers (53-2010)"
9040  "Air traffic controllers and airfield operations specialists (53-2020)"
9110  "Ambulance drivers and attendants, except emergency medical technicians (53-3011)"
9120  "Bus drivers (53-3020)"
9130  "Driver/sales workers and truck drivers (53-3030)"
9140  "Taxi drivers and chauffeurs (53-3041)"
9150  "Motor vehicle operators, all other (53-3099)"
9200  "Locomotive engineers and operators (53-4010)"
9230  "Railroad brake, signal, and switch operators (53-4021)"
9240  "Railroad conductors and yardmasters (53-4031)"
9260  "Subway, streetcar, and other rail transportation workers (53-40XX)"
9300  "Sailors and marine oilers (53-5011)"
9310  "Ship and boat captains and operators (53-5020)"
9330  "Ship engineers (53-5031)"
9340  "Bridge and lock tenders (53-6011)"
9350  "Parking lot attendants (53-6021)"
9360  "Service station attendants (53-6031)"
9410  "Transportation inspectors (53-6051)"
9420  "Other transportation workers (53-60XX)"
9500  "Conveyor operators and tenders (53-7011)"
9510  "Crane and tower operators (53-7021)"
9520  "Dredge, excavating, and loading machine operators (53-7030)"
9560  "Hoist and winch operators (53-7041)"
9600  "Industrial truck and tractor operators (53-7051)"
9610  "Cleaners of vehicles and equipment (53-7061)"
9620  "Laborers and freight, stock, and material movers, hand (53-7062)"
9630  "Machine feeders and offbearers (53-7063)"
9640  "Packers and packagers, hand (53-7064)"
9650  "Pumping station operators (53-7070)"
9720  "Refuse and recyclable material collectors (53-7081)"
9730  "Shuttle car operators (53-7111)"
9740  "Tank car, truck, and ship loaders (53-7121)"
9750  "Material moving workers, all other (53-7199)"
9840  "Persons whose current labor force status is unemployed and last job was Armed Forces"
;
label define FM83X
-1  "Not in Universe"
0010  "Chief executives (11-1011)"
0020  "General and operations managers (11-1021)"
0040  "Advertising and promotions managers (11-2011)"
0050  "Marketing and sales managers (11-2020)"
0060  "Public relations managers (11-2031)"
0100  "Administrative services managers (11-3011)"
0110  "Computer and information systems managers (11-3021)"
0120  "Financial managers (11-3031)"
0130  "Human resources managers (11-3040)"
0140  "Industrial production managers(11-3051)"
0150  "Purchasing managers (11-3061)"
0160  "Transportation, storage, and distribution managers (11-3071)"
0200  "Farm, ranch, and other agricultural managers (11-9011)"
0210  "Farmers and ranchers (11-9012)"
0220  "Construction managers (11-9021)"
0230  "Education administrators (11-9030)"
0300  "Engineering managers (11-9041)"
0310  "Food service managers (11-9051)"
0320  "Funeral directors (11-9061)"
0330  "Gaming managers (11-9071)"
0340  "Lodging managers (11-9081)"
0350  "Medical and health services managers (11-9111)"
0360  "Natural sciences managers (11-9121)"
0410  "Property, real estate, and community association managers (11-9141)"
0420  "Social and community service managers (11-9151)"
0430  "Managers, all other (11-9199)"
0500  "Agents and business managers of artists, performers, and athletes (13-1011)"
0510  "Purchasing agents and buyers, farm products (13-1021)"
0520  "Wholesale and retail buyers, except farm products (13-1022)"
0530  "Purchasing agents, except wholesale, retail, and farm products (13-1023)"
0540  "Claims adjusters, appraisers, examiners, and investigators (13-1030)"
0560  "Compliance officers, except agriculture, construction, health and safety, and transporta"
0600  "Cost estimators (13-1051)"
0620  "Human resources, training, and labor relations specialists (13-1070)"
0700  "Logisticians (13-1081)"
0710  "Management analysts (13-1111)"
0720  "Meeting and convention planners (13-1121)"
0730  "Other business operations specialists (13-11XX)"
0800  "Accountants and auditors (13-2011)"
0810  "Appraisers and assessors of real estate (13-2021)"
0820  "Budget analysts (13-2031)"
0830  "Credit analysts (13-2041)"
0840  "Financial analysts (13-2051)"
0850  "Personal financial advisors (13-2052)"
0860  "Insurance underwriters (13-2053)"
0900  "Financial examiners (13-2061)"
0910  "Loan counselors and officers (13-2070)"
0930  "Tax examiners, collectors, and revenue agents (13-2081)"
0940  "Tax preparers (13-2082)"
0950  "Financial specialists, all other (13-2099)"
1000  "Computer scientists and systems analysts (15-10XX)"
1010  "Computer programmers (15-1021)"
1020  "Computer software engineers (15-1030)"
1040  "Computer support specialists (15-1041)"
1060  "Database administrators (15-1061)"
1100  "Network and computer systems administrators (15-1071)"
1110  "Network systems and data communications analysts (15-1081)"
1200  "Actuaries (15-2011)"
1210  "Mathematicians (15-2021)"
1220  "Operations research analysts (15-2031)"
1230  "Statisticians (15-2041)"
1240  "Miscellaneous mathematical science occupations (15-2090)"
1300  "Architects, except naval (17-1010)"
1310  "Surveyors, cartographers, and photogrammetrists (17-1020)"
1320  "Aerospace engineers (17-2011)"
1330  "Agricultural engineers (17-2021)"
1340  "Biomedical engineers (17-2031)"
1350  "Chemical engineers (17-2041)"
1360  "Civil engineers (17-2051)"
1400  "Computer hardware engineers (17-2061)"
1410  "Electrical and electronic engineers (17-2070)"
1420  "Environmental engineers (17-2081)"
1430  "Industrial engineers, including health and safety (17-2110)"
1440  "Marine engineers and naval architects (17-2121)"
1450  "Materials engineers (17-2131)"
1460  "Mechanical engineers (17-2141)"
1500  "Mining and geological engineers, including mining safety engineers (17-2151)"
1510  "Nuclear engineers (17-2161)"
1520  "Petroleum engineers (17-2171)"
1530  "Engineers, all other (17-2199)"
1540  "Drafters (17-3010)"
1550  "Engineering technicians, except drafters (17-3020)"
1560  "Surveying and mapping technicians (17-3031)"
1600  "Agricultural and food scientists (19-1010)"
1610  "Biological scientists (19-1020)"
1640  "Conservation scientists and foresters (19-1030)"
1650  "Medical scientists (19-1040)"
1700  "Astronomers and physicists (19-2010)"
1710  "Atmospheric and space scientists (19-2021)"
1720  "Chemists and materials scientists (19-2030)"
1740  "Environmental scientists and geoscientists (19-2040)"
1760  "Physical scientists, all other (19-2099)"
1800  "Economists (19-3011)"
1810  "Market and survey researchers (19-3020)"
1820  "Psychologists (19-3030)"
1830  "Sociologists (19-3041)"
1840  "Urban and regional planners (19-3051)"
1860  "Miscellaneous social scientists and related workers (19-3090)"
1900  "Agricultural and food science technicians (19-4011)"
1910  "Biological technicians (19-4021)"
1920  "Chemical technicians (19-4031)"
1930  "Geological and petroleum technicians (19-4041)"
1940  "Nuclear technicians (19-4051)"
1960  "Other life, physical, and social science technicians (19-40XX)"
2000  "Counselors (21-1010)"
2010  "Social workers (21-1020)"
2020  "Miscellaneous community and social service specialists (21-1090)"
2040  "Clergy (21-2011)"
2050  "Directors, religious activities and education (21-2021)"
2060  "Religious workers, all other (21-2099)"
2100  "Lawyers (23-1011)"
2140  "Paralegals and legal assistants (23-2011)"
2150  "Miscellaneous legal support workers (23-2090)"
2200  "Postsecondary teachers (25-1000)"
2300  "Preschool and kindergarten teachers (25-2010)"
2310  "Elementary and middle school teachers (25-2020)"
2320  "Secondary school teachers (25-2030)"
2330  "Special education teachers (25-2040)"
2340  "Other teachers and instructors (25-3000)"
2400  "Archivists, curators, and museum technicians (25-4010)"
2430  "Librarians (25-4021)"
2440  "Library technicians (25-4031)"
2540  "Teacher assistants (25-9041)"
2550  "Other education, training, and library workers (25-90XX)"
2600  "Artists and related workers (27-1010)"
2630  "Designers (27-1020)"
2700  "Actors (27-2011)"
2710  "Producers and directors (27-2012)"
2720  "Athletes, coaches, umpires, and related workers (27-2020)"
2740  "Dancers and choreographers (27-2030)"
2750  "Musicians, singers, and related workers (27-2040)"
2760  "Entertainers and performers, sports and related workers, all other (27-2099)"
2800  "Announcers (27-3010)"
2810  "News analysts, reporters and correspondents (27-3020)"
2820  "Public relations specialists (27-3031)"
2830  "Editors (27-3041)"
2840  "Technical writers (27-3042)"
2850  "Writers and authors (27-3043)"
2860  "Miscellaneous media and communication workers (27-3090)"
2900  "Broadcast and sound engineering technicians and radio operators (27-4010)"
2910  "Photographers (27-4021)"
2920  "Television, video, and motion picture camera operators and editors (27-4030)"
2960  "Media and communication equipment workers, all other (27-4099)"
3000  "Chiropractors (29-1011)"
3010  "Dentists (29-1020)"
3030  "Dietitians and nutritionists (29-1031)"
3040  "Optometrists (29-1041)"
3050  "Pharmacists (29-1051)"
3060  "Physicians and surgeons (29-1060)"
3110  "Physician assistants (29-1071)"
3120  "Podiatrists (29-1081)"
3130  "Registered nurses (29-1111)"
3140  "Audiologists (29-1121)"
3150  "Occupational therapists (29-1122)"
3160  "Physical therapists (29-1123)"
3200  "Radiation therapists (29-1124)"
3210  "Recreational therapists (29-1125)"
3220  "Respiratory therapists (29-1126)"
3230  "Speech-language pathologists (29-1127)"
3240  "Therapists, all other (29-1129)"
3250  "Veterinarians (29-1131)"
3260  "Health diagnosing and treating practitioners, all other (29-1199)"
3300  "Clinical laboratory technologists and technicians (29-2010)"
3310  "Dental hygienists (29-2021)"
3320  "Diagnostic related technologists and technicians (29-2030)"
3400  "Emergency medical technicians and paramedics (29-2041)"
3410  "Health diagnosing and treating practitioner support technicians (29-2050)"
3500  "Licensed practical and licensed vocational nurses (29-2061)"
3510  "Medical records and health information technicians (29-2071)"
3520  "Opticians, dispensing (29-2081)"
3530  "Miscellaneous health technologists and technicians (29-2090)"
3540  "Other healthcare practitioners and technical occupations (29-9000)"
3600  "Nursing, psychiatric, and home health aides (31-1010)"
3610  "Occupational therapist assistants and aides (31-2010)"
3620  "Physical therapist assistants and aides (31-2020)"
3630  "Massage therapists (31-9011)"
3640  "Dental assistants (31-9091)"
3650  "Medical assistants and other healthcare support occupations (31-909X)"
3700  "First-line supervisors/managers of correctional officers (33-1011)"
3710  "First-line supervisors/managers of police and detectives (33-1012)"
3720  "First-line supervisors/managers of fire fighting and prevention workers (33-1021)"
3730  "Supervisors, protective service workers, all other (33-1099)"
3740  "Fire fighters (33-2011)"
3750  "Fire inspectors (33-2020)"
3800  "Bailiffs, correctional officers, and jailers (33-3010)"
3820  "Detectives and criminal investigators (33-3021)"
3830  "Fish and game wardens (33-3031)"
3840  "Parking enforcement workers (33-3041)"
3850  "Police and sheriff''s patrol officers(33-3051)"
3860  "Transit and railroad police (33-3052)"
3900  "Animal control workers (33-9011)"
3910  "Private detectives and investigators (33-9021)"
3920  "Security guards and gaming surveillance officers (33-9030)"
3940  "Crossing guards (33-9091)"
3950  "Lifeguards and other protective service workers (33-909X)"
4000  "Chefs and head cooks (35-1011)"
4010  "First-line supervisors/managers of food preparation and serving workers (35-1012)"
4020  "Cooks (35-2010)"
4030  "Food preparation workers (35-2021)"
4040  "Bartenders (35-3011)"
4050  "Combined food preparation and serving workers, including fast food (35-3021)"
4060  "Counter attendants, cafeteria, food concession, and coffee shop (35-3022)"
4110  "Waiters and waitresses (35-3031)"
4120  "Food servers, nonrestaurant (35-3041)"
4130  "Dining room and cafeteria attendants and bartender helpers (35-9011)"
4140  "Dishwashers (35-9021)"
4150  "Hosts and hostesses, restaurant, lounge, and coffee shop (35-9031)"
4160  "Food preparation and serving related workers, all other (35-9099)"
4200  "First-line supervisors/managers of housekeeping and janitorial workers (37-1011)"
4210  "First-line supervisors/managers of landscaping, lawn service, and groundskeeping workers"
4220  "Janitors and building cleaners (37-201X)"
4230  "Maids and housekeeping cleaners (37-2012)"
4240  "Pest control workers (37-2021)"
4250  "Grounds maintenance workers (37-3010)"
4300  "First-line supervisors/managers of gaming workers (39-1010)"
4320  "First-line supervisors/managers of personal service workers (39-1021)"
4340  "Animal trainers (39-2011)"
4350  "Nonfarm animal caretakers (39-2021)"
4400  "Gaming services workers (39-3010)"
4410  "Motion picture projectionists (39-3021)"
4420  "Ushers, lobby attendants, and ticket takers (39-3031)"
4430  "Miscellaneous entertainment attendants and related workers (39-3090)"
4460  "Funeral service workers (39-4000)"
4500  "Barbers (39-5011)"
4510  "Hairdressers, hairstylists, and cosmetologists (39-5012)"
4520  "Miscellaneous personal appearance workers (39-5090)"
4530  "Baggage porters, bellhops, and concierges (39-6010)"
4540  "Tour and travel guides (39-6020)"
4550  "Transportation attendants (39-6030)"
4600  "Child care workers (39-9011)"
4610  "Personal and home care aides (39-9021)"
4620  "Recreation and fitness workers (39-9030)"
4640  "Residential advisors (39-9041)"
4650  "Personal care and service workers, all other (39-9099)"
4700  "First-line supervisors/managers of retail sales workers (41-1011)"
4710  "First-line supervisors/managers of non-retail sales workers (41-1012)"
4720  "Cashiers (41-2010)"
4740  "Counter and rental clerks (41-2021)"
4750  "Parts salespersons (41-2022)"
4760  "Retail salespersons (41-2031)"
4800  "Advertising sales agents (41-3011)"
4810  "Insurance sales agents (41-3021)"
4820  "Securities, commodities, and financial services sales agents (41-3031)"
4830  "Travel agents (41-3041)"
4840  "Sales representatives, services, all other (41-3099)"
4850  "Sales representatives, wholesale and manufacturing (41-4010)"
4900  "Models, demonstrators, and product promoters (41-9010)"
4920  "Real estate brokers and sales agents (41-9020)"
4930  "Sales engineers (41-9031)"
4940  "Telemarketers (41-9041)"
4950  "Door-to-door sales workers, news and street vendors, and related workers (41-9091)"
4960  "Sales and related workers, all other (41-9099)"
5000  "First-line supervisors/managers of office and administrative support workers (43-1011)"
5010  "Switchboard operators, including answering service (43-2011)"
5020  "Telephone operators (43-2021)"
5030  "Communications equipment operators, all other (43-2099)"
5100  "Bill and account collectors (43-3011)"
5110  "Billing and posting clerks and machine operators (43-3021)"
5120  "Bookkeeping, accounting, and auditing clerks (43-3031)"
5130  "Gaming cage workers (43-3041)"
5140  "Payroll and timekeeping clerks (43-3051)"
5150  "Procurement clerks (43-3061)"
5160  "Tellers (43-3071)"
5200  "Brokerage clerks (43-4011)"
5210  "Correspondence clerks (43-4021)"
5220  "Court, municipal, and license clerks (43-4031)"
5230  "Credit authorizers, checkers, and clerks (43-4041)"
5240  "Customer service representatives (43-4051)"
5250  "Eligibility interviewers, government programs (43-4061)"
5260  "File Clerks (43-4071)"
5300  "Hotel, motel, and resort desk clerks (43-4081)"
5310  "Interviewers, except eligibility and loan (43-4111)"
5320  "Library assistants, clerical (43-4121)"
5330  "Loan interviewers and clerks (43-4131)"
5340  "New accounts clerks (43-4141)"
5350  "Order clerks (43-4151)"
5360  "Human resources assistants, except payroll and timekeeping (43-4161)"
5400  "Receptionists and information clerks (43-4171)"
5410  "Reservation and transportation ticket agents and travel clerks (43-4181)"
5420  "Information and record clerks, all other (43-4199)"
5500  "Cargo and freight agents (43-5011)"
5510  "Couriers and messengers (43-5021)"
5520  "Dispatchers (43-5030)"
5530  "Meter readers, utilities (43-5041)"
5540  "Postal service clerks (43-5051)"
5550  "Postal service mail carriers (43-5052)"
5560  "Postal service mail sorters, processors, and processing machine operators (43-5053)"
5600  "Production, planning, and expediting clerks (43-5061)"
5610  "Shipping, receiving, and traffic clerks (43-5071)"
5620  "Stock clerks and order fillers (43-5081)"
5630  "Weighers, measurers, checkers, and samplers, recordkeeping (43-5111)"
5700  "Secretaries and administrative assistants (43-6010)"
5800  "Computer operators (43-9011)"
5810  "Data entry keyers (43-9021)"
5820  "Word processors and typists (43-9022)"
5830  "Desktop publishers (43-9031)"
5840  "Insurance claims and policy processing clerks (43-9041)"
5850  "Mail clerks and mail machine operators, except postal service (43-9051)"
5860  "Office clerks, general (43-9061)"
5900  "Office machine operators, except computer (43-9071)"
5910  "Proofreaders and copy markers (43-9081)"
5920  "Statistical assistants (43-9111)"
5930  "Office and administrative support workers, all other (43-9199)"
6000  "First-line supervisors/managers of farming, fishing, and forestry workers (45-1010)"
6010  "Agricultural inspectors (45-2011)"
6020  "Animal breeders (45-2021)"
6040  "Graders and sorters, agricultural products (45-2041)"
6050  "Miscellaneous agricultural workers (45-2090)"
6100  "Fishers and related fishing workers (45-3011)"
6110  "Hunters and trappers (45-3021)"
6120  "Forest and conservation workers (45-4011)"
6130  "Logging workers (45-4020)"
6200  "First-line supervisors/managers of construction trades and extraction workers (47-1011)"
6210  "Boilermakers (47-2011)"
6220  "Brickmasons, blockmasons, and stonemasons (47-2020)"
6230  "Carpenters (47-2031)"
6240  "Carpet, floor, and tile installers and finishers (47-2040)"
6250  "Cement masons, concrete finishers, and terrazzo workers (47-2050)"
6260  "Construction laborers (47-2061)"
6300  "Paving, surfacing, and tamping equipment operators (47-2071)"
6310  "Pile-driver operators (47-2072)"
6320  "Operating engineers and other construction equipment operators (47-2073)"
6330  "Drywall installers, ceiling tile installers, and tapers (47-2080)"
6350  "Electricians (47-2111)"
6360  "Glaziers (47-2121)"
6400  "Insulation workers (47-2130)"
6420  "Painters, construction and maintenance (47-2141)"
6430  "Paperhangers (47-2142)"
6440  "Pipelayers, plumbers, pipefitters, and steamfitters (47-2150)"
6460  "Plasterers and stucco masons (47-2161)"
6500  "Reinforcing iron and rebar workers (47-2171)"
6510  "Roofers (47-2181)"
6520  "Sheet metal workers (47-2211)"
6530  "Structural iron and steel workers (47-2221)"
6600  "Helpers, construction trades (47-3010)"
6660  "Construction and building inspectors (47-4011)"
6700  "Elevator installers and repairers (47-4021)"
6710  "Fence erectors (47-4031)"
6720  "Hazardous materials removal workers (47-4041)"
6730  "Highway maintenance workers (47-4051)"
6740  "Rail-track laying and maintenance equipment operators (47-4061)"
6750  "Septic tank servicers and sewer pipe cleaners (47-4071)"
6760  "Miscellaneous construction and related workers (47-4090)"
6800  "Derrick, rotary drill, and service unit operators, oil, gas, and mining (47-5010)"
6820  "Earth drillers, except oil and gas (47-5021)"
6830  "Explosives workers, ordnance handling experts, and blasters (47-5031)"
6840  "Mining machine operators (47-5040)"
6910  "Roof bolters, mining (47-5061)"
6920  "Roustabouts, oil and gas (47-5071)"
6930  "Helpers--extraction workers (47-5081)"
6940  "Other extraction workers (47-50XX)"
7000  "First-line supervisors/managers of mechanics, installers, and repairers (49-1011)"
7010  "Computer, automated teller, and office machine repairers (49-2011)"
7020  "Radio and telecommunications equipment installers and repairers (49-2020)"
7030  "Avionics technicians (49-2091)"
7040  "Electric motor, power tool, and related repairers (49-2092)"
7050  "Electrical and electronics installers and repairers, transportation equipment (49-2093)"
7100  "Electrical and electronics repairers, industrial and utility (49-209X)"
7110  "Electronic equipment installers and repairers, motor vehicles (49-2096)"
7120  "Electronic home entertainment equipment installers and repairers (49-2097)"
7130  "Security and fire alarm systems installers (49-2098)"
7140  "Aircraft mechanics and service technicians (49-3011)"
7150  "Automotive body and related repairers (49-3021)"
7160  "Automotive glass installers and repairers (49-3022)"
7200  "Automotive service technicians and mechanics (49-3023)"
7210  "Bus and truck mechanics and diesel engine specialists (49-3031)"
7220  "Heavy vehicle and mobile equipment service technicians and mechanics (49-3040)"
7240  "Small engine mechanics (49-3050)"
7260  "Miscellaneous vehicle and mobile equipment mechanics, installers, and repairers (49-3090"
7300  "Control and valve installers and repairers (49-9010)"
7310  "Heating, air conditioning, and refrigeration mechanics and installers (49-9021)"
7320  "Home appliance repairers (49-9031)"
7330  "Industrial and refractory machinery mechanics (49-904X)"
7340  "Maintenance and repair workers, general (49-9042)"
7350  "Maintenance workers, machinery (49-9043)"
7360  "Millwrights (49-9044)"
7410  "Electrical power-line installers and repairers (49-9051)"
7420  "Telecommunications line installers and repairers (49-9052)"
7430  "Precision instrument and equipment repairers (49-9060)"
7510  "Coin, vending, and amusement machine servicers and repairers (49-9091)"
7520  "Commercial divers (49-9092)"
7540  "Locksmiths and safe repairers (49-9094)"
7550  "Manufactured building and mobile home installers (49-9095)"
7560  "Riggers (49-9096)"
7600  "Signal and track switch repairers (49-9097)"
7610  "Helpers--installation, maintenance, and repair workers (49-9098)"
7620  "Other installation, maintenance, and repair workers (49-909X)"
7700  "First-line supervisors/managers of production and operating workers (51-1011)"
7710  "Aircraft structure, surfaces, rigging, and systems assemblers (51-2011)"
7720  "Electrical, electronics, and electromechanical assemblers (51-2020)"
7730  "Engine and other machine assemblers (51-2031)"
7740  "Structural metal fabricators and fitters (51-2041)"
7750  "Miscellaneous assemblers and fabricators (51-2090)"
7800  "Bakers (51-3011)"
7810  "Butchers and other meat, poultry, and fish processing workers (51-3020)"
7830  "Food and tobacco roasting, baking, and drying machine operators and tenders (51-3091)"
7840  "Food batchmakers (51-3092)"
7850  "Food cooking machine operators and tenders (51-3093)"
7900  "Computer control programmers and operators (51-4010)"
7920  "Extruding and drawing machine setters, operators, and tenders, metal and plastic (51-402"
7930  "Forging machine setters, operators, and tenders, metal and plastic (51-4022)"
7940  "Rolling machine setters, operators, and tenders, metal and plastic (51-4023)"
7950  "Cutting, punching, and press machine setters, operators, and tenders, metal and plastic"
7960  "Drilling and boring machine tool setters, operators, and tenders, metal and plastic (51-"
8000  "Grinding, lapping, polishing, and buffing machine tool setters, operators, and tenders,"
8010  "Lathe and turning machine tool setters, operators, and tenders, metal and plastic (51-40"
8020  "Milling and planing machine setters, operators, and tenders, metal and plastic (51-4035)"
8030  "Machinists (51-4041)"
8040  "Metal furnace and kiln operators and tenders (51-4050)"
8060  "Model makers and patternmakers, metal and plastic (51-4060)"
8100  "Molders and molding machine setters, operators, and tenders, metal and plastic (51-4070)"
8120  "Multiple machine tool setters, operators, and tenders, metal and plastic (51-4081)"
8130  "Tool and die makers (51-4111)"
8140  "Welding, soldering, and brazing workers (51-4120)"
8150  "Heat treating equipment setters, operators, and tenders, metal and plastic (51-4191)"
8160  "Lay-out workers, metal and plastic (51-4192)"
8200  "Plating and coating machine setters, operators, and tenders, metal and plastic (51-4193)"
8210  "Tool grinders, filers, and sharpeners (51-4194)"
8220  "Metalworkers and plastic workers, all other (51-4199)"
8230  "Bookbinders and bindery workers (51-5010)"
8240  "Job printers (51-5021)"
8250  "Prepress technicians and workers (51-5022)"
8260  "Printing machine operators (51-5023)"
8300  "Laundry and dry-cleaning workers (51-6011)"
8310  "Pressers, textile, garment, and related materials (51-6021)"
8320  "Sewing machine operators (51-6031)"
8330  "Shoe and leather workers and repairers (51-6041)"
8340  "Shoe machine operators and tenders (51-6042)"
8350  "Tailors, dressmakers, and sewers (51-6050)"
8360  "Textile bleaching and dyeing machine operators and tenders (51-6061)"
8400  "Textile cutting machine setters, operators, and tenders (51-6062)"
8410  "Textile knitting and weaving machine setters, operators, and tenders (51-6063)"
8420  "Textile winding, twisting, and drawing out machine setters, operators, and tenders (51-6"
8430  "Extruding and forming machine setters, operators, and tenders, synthetic and glass fiber"
8440  "Fabric and apparel patternmakers (51-6092)"
8450  "Upholsterers (51-6093)"
8460  "Textile, apparel, and furnishings workers, all other (51-6099)"
8500  "Cabinetmakers and bench carpenters (51-7011)"
8510  "Furniture finishers (51-7021)"
8520  "Model makers and patternmakers, wood (51-7030)"
8530  "Sawing machine setters, operators, and tenders, wood (51-7041)"
8540  "Woodworking machine setters, operators, and tenders, except sawing (51-7042)"
8550  "Woodworkers, all other (51-7099)"
8600  "Power plant operators, distributors, and dispatchers (51-8010)"
8610  "Stationary engineers and boiler operators (51-8021)"
8620  "Water and liquid waste treatment plant and system operators (51-8031)"
8630  "Miscellaneous plant and system operators (51-8090)"
8640  "Chemical processing machine setters, operators, and tenders (51-9010)"
8650  "Crushing, grinding, polishing, mixing, and blending workers (51-9020)"
8710  "Cutting workers (51-9030)"
8720  "Extruding, forming, pressing, and compacting machine setters, operators, and tenders (51"
8730  "Furnace, kiln, oven, drier, and kettle operators and tenders (51-9051)"
8740  "Inspectors, testers, sorters, samplers, and weighers (51-9061)"
8750  "Jewelers and precious stone and metal workers (51-9071)"
8760  "Medical, dental, and ophthalmic laboratory technicians (51-9080)"
8800  "Packaging and filling machine operators and tenders (51-9111)"
8810  "Painting workers (51-9120)"
8830  "Photographic process workers and processing machine operators (51-9130)"
8840  "Semiconductor processors (51-9141)"
8850  "Cementing and gluing machine operators and tenders (51-9191)"
8860  "Cleaning, washing, and metal pickling equipment operators and tenders (51-9192)"
8900  "Cooling and freezing equipment operators and tenders (51-9193)"
8910  "Etchers and engravers (51-9194)"
8920  "Molders, shapers, and casters, except metal and plastic (51-9195)"
8930  "Paper goods machine setters, operators, and tenders (51-9196)"
8940  "Tire builders (51-9197)"
8950  "Helpers--production workers (51-9198)"
8960  "Production workers, all other (51-9199)"
9000  "Supervisors, transportation and material moving workers (53-1000)"
9030  "Aircraft pilots and flight engineers (53-2010)"
9040  "Air traffic controllers and airfield operations specialists (53-2020)"
9110  "Ambulance drivers and attendants, except emergency medical technicians (53-3011)"
9120  "Bus drivers (53-3020)"
9130  "Driver/sales workers and truck drivers (53-3030)"
9140  "Taxi drivers and chauffeurs (53-3041)"
9150  "Motor vehicle operators, all other (53-3099)"
9200  "Locomotive engineers and operators (53-4010)"
9230  "Railroad brake, signal, and switch operators (53-4021)"
9240  "Railroad conductors and yardmasters (53-4031)"
9260  "Subway, streetcar, and other rail transportation workers (53-40XX)"
9300  "Sailors and marine oilers (53-5011)"
9310  "Ship and boat captains and operators (53-5020)"
9330  "Ship engineers (53-5031)"
9340  "Bridge and lock tenders (53-6011)"
9350  "Parking lot attendants (53-6021)"
9360  "Service station attendants (53-6031)"
9410  "Transportation inspectors (53-6051)"
9420  "Other transportation workers (53-60XX)"
9500  "Conveyor operators and tenders (53-7011)"
9510  "Crane and tower operators (53-7021)"
9520  "Dredge, excavating, and loading machine operators (53-7030)"
9560  "Hoist and winch operators (53-7041)"
9600  "Industrial truck and tractor operators (53-7051)"
9610  "Cleaners of vehicles and equipment (53-7061)"
9620  "Laborers and freight, stock, and material movers, hand (53-7062)"
9630  "Machine feeders and offbearers (53-7063)"
9640  "Packers and packagers, hand (53-7064)"
9650  "Pumping station operators (53-7070)"
9720  "Refuse and recyclable material collectors (53-7081)"
9730  "Shuttle car operators (53-7111)"
9740  "Tank car, truck, and ship loaders (53-7121)"
9750  "Material moving workers, all other (53-7199)"
9840  "Persons whose current labor force status is unemployed and last job was Armed Forces"
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
EMAX 154 - 162
EMOONLIT 163 - 171
EMRTJNT 172 - 180
EMRTOWN 181 - 189
EMS 190 - 198
EORIGIN 199 - 207
EPDJBTHN 208 - 216
EPNSPOUS 217 - 225
EPPINTVW 226 - 234
EPPPNUM 235 - 243
EPTRESN 244 - 252
EPTWRK 253 - 261
ER04 262 - 270
ER05 271 - 279
ER06 280 - 288
ERACE 289 - 297
ERSEND1 298 - 306
ERSEND2 307 - 315
ERSNOWRK 316 - 324
ESEX 325 - 333
ESFNP 334 - 342
ESTLEMP1 343 - 351
ESTLEMP2 352 - 360
ETENURE 361 - 369
EUECTYP5 370 - 378
RFID 379 - 387
RFNKIDS 388 - 396
RGED 397 - 405
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
T06AMT 640 - 648
T10AMT 649 - 657
T15AMT 658 - 666
TAGE 667 - 675
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
str13 SSUID 882 - 894

using "wave1.asc"
;

label variable EABRE "LF: Main reason for being absent without pay";
label variable EAWOP "LF: Had full-week unpaid absences from work";
label variable ECNTRC1 "JB: Coverage by union or something like a union contract";
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
label variable EMAX "LF: Number of weeks in the reference period";
label variable EMOONLIT "LF: Income from additional work";
label variable EMRTJNT "AS: Mortgage owned jointly with spouse";
label variable EMRTOWN "AS: Mortgages held in own name";
label variable EMS "PE: Marital status";
label variable EORIGIN "PE: Spanish, Hispanic or Latino";
label variable EPDJBTHN "LF: Paid job during the reference period";
label variable EPNSPOUS "PE: Person number of spouse";
label variable EPPINTVW "PE: Person''s interview status";
label variable EPPPNUM "PE: Person number";
label variable EPTRESN "LF: Main reason for working less than 35 hours";
label variable EPTWRK "LF: Worked less than 35 hours some weeks";
label variable ER04 "GI: Receipt of State SSI (ISS Code 4)";
label variable ER05 "GI: Receipt of State Unemployment Comp. (ISS Code 5)";
label variable ER06 "GI: Receipt of Supplemental Unemployment Benefits";
label variable ERACE "PE: The race(s) the respondent is";
label variable ERSEND1 "JB: Main reason stopped working for employer";
label variable ERSEND2 "JB: Main reason stopped working for employer";
label variable ERSNOWRK "LF: Main reason for not having a job during the reference period";
label variable ESEX "PE: Sex of this person";
label variable ESFNP "SF: Number of persons in this related subfamily";
label variable ESTLEMP1 "JB: Still working for this employer";
label variable ESTLEMP2 "JB: Still working for this employer";
label variable ETENURE "HH: Ownership status of living quarters";
label variable EUECTYP5 "GI: Receipt of State unemployment comp. (ISS Code 5)";
label variable RFID "FA: Family ID Number for this month";
label variable RFNKIDS "FA: Total number of children under 18 in family";
label variable RGED "ED: Completed high school by GED or equivalency";
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
label variable T06AMT "GI: Amount of Supplemental Unemployment Benefits";
label variable T10AMT "GI: Amount of workers'' compensation (ISS Code 10)";
label variable T15AMT "GI: Amount of severance pay (ISS Code 15)";
label variable TAGE "PE: Age as of last birthday";
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
label variable TPMSUM2 "JB: Earnings from job received in this month";
label variable TPTOTINC "PE: Total person''s income for the reference month";
label variable TPYRATE1 "JB: Regular hourly pay rate";
label variable TPYRATE2 "JB: Regular hourly pay rate";
label variable TSJDATE1 "JB: Starting date of job";
label variable TSJDATE2 "JB: Starting date of job";
label variable TSTOTINC "SF: Total related subfamily income for this month";
label variable WHFNWGT "WW: Household weight";
label variable WPFINWGT "WW: Person weight";
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
label values EMAX FM17X;
label values EMOONLIT FM18X;
label values EMRTJNT FM19X;
label values EMRTOWN FM20X;
label values EMS FM21X;
label values EORIGIN FM22X;
label values EPDJBTHN FM23X;
label values EPNSPOUS FM24X;
label values EPPINTVW FM25X;
label values EPTRESN FM27X;
label values EPTWRK FM28X;
label values ER04 FM29X;
label values ER05 FM30X;
label values ER06 FM31X;
label values ERACE FM32X;
label values ERSEND1 FM33X;
label values ERSEND2 FM34X;
label values ERSNOWRK FM35X;
label values ESEX FM36X;
label values ESFNP FM37X;
label values ESTLEMP1 FM38X;
label values ESTLEMP2 FM39X;
label values ETENURE FM40X;
label values EUECTYP5 FM41X;
label values RGED FM44X;
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
label values T06AMT FM71X;
label values T10AMT FM72X;
label values T15AMT FM73X;
label values TAGE FM74X;
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

save "wave1",
replace;

describe;

