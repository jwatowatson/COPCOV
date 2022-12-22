
**************************************************************************
* CONSOLIDATED ENDPOINT FROM COPCOV TEAM AND SEROLOGY ENDPOINT REVIEW    *
**************************************************************************


***********************************************
* SEROLOGY ENDPOINT REVIEW                    *
***********************************************

insheet using outcomes_final.csv, clear

br
keep subjectno site outcome_possible outcome type_data
gen SEAC_covid19=.
replace SEAC_covid19 =1 if strpos( outcome ,"Baseline")>0
replace SEAC_covid19 =1 if strpos( outcome ,"Binary")>0 & SEAC_covid19==.
replace SEAC_covid19 =1 if strpos( outcome ,"baseline")>0
replace SEAC_covid19 =1 if strpos( outcome ,"binary")>0 & SEAC_covid19==.
replace SEAC_covid19 =1 if strpos( outcome ,"PCR")>0 & SEAC_covid19==.
tab outcome SEAC_covid19, m

br
sort subjectno

saveold DE_TP_outcomes_new_22_12_2022, replace



**************************************
*Merging Team and SEAC endpoints     *
* Merging sith Symptom data          *
**************************************

use Serology_JT_PCR_Covid_19, clear   // File 
sort subjectno

br subjectno PCR_Res covid19_final if inlist(subjectno, "P036-048", "P043-051","R032-266","R035-367","R036-146","Q045-131", "Q066-087")

merge 1:1 subjectno using DE_TP_outcomes_new_22_12_2022   // SEAC endpoints added
drop _merge
br

br subjectno covid19_final outcome SEAC_covid19  if covid19_final != SEAC_covid19

tab SEAC_covid19 covid19_final, m

tab covid19_final if covid19_final != SEAC_covid19
tab SEAC_covid19 if covid19_final != SEAC_covid19



gen covid19_final_old=covid19_final
gen SEAC_flag=1  if covid19_final != SEAC_covid19
br subjectno covid19_final outcome SEAC_covid19 covid19_final_old SEAC_flag if covid19_final != SEAC_covid19
br subjectno covid19_final outcome SEAC_covid19 SEAC_flag if  SEAC_flag==.


rename covid19_final covid19_final_old1
gen covid19_final=.
replace covid19_final=SEAC_covid19 


br subjectno covid19_final outcome SEAC_covid19 covid19_final_old SEAC_flag 
saveold Covid_19_DE_TP_new_22_12_2022, replace
tab covid19_final


merge 1:1 subjectno using Symptomtomatic_Asymptomatic375  //  Symptoms data added greater than equal 37.5


tab outcome_possible

replace covid19_final=0 if covid19_final==. &  strpos( outcome_possible ,"yes")>0 & SEAC_covid19==. // generating negatives for those that are not positive
tab covid19_final
tab covid19_final symptomatic
tab SEAC_covid19 symptomatic


drop _merge

***********************************************
*Generating Covid 19 Analysis population sets *
***********************************************


gen PCR=""  // Generating PCR population set

replace  PCR="PCR" if inlist(subjectno, "P036-048", "P043-051","R032-266","R035-367","R036-146","Q045-131", "Q066-087")

br subjectno PCR_Res covid19_final PCR if inlist(subjectno, "P036-048", "P043-051","R032-266","R035-367","R036-146","Q045-131", "Q066-087")

***************************************************************************
* subject IDs for new Mallika result  for PCR Negative to positive for PCR.*
***************************************************************************

replace  covid19_final=1 if inlist(subjectno, "P036-048", "P043-051","R032-266","R035-367","R036-146","Q045-131", "Q066-087")

br subjectno PCR_Res PCR covid19_final if inlist(subjectno, "P036-048", "P043-051","R032-266","R035-367","R036-146","Q045-131", "Q066-087")


replace PCR="PCR" if PCR_Res=="POS"

br subjectno PCR_Res covid19_final PCR if PCR=="PCR" 

replace covid19_final=1 if PCR=="PCR"
gen PCRcovid=covid19_final if  PCR=="PCR"
replace PCRcovid=0 if PCRcovid==. 
tab symptomatic PCRcovid 

gen Serumcovid=covid19_final if type_data=="serum" 
replace Serumcovid=0 if Serumcovid==. & covid19_final!=. // & PCR!="PCR"
tab symptomatic Serumcovid

gen DBScovid=covid19_final if  type_data=="DBS" 
replace DBScovid=0 if DBScovid==. & covid19_final!=. // & PCR!="PCR" & Sero_serum!="serum"
tab symptomatic DBScovid


