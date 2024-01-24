#### Preamble ####
# Purpose: Download dataset containing information for all COVID-19 cases in Toronto
# Author: Kaavya Kalani
# Date: 24 January 2024
# Contact: kaavya.kalani@mail.utoronto.ca
# License: MIT
# Pre-requisites: none

#### Workspace setup ####
# install.packages("tidyverse")
# install.packages("opendatatoronto")
# install.packages("arrow")

library(opendatatoronto)
library(tidyverse)
library(arrow)

#### Download data ####
covid19_data <- 
  # Each package is associated with a unique id found in the "For 
  # Developers" tab of the page from Open Data Toronto
  # https://open.toronto.ca/dataset/covid-19-cases-in-toronto/ 
  list_package_resources("64b54586-6180-4485-83eb-81e8fae3b8fe") |>
  # Within that package, we are interested in the csv with cases' information
  filter(name == "COVID19 cases.csv") |>
  get_resource()

#### Save data as Parquet ####
write_parquet(covid19_data, "inputs/data/unedited_data.parquet")
