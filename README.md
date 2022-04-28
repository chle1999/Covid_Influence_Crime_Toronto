# Does Global Covid-19 Pandemic and Toronto Lockdown Policy Decrease the Crime Rate?

This report presents a secondary analysis of the change of the City of Toronto's crime rate change from 2016 to 2021. The results indicate that the Covid-19 Pandemic and corresponding government restrictions policy could affect the occurrence number and types of Toronto's crime rate. In detail, covid will cause a decrease in Assault but an increase in AutoTheft. The analysis consists of logistic regression performed with the statistical programming language R. The results contribute to our understanding of how to lower the crime rate, and help the Police department optimize the decision of crime elimination. Also, it can provide some useful insights for the government and policymakers regarding future strategic planning.

The final report can be viewed [here](https://github.com/chle1999/Covid_Influence_Crime_Toronto/blob/main/outputs/paper/paper.pdf).

## R Packages

In order to process the data and analysis, the following packages should be installed:

1. janitor()
2. pdftools()
3. purrr()
4. tidyverse() 
5. stringi()
6. kableExtra()
7. here()
8. readr()
9. knitr()
10. tinytex()
11. lme4()
12. rvest()
13. polite()
14. lmtest()
15. lmerTest()



## File Structure

The raw data are extracted from the report of IDHS 1998 pdf file downloaded from the DHS website, which is contained in the “input” folder.

The "output" folder contains the original R Markdown file containing the analysis carried out in R, a PDF version of the final paper, and the reference list.
