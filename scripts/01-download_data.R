#### Preamble ####
# Purpose: Download dataset containing information for all COVID-19 cases in Toronto
# Author: Kaavya Kalani
# Date: 23 January 2024
# Contact: kaavya.kalani@mail.utoronto.ca
# License: MIT
# Pre-requisites: none

#### Workspace setup ####
# install.packages("tidyverse")
# install.packages("opendatatoronto")

library(opendatatoronto)
library(tidyverse)

#### Download data ####
covid19_data <-
  # Each package is associated with a unique id  found in the "For 
  # Developers" tab of the relevant page from Open Data Toronto
  # https://open.toronto.ca/dataset/covid-19-cases-in-toronto/ 
  list_package_resources("64b54586-6180-4485-83eb-81e8fae3b8fe") |>
  # Within that package, we are interested in the 2021 dataset
  filter(name == "COVID19 cases.csv") |>
  # Having reduced the dataset to one row we can get the resource
  get_resource()


#### Save data ####
write_csv(covid19_data, "inputs/data/unedited_data.csv") 

