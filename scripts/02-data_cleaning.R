#### Preamble ####
# Purpose: Cleans the raw data saved in inputs/data/unedited_data.csv to contain data we need for our analysis
# Author: Kaavya Kalani
# Date: 24 January 2024
# Contact: kaavya.kalani@mail.utoronto.ca
# License: MIT
# Pre-requisites: run scripts/01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Clean data ####
raw_data <- read_parquet("inputs/data/unedited_data.parquet") # loads in the raw data

cleaned_data <-
  raw_data |> 
  filter(Reported.Date <= "2022-12-31", # cases before 2023
         Classification == "CONFIRMED", # confirmed cases only
         Age.Group != "",
         Outcome != "ACTIVE") |> # cases which have a known outcome - fatal or resolved
  mutate(Reported.Date = as.Date(Reported.Date), # change the datatype
         Classification = tolower(Classification), # change case to be uniform
         Outcome = tolower(Outcome), # change case to be uniform
         Ever.Hospitalized = tolower(Ever.Hospitalized), # change case to be uniform
         Ever.in.ICU = tolower(Ever.in.ICU)) |> # change case to be uniform
  select(X_id, Age.Group, Reported.Date, Outcome, Ever.Hospitalized, Ever.in.ICU) # keeping only the relevant columns

# renaming columns for convenience and ease of understanding
cleaned_data <-
  cleaned_data |> 
  rename(id = X_id, age_group = Age.Group, reported_date = Reported.Date, outcome = Outcome, hospitalised = Ever.Hospitalized, icu = Ever.in.ICU)

#### Save data ####
write_csv(cleaned_data, "outputs/data/covid19_data.csv")
