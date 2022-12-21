# Primary analysis of the COPCOV trial

This github repository provides all code and data necessary to reproduce the primary analysis reported in "Hydroxychloroquine or chloroquine prevention of COVID-19:a double-blind placebo-controlled trial".

The repository is organised into multiple RMarkdown scripts and stata do files:

* *endpoint_review_algorithm* includes the code provided by the blinded independent serological endpoint review committee (Prof Tim Peto and Dr David Eyre). This outputs endpoint assignments (seroconversion or sero-increase >4-fold) based on the available serological data. This is then merged with symptoms and PCR to derive the primary endpoint
* *Time_to_event_curves* generates the primary Figure for the time to PCR+ (restricted to SARS-CoV-2 and then all-cause respiratory infections)
* *Days_lost_work* fit a zero-inflated Poisson regression model to the participant reported number of days of work lost and generates the Appendix XX.
* *meta_analysis* generates the forest plot and fixed effect meta-analysis for the efficacy endpoints and tolerability (discontinuation due to adverse effects)


For access to the full dataset, a request to the MORU data access committee is required.

If you see any bugs please email me a jwatowatson at gmail dot com


