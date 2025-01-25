**Hasard statistics data
**Australia
**source: OECD

cd "D:\My Documents\Data Study\PowerBI\Hasard Statistics Data-Australia"
//import datasets
/*stat1 dataset*/
import excel "D:\My Documents\Data Study\Dataset\OECD\Climate hasard statistics.xlsx", sheet("hazard-stat") firstrow
/*stat2 dataset*/
import excel "D:\My Documents\Data Study\Dataset\OECD\Climate hasard statistics.xlsx", sheet("hazard-stat-2") firstrow
/*stat3 dataset*/
import excel "D:\My Documents\Data Study\Dataset\OECD\Climate hasard statistics.xlsx", sheet("hazard-stat-3") firstrow

//assign labels to variables
foreach var of varlist _all {
   local x = `var'[1]
   label var `var' "`x'"
   }
drop if [_n]==1
foreach var of varlist _all {
   cap destring `var', replace
   }

//reshape to long   
gen id=_n
reshape long y, i(id) j(no)
label var no "Year"
sort id no
drop id

//stat1
gen id2=_n
gen id3=.

replace id3=1 if measure=="Land exposure to river flooding"
replace id3=2 if measure=="Land exposure to coastal flooding"
replace id3=3 if measure=="Cropland exposure to coastal flooding"
replace id3=4 if measure=="Built-up area exposure to river flooding"
replace id3=5 if measure=="Built-up area exposure to coastal flooding"

reshape wide y, i( id2 ) j(id3)
sort id2
replace y2 = y2[_n+256] if id2<=128
replace y3 = y3[_n+512] if id2<=128
replace y4 = y4[_n+128] if id2<=128
replace y5 = y5[_n+384] if id2<=128
drop if id2>128

label var y1 "Land exposure to river flooding"
label var y2 "Land exposure to coastal flooding"
label var y3 "Cropland exposure to coastal flooding"
label var y4 "Built-up area exposure to river flooding"
label var y5 "Built-up area exposure to coastal flooding"
drop measure id2

//stat2
drop measure
label var y "Mean population exposure to heat stress"

//stat3
gen id2=_n
gen id3=.

replace id3=1 if measure=="Built-up area exposure to wildfires"
replace id3=2 if measure=="Cooling degree days"
replace id3=3 if measure=="Cropland area exposure to wildfires"
replace id3=4 if measure=="Forest exposure to wildfires"
replace id3=5 if measure=="Heating degree days"
replace id3=6 if measure=="Land exposure to wildfires (%)"
replace id3=7 if measure=="Land exposure to wildfires (sqm)"
replace id3=8 if measure=="Population exposure to wildfires"

reshape wide y, i( id2 ) j(id3)
sort id2
replace y1 = y1[_n+200] if id2<=40
replace y3 = y3[_n+240] if id2<=40
replace y4 = y4[_n+280] if id2<=40
replace y5 = y5[_n+40] if id2<=40
replace y6 = y6[_n+160] if id2<=40
replace y6 = y6[_n+160] if id2<=40
replace y7 = y7[_n+120] if id2<=40
replace y8 = y8[_n+80] if id2<=40
drop if id2>40

label var y1 "Built-up area exposure to wildfires"
label var y2 "Cooling degree days"
label var y3 "Cropland area exposure to wildfires"
label var y4 "Forest exposure to wildfires"
label var y5 "Heating degree days"
label var y6 "Land exposure to wildfires (%)"
label var y7 "Land exposure to wildfires (sqm)"
label var y8 "Population exposure to wildfires"
drop measure id2

**Generated datasets:
use stat1 /*measures with return periods*/
use stat2 /*measures with heat threshold*/
use stat3 /*other measures without threshold/return period*/