saveold Covid_19_DE_TP_ALL_new_22_12_2022, replace

*****************************************************************************************************************************

***************************************************
* Merging Final Endpoint to  Baseline data        *
***************************************************

use COP_Baseline_CQHCQvsPlacebo_table1, clear
sort label
rename label subjectno 
capture drop _merge
merge 1:1 subjectno using Covid_19_DE_TP_ALL_new_22_12_2022
drop _merge
br



*******************************************************************************************************************
*Moving participants "P036-266", "A12-069", "A12-199", "Q058-079", "Q058-152", "Q058-332", "Q058-326", "Q065-125" *
*to Asymptomatic category
*******************************************************************************************************************

br subjectno symptomatic PCR if inlist(subjectno, "P036-266","P043-069","P043-199", "Q058-152", "Q058-332", "Q058-326", "Q065-125")

replace symptomatic=0 if inlist(subjectno, "P036-266","P043-069","P043-199", "Q058-152", "Q058-332", "Q058-326", "Q065-125")


**************************************************
*Table 2                                         *
**************************************************

******************************************************
* All-cause Respiratory illness analysis    Table 2  *
******************************************************

tab respiratoryill
gen respiratoryill_num=.
replace respiratoryill_num=1 if respiratoryill=="POS"
replace respiratoryill_num=1 if PCR=="PCR" &  respiratoryill_num==.

replace respiratoryill_num=0 if respiratoryill_num==.


br subject treatment respiratoryill_num respiratoryill PCR covid19_final  if respiratoryill_num==1

tab  respiratoryill_num 
duplicates list if respiratoryill_num==1


tab  treatment respiratoryill_num, exact chi2 row 


br subject respiratoryill_num PCR covid19_final if respiratoryill_num==. & treatment==.

 ci proportions respiratoryill_num if treatment==1
 ci proportions respiratoryill_num if treatment==0

binreg respiratoryill_num treatment if  covid19_final!=., rr
 


*********************************
*Analysis of Endpoints          *
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
 br subjectno PCR_Res PCR symptomatic_Serumcovid site outcome_possible outcome type_data if treatment==1 & type_data=="serum" & symptomatic_Serumcovid==1
 br subjectno PCR_Res PCR symptomatic_Serumcovid site outcome_possible outcome type_data if treatment==0 & type_data=="serum" & symptomatic_Serumcovid==1
  
 tab treatment  symptomatic_Serumcovid, chi2 exact row, if type_data=="serum"
 

 ci   proportions symptomatic_Serumcovid  if treatment==1 & type_data=="serum"
 ci   proportions symptomatic_Serumcovid  if treatment==0 & type_data=="serum"
 binreg symptomatic_Serumcovid treatment if type_data=="serum", rr
  
  

**************************************************************
* Symptomatic Covid19 - Serology (dbs) endpoint  ITT Table 2 *
**************************************************************

 tab symptomatic DBScovid 

 gen  symptomatic_DBScovid=DBScovid if symptomatic==1
 replace symptomatic_DBScovid=0 if symptomatic_DBScovid==. & type_data=="DBS"
 replace symptomatic_DBScovid=0 if outcome=="NA"
  
 tab symptomatic_DBScovid type_data
 br subjectno PCR_Res PCR symptomatic_DBScovid site outcome_possible outcome type_data if treatment==1 & type_data=="DBS" & symptomatic_DBScovid==1
 br subjectno PCR_Res PCR symptomatic_DBScovid site outcome_possible outcome  type_data if treatment==0 & type_data=="DBS" & symptomatic_DBScovid==1
  
 tab treatment  symptomatic_DBScovid, chi2 exact row, if type_data=="DBS"
 
 ci   proportions symptomatic_DBScovid  if treatment==1 & type_data=="DBS"
 ci   proportions symptomatic_DBScovid  if treatment==0 & type_data=="DBS"
 binreg symptomatic_DBScovid treatment if type_data=="DBS", rr
 
 
****************************************************
* Asymptomatic Covid19   ITT   Table 2             *
**************************************************** 
 gen asymptomatic_covid=covid19_final            
 replace asymptomatic_covid=0 if symptomatic==1 & covid19_final!=.
 replace asymptomatic_covid=0 if covid19_final==.
 tab  treatment asymptomatic_covid, exact chi2 row
 ci proportions asymptomatic_covid if treatment==1
 ci proportions asymptomatic_covid if treatment==0
  binreg asymptomatic_covid treatment, rr
 
 
 
