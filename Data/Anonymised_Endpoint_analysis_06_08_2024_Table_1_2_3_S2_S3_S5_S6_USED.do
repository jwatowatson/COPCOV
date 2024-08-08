cd "E:\D_original\COPCOV data cleaning\Final datsets\Datasets\COPCOV_Final_datasets\COPCOV_GitHub_04_11_2023\Anonymised_COPCOV_files_06_08_2024\Anonymised_COPCOV_files_06_08_2024"


set more off
******************************************************************************
* This file was created by Prof Mavuto Mukaka  for COPCOV Endpoint Analysis  *
*                                                                            *
* This do-file imports baseline and endpoint COPCOV dataset                  *
* Summarizes baseline Table1 Table 2, Table 3, Table S2, Table S3 ,          *
* Table S5 and Table S6                                                      *
******************************************************************************

*  Download the following datasets from the Github
*
* 1. Anonymised_COPCOV_Baseline_endpoint_02112023
* 2. Anonymised_days_of_follow_up
* 3. Anonymised_workdaysloss_02112023
* 4. Anonymised_Adverse_events_02112023
* 5. Anonymised_SAE_02112023.xlsx
* 6. Anonymised_PP_set_02112023

* Change the path/directory in line 1 above to specify your folder containing the downloaded files
* install the following user-written commands:
* ssc install table1_mc
* ssc install fre
* Select the whole code and execute all.
* This is report Table1 Table 2, Table 3, Table S2, Table S3 , Table S5 and Table S6
*
*******************************************************************************
**#   Table 1: Demographic details of the COPCOV study participants.        *
*******************************************************************************

use Anonymised_COPCOV_Baseline_endpoint_02112023,clear
*br

label var age_calyr "Age years, median (IQR)"
label var sex "Sex, n (%)"
label var tempc "Temperature ⁰C, mean (SD)"
label var weight "Weight, mean (SD)"
label var height "Height, mean (SD)"
label var bmi "BMI(kg/m2), median (IQR)"
label var smoking "Smoking, n (%)"
label var epi_househ "COVID-19 in Household, n/N (%)"
label var mh_yn "Existing comorbidities"
label var mh_cpd "Chronic pulmonary disease (not asthma), n/N (%)"
label var mh_ast "Asthma (physician diagnosed), n/N (%)"
label var mh_ckd "Chronic kidney disease, n/N (%)"
label var mh_liv "Liver disease, n/N (%)"
label var mh_hiv "AIDS/HIV, n/N (%)"
label var mh_diab "Diabetes, n/N (%)"
label var mh_hyp "Hypertension, n/N (%)"
label var mh_canc "Cancer, n/N (%)"
label var mh_immun "Condition requiring immunosuppressive drugs, n/N (%)"
label var mh_isch "Ischaemic heart disease, n/N (%)"
label var mh_hchol "High cholesterol, n/N (%)"
label var anychronic "Any chronic condition, n (%)"
label var symptoms_yn "Baseline symptoms"
label var fever "Fever, n (%)"
label var cough "Cough, n (%)"
label var sorethroat "Sore throat, n (%)"
label var runnynose "Runny nose (Rhinorrhoea), n (%)"
label var wheezing "Wheezing, n (%)"
label var anosmia "Anosmia, n (%)"
label var chestpain "Chest pain, n (%)"
label var musclepain "Muscle pain (myalgia), n (%)"
label var jointpain "Joint pain (Arthralgia), n (%)"
label var shortbreath1 "Shortness of breath on exertion, n (%)"
label var shortbreath2 "Shortness of breath at rest, n (%)"
label var fatigue "Fatigue/malaise, n (%)"
label var itching "Itching, n (%)"
label var headache "Headache, n (%)"
label var dizzy "Dizziness, n (%)"
label var visualdisturb "Visual disturbance, n (%)"
label var abdopain "Abdominal pain, n (%)"
label var appetite "Poor appetite, n (%)"
label var nausea "Nausea, n (%)"
label var vomit "Vomiting, n (%)"
label var diarrhoea "Dhiarrhoea, n (%)"
label var skinrash "Skin rash, n (%)"



table1_mc, by(treatment) ///
vars(age_calyr conts %5.0fc \ sex cat %5.2fc \  ///
tempc contn %5.1fc \ ///
weight contn %5.1fc \ height contn %5.0fc \ ///
bmi conts %5.1fc \ ///
smoking cat %5.2fc \ ///
epi_househ bin %5.2fc \ ///
mh_yn bin %5.2fc \ ///
mh_cpd bin %5.2fc \ mh_ast bin %5.2fc \ ///
mh_ckd bin %5.0fc \ mh_liv bin %5.2fc \ ///
mh_hiv bin %5.2fc \ mh_diab bin %5.2fc \ ///
mh_hyp bin %5.2fc \ mh_canc bin %5.2fc \ ///
mh_immun bin %5.2fc \ mh_isch bin %5.2fc \ ///
mh_hchol bin %5.2fc \ anychronic bin %5.2fc \ ///
symptoms_yn bin %5.2fc \ ///
fever bin %5.0fc \ cough bin %5.2fc \ ///
sorethroat bin %5.2fc \ runnynose bin %5.2fc \ ///
wheezing bin %5.2fc \ anosmia bin %5.0fc \ ///
chestpain bin %5.2fc \ musclepain bin %5.2fc \ ///
jointpain bin %5.2fc \ shortbreath1 bin %5.2fc \ ///
shortbreath2 bin %5.0fc \ fatigue bin %5.2fc \ ///
itching bin %5.2fc \ headache bin %5.2fc \ ///
dizzy bin %5.2fc \ visualdisturb bin %5.2fc \ ///
abdopain bin %5.2fc \ appetite bin %5.2fc \ ///
nausea bin %5.2fc \ vomit bin %5.2fc \ ///
diarrhoea bin %5.2fc \ skinrash bin %5.2fc) total(after) ///
onecol nospace percsign("") ///
saving("Baseline_COPCOV_CQHCQvsPlacebo_Raw_Output.xlsx", replace) clear
*onecol nospace percsign("") to omit denominators OR onecol nospace slashN percsign("") to include

  ** Formatting Excel Output
putexcel set Table_1_Baseline_COPCOV_CQHCQvsPlacebo_Formatted_Output.xlsx, replace

putexcel (A1:B1)="Table 1 Demographic details of the COPCOV study participants.", bold merge font(calibri, 12, blue)
putexcel (C1:D1)="Results last updated:`c(current_date)'", merge right italic font(calibri,10,red) //ehour.pkg for ce=current date
putexcel (A2:A3), merge hcenter bold
putexcel (A2:A3)="Characteristics", hcenter bold
putexcel (B2:B3), hcenter bold
putexcel (C2:C3), hcenter bold
putexcel (D2:D3), hcenter bold


** i =row indicator from stata, j=row indicator from excel
foreach i of numlist 1 (1) 55 {
local j=`i'+1
putexcel A`j'=factor[`i']
putexcel B`j'=treatment_1[`i'] C`j'=treatment_0[`i'] D`j'=treatment_T[`i'] , hcenter
}

putexcel B18=""
putexcel C18=""
putexcel D18=""

putexcel B31=""
putexcel C31=""
putexcel D31=""

putexcel (A1:D1), border(bottom)
putexcel (B2:D2), border(bottom)
putexcel (A3:D3), border(bottom)
putexcel (A53:D53), border(bottom)
********************************************************************************
********************************************************************************






************************************************************************************************
**#  Table 2: Pre-specified endpoints of the COPCOV trial in the intention to treat population.*
************************************************************************************************

use Anonymised_COPCOV_Baseline_endpoint_02112023,clear
*br


******************************************************
* All-cause Respiratory illness analysis    Table 2  *
******************************************************
tab respiratoryill
gen respiratoryill_num=.
replace respiratoryill_num=1 if respiratoryill=="POS"
replace respiratoryill_num=1 if PCR=="PCR" &  respiratoryill_num==.

replace respiratoryill_num=0 if respiratoryill_num==.


*br subject treatment respiratoryill_num respiratoryill PCR covid19_final  if respiratoryill_num==1

tab  respiratoryill_num 
duplicates list if respiratoryill_num==1


tab  treatment respiratoryill_num, exact chi2 row 


*br subject respiratoryill_num PCR covid19_final if respiratoryill_num==. & treatment==.

 ci proportions respiratoryill_num if treatment==1
 ci proportions respiratoryill_num if treatment==0

binreg respiratoryill_num treatment if  covid19_final!=., rr
 


*********************************
*     Analysis of Endpoints     *
*********************************


**************************************************************
* Primary endpoint - Symptomatic covid19   ITT  Table 2      *
**************************************************************

 gen symptomatic_covid=covid19_final            
 replace symptomatic_covid=0 if symptomatic==0 & covid19_final!=.
 replace  symptomatic_covid=0 if covid19_final==.
 
 tab  symptomatic_covid
 tab  treatment symptomatic_covid, exact chi2 row
 tab treatment
 tab treatment, nolab
 ci proportions symptomatic_covid if treatment==1
 ci proportions symptomatic_covid if treatment==0
 
 binreg symptomatic_covid treatment, rr

 
 
************************************************************
* PCR endpoint   Symptomatic Covid19     ITT Table 2       *
************************************************************ 
 tab symptomatic PCRcovid 

 tab  treatment PCRcovid, exact chi2 row
 tab  treatment
 tab  treatment, nolab
 ci   proportions PCRcovid if treatment==1
 ci   proportions PCRcovid if treatment==0
 binreg PCRcovid treatment, rr
 
 
*****************************************************************
* Symptomatic Covid19  -  Serology (Serum) endpoint ITT Table 2 *
*****************************************************************

 tab symptomatic Serumcovid 

 gen  symptomatic_Serumcovid=Serumcovid if symptomatic==1 
 replace symptomatic_Serumcovid=0 if symptomatic_Serumcovid==. & type_data=="serum"
 replace symptomatic_Serumcovid=0 if outcome=="NA"
 
 tab symptomatic_Serumcovid type_data
 *br subjectno PCR_Res PCR symptomatic_Serumcovid outcome_possible outcome type_data if treatment==1 & type_data=="serum" & symptomatic_Serumcovid==1
 *br subjectno PCR_Res PCR symptomatic_Serumcovid outcome_possible outcome type_data if treatment==0 & type_data=="serum" & symptomatic_Serumcovid==1
  
 tab treatment symptomatic_Serumcovid, chi2 exact row, if type_data=="serum"
 

 ci proportions symptomatic_Serumcovid  if treatment==1 & type_data=="serum"
 ci proportions symptomatic_Serumcovid  if treatment==0 & type_data=="serum"
 binreg symptomatic_Serumcovid treatment if type_data=="serum", rr
  
  

