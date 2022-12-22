# Primary analysis of the COPCOV trial

This github repository provides all code and data necessary to reproduce the primary analysis reported in "Hydroxychloroquine or chloroquine prevention of COVID-19:a double-blind placebo-controlled trial".

The repository is organised into multiple RMarkdown scripts and Stata do files:

* *endpoint_review_algorithm* includes the code provided by the blinded independent serological endpoint review committee (Prof Tim Peto and Dr David Eyre). This outputs endpoint assignments (seroconversion or sero-increase >4-fold) based on the available serological data. This is then merged with symptoms and PCR to derive the primary endpoint
* *Primary_endpoints* derives the primary endpoint (symptomatic COVID-19) and the secondary endpoints (asymptomatic SARS-CoV-2 infection, all SARS-CoV-2 infection), and gives number of primary endpoints by means of derivation (PCR, serum, or DBS). This should be run after running the endpoint review algorithm.
* *Time_to_event_curves* generates the primary Figure for the time to PCR+ (restricted to SARS-CoV-2 and then all-cause respiratory infections)
* *Days_lost_work* fit a zero-inflated Poisson regression model to the participant reported number of days of work lost and generates the Appendix XX.
* *meta_analysis* generates the forest plot and common effect meta-analysis for the efficacy endpoints and tolerability (discontinuation due to adverse effects)



# Required software

The primary analyses are done using Stata version 17.0 and R version 4.2.2.
For the RMarkdown scripts the following packages are needed:

* *tidyverse* version 1.3.2
* *readxl* version 1.4.1
* *lubridate* version 1.9.0
* *brms* version 2.18.0
* *Rcpp* version 1.0.9
* *meta* version 6.0.0



For access to the full dataset, a request to the MORU data access committee is required.

If you see any bugs please email me a jwatowatson at gmail dot com


