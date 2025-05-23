# ---- Load packages ----
library(tidyverse)
library(readxl)
library(httr)


# ---- Get and clean data ----
# Mortality All Causes data
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/deathsregisteredinenglandandwalesseriesdrreferencetables


tf <- tempfile(fileext = ".xlsx")
download.file("https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/deathsregisteredinenglandandwalesseriesdrreferencetables/2023/annualdeathregistrations2023.xlsx", tf, mode = "wb")

mortality_all_causes_raw <- read_excel(tf, sheet = 5, skip = 4)

people_all_mortality <- mortality_all_causes_raw |>
  filter(
    str_starts(`Area code`, "W"),
    `Area code` != "W92000004",
    Sex == "All people",
    `Year of registration` == "2023",
    `Geography level` == "Unitary Authority"
  ) |>
  select(
    ltla24_code = `Area code`,
    all_deaths_per_100k = `Age Standardised Mortality Rate (ASMR)`,
    year = `Year of registration`
  )

people_all_mortality <- people_all_mortality |>
  mutate(domain = "people") |>
  mutate(subdomain = "mortality") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(people_all_mortality, overwrite = TRUE)