*****************************************
* All SARS-CoV-2 infection   ITT Table 2*
*****************************************

 replace covid19_final=0 if covid19_final==.
 tab  treatment covid19_final, exact chi2 row
 ci proportions covid19_final if treatment==1
 ci proportions covid19_final if treatment==0
 binreg covid19_final treatment, rr 
  
  
  
 **************************************************************
 * Table S3                                                   *
 **************************************************************
 
******************************************************************************************************************************************************* 
 
*****************************************
* Per Protocol (PP) ANALYSES Table S3   *
*****************************************
cd "\\henrietta\teams\ClinStudies\Statistics\VIR20001_COPCOV\Pimnara_Files\Datasets"

use  COP_Baseline_CQHCQvsPlacebo_table1, clear          // replace with PP population set
sort label
rename label subjectno 
capture drop _merge
merge 1:1 subjectno using COPCOV_PP_set
keep if _merge==3
drop _merge
merge 1:1 subjectno using Covid_19_DE_TP_ALL_new_22_12_2022
keep if _merge==3
drop _merge


*******************************************************************************************************************
*Moving participants "P036-266", "A12-069", "A12-199", "Q058-079", "Q058-152", "Q058-332", "Q058-326", "Q065-125" *
*to Asymptomatic category
*******************************************************************************************************************

br subjectno symptomatic PCR if inlist(subjectno, "P036-266","P043-069","P043-199", "Q058-152", "Q058-332", "Q058-326", "Q065-125")

replace symptomatic=0 if inlist(subjectno, "P036-266","P043-069","P043-199", "Q058-152", "Q058-332", "Q058-326", "Q065-125")


******************************************************
*Respiratory illness Table S3                        *
******************************************************

tab respiratoryill
gen respiratoryill_num=.
replace respiratoryill_num=1 if respiratoryill=="POS"
replace respiratoryill_num=1 if PCR=="PCR" &  respiratoryill_num==.
replace respiratoryill_num=0 if respiratoryill_num==.


br subject treatment respiratoryill_num respiratoryill PCR covid19_final  if respiratoryill_num==1

tab  respiratoryill_num 
duplicates list if respiratoryill_num==1

tab  treatment respiratoryill_num, exact chi2 row 


br subject respiratoryill_num PCR covid19_final if respiratoryill_num==. & treatment==.

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
* PCR endpoint   Symptomatic Covid19     Per Protocol (PP) Table S3  *
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
 br subjectno PCR_Res PCR symptomatic_Serumcovid site outcome_possible outcome type_data if treatment==1 & type_data=="serum" & symptomatic_Serumcovid==1
 br subjectno PCR_Res PCR symptomatic_Serumcovid site outcome_possible outcome type_data if treatment==0 & type_data=="serum" & symptomatic_Serumcovid==1
  
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
 br subjectno PCR_Res PCR symptomatic_DBScovid site outcome_possible outcome type_data if treatment==1 & type_data=="DBS" & symptomatic_DBScovid==1
 br subjectno PCR_Res PCR symptomatic_DBScovid site outcome_possible outcome  type_data if treatment==0 & type_data=="DBS" & symptomatic_DBScovid==1
  
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
 

 
 
 
 ******************************************************************
 *Table S1                                                        *
 ******************************************************************
 
use COP_Baseline_CQHCQvsPlacebo_table1, clear
sort label
rename label subjectno 
capture drop _merge
merge 1:1 subjectno using Covid_19_DE_TP_ALL_new_22_12_2022
drop _merge
br



***********************************************************************************************************************
* Assigning participants "P036-266", "A12-069", "A12-199", "Q058-079", "Q058-152", "Q058-332", "Q058-326", "Q065-125" *
* to Asymptomatic category following algorithm                                                                        *
***********************************************************************************************************************

br subjectno symptomatic PCR if inlist(subjectno, "P036-266","P043-069","P043-199", "Q058-152", "Q058-332", "Q058-326", "Q065-125")

replace symptomatic=0 if inlist(subjectno, "P036-266","P043-069","P043-199", "Q058-152", "Q058-332", "Q058-326", "Q065-125")


******************************************************
*Respiratory illness                                 *
******************************************************

tab respiratoryill
gen respiratoryill_num=.
replace respiratoryill_num=1 if respiratoryill=="POS"
replace respiratoryill_num=1 if PCR=="PCR" &  respiratoryill_num==.

replace respiratoryill_num=0 if respiratoryill_num==.


br subject treatment respiratoryill_num respiratoryill PCR covid19_final  if respiratoryill_num==1

tab  respiratoryill_num 
duplicates list if respiratoryill_num==1

tab  treatment respiratoryill_num, exact chi2 row 


