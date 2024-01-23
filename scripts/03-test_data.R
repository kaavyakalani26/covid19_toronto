#### Preamble ####
# Purpose: Tests the cleaned dataset 
# Author: Kaavya Kalani
# Date: 23 January 2024
# Contact: kaavya.kalani@mail.utoronto.ca
# License: MIT
# Pre-requisites: run scripts/01-download_data.R followed by scripts/02-data_cleaning.R

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
covid19_data <- read_csv("outputs/data/covid19_data.csv")

#### Test ####
# datatypes
class(covid19_data$id) == "numeric"
class(covid19_data$age_group) == "character"
class(covid19_data$classification) == "character"
class(covid19_data$reported_date) == "Date"
class(covid19_data$outcome) == "character"
class(covid19_data$hospitalised) == "character"
class(covid19_data$icu) == "character"

# no na in any columns
all(!is.na(cleaned_data))

# all confirmed cases 
all(cleaned_data$classification == "confirmed")

# all cases before 2022-12-31
all(cleaned_data$reported_date <= as.Date("2022-12-31"))

# Test 4: Outcome is either resolved or fatal
all(cleaned_data$outcome %in% c("resolved", "fatal"))

# Test 5: Hospitalised either yes or no
all(cleaned_data$hospitalised %in% c("yes", "no"))

# Test 6: ICU either yes or no
all(cleaned_data$icu %in% c("yes", "no"))
