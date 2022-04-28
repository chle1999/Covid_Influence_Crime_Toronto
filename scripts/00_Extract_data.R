# install.packages("janitor")
# install.packages("purrr")
# install.packages("tidyverse")
# install.packages("stringi")
# install.packages("here")
library(janitor)
library(purrr)
library(tidyverse)
library(stringi)
library(here)

# read original data set from inputs
covid_origin <- read_csv(paste(here(), "/inputs/data/COVID19_cases.csv", sep = "")) 
crime_origin <- read_csv(paste(here(), "/inputs/data/Major_Crime_Indicators.csv", sep = ""))
annual_crime_origin <- read_csv(paste(here(), "/inputs/data/Neighbourhood_Crime_Rates.csv", sep = "")) 

# filter the annual_crime_origin by attractive topics of crime
crime_types <- c("Assault", "AutoTheft", "BreakAndEnter", "Robbery", "TheftOver", "Homicide", "Shootings")
filter1 <- vector()
for (i in 1:length(crime_types)) {
  for (j in 2014:2020) {
    word <- paste(as.character(crime_types[i]), as.character(j), sep = "_")
    filter1 <- filter1 %>% append(word)
  }
}
annual_crime <- annual_crime_origin %>% subset(select = filter1) %>% colSums()
final_annual_crime <- tibble(Year=(2014:2020))
year_number = length((2014:2020))
for (i in 1:length(crime_types)) {
  tmp <- vector()
  for (j in 1:year_number) {
    number = 7*(i-1)+j
    tmp <- tmp %>% append(annual_crime[number])
  }
  typeof(crime_types[i])
  final_annual_crime <- final_annual_crime %>% mutate(tmp)
  names(final_annual_crime)[names(final_annual_crime) == "tmp"] <- crime_types[i]
}

# save the data to output folder
write.csv(final_annual_crime, paste(here(), "/outputs/data/", "Annual_Crime.csv", sep = ""), row.names = FALSE)
write.csv(covid_origin, paste(here(), "/outputs/data/", "COVID19_cases_raw.csv", sep = ""), row.names = FALSE)
write.csv(crime_origin, paste(here(), "/outputs/data/", "Major_Crime_Indicators_raw.csv", sep = ""), row.names = FALSE)
write.csv(annual_crime_origin, paste(here(), "/outputs/data/", "Neighbourhood_Crime_Rates_raw.csv", sep = ""), row.names = FALSE)


