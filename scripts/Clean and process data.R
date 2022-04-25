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
fianal_annual_crime <- tibble(Year=(2014:2020))
year_number = length((2014:2020))
for (i in 1:length(crime_types)) {
  tmp <- vector()
  for (j in 1:year_number) {
    number = 7*(i-1)+j
    tmp <- tmp %>% append(annual_crime[number])
  }
  typeof(crime_types[i])
  fianal_annual_crime <- fianal_annual_crime %>% mutate(tmp)
  names(fianal_annual_crime)[names(fianal_annual_crime) == "tmp"] <- crime_types[i]
}

# filter the each month covid patients number from Jan 2020 to Dec 2021
covid_number <- vector()
months = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
for (i in 2020:2021) {
  for (j in 1:length(months)) {
    number <- covid_origin %>% filter(grepl(paste(i, months[j], sep="-"), `Episode Date`)) %>% count()
    covid_number <- covid_number %>% append(number)
  }
}

# the lock down policy include two stage: Mar 2020 to Jul 2021 and Dec 2020 to May 2021
Lockdown <- c(rep("NO", 74), rep("YES", 5), rep("NO", 4), rep("YES", 6), rep("NO", 6), "YES")

months <- c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")

# filter the crime_origin by specific crime types(BreakAndEnter, Assault, AutoTheft) and years(2014:2021)
# filter the BreakAndEnter and combine covid data and lockdown data
BreakAndEnter <- tibble("Months"=(1:96))
Number <- vector()
for (i in 2014:2021) {
  for (j in 1:length(months)) {
    number <- crime_origin %>% filter(grepl("Break and Enter", `MCI`) | grepl("BreakAndEnter", `MCI`)) %>% filter(occurrenceyear == i & occurrencemonth == months[j]) %>% count()
    Number <- Number %>% append(number)
  }
}
BreakAndEnter <- BreakAndEnter %>% mutate("Number"=Number%>%unlist()) %>% mutate(Covid=c(rep(0, 72), covid_number)%>%unlist()) %>% mutate(Lockdown)

# filter the Assault and combine covid data and lockdown data
Assault <- tibble("Months"=(1:96))
Number <- vector()
for (i in 2014:2021) {
  for (j in 1:length(months)) {
    number <- crime_origin %>% filter(grepl("Assault", `MCI`)) %>% filter(occurrenceyear == i & occurrencemonth == months[j]) %>% count()
    Number <- Number %>% append(number)
  }
}
Assault <- Assault %>% mutate("Number"=Number%>%unlist()) %>% mutate(Covid=c(rep(0, 72), covid_number)%>%unlist()) %>% mutate(Lockdown)

# filter the AutoTheft and combine covid data and lockdown data
AutoTheft <- tibble("Months"=(1:96))
Number <- vector()
for (i in 2014:2021) {
  for (j in 1:length(months)) {
    number <- crime_origin %>% filter(grepl("Auto", `MCI`)) %>% filter(occurrenceyear == i & occurrencemonth == months[j]) %>% count()
    Number <- Number %>% append(number)
  }
}
AutoTheft <- AutoTheft %>% mutate("Number"=Number%>%unlist()) %>% mutate(Covid=c(rep(0, 72), covid_number)%>%unlist()) %>% mutate(Lockdown)
# save the df to csv files
write.csv(fianal_annual_crime, paste(here(), "/outputs/data/", "Annual_Crime.csv", sep = ""), row.names = FALSE)
write.csv(BreakAndEnter, paste(here(), "/outputs/data/", "BreakAndEnter.csv", sep = ""), row.names = FALSE)
write.csv(Assault, paste(here(), "/outputs/data/", "Assault.csv", sep = ""), row.names = FALSE)
write.csv(AutoTheft, paste(here(), "/outputs/data/", "AutoTheft.csv", sep = ""), row.names = FALSE)





