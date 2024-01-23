#### Preamble ####
# Purpose: Cleans the raw data saved in inputs/data/unedited_data.csv to contain data we need for our analysis
# Author: Kaavya Kalani
# Date: 23 January 2024
# Contact: kaavya.kalani@mail.utoronto.ca
# License: MIT
# Pre-requisites: run scripts/01-download_data.R

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Clean data ####
raw_data <- read_parquet("inputs/data/unedited_data.parquet")

cleaned_data <-
  raw_data |> 
  filter(Reported.Date <= "2022-12-31",
         Classification == "CONFIRMED",
         Age.Group != "",
         Outcome != "ACTIVE") |>
  mutate(Reported.Date = as.Date(Reported.Date),
         Classification = tolower(Classification),
         Outcome = tolower(Outcome),
         Ever.Hospitalized = tolower(Ever.Hospitalized),
         Ever.in.ICU = tolower(Ever.in.ICU)) |>
  select(X_id, Age.Group, Reported.Date, Outcome, Ever.Hospitalized, Ever.in.ICU)

cleaned_data <-
  cleaned_data |> 
  rename(id = X_id, age_group = Age.Group, reported_date = Reported.Date, outcome = Outcome, hospitalised = Ever.Hospitalized, icu = Ever.in.ICU)

#### Save data ####
write_csv(cleaned_data, "outputs/data/covid19_data.csv")