br subject respiratoryill_num PCR covid19_final if respiratoryill_num==. & treatment==.

 ci proportions respiratoryill_num if treatment==1
 ci proportions respiratoryill_num if treatment==0

binreg respiratoryill_num treatment if  covid19_final!=., rr
 


***************************************************************************************
* Primary endpoint - Symptomatic covid19   include only Asssessable by SEAC  Table S1 *
***************************************************************************************

 
 gen symptomatic_covid=covid19_final            
 replace symptomatic_covid=0 if symptomatic==0 & covid19_final!=.
 
 tab  symptomatic_covid
 tab  treatment symptomatic_covid, exact chi2 row
 tab treatment
 tab treatment, nolab
 ci proportions symptomatic_covid if treatment==1
 ci proportions symptomatic_covid if treatment==0
 
 binreg symptomatic_covid treatment, rr

 
 
*****************************************************************************************
* PCR endpoint   Symptomatic Covid19    include only Asssessable by SEAC Table S1       *
***************************************************************************************** 
 tab symptomatic PCRcovid 

 tab  treatment PCRcovid, exact chi2 row
 tab  treatment
 tab  treatment, nolab
 ci   proportions PCRcovid if treatment==1
 ci   proportions PCRcovid if treatment==0
  binreg PCRcovid treatment, rr
 
**************************************************************************************
* Symptomatic Covid19  -  Serology (Serum) include only Asssessable by SEAC Table S1 *
**************************************************************************************

 tab symptomatic Serumcovid 

 gen  symptomatic_Serumcovid=Serumcovid if symptomatic==1 
 replace symptomatic_Serumcovid=0 if symptomatic_Serumcovid==. & type_data=="serum"
 replace symptomatic_Serumcovid=0 if outcome=="NA"
 
 tab symptomatic_Serumcovid type_data
 br subjectno PCR_Res PCR symptomatic_Serumcovid site outcome_possible outcome type_data if treatment==1 & type_data=="serum" & symptomatic_Serumcovid==1
 br subjectno PCR_Res PCR symptomatic_Serumcovid site outcome_possible outcome type_data if treatment==0 & type_data=="serum" & symptomatic_Serumcovid==1
  
 tab treatment  symptomatic_Serumcovid, chi2 exact row, if type_data=="serum"
 

 ci   proportions symptomatic_Serumcovid  if treatment==1 & type_data=="serum"
 ci   proportions symptomatic_Serumcovid  if treatment==0 & type_data=="serum"
 binreg symptomatic_Serumcovid treatment if type_data=="serum", rr
  
  

********************************************************************************************
* Symptomatic Covid19 - Serology (dbs) endpoint  include only Asssessable by SEAC Table S1 *
********************************************************************************************

 tab symptomatic DBScovid 

 gen  symptomatic_DBScovid=DBScovid if symptomatic==1
 replace symptomatic_DBScovid=0 if symptomatic_DBScovid==. & type_data=="DBS"
 replace symptomatic_DBScovid=0 if outcome=="NA"
  
 tab symptomatic_DBScovid type_data
 br subjectno PCR_Res PCR symptomatic_DBScovid site outcome_possible outcome type_data if treatment==1 & type_data=="DBS" & symptomatic_DBScovid==1
 br subjectno PCR_Res PCR symptomatic_DBScovid site outcome_possible outcome  type_data if treatment==0 & type_data=="DBS" & symptomatic_DBScovid==1
  
 tab treatment  symptomatic_DBScovid, chi2 exact row, if type_data=="DBS"
 
 ci   proportions symptomatic_DBScovid  if treatment==1 & type_data=="DBS"
 ci   proportions symptomatic_DBScovid  if treatment==0 & type_data=="DBS"
 binreg symptomatic_DBScovid treatment if type_data=="DBS", rr
 

 
*********************************************************************
* Asymptomatic Covid19   include only Asssessable by SEAC Table S1  * 
********************************************************************* 
 gen asymptomatic_covid=covid19_final            
 replace asymptomatic_covid=0 if symptomatic==1 & covid19_final!=.
 
 tab  treatment asymptomatic_covid, exact chi2 row
 ci proportions asymptomatic_covid if treatment==1
 ci proportions asymptomatic_covid if treatment==0
 
 binreg asymptomatic_covid treatment, rr
 
 
 
***********************************************************************
*All SARS-CoV-2 infection  include only Asssessable by SEAC Table S1  *
***********************************************************************

 tab  treatment covid19_final, exact chi2 row

 ci proportions covid19_final if treatment==1
 ci proportions covid19_final if treatment==0
  binreg covid19_final treatment, rr 
  