**************************************************************
* Symptomatic Covid19 - Serology (dbs) endpoint  ITT Table 2 *
**************************************************************

 tab symptomatic DBScovid 

 gen symptomatic_DBScovid=DBScovid if symptomatic==1
 replace symptomatic_DBScovid=0 if symptomatic_DBScovid==. & type_data=="DBS"
 replace symptomatic_DBScovid=0 if outcome=="NA"
  
 tab symptomatic_DBScovid type_data
 *br subjectno PCR_Res PCR symptomatic_DBScovid outcome_possible outcome type_data if treatment==1 & type_data=="DBS" & symptomatic_DBScovid==1
 *br subjectno PCR_Res PCR symptomatic_DBScovid outcome_possible outcome  type_data if treatment==0 & type_data=="DBS" & symptomatic_DBScovid==1
  
 tab treatment  symptomatic_DBScovid, chi2 exact row, if type_data=="DBS"
 
 ci  proportions symptomatic_DBScovid  if treatment==1 & type_data=="DBS"
 ci  proportions symptomatic_DBScovid  if treatment==0 & type_data=="DBS"
 binreg symptomatic_DBScovid treatment if type_data=="DBS", rr
 
 
****************************************************
* Asymptomatic Covid19   ITT   Table 2             *
**************************************************** 
 gen asymptomatic_covid=covid19_final            
 replace asymptomatic_covid=0 if symptomatic==1 & covid19_final!=.
 replace asymptomatic_covid=0 if covid19_final==.
 tab treatment asymptomatic_covid, exact chi2 row
 ci proportions asymptomatic_covid if treatment==1
 ci proportions asymptomatic_covid if treatment==0
 binreg asymptomatic_covid treatment, rr
 
 
 
*****************************************
* All SARS-CoV-2 infection   ITT Table 2*
*****************************************
gen all_sars=.
replace all_sars=covid19_final
replace all_sars=0 if all_sars==.
 
tab  treatment all_sars, exact chi2 row
ci proportions all_sars if treatment==1
ci proportions all_sars if treatment==0
binreg all_sars treatment, rr 
 
save data_copcov_table2, replace // This dataset is useful for automating output from regression models


  
  
********************************************************************************
**#                          OUTPUT:  Excel  for  Table 2                      *
********************************************************************************
* Set Excel table
putexcel set Table_2_COPCOV_Endpoint_analysis_Output.xlsx, sheet("Table2",replace) modify

putexcel A1="Table 2 Pre-specified endpoints of the COPCOV trial in the intention to treat population",vcenter bold font(calibri, 11, black)
putexcel (C2:D2)="Results last updated:`c(current_date)'", merge right italic font(calibri,10,red) //ehour.pkg for ce=current date
putexcel A3="Outcome", hcenter bold
putexcel B3="Chloroquine/Hydroxychloroquine (N= 2,320)", hcenter bold 
putexcel C3="Placebo (N= 2,332)", hcenter bold
putexcel D3="Risk ratio (95%CI)", hcenter bold
putexcel E3="Fisher's exact P-value", hcenter bold

putexcel A4="Total participant days", left
putexcel A5="Symptomatic COVID-19. n(%); 95%CI", left 
putexcel A6="PCR-confirmed diagnosis. n/N (%); 95%CI", left 
putexcel A7="Serology confirmed diagnosis (serum). n (%); 95%CI", left 
putexcel A8="Serology confirmed diagnosis (DBS). n (%); 95%CI", left 
putexcel A9="Asymptomatic SARS-CoV-2 infection. n (%); 95%CI", left 
putexcel A10="All SARS-CoV-2 infection n(%); 95%CI", left 
putexcel A11="All-cause respiratory illness*. n(%); 95%CI", left 
putexcel A12="Severity score. Median (IQR)", left 
putexcel A13="Participant work days loss n days/total follow-up days", left 


* Format border
putexcel (A3:E13), border(all)
*******************************

* Total participant days 
use "Anonymised_workdaysloss_02112023" ,clear

tab workprob treatment

local day1="181,263"      //total follow-up days -CQHCQ
local day2="184,688"      //total follow-up days -Placebo  
putexcel B4= "`day1'", hcenter 
putexcel C4= "`day2'", hcenter 


* Symptomatic COVID-19. n(%); 95%CI Table 2
use data_copcov_table2,clear  
*br 

tab treatment symptomatic_covid, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions symptomatic_covid if treatment==1 //95%CI - //CQHCQ  Table 2
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions symptomatic_covid if treatment==0 //95%CI -Placebo Table 2
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B5= "`result1'", hcenter 	
putexcel C5= "`result2'", hcenter 
  
binreg symptomatic_covid treatment, rr //Risk ratio Table 2
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D5= "`riskratio'", hcenter 

tab treatment symptomatic_covid, chi exact //P-value Table 2
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")
putexcel E5= "`pvalue'", hcenter 	



* PCR-confirmed diagnosis. n/N (%); 95%CI Table 2
tab treatment PCRcovid, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 


ci proportions PCRcovid if treatment==1 //95%CI - CQHCQ Table 2
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions PCRcovid if treatment==0 //95%CI -Placebo Table 2
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B6= "`result1'", hcenter 	
putexcel C6= "`result2'", hcenter 
 
 
binreg PCRcovid treatment, rr //Risk ratio Table 2
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D6= "`riskratio'", hcenter 	
 	
tab treatment PCRcovid, chi exact //P-value
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")
putexcel E6= "`pvalue'", hcenter 	



* Serology confirmed diagnosis (serum). n (%); 95%CI Table 2

tab  treatment symptomatic_Serumcovid if type_data=="serum", matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 


ci proportions symptomatic_Serumcovid if treatment==1 & type_data=="serum" //95%CI - CQHCQ Table 2
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions symptomatic_Serumcovid if treatment==0 & type_data=="serum" //95%CI -Placebo Table 2
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B7= "`result1'", hcenter 	
putexcel C7= "`result2'", hcenter 
  
binreg symptomatic_Serumcovid treatment if type_data=="serum", rr //Risk ratio Table 2
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D7= "`riskratio'", hcenter 		

tab treatment symptomatic_Serumcovid if type_data=="serum", chi exact //P-value
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")
putexcel E7= "`pvalue'", hcenter 	




* Serology confirmed diagnosis (DBS). n (%); 95%CI Table 2

tab treatment symptomatic_DBScovid if type_data=="DBS", matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions symptomatic_DBScovid if treatment==1 & type_data=="DBS" //95%CI - CQHCQ Table 2
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions symptomatic_DBScovid if treatment==0 & type_data=="DBS"  //95%CI -Placebo Table 2
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B8= "`result1'", hcenter 	
putexcel C8= "`result2'", hcenter 
 
 
binreg symptomatic_DBScovid treatment if type_data=="DBS" , rr //Risk ratio Table 2
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D8= "`riskratio'", hcenter 

tab treatment symptomatic_DBScovid if type_data=="DBS", chi exact //P-value Table 2
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")	
putexcel E8= "`pvalue'", hcenter 	



* Asymptomatic SARS-CoV-2 infection. n (%); 95%CI Table 2

tab treatment asymptomatic_covid, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions asymptomatic_covid if treatment==1 //95%CI - CQHCQ Table 2
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions asymptomatic_covid if treatment==0 //95%CI -Placebo Table 2
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B9= "`result1'", hcenter 	
putexcel C9= "`result2'", hcenter 
 
 
binreg asymptomatic_covid treatment, rr //Risk ratio //Risk ratio Table 2
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D9= "`riskratio'", hcenter 	

tab treatment asymptomatic_covid, chi exact //P-value Table 2
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")
putexcel E9= "`pvalue'", hcenter 



* All SARS-CoV-2 infection n(%); 95%CI Table 2

tab treatment all_sars, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions all_sars if treatment==1 //95%CI - CQHCQ Table 2
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions all_sars if treatment==0 //95%CI -Placebo Table 2
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B10= "`result1'", hcenter 	
putexcel C10= "`result2'", hcenter 
 
 
binreg all_sars treatment, rr //Risk ratio Table 2
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D10= "`riskratio'", hcenter 	

tab treatment all_sars, chi exact //P-value Table 2
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")
putexcel E10= "`pvalue'", hcenter 




* All-cause Respiratory illness analysis Table 2

tab treatment respiratoryill_num, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 


