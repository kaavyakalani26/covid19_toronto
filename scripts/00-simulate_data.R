#### Preamble ####
# Purpose: Simulate the COVID-19 cases trend as visualised in intial sketches
# Author: Kaavya Kalani
# Date: 24 January 2024
# Contact: kaavya.kalani@mail.utoronto.ca
# License: MIT
# Pre-requisites: none

#### Workplace setup ####
#install.packages("tidyverse")
library(tidyverse)

#### Simulation ####
set.seed(1007846823)

# Function to generate outcome based on age
generate_outcome <- function(age) {
  if (age <= 40) {
    outcome_prob <- c(0.01, 0.99)
  } else if (age <= 65) {
    outcome_prob <- c(0.05, 0.95)
  } else if (age <= 75) {
    outcome_prob <- c(0.1, 0.9)
  } else {
    outcome_prob <- c(0.2, 0.8)
  }
  
  outcome <- sample(c("fatal", "non-fatal"), 1, prob = outcome_prob)
  return(outcome)
}

# Generate simulated tibble
simulated_data <- tibble(
  Date = seq(as.Date("2020-01-01"), as.Date("2022-12-31"), by = "days"),
  Age = as.integer(rnorm(length(Date), mean = 40, sd = 40) %>% pmax(5) %>% pmin(100)),
  Outcome = map_chr(Age, generate_outcome)
)

# View the first few rows of the simulated tibble
head(simulated_data)
