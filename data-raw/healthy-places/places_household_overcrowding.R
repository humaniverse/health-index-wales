# ---- Load packages ----
library(tidyverse)
library(httr)
library(readxl)

# ---- Get and clean data ----
# Household Overcrowding data
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/housing/datasets/overcrowdingandunderoccupancybyhouseholdcharacteristicsenglandandwalescensus2021

url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/housing/datasets/overcrowdingandunderoccupancybyhouseholdcharacteristicsenglandandwalescensus2021/census2021/hou04dataset.xlsx"
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")

overcrowding_raw <- read_excel(temp_file, sheet = 4, skip = 2)

places_household_overcrowding <- overcrowding_raw |>
  filter(
    str_starts(`Area code`, "W"),
    `Area code` != "W92000004"
  ) |>
  mutate(
    household_sum = rowSums(across(`Occupancy rating of -1 or less`:`Occupancy rating of +2 or more`), na.rm = TRUE),
    overcrowding_occupancy_rating = `Occupancy rating of -1 or less`,
    percentage_households_overcrowding = (overcrowding_occupancy_rating / household_sum) * 100,
    year = "2021"
  ) |>
  select(
    ltla24_code = `Area code`,
    percentage_households_overcrowding,
    year
  )

places_household_overcrowding <- places_household_overcrowding |>
  mutate(domain = "places") |>
  mutate(subdomain = "living conditions") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(places_household_overcrowding, overwrite = TRUE)