ci proportions respiratoryill_num if treatment==1 //95%CI - CQHCQ Table 2
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions respiratoryill_num if treatment==0 //95%CI -Placebo -Table 2
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B11= "`result1'", hcenter 	
putexcel C11= "`result2'", hcenter 
 
 
binreg respiratoryill_num treatment, rr //Risk ratio -Table 2
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local table41=r(table)[4,1]
local pvalue=string(`table41',"%9.3f")
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D11= "`riskratio'", hcenter 	

tab treatment respiratoryill_num, chi exact //P-value Table 2
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")
putexcel E11= "`pvalue'", hcenter 



* Severity score. Median (IQR)
putexcel B12="20.0 (5-85)", hcenter  //Calculated in R code, check
putexcel C12="21.5 (5-89)", hcenter  //Calculated in R code, check
putexcel D12="NA", hcenter            
putexcel E12="1.000", hcenter 


* Participant work days loss n days/total follow-up days
* Total participant days 
* Work loss analysis  
use "Anonymised_days_of_follow_up",clear
 
egen Fu_daysTot=sum(Fu_days),by(treatment)
label var Fu_daysTot "Total follow up days by arm" 
 
tabstat Fu_daysTot, stats( min max) by(treatment)
  
  
  
  
use "Anonymised_workdaysloss_02112023" ,clear

tab workprob treatment

prtesti 181263 700 184688 932, count
  
local num1="700"         //total work loss days -CQHCQ
local num2="932"         //total work loss days -Placebo
local day1="181,263"     //total follow-up days -CQHCQ
local day2="184,688"     //total follow-up days -Placebo
local pval="0.0002**"    //P-value

putexcel B13="`num1'/`day1'", hcenter   //CQHCQ
putexcel C13="`num2'/`day2'", hcenter   //Placebo
putexcel D13="NA" , hcenter             //Risk ratio (95%CI)

putexcel E13="`pval'" , hcenter         //Fisher's exact P-value
********************************************************************************
********************************************************************************



********************************************************************************
**#  Table 3: Safety and tolerability of the COPCOV study medications.         *
********************************************************************************

**************************
*   AE-Adverse Event     *
**************************

use "Anonymised_Adverse_events_02112023", clear // AE-Adverse Event
*br
count // 1239
rename Label subjectno
codebook subjectno //460
sort subjectno

* Merge Treatment arm from baseline
merge m:1 subjectno using "Anonymised_COPCOV_Baseline_endpoint_02112023.dta",keepusing(treatment) 
keep if _merge==3
*drop if _merge==2
*drop if _merge==1
drop _merge
codebook subjectno //460

*br subjectno ae_term ae_stdat ae_endat ae_sev ae_outc treatment ae_yn
keep subjectno ae_term ae_stdat ae_endat ae_sev ae_outc treatment ae_yn
export excel using "All_AE_03_11_2023.xlsx", firstrow(var) replace


* Number of subjects with at least one AE, n (%)
codebook subjectno if treatment==1 	//Hydroxychloroquine -218
codebook subjectno if treatment==0 	//Placebo -242

egen tag_aeid=tag(subjectno) if ae_yn!=.
tab tag_aeid,m
tab tag_aeid treatment   

* Events, nE (%)                                                     
tab ae_sev treatment if ae_sev!=1 //Total adverse events -OUTPUT**


* Symptoms
tab ae_term treatment,col  //OUTPUT** 


 foreach num of numlist 1(1)10 99 {   //Gen each symptoms for output excel
     gen ae`num'= 1 if ae_term==`num'
	 replace ae`num'=0 if ae`num'==.
  }

label variable ae1 "Itching"
label variable ae2 "Headache"
label variable ae3 "Dizziness"
label variable ae4 "Visual disturbance"
label variable ae5 "Abdominal pain"
label variable ae6 "Poor appetite"
label variable ae7 "Nausea"
label variable ae8 "Vomiting"
label variable ae9 "Diarrhoea"
label variable ae10 "Skin rash"
label variable ae99 "Other"
tab1 ae*


* Grading of adverse events Symptoms
fre ae_sev 
 
tab ae_term treatment if ae_sev==2              // Moderate grade 2
tab ae_term treatment if ae_sev==3 | ae_sev==4  // Moderate grade 3-4


save data_copcov_tableS3_AEs, replace
********************************************************************************


********************************************************************************
**#                    OUTPUT:  Excel  for  Table 3                            *
********************************************************************************

* Set Excel table
putexcel set Table_3_COPCOV_AEs_SAEs_analysis_Output.xlsx, sheet("Table3",replace) modify

putexcel A1="Table 3 Safety and tolerability of the COPCOV study medications.",vcenter bold font(calibri, 11, black)
putexcel (D2:F2)="Results last updated:`c(current_date)'", merge right italic font(calibri,10,red) //ehour.pkg for ce=current 
putexcel A3="Adverse events", hcenter bold
putexcel (B3:C3)="Chloroquine/Hydroxychloroquine", merge hcenter bold
putexcel (D3:E3)="Placebo", merge hcenter bold
putexcel F3="Fisher's exact P-value", hcenter bold

putexcel A4="Number of subjects", left
putexcel A5="Total participant days ", left
putexcel A6="Number of subjects with at least one AE, n (%)", left
putexcel A7="Total adverse events, nE (%)", left
putexcel A8="Participants with at least one Serious Adverse Event (SAE), n (%):", left
putexcel A9="Total events,nE (%):", left
putexcel A10="Deaths, n/N, (%)", left
putexcel A11="Possible, probable or definite drug related SAEs, n/N, (%)", left

putexcel A12="Grading of adverse events, nE/N, (%)", vcenter hcenter bold  
putexcel B12="Moderate (grade 2) N=2,320", vcenter hcenter bold txtwrap 
putexcel C12="Severe (grade 3) N=2,320", vcenter hcenter bold txtwrap 
putexcel D12="Moderate (grade 2) N=2,332", vcenter hcenter bold txtwrap 
putexcel E12="Severe (grade 3) N=2,332", vcenter hcenter bold txtwrap 
putexcel F12="P value for total severe AEs between groups", vcenter hcenter  bold txtwrap 

putexcel A13="	Symptoms", hcenter 
putexcel A14="Number of adverse events**", hcenter 


* Number of subjects
putexcel (B4:C4) = "N=2,320" , merge hcenter
putexcel (D4:E4) = "N=2,332" , merge hcenter



* Total participant days 
use "Anonymised_days_of_follow_up",clear
rename label  subjectno
sort subjectno
 
egen Fu_daysTot=sum(Fu_days),by(treatment)
label var Fu_daysTot "Total follow up days by arm" 
 
tabstat Fu_daysTot, stats( min max) by(treatment)
  
local day1="181,263"      //total follow-up days -CQHCQ
local day2="184,688"      //total follow-up days -Placebo

putexcel (B5:C5)="`day1'", merge hcenter   //CQHCQ
putexcel (D5:E5)="`day2'",merge hcenter    //Placebo



* Number of subjects with at least one AE, n (%)
use data_copcov_tableS3_AEs,clear  
*br 

tab tag_aeid treatment, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local p1=string((`x1'/2320*100),"%9.2f")
putexcel (B6:C6)="`x1' (`p1')", merge hcenter   //CQHCQ

local x2=freq[2,1] //Placebo
local p2=string((`x2'/2332*100),"%9.2f")
putexcel (D6:E6)="`x2' (`p2')",merge hcenter    //Placebo

prtesti 2320 218 2332 242, count //P-value
return list
local exact= r(p)
local pvalue=string(`exact',"%9.2f")  	
putexcel F6="`pvalue'", hcenter 	


* Total adverse events, nE (%)
tab ae_sev treatment if ae_sev!=1, matcell(freq) matrow(names) 
matrix list freq
local t1=freq[1,2] + freq[2,2] //CQHCQ
local p1=string((`t1'/2320*100),"%9.2f")

local t2=freq[1,1] + freq[2,1] //Placebo
local p2=string((`t2'/2332*100),"%9.2f")

putexcel (B7:C7)="`t1' (`p1')", merge hcenter   //CQHCQ
putexcel (D7:E7)="`t2' (`p2')",merge hcenter    //Placebo



* Grading of adverse events, nE/N, (%)
use data_copcov_tableS3_AEs,clear 

* Number of adverse events**
sum ae_term if treatment==1 & ae_sev==2 //CQHCQ - Moderate (grade 2)
return list
local n1=r(N) //CQHCQ
local p1=string((`n1'/2320*100),"%9.2f")
putexcel B14="`n1' (`p1')", hcenter   

sum ae_term if treatment==0  & ae_sev==2 //Placebo - Moderate (grade 2)
return list
local n2=r(N) //CQHCQ
local p2=string((`n2'/2332*100),"%9.2f")
putexcel D14="`n2' (`p2')", hcenter   

sum ae_term if treatment==1 & ae_sev==3 | ae_sev==4 //CQHCQ - Severe (grade 3)
return list
local n3=r(N) //CQHCQ
local p3=string((`n3'/2320*100),"%9.2f")
putexcel C14="`n3' (`p3')", hcenter   

sum ae_term if treatment==0  & ae_sev==3 | ae_sev==4 //Placebo - Severe (grade 3)
return list
local n4=r(N) //CQHCQ
local p4=string((`n4'/2332*100),"%9.2f")
putexcel E14="`n4' (`p4')", hcenter  

prtesti 2320 0.013 2332 0.025 //P-value -Proportion test

tabi 2289 31 \ 2274 58  //P-value-Fisher's exact
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")  	
putexcel F14="`pvalue'", hcenter 	


** Moderate 
use data_copcov_tableS3_AEs,clear

table1_mc if ae_sev==2  , by(treatment) ///
vars(ae1 bin %5.2fc \ ae2 bin %5.2fc \  ae3 bin %5.2fc \ ///
ae4 bin %5.2fc \ ae5 bin %5.2fc \  ae6 bin %5.2fc \ ///
ae7 bin %5.2fc \ ae8 bin %5.2fc \  ae9 bin %5.2fc \ ///
ae10 bin %5.2fc \ ae99 bin %5.2fc) total(after) ///
onecol nospace percsign("") ///
saving("COPCOV_CQHCQvsPlacebo_Moderate_AEs.dta", replace) clear

 * Revised Total N [n/2320  ,  n/2332]
keep factor _columna_0 _columna_1 _columna_T
gen placebo=_columna_0 if _columna_0!="Placebo"
gen CQHCQ=_columna_1 if _columna_1!="Chloroquine/Hydroxychloroquine"
destring placebo CQHCQ, replace

gen p_CQHCQ = string(CQHCQ/2320*100, "%5.2f") 
gen p_placebo =string(placebo/2332*100, "%5.2f")

tostring placebo CQHCQ, replace

gen treatment_1 = CQHCQ + "" + "(" + p_CQHCQ +")" 
gen treatment_0 = placebo + "" + "(" + p_placebo +")" 
replace treatment_1 ="" in 2
replace treatment_0 ="" in 2
replace treatment_1 ="Chloroquine/Hydroxychloroquine" in 1
replace treatment_0 ="Placebo" in 1


** i=row indicator from stata, j=row indicator from excel
foreach i of numlist 3 (1) 26 {
local j=`i'+12
putexcel A`j'=factor[`i'], left
putexcel B`j'=treatment_1[`i']  D`j'=treatment_0[`i'], hcenter
}


** Severe 
use data_copcov_tableS3_AEs,clear
 
table1_mc if ae_sev==3 | ae_sev==4, by(treatment) ///
vars(ae1 bin %5.2fc \ ae2 bin %5.2fc \  ae3 bin %5.2fc \ ///
ae4 bin %5.2fc \ ae5 bin %5.2fc \  ae6 bin %5.2fc \ ///
ae7 bin %5.2fc \ ae8 bin %5.2fc \  ae9 bin %5.2fc \ ///
ae10 bin %5.2fc \ ae99 bin %5.2fc) total(after) ///
onecol nospace percsign("") ///
saving("COPCOV_CQHCQvsPlacebo_Severe_AEs.dta", replace) clear

* Revised Total N [n/2320  ,  n/2332]
keep factor _columna_0 _columna_1 _columna_T
gen placebo=_columna_0 if _columna_0!="Placebo"
gen CQHCQ=_columna_1 if _columna_1!="Chloroquine/Hydroxychloroquine"
destring placebo CQHCQ, replace

gen p_CQHCQ = string(CQHCQ/2320*100, "%5.2f") 
gen p_placebo =string(placebo/2332*100, "%5.2f")

tostring placebo CQHCQ, replace

gen treatment_1 = CQHCQ + "" + "(" + p_CQHCQ +")" 
gen treatment_0 = placebo + "" + "(" + p_placebo +")" 
replace treatment_1 ="" in 2
replace treatment_0 ="" in 2
replace treatment_1 ="Chloroquine/Hydroxychloroquine" in 1
replace treatment_0 ="Placebo" in 1


** i=row indicator from stata, j=row indicator from excel
foreach i of numlist 3 (1) 26 {
local j=`i'+12
putexcel A`j'=factor[`i']
putexcel C`j'=treatment_1[`i']  E`j'=treatment_0[`i'], hcenter
}
********************************************************************************



***********************************
*     SAEs from summary sheet     *
***********************************
import excel using Anonymised_SAE_02112023.xlsx, firstrow clear
*br
rename label subjectno
sort subjectno
saveold SAE_summary, replace

use Anonymised_COPCOV_Baseline_endpoint_02112023, clear
sort subjectno

capture drop _merge
merge 1:m subjectno using SAE_summary

keep if _merge==3
keep subjectno Diagnosis Relationship SAE_number SAEtype Description treatment

sort SAEtype subjectno
gen SAE_ID=_n
order subjectno SAE_ID treatment SAEtype Diagnosis Relationship SAE_number SAEtype Description
*br subjectno SAE_ID treatment Diagnosis Relationship SAE_number SAEtype Description
 

* Participants with at least one Serious Adverse Event (SAE),    n (%):
codebook subjectno if treatment==1  //CQHCQ
codebook subjectno if treatment==0  //Placebo

 
* Total events,nE (%):
tab treatment



********************************
* OUTPUT Excel SAE for Table 3
********************************
* Participants with at least one Serious Adverse Event (SAE), n (%):
egen tag_saeid=tag(subjectno)
tab tag_saeid treatment 

sum tag_saeid if treatment==1 & tag_saeid==1  	//CQHCQ
return list
local x1=r(N) 
local p1=string((`x1'/2320*100),"%9.2f")
putexcel (B8:C8)="`x1' (`p1')", merge hcenter   

sum tag_saeid if treatment==0 & tag_saeid==1	//Placebo
return list
local x2=r(N) 
local p2=string((`x2'/2332*100),"%9.2f")
putexcel (D8:E8)="`x2' (`p2')",merge hcenter  



* Total events,nE (%):
sum treatment if treatment==1   	//CQHCQ
return list
local tt1=r(N) 
local pp1=string((`tt1'/2320*100),"%9.2f")
putexcel (B9:C9)="`tt1' (`pp1')", merge hcenter   

sum treatment if treatment==0 		//Placebo
return list
local tt2=r(N) 
local pp2=string((`tt2'/2332*100),"%9.2f")
putexcel (D9:E9)="`tt2' (`pp2')",merge hcenter  


* Deaths, n/N, (%)   //No events**
putexcel (B10:C10)="0 (0)", merge hcenter   
putexcel (D10:E10)="0 (0)", merge hcenter    

  
* Possible, probable or definite drug related SAEs, n/N, (%)  //No events**
putexcel (B11:C11)="0 (0)", merge hcenter   
putexcel (D11:E11)="0 (0)", merge hcenter     
 
 
* Fomatted Border
putexcel (A3:F5), border(all)
putexcel (A7:F7), border(bottom)
putexcel (A6:F6), border(right)
putexcel (A7:F7), border(right)
putexcel (A8:F8), border(right)
putexcel (A9:F9), border(bottom)
putexcel (A9:F9), border(right)
putexcel (A10:F25), border(all)
********************************************************************************
********************************************************************************  
  
  


  
********************************************************************************
**#  Table S2: Baseline characteristics in the COPCOV trial (Per Protocol Analysis) *
********************************************************************************
  
use Anonymised_COPCOV_Baseline_endpoint_02112023,clear

merge 1:1 subjectno using Anonymised_PP_set_02112023
keep if _merge==3
drop _merge
 
count //3,323

tab treatment,m


label var age_calyr "Age years, median (IQR)"
label var sex "Sex, n (%)"
label var tempc "Temperature ⁰C, mean (SD)"
label var weight "Weight, mean (SD)"
label var height "Height, mean (SD)"
label var bmi "BMI(kg/m2), median (IQR)"
label var smoking "Smoking, n (%)"
label var epi_househ "COVID-19 in Household, n/N (%)"
label var mh_yn "Existing comorbidities"
label var mh_cpd "Chronic pulmonary disease (not asthma), n/N (%)"
label var mh_ast "Asthma (physician diagnosed), n/N (%)"
label var mh_ckd "Chronic kidney disease, n/N (%)"
label var mh_liv "Liver disease, n/N (%)"
label var mh_hiv "AIDS/HIV, n/N (%)"
label var mh_diab "Diabetes, n/N (%)"
label var mh_hyp "Hypertension, n/N (%)"
label var mh_canc "Cancer, n/N (%)"
label var mh_immun "Condition requiring immunosuppressive drugs, n/N (%)"
label var mh_isch "Ischaemic heart disease, n/N (%)"
label var mh_hchol "High cholesterol, n/N (%)"
label var anychronic "Any chronic condition, n (%)"
label var symptoms_yn "Baseline symptoms"
label var fever "Fever, n (%)"
label var cough "Cough, n (%)"
label var sorethroat "Sore throat, n (%)"
label var runnynose "Runny nose (Rhinorrhoea), n (%)"
label var wheezing "Wheezing, n (%)"
label var anosmia "Anosmia, n (%)"
label var chestpain "Chest pain, n (%)"
label var musclepain "Muscle pain (myalgia), n (%)"
label var jointpain "Joint pain (Arthralgia), n (%)"
label var shortbreath1 "Shortness of breath on exertion, n (%)"
label var shortbreath2 "Shortness of breath at rest, n (%)"
label var fatigue "Fatigue/malaise, n (%)"
label var itching "Itching, n (%)"
label var headache "Headache, n (%)"
label var dizzy "Dizziness, n (%)"
label var visualdisturb "Visual disturbance, n (%)"
label var abdopain "Abdominal pain, n (%)"
label var appetite "Poor appetite, n (%)"
label var nausea "Nausea, n (%)"
label var vomit "Vomiting, n (%)"
label var diarrhoea "Dhiarrhoea, n (%)"
label var skinrash "Skin rash, n (%)"



table1_mc, by(treatment) ///
vars(age_calyr conts %5.0fc \ sex cat %5.2fc \  ///
tempc contn %5.1fc \ ///
weight contn %5.1fc \ height contn %5.0fc \ ///
bmi conts %5.1fc \ ///
smoking cat %5.2fc \ ///
epi_househ bin %5.2fc \ ///
mh_yn bin %5.2fc \ ///
mh_cpd bin %5.2fc \ mh_ast bin %5.2fc \ ///
mh_ckd bin %5.2fc \ mh_liv bin %5.2fc \ ///
mh_hiv bin %5.2fc \ mh_diab bin %5.2fc \ ///
mh_hyp bin %5.2fc \ mh_canc bin %5.2fc \ ///
mh_immun bin %5.2fc \ mh_isch bin %5.2fc \ ///
mh_hchol bin %5.2fc \ anychronic bin %5.2fc \ ///
symptoms_yn bin %5.2fc \ ///
fever bin %5.0fc \ cough bin %5.2fc \ ///
sorethroat bin %5.2fc \ runnynose bin %5.2fc \ ///
wheezing bin %5.2fc \ anosmia bin %5.0fc \ ///
chestpain bin %5.2fc \ musclepain bin %5.2fc \ ///
jointpain bin %5.2fc \ shortbreath1 bin %5.2fc \ ///
shortbreath2 bin %5.0fc \ fatigue bin %5.2fc \ ///
itching bin %5.2fc \ headache bin %5.2fc \ ///
dizzy bin %5.2fc \ visualdisturb bin %5.2fc \ ///
abdopain bin %5.2fc \ appetite bin %5.2fc \ ///
nausea bin %5.2fc \ vomit bin %5.2fc \ ///
diarrhoea bin %5.0fc \ skinrash bin %5.2fc) total(after) ///
onecol nospace percsign("") ///
saving("Baseline_COPCOV_CQHCQvsPlacebo_PPanalysis_Raw_Output.xlsx", sheet("Output") replace)  clear
*onecol nospace percsign("") to omit denominators OR onecol nospace slashN percsign("") to include

  ** Formatting Excel Output
putexcel set Table_S2_Baseline_COPCOV_CQHCQvsPlacebo_PPanalysis_Formatted_Output.xlsx, sheet("Report") modify
putexcel (A1:B1)="Table S2 Baseline characteristics in the COPCOV trial (Per Protocol Analysis).", bold merge font(calibri, 12, blue)
putexcel (C1:D1)="Results last updated:`c(current_date)'", merge right italic font(calibri,10,red) //ehour.pkg for ce=current date
putexcel (A2:A3), merge hcenter bold
putexcel (A2:A3)="Characteristics", hcenter bold
putexcel (B2:B3), hcenter bold
putexcel (C2:C3), hcenter bold
putexcel (D2:D3), hcenter bold


** i =row indicator from stata, j=row indicator from excel
foreach i of numlist 1 (1) 55 {
local j=`i'+1
putexcel A`j'=factor[`i'] B`j'=treatment_1[`i']  C`j'=treatment_0[`i'] D`j'=treatment_T[`i'] 
}
putexcel B18=""
putexcel C18=""
putexcel D18=""

putexcel B31=""
putexcel C31=""
putexcel D31=""

putexcel (A1:D1), border(bottom)
putexcel (B2:D2), border(bottom)
putexcel (A3:D3), border(bottom)
putexcel (A53:D53), border(bottom)  
********************************************************************************  
********************************************************************************  
  
  
  
  
  
  
********************************************************************************
**# Table S3: Outcomes of Chloroquine/Hydroxychloroquine and Placebo Pre-exposure Prophylaxis against COVID-19 in the COPCOV study (Per Protocol Analysis)                                                              *
********************************************************************************
 
use Anonymised_COPCOV_Baseline_endpoint_02112023,clear

merge 1:1 subjectno using Anonymised_PP_set_02112023
keep if _merge==3
drop _merge
 


******************************************************
*      Respiratory illness Table S3                  *
******************************************************

tab respiratoryill
gen respiratoryill_num=.
replace respiratoryill_num=1 if respiratoryill=="POS"
replace respiratoryill_num=1 if PCR=="PCR" &  respiratoryill_num==.
replace respiratoryill_num=0 if respiratoryill_num==.


*br subject treatment respiratoryill_num respiratoryill PCR covid19_final  if respiratoryill_num==1

tab  respiratoryill_num 
duplicates list if respiratoryill_num==1

tab  treatment respiratoryill_num, exact chi2 row 


*br subject respiratoryill_num PCR covid19_final if respiratoryill_num==. & treatment==.

 ci proportions respiratoryill_num if treatment==1
 ci proportions respiratoryill_num if treatment==0

binreg respiratoryill_num treatment if  covid19_final!=., rr
 


 
*************************************************************************
* Primary endpoint - Symptomatic covid19   Per Protocol (PP) Table S3   *
*************************************************************************


 gen symptomatic_covid=covid19_final            
 replace symptomatic_covid=0 if symptomatic==0 & covid19_final!=.
 replace  symptomatic_covid=0 if covid19_final==.
 tab  treatment symptomatic_covid, exact chi2 row
 ci proportions symptomatic_covid if treatment==1
 ci proportions symptomatic_covid if treatment==0
 binreg symptomatic_covid treatment, rr

 
 
**********************************************************************
* PCR endpoint -  Symptomatic Covid19     Per Protocol (PP) Table S3  *
********************************************************************** 
 tab symptomatic PCRcovid 
 tab  treatment PCRcovid, exact chi2 row
 ci   proportions PCRcovid if treatment==1
 ci   proportions PCRcovid if treatment==0
  binreg PCRcovid treatment, rr
 
***************************************************************************
* Symptomatic Covid19  -  Serology (Serum)    Per Protocol (PP) Table S3  *
***************************************************************************

 tab symptomatic Serumcovid 
 gen  symptomatic_Serumcovid=Serumcovid if symptomatic==1 
 replace symptomatic_Serumcovid=0 if symptomatic_Serumcovid==. & type_data=="serum"
 replace symptomatic_Serumcovid=0 if outcome=="NA"
 
 tab symptomatic_Serumcovid type_data
 *br subjectno PCR_Res PCR symptomatic_Serumcovid outcome_possible outcome type_data if treatment==1 & type_data=="serum" & symptomatic_Serumcovid==1
 *br subjectno PCR_Res PCR symptomatic_Serumcovid outcome_possible outcome type_data if treatment==0 & type_data=="serum" & symptomatic_Serumcovid==1
  
 tab treatment  symptomatic_Serumcovid, chi2 exact row, if type_data=="serum"
 

 ci   proportions symptomatic_Serumcovid  if treatment==1 & type_data=="serum"
 ci   proportions symptomatic_Serumcovid  if treatment==0 & type_data=="serum"
 binreg symptomatic_Serumcovid treatment if type_data=="serum", rr
  
  

******************************************************************************
* Symptomatic Covid19 - Serology (dbs) endpoint  Per Protocol (PP) Table S3  *
******************************************************************************

 tab symptomatic DBScovid 

 gen  symptomatic_DBScovid=DBScovid if symptomatic==1
 replace symptomatic_DBScovid=0 if symptomatic_DBScovid==. & type_data=="DBS"
 replace symptomatic_DBScovid=0 if outcome=="NA"
  
 tab symptomatic_DBScovid type_data
 *br subjectno PCR_Res PCR symptomatic_DBScovid outcome_possible outcome type_data if treatment==1 & type_data=="DBS" & symptomatic_DBScovid==1
 *br subjectno PCR_Res PCR symptomatic_DBScovid outcome_possible outcome  type_data if treatment==0 & type_data=="DBS" & symptomatic_DBScovid==1
  
 tab treatment  symptomatic_DBScovid, chi2 exact row, if type_data=="DBS"
 
 ci   proportions symptomatic_DBScovid  if treatment==1 & type_data=="DBS"
 ci   proportions symptomatic_DBScovid  if treatment==0 & type_data=="DBS"
 binreg symptomatic_DBScovid treatment if type_data=="DBS", rr
 

 
 
*********************************************************
* Asymptomatic Covid19   Per Protocol (PP) Table S3     *
********************************************************* 
 gen asymptomatic_covid=covid19_final            
 replace asymptomatic_covid=0 if symptomatic==1 & covid19_final!=.
 replace asymptomatic_covid=0 if covid19_final==.
  tab   asymptomatic_covid
 tab  treatment asymptomatic_covid, exact chi2 row
 tab treatment
 tab treatment, nolab
 ci proportions asymptomatic_covid if treatment==1
 ci proportions asymptomatic_covid if treatment==0
 
 binreg asymptomatic_covid treatment, rr
 
 
 
 
***************************************************************
* Primary endpoint - All covid19   Per Protocol (PP) Table S3 *
***************************************************************
 replace covid19_final=0 if covid19_final==.
 tab treatment covid19_final, exact chi2 row
 ci proportions covid19_final if treatment==1
 ci proportions covid19_final if treatment==0
 binreg covid19_final treatment, rr 
 
 
 
 
 
********************************************************************************
* Asymptomatic covid19   Serology (serum) endpoint Per Protocol (PP) Table S3  *
********************************************************************************
 
 
 gen  asymptomatic_Serumcovid=Serumcovid if symptomatic==0
 replace asymptomatic_Serumcovid=0 if asymptomatic_Serumcovid==. & Serumcovid!=.
 
 tab treatment  asymptomatic_Serumcovid, chi2 exact
 ci   proportions asymptomatic_Serumcovid  if treatment==1
 ci   proportions asymptomatic_Serumcovid  if treatment==0
 binreg asymptomatic_Serumcovid treatment, rr
 
 
 
 
*****************************************************************************
* Asymptomatic covid19 Serology (dbs) endpoint  Per Protocol (PP) Table S3  *
*****************************************************************************
 
 gen  asymptomatic_DBScovid=DBScovid if symptomatic==0
 replace asymptomatic_DBScovid=0 if asymptomatic_DBScovid==. & DBScovid!=.
 
 tab treatment  asymptomatic_DBScovid, chi2 exact
 ci   proportions asymptomatic_DBScovid  if treatment==1
 ci   proportions asymptomatic_DBScovid  if treatment==0
 binreg asymptomatic_DBScovid treatment, rr
 

save data_copcov_tableS3, replace // This dataset is useful for automating output from regression models
 
 
 
 
********************************************************************************
**#                       OUTPUT:  Excel  for  Table S3                        *
********************************************************************************
cls
set more off

use data_copcov_tableS3,clear  


* Set Excel table
putexcel set Table_S3_COPCOV_Endpoint_analysis_Output.xlsx, sheet("TableS3", replace) modify

putexcel A1="Table S3 Outcomes of Chloroquine/Hydroxychloroquine and Placebo Pre-exposure Prophylaxis against COVID-19 in the COPCOV study (Per Protocol Analysis).", bold font(calibri, 11, black)
putexcel (C2:E2)="Results last updated:`c(current_date)'", merge right italic font(calibri,10,red) //ehour.pkg for ce=current date
putexcel A3="Outcome",hcenter bold
putexcel B3="Chloroquine/Hydroxychloroquine (N= 1,645)",hcenter bold 
putexcel C3="Placebo (N= 1,678)", hcenter bold
putexcel D3="Risk ratio (95%CI)", hcenter bold
putexcel E3="Fisher's exact P-value", hcenter bold

putexcel A4="Total participant days ", left
putexcel A5="Symptomatic COVID-19. n(%); 95%CI", left 
putexcel A6="PCR-confirmed diagnosis. n/N (%); 95%CI", left 
putexcel A7="Serology confirmed diagnosis (serum). n (%); 95%CI", left 
putexcel A8="Serology confirmed diagnosis (DBS). n (%); 95%CI", left 
putexcel A9="Asymptomatic SARS-CoV-2 infection. n (%); 95%CI", left  
putexcel A10="All SARS-CoV-2 infection n(%); 95%CI", left 
putexcel A11="All-cause respiratory illness*. n(%); 95%CI", left


* Format border
putexcel (A3:E11), border(all)
*******************************

* Total participant days 
use "Anonymised_days_of_follow_up",clear
rename label  subjectno
sort subjectno

merge m:1 subjectno using data_copcov_tableS3
keep if _merge==3
drop _merge 
 
egen Fu_daysTot=sum(Fu_days),by(treatment)
label var Fu_daysTot "Total follow up days by arm" 
 
tabstat Fu_daysTot, stats( min max) by(treatment)
  
local day1="150,505"      //total follow-up days -CQHCQ
local day2="153,442"      //total follow-up days -Placebo

putexcel B4="`day1'",hcenter   //CQHCQ
putexcel C4="`day2'",hcenter  //Placebo

  

* Symptomatic COVID-19. n(%); 95%CI  Table S3  
use data_copcov_tableS3,clear 

tab treatment symptomatic_covid, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 


ci proportions symptomatic_covid if treatment==1 //95%CI - CQHCQ  Table S3  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions symptomatic_covid if treatment==0 //95%CI -Placebo  Table S3  
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B5= "`result1'", hcenter 	
putexcel C5= "`result2'", hcenter 
 
 
binreg symptomatic_covid treatment, rr //Risk ratio  Table S3  
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D5= "`riskratio'", hcenter

tab treatment symptomatic_covid, chi exact //P-value
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")  	
putexcel E5= "`pvalue'", hcenter 	



* PCR-confirmed diagnosis. n/N (%); 95%CI

tab  treatment PCRcovid, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions PCRcovid if treatment==1 //95%CI - CQHCQ  Table S3  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions PCRcovid if treatment==0 //95%CI -Placebo  Table S3  
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B6= "`result1'", hcenter 	
putexcel C6= "`result2'", hcenter 
 
 
binreg PCRcovid treatment, rr //Risk ratio  Table S3  
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D6= "`riskratio'", hcenter

tab treatment PCRcovid, chi exact //P-value
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")  	
putexcel E6= "`pvalue'", hcenter 	



* Serology confirmed diagnosis (serum). n (%); 95%CI  Table S3  

tab  treatment symptomatic_Serumcovid if type_data=="serum", matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/"  

ci proportions symptomatic_Serumcovid if treatment==1 & type_data=="serum" //95%CI - CQHCQ  Table S3  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions symptomatic_Serumcovid if treatment==0 & type_data=="serum" //95%CI -Placebo  Table S3  
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B7= "`result1'", hcenter 	
putexcel C7= "`result2'", hcenter 
 
 
binreg symptomatic_Serumcovid treatment if type_data=="serum", rr //Risk ratio  Table S3  
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D7= "`riskratio'", hcenter 

tab treatment symptomatic_Serumcovid if type_data=="serum", chi exact //P-value  Table S3  
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f") 	
putexcel E7= "`pvalue'", hcenter 	



* Serology confirmed diagnosis (DBS). n (%); 95%CI  Table S3  

tab  treatment symptomatic_DBScovid if type_data=="DBS", matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions symptomatic_DBScovid if treatment==1 & type_data=="DBS" //95%CI - CQHCQ  Table S3  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions symptomatic_DBScovid if treatment==0 & type_data=="DBS" //95%CI -Placebo  Table S3  
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B8= "`result1'", hcenter 	
putexcel C8= "`result2'", hcenter 
 
 
binreg symptomatic_DBScovid treatment if type_data=="DBS", rr //Risk ratio Table S3  
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D8= "`riskratio'", hcenter 

tab treatment symptomatic_DBScovid if type_data=="DBS", chi exact //P-value Table S3  
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f") 	
putexcel E8= "`pvalue'", hcenter 	



* Asymptomatic SARS-CoV-2 infection. n (%); 95%CI

tab  treatment asymptomatic_covid, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions asymptomatic_covid if treatment==1 //95%CI - CQHCQ Table S3  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions asymptomatic_covid if treatment==0 //95%CI -Placebo Table S3  
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B9= "`result1'", hcenter 	
putexcel C9= "`result2'", hcenter 
 
 
binreg asymptomatic_covid treatment, rr //Risk ratio Table S3  
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D9= "`riskratio'", hcenter

tab treatment asymptomatic_covid, chi exact //P-value
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f") 	
putexcel E9= "`pvalue'", hcenter 



* All SARS-CoV-2 infection n(%); 95%CI Table S3  

tab treatment covid19_final, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions covid19_final if treatment==1 //95%CI - CQHCQ Table S3  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions covid19_final if treatment==0 //95%CI -Placebo Table S3  
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B10= "`result1'", hcenter 	
putexcel C10= "`result2'", hcenter 
 
 
binreg covid19_final treatment, rr //Risk ratio Table S3  
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D10= "`riskratio'", hcenter

tab treatment covid19_final, chi exact //P-value Table S3  
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")  	
putexcel E10= "`pvalue'", hcenter 



* All-cause Respiratory illness analysis Table S3  

tab treatment respiratoryill_num, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/"  

ci proportions respiratoryill_num if treatment==1 //95%CI - CQHCQ Table S3  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions respiratoryill_num if treatment==0 //95%CI -Placebo Table S3  
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B11= "`result1'", hcenter 	
putexcel C11= "`result2'", hcenter 
 
 
binreg respiratoryill_num treatment, rr //Risk ratio  Table S3  
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio ="`rr' (`rrll' `to' `rrul')"

putexcel D11="`riskratio'", hcenter

tab treatment respiratoryill_num, chi exact //P-value  Table S3  
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")  	
putexcel E11= "`pvalue'", hcenter 
********************************************************************************
********************************************************************************
    
 

  
********************************************************************************
**# Table S5: Primary and secondary outcomes of Chloroquine/Hydroxychloroquine *
*Therapy for Pre-exposure Prophylaxis against Covid-19                         *
*(missing outcomes treated as not having had covid-19 during the study period) * 
* ITT – Results presented as "Risk differences".	                           *
********************************************************************************  
  
use data_copcov_table2,clear  
  

* Symptomatic COVID-19. n(%); 95%CI
tab treatment symptomatic_covid
ci proportions symptomatic_covid if treatment==1  //95%CI - CQHCQ
ci proportions symptomatic_covid if treatment==0  //95%CI -Placebo
binreg symptomatic_covid treatment, rd            //Risk difference
tab treatment symptomatic_covid, chi exact        //Fisher's exact P-value 


* PCR-confirmed diagnosis. n/N (%); 95%CI
tab treatment PCRcovid
ci proportions PCRcovid if treatment==1   //95%CI - CQHCQ
ci proportions PCRcovid if treatment==0   //95%CI -Placebo
binreg PCRcovid treatment, rd             //Risk difference
tab treatment PCRcovid, chi exact         //Fisher's exact P-value
  

* Serology confirmed diagnosis (serum). n (%); 95%CI
tab treatment symptomatic_Serumcovid if type_data=="serum"
ci proportions symptomatic_Serumcovid if treatment==1 & type_data=="serum"  //95%CI - CQHCQ
ci proportions symptomatic_Serumcovid if treatment==0 & type_data=="serum"  //95%CI -Placebo
binreg symptomatic_Serumcovid treatment if type_data=="serum", rd           //Risk difference
tab treatment symptomatic_Serumcovid if type_data=="serum", chi exact       //Fisher's exact P-value


* Serology confirmed diagnosis (DBS). n (%); 95%CI
tab  treatment symptomatic_DBScovid if type_data=="DBS"
ci proportions symptomatic_DBScovid if treatment==1 & type_data=="DBS"  //95%CI - CQHCQ
ci proportions symptomatic_DBScovid if treatment==0 & type_data=="DBS"  //95%CI -Placebo
binreg symptomatic_DBScovid treatment if type_data=="DBS" , rd          //Risk difference
tab treatment symptomatic_DBScovid if type_data=="DBS", chi exact       //Fisher's exact P-value


* Asymptomatic SARS-CoV-2 infection. n (%); 95%CI
tab  treatment asymptomatic_covid 
ci proportions asymptomatic_covid if treatment==1         //95%CI - CQHCQ
ci proportions asymptomatic_covid if treatment==0         //95%CI -Placebo
binreg asymptomatic_covid treatment, rd                   //Risk difference 
tab treatment asymptomatic_covid, chi exact               //Fisher's exact P-value
 
 
 
* All SARS-CoV-2 infection n(%); 95%CI
tab  treatment respiratoryill_num
ci proportions respiratoryill_num if treatment==1 	//95%CI - CQHCQ
ci proportions respiratoryill_num if treatment==0 	//95%CI -Placebo
binreg respiratoryill_num treatment, rd           	//Risk difference
tab treatment respiratoryill_num, chi exact       	//Fisher's exact P-value



* All-cause respiratory illness*. n(%); 95%CI
tab  treatment all_sars
ci proportions all_sars if treatment==1 //95%CI - CQHCQ
ci proportions all_sars if treatment==0 //95%CI -Placebo
binreg all_sars treatment, rd           //Risk difference
tab treatment all_sars, chi exact       //Fisher's exact P-value




********************************************************************************
**#                      OUTPUT:  Excel  for  Table S5                         *
********************************************************************************  
  
* Set Excel table
putexcel set Table_S5_COPCOV_Endpoint_analysis_Output_Risk_Difference.xlsx, sheet("TableS5_Risk_Difference",replace) modify

putexcel A1="Table S5 Primary and secondary outcomes of Chloroquine/Hydroxychloroquine Therapy for Pre-exposure Prophylaxis against Covid-19 (missing outcomes treated as not having had covid-19 during the study period) ITT – Results presented as 'Risk differences'.",vcenter bold font(calibri, 11, black)
putexcel (C2:E2)="Results last updated:`c(current_date)'", merge right italic font(calibri,10,red) //ehour.pkg for ce=current date

putexcel A4="Outcome", hcenter bold
putexcel B4="Chloroquine/Hydroxychloroquine (N= 2,320)", hcenter bold 
putexcel C4="Placebo (N= 2,332)", hcenter bold
putexcel D4="Risk difference (95%CI)", hcenter bold
putexcel E4="Fisher's exact P-value", hcenter bold

putexcel A5="Symptomatic COVID-19. n(%); 95%CI", left 
putexcel A6="PCR-confirmed diagnosis. n/N (%); 95%CI", left 
putexcel A7="Serology confirmed diagnosis (serum). n (%); 95%CI", left 
putexcel A8="Serology confirmed diagnosis (DBS). n (%); 95%CI", left 
putexcel A9="Asymptomatic SARS-CoV-2 infection. n (%); 95%CI", left 
putexcel A10="All SARS-CoV-2 infection n(%); 95%CI", left 
putexcel A11="All-cause respiratory illness*. n(%); 95%CI", left 
putexcel A12="Severity score. (Median (IQR)", left 
putexcel A13="Participant work days loss n days/total follow-up days", left 

putexcel B12="20.0 (5-85)", hcenter     //Calculated in R code, check
putexcel C12="21.5 (5-89)", hcenter     //Calculated in R code, check
putexcel D12="NA", hcenter              
putexcel E12="1.000", hcenter           //Calculated in R code, check

* Format border
putexcel (A4:E13), border(all)
*******************************


* Symptomatic COVID-19. n(%); 95%CI Table S5

tab treatment symptomatic_covid, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions symptomatic_covid if treatment==1 //95%CI - //CQHCQ  Table S5
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions symptomatic_covid if treatment==0 //95%CI -Placebo Table S5
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B5= "`result1'", hcenter 	
putexcel C5= "`result2'", hcenter 
  
binreg symptomatic_covid treatment, rd //Risk difference Table S5
matrix list r(table)
local table11=r(table)[1,1]*100
local table51=r(table)[5,1]*100
local table61=r(table)[6,1]*100
local rd=string(`table11',"%9.2f")
local rdll=string(`table51',"%9.2f")
local rdul=string(`table61',"%9.2f")
local to = "to"
local riskdifference = "`rd' (`rdll' `to' `rdul')"

putexcel D5= "`riskdifference'", hcenter 

tab treatment symptomatic_covid, chi exact //P-value Table S5
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")
putexcel E5= "`pvalue'", hcenter 	




* PCR-confirmed diagnosis. n/N (%); 95%CI Table S5

tab  treatment PCRcovid, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 


ci proportions PCRcovid if treatment==1 //95%CI - CQHCQ Table S5
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions PCRcovid if treatment==0 //95%CI -Placebo Table S5
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B6= "`result1'", hcenter 	
putexcel C6= "`result2'", hcenter 
 
 
binreg PCRcovid treatment, rd //Risk difference Table S5
matrix list r(table)
local table11=r(table)[1,1]*100
local table51=r(table)[5,1]*100
local table61=r(table)[6,1]*100
local rd=string(`table11',"%9.2f")
local rdll=string(`table51',"%9.2f")
local rdul=string(`table61',"%9.2f")
local to = "to"
local riskdifference = "`rd' (`rdll' `to' `rdul')"

putexcel D6= "`riskdifference'", hcenter 	
 	
tab treatment PCRcovid, chi exact //P-value
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")
putexcel E6= "`pvalue'", hcenter 	



* Serology confirmed diagnosis (serum). n (%); 95%CI Table S5

tab  treatment symptomatic_Serumcovid if type_data=="serum", matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 


ci proportions symptomatic_Serumcovid if treatment==1 & type_data=="serum" //95%CI - CQHCQ Table S5
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions symptomatic_Serumcovid if treatment==0 & type_data=="serum" //95%CI -Placebo Table S5
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B7= "`result1'", hcenter 	
putexcel C7= "`result2'", hcenter 
  
binreg symptomatic_Serumcovid treatment if type_data=="serum", rd //Risk difference Table S5
matrix list r(table)
local table11=r(table)[1,1]*100
local table51=r(table)[5,1]*100
local table61=r(table)[6,1]*100
local rd=string(`table11',"%9.2f")
local rdll=string(`table51',"%9.2f")
local rdul=string(`table61',"%9.2f")
local to = "to"
local riskdifference = "`rd' (`rdll' `to' `rdul')"

putexcel D7= "`riskdifference'", hcenter 		

tab treatment symptomatic_Serumcovid if type_data=="serum", chi exact //P-value 
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")
putexcel E7= "`pvalue'", hcenter 	




* Serology confirmed diagnosis (DBS). n (%); 95%CI Table S5

tab  treatment symptomatic_DBScovid if type_data=="DBS", matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions symptomatic_DBScovid if treatment==1 & type_data=="DBS" //95%CI - CQHCQ Table S5
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions symptomatic_DBScovid if treatment==0 & type_data=="DBS"  //95%CI -Placebo Table S5
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B8= "`result1'", hcenter 	
putexcel C8= "`result2'", hcenter 
 
 
binreg symptomatic_DBScovid treatment if type_data=="DBS" , rd //Risk difference Table S5
matrix list r(table)
local table11=r(table)[1,1]*100
local table51=r(table)[5,1]*100
local table61=r(table)[6,1]*100
local rd=string(`table11',"%9.2f")
local rdll=string(`table51',"%9.2f")
local rdul=string(`table61',"%9.2f")
local to = "to"
local riskdifference = "`rd' (`rdll' `to' `rdul')"

putexcel D8= "`riskdifference'", hcenter 

tab treatment symptomatic_DBScovid if type_data=="DBS", chi exact //P-value Table S5
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")	
putexcel E8= "`pvalue'", hcenter 	



* Asymptomatic SARS-CoV-2 infection. n (%); 95%CI Table S5

tab  treatment asymptomatic_covid, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions asymptomatic_covid if treatment==1 //95%CI - CQHCQ Table S5
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions asymptomatic_covid if treatment==0 //95%CI -Placebo Table S5
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B9= "`result1'", hcenter 	
putexcel C9= "`result2'", hcenter 
 
 
binreg asymptomatic_covid treatment, rd //Risk difference //Risk difference Table S5
matrix list r(table)
local table11=r(table)[1,1]*100
local table51=r(table)[5,1]*100
local table61=r(table)[6,1]*100
local rd=string(`table11',"%9.2f")
local rdll=string(`table51',"%9.2f")
local rdul=string(`table61',"%9.2f")
local to = "to"
local riskdifference = "`rd' (`rdll' `to' `rdul')"

putexcel D9= "`riskdifference'", hcenter 	

tab treatment asymptomatic_covid, chi exact //P-value Table S5
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")
putexcel E9= "`pvalue'", hcenter 



* All SARS-CoV-2 infection n(%); 95%CI Table S5

tab  treatment all_sars, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions all_sars if treatment==1 //95%CI - CQHCQ Table S5
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions all_sars if treatment==0 //95%CI -Placebo Table S5
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B10= "`result1'", hcenter 	
putexcel C10= "`result2'", hcenter 
 
 
binreg all_sars treatment, rd //Risk difference Table S5
matrix list r(table)
local table11=r(table)[1,1]*100
local table51=r(table)[5,1]*100
local table61=r(table)[6,1]*100
local rd=string(`table11',"%9.2f")
local rdll=string(`table51',"%9.2f")
local rdul=string(`table61',"%9.2f")
local to = "to"
local riskdifference = "`rd' (`rdll' `to' `rdul')"

putexcel D10= "`riskdifference'", hcenter 	

tab treatment all_sars, chi exact //P-value Table S5
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")
putexcel E10= "`pvalue'", hcenter 




* All-cause Respiratory illness analysis Table S5

tab  treatment respiratoryill_num, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 


ci proportions respiratoryill_num if treatment==1 //95%CI - CQHCQ Table S5
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions respiratoryill_num if treatment==0 //95%CI -Placebo Table S5
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B11= "`result1'", hcenter 	
putexcel C11= "`result2'", hcenter 
 
 
binreg respiratoryill_num treatment, rd //Risk difference Table S5
matrix list r(table)
local table11=r(table)[1,1]*100
local table51=r(table)[5,1]*100
local table61=r(table)[6,1]*100
local rd=string(`table11',"%9.2f")
local rdll=string(`table51',"%9.2f")
local rdul=string(`table61',"%9.2f")
local to = "to"
local riskdifference = "`rd' (`rdll' `to' `rdul')"

putexcel D11= "`riskdifference'", hcenter 	

tab treatment respiratoryill_num, chi exact //P-value Table S5
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")
putexcel E11= "`pvalue'", hcenter 




* Severity score (Median (IQR)
* Calculated by R



* Participant work days loss n days/total follow-up days

* Work loss analysis  
use "Anonymised_days_of_follow_up",clear
 
egen Fu_daysTot=sum(Fu_days),by(treatment)
label var Fu_daysTot "Total follow up days by arm" 
 
tabstat Fu_daysTot, stats( min max) by(treatment)
  
  
  

use "Anonymised_workdaysloss_02112023" ,clear

tab workprob treatment

prtesti 181263 700 184688 932, count
  
local num1="700"         //total work loss days -CQHCQ
local num2="932"         //total work loss days -Placebo
local day1="181263"      //total follow-up days -CQHCQ
local day2="184688"      //total follow-up days -Placebo
local pval="0.0002**"    //P-value

putexcel B13="`num1'/`day1'" , hcenter  //CQHCQ
putexcel C13="`num2'/`day2'" , hcenter  //Placebo
putexcel D13="NA" , hcenter             //Risk ratio (95%CI)
putexcel E13="`pval'"  , hcenter        //Fisher's exact P-value
********************************************************************************
********************************************************************************

  

  
********************************************************************************
**#  Table S6: Outcomes of Chloroquine/Hydroxychloroquine and Placebo Pre-exposure 
*              Prophylaxis against COVID-19 in the COPCOV study (removing cases 
*              for which the SEAC judged that a study endpoint could not be          
*              determined).                                                                  
********************************************************************************
 
use Anonymised_COPCOV_Baseline_endpoint_02112023,clear


**************************************
*         Respiratory illness        *
**************************************
tab respiratoryill
gen respiratoryill_num=.
replace respiratoryill_num=1 if respiratoryill=="POS"
replace respiratoryill_num=1 if PCR=="PCR" &  respiratoryill_num==.

replace respiratoryill_num=0 if respiratoryill_num==.


*br subject treatment respiratoryill_num respiratoryill PCR covid19_final  if respiratoryill_num==1

tab  respiratoryill_num 
duplicates list if respiratoryill_num==1

tab  treatment respiratoryill_num, exact chi2 row 


*br subject respiratoryill_num PCR covid19_final if respiratoryill_num==. & treatment==.

 ci proportions respiratoryill_num if treatment==1
 ci proportions respiratoryill_num if treatment==0

binreg respiratoryill_num treatment if  covid19_final!=., rr
 


***************************************************************************************
* Primary endpoint - Symptomatic covid19   include only Asssessable by SEAC  Table S1 *
***************************************************************************************

 
 gen symptomatic_covid=covid19_final            
 replace symptomatic_covid=0 if symptomatic==0 & covid19_final!=.
 
 tab symptomatic_covid
 tab treatment symptomatic_covid, exact chi2 row
 tab treatment
 tab treatment, nolab
 ci proportions symptomatic_covid if treatment==1
 ci proportions symptomatic_covid if treatment==0
 
 binreg symptomatic_covid treatment, rr

 
 
*****************************************************************************************
* PCR endpoint   Symptomatic Covid19    include only Asssessable by SEAC Table S1       *
***************************************************************************************** 
 tab symptomatic PCRcovid 

 tab treatment PCRcovid, exact chi2 row
 tab treatment
 tab treatment, nolab
 ci  proportions PCRcovid if treatment==1
 ci  proportions PCRcovid if treatment==0
  binreg PCRcovid treatment, rr
 
**************************************************************************************
* Symptomatic Covid19  -  Serology (Serum) include only Asssessable by SEAC Table S1 *
**************************************************************************************

 tab symptomatic Serumcovid 

 gen symptomatic_Serumcovid=Serumcovid if symptomatic==1 
 replace symptomatic_Serumcovid=0 if symptomatic_Serumcovid==. & type_data=="serum"
 replace symptomatic_Serumcovid=0 if outcome=="NA"
 
 tab symptomatic_Serumcovid type_data
 *br subjectno PCR_Res PCR symptomatic_Serumcovid outcome_possible outcome type_data if treatment==1 & type_data=="serum" & symptomatic_Serumcovid==1
 *br subjectno PCR_Res PCR symptomatic_Serumcovid outcome_possible outcome type_data if treatment==0 & type_data=="serum" & symptomatic_Serumcovid==1
  
 tab treatment  symptomatic_Serumcovid, chi2 exact row, if type_data=="serum"
 

 ci proportions symptomatic_Serumcovid  if treatment==1 & type_data=="serum"
 ci proportions symptomatic_Serumcovid  if treatment==0 & type_data=="serum"
 binreg symptomatic_Serumcovid treatment if type_data=="serum", rr
  
  

********************************************************************************************
* Symptomatic Covid19 - Serology (dbs) endpoint  include only Asssessable by SEAC Table S1 *
********************************************************************************************

 tab symptomatic DBScovid 

 gen  symptomatic_DBScovid=DBScovid if symptomatic==1
 replace symptomatic_DBScovid=0 if symptomatic_DBScovid==. & type_data=="DBS"
 replace symptomatic_DBScovid=0 if outcome=="NA"
  
 tab symptomatic_DBScovid type_data
 *br subjectno PCR_Res PCR symptomatic_DBScovid outcome_possible outcome type_data if treatment==1 & type_data=="DBS" & symptomatic_DBScovid==1
 *br subjectno PCR_Res PCR symptomatic_DBScovid outcome_possible outcome  type_data if treatment==0 & type_data=="DBS" & symptomatic_DBScovid==1
  
 tab treatment symptomatic_DBScovid, chi2 exact row, if type_data=="DBS"
 
 ci proportions symptomatic_DBScovid if treatment==1 & type_data=="DBS"
 ci proportions symptomatic_DBScovid if treatment==0 & type_data=="DBS"
 binreg symptomatic_DBScovid treatment if type_data=="DBS", rr
 

 
*********************************************************************
* Asymptomatic Covid19  include only Asssessable by SEAC Table S1  * 
********************************************************************* 
 gen asymptomatic_covid=covid19_final            
 replace asymptomatic_covid=0 if symptomatic==1 & covid19_final!=.
 
 tab treatment asymptomatic_covid, exact chi2 row
 ci proportions asymptomatic_covid if treatment==1
 ci proportions asymptomatic_covid if treatment==0
 
 binreg asymptomatic_covid treatment, rr
 
 
 
***********************************************************************
*All SARS-CoV-2 infection  include only Asssessable by SEAC Table S1  *
***********************************************************************

tab treatment covid19_final, exact chi2 row

ci proportions covid19_final if treatment==1
ci proportions covid19_final if treatment==0
binreg covid19_final treatment, rr 
  
save data_copcov_tableS6, replace // This dataset is useful for automating output from regression models

  
  


********************************************************************************
**#                         OUTPUT:  Excel  for  Table S6                      *
********************************************************************************
cls
set more off

use data_copcov_tableS6,clear  


* Set Excel table
putexcel set Table_S6_COPCOV_Endpoint_analysis_Output.xlsx, sheet("TableS6", replace) modify

putexcel A1="Table S6 Outcomes of Chloroquine/Hydroxychloroquine Therapy for Pre-exposure Prophylaxis against Covid-19 (removing cases for which the SEAC judged that a study endpoint could not be determined)", bold font(calibri, 11, black)
putexcel (C2:E2)="Results last updated:`c(current_date)'", merge right italic font(calibri,10,red) //ehour.pkg for ce=current date

putexcel A3="Outcome", hcenter bold
putexcel B3="Chloroquine/Hydroxychloroquine (N= 1,742)", hcenter bold 
putexcel C3="Placebo (N= 1,796)", hcenter bold
putexcel D3="Risk ratio (95%CI)", hcenter bold
putexcel E3="Fisher's exact P-value", hcenter bold

putexcel A4="Symptomatic COVID-19. n(%); 95%CI",left 
putexcel A5="	PCR-confirmed diagnosis. n/N (%); 95%CI", left 
putexcel A6="	Serology confirmed diagnosis (serum). n (%); 95%CI", left 
putexcel A7="	Serology confirmed diagnosis (DBS). n (%); 95%CI", left 
putexcel A8="Asymptomatic SARS-CoV-2 infection. n (%); 95%CI", left
putexcel A9="All SARS-CoV-2 infection n(%); 95%CI", left  
putexcel A10="All-cause respiratory illness*. n(%); 95%CI", left 

* Format border
putexcel (A3:E10), border(all)
*******************************



* Symptomatic COVID-19. n(%); 95%CI Table S6 

tab treatment symptomatic_covid, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 


ci proportions symptomatic_covid if treatment==1 //95%CI - CQHCQ  Table S6  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions symptomatic_covid if treatment==0 //95%CI -Placebo Table S6  
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B4= "`result1'", hcenter 	
putexcel C4= "`result2'", hcenter 
 
 
binreg symptomatic_covid treatment, rr //Risk ratio Table S6  
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D4= "`riskratio'", hcenter 

tab treatment symptomatic_covid, chi exact //P-value
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")	
putexcel E4= "`pvalue'", hcenter 	



* PCR-confirmed diagnosis. n/N (%); 95%CI Table S6  

tab treatment PCRcovid, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 


ci proportions PCRcovid if treatment==1 //95%CI - CQHCQ Table S6  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions PCRcovid if treatment==0 //95%CI -Placebo
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B5= "`result1'", hcenter 	
putexcel C5= "`result2'", hcenter 
 
 
binreg PCRcovid treatment, rr //Risk ratio
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D5= "`riskratio'", hcenter

tab treatment PCRcovid, chi exact //P-value
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f") 	
putexcel E5= "`pvalue'", hcenter 	



* Serology confirmed diagnosis (serum). n (%); 95%CI Table S6  

tab treatment symptomatic_Serumcovid if type_data=="serum", matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions symptomatic_Serumcovid if treatment==1 & type_data=="serum" //95%CI - CQHCQ Table S6  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions symptomatic_Serumcovid if treatment==0  & type_data=="serum" //95%CI -Placebo Table S6  
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B6= "`result1'", hcenter 	
putexcel C6= "`result2'", hcenter 
 
 
binreg symptomatic_Serumcovid treatment if type_data=="serum", rr //Risk ratio Table S6  
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D6= "`riskratio'", hcenter

tab treatment symptomatic_Serumcovid if type_data=="serum", chi exact //P-value Table S6  
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")  	
putexcel E6= "`pvalue'", hcenter 	



* Serology confirmed diagnosis (DBS). n (%); 95%CI Table S6 

tab  treatment symptomatic_DBScovid if type_data=="DBS", matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions symptomatic_DBScovid if treatment==1 & type_data=="DBS" //95%CI - CQHCQ Table S6 
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions symptomatic_DBScovid if treatment==0 & type_data=="DBS" //95%CI -Placebo Table S6  
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B7= "`result1'", hcenter 	
putexcel C7= "`result2'", hcenter 
 
 
binreg symptomatic_DBScovid treatment if type_data=="DBS", rr //Risk ratio Table S6 
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D7= "`riskratio'", hcenter 

tab treatment symptomatic_DBScovid if type_data=="DBS", chi exact //P-value
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")  	
putexcel E7= "`pvalue'", hcenter 	



* Asymptomatic SARS-CoV-2 infection. n (%); 95%CI Table S6 

tab  treatment asymptomatic_covid, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions asymptomatic_covid if treatment==1 //95%CI - CQHCQ Table S6  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions asymptomatic_covid if treatment==0 //95%CI -Placebo Table S6  
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B8= "`result1'", hcenter 	
putexcel C8= "`result2'", hcenter 
 
 
binreg asymptomatic_covid treatment, rr //Risk ratio Table S6 
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D8= "`riskratio'", hcenter

tab treatment asymptomatic_covid, chi exact //P-value
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")  	
putexcel E8= "`pvalue'", hcenter 



* All SARS-CoV-2 infection n(%); 95%CI Table S6  

tab  treatment covid19_final, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 

ci proportions covid19_final if treatment==1 //95%CI - CQHCQ Table S6  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions covid19_final if treatment==0 //95%CI -Placebo Table S6 
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B9= "`result1'", hcenter 	
putexcel C9= "`result2'", hcenter 
 
 
binreg covid19_final treatment, rr //Risk ratio Table S6 
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D9= "`riskratio'", hcenter 	

tab treatment covid19_final, chi exact //P-value Table S6 
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f")  
putexcel E9= "`pvalue'", hcenter 



* All-cause Respiratory illness analysis Table S6  

tab  treatment respiratoryill_num, matcell(freq) matrow(names) 
matrix list freq
local x1=freq[2,2] //CQHCQ
local n1=freq[2,1]+ freq[2,2]
local slash1="/" 

local x2=freq[1,2] //Placebo
local n2=freq[1,1]+ freq[1,2]
local slash2="/" 


ci proportions respiratoryill_num if treatment==1 //95%CI - CQHCQ Table S6  
return list
local p1 = r(proportion)*100
local plb1 = r(lb)*100
local pub1 = r(ub)*100
local prop1 = string(`p1',"%9.1f")
local lb1 = string(`plb1',"%9.1f")
local ub1 = string(`pub1',"%9.1f")
local to = "to"
local 95ci1 = "(`lb1' `to' `ub1')"
local result1= "`x1'`slash1'`n1' `prop1' `95ci1'" 
  
ci proportions respiratoryill_num if treatment==0 //95%CI -Placebo Table S6  
return list
local p2 = r(proportion)*100
local plb2 = r(lb)*100
local pub2 = r(ub)*100
local prop2 = string(`p2',"%9.1f")
local lb2 = string(`plb2',"%9.1f")
local ub2 = string(`pub2',"%9.1f")
local to = "to"
local 95ci2 = "(`lb2' `to' `ub2')"
local result2= "`x2'`slash2'`n2' `prop2' `95ci2'"

putexcel B10= "`result1'", hcenter 	
putexcel C10= "`result2'", hcenter 
 
 
binreg respiratoryill_num treatment, rr //Risk ratio Table S6 
matrix list r(table)
local table11=r(table)[1,1]
local table51=r(table)[5,1]
local table61=r(table)[6,1]
local rr=string(`table11',"%9.2f")
local rrll=string(`table51',"%9.2f")
local rrul=string(`table61',"%9.2f")
local to = "to"
local riskratio = "`rr' (`rrll' `to' `rrul')"

putexcel D10= "`riskratio'", hcenter 	

tab treatment respiratoryill_num , chi exact //P-value Table S6  
return list
local exact= r(p_exact)
local pvalue=string(`exact',"%9.3f") 
putexcel E10= "`pvalue'", hcenter 

********************************************************************************
********************************************************************************
