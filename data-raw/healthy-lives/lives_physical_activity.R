# ---- Load packages ----
library(tidyverse)
library(geographr)


# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22

# Physical Activity data
# Source: https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles/adultlifestyles-by-healthboard-from-202021

physical_activity_raw <- read_csv("data-raw/healthy-lives/raw-data/adult_lifestyle.csv", skip = 8)

physical_activity <- physical_activity_raw |>
  slice(18:20) |>
  filter(`...2` == "Active at least 150 minutes in previous week") |>
  pivot_longer(
    cols = everything(),
    names_to = "wales_areas",
    values_to = "activity_levels_met_percentage"
  )


# Join datasets
lives_physical_activity <- physical_activity |>
  left_join(wales_hb_ltla, by = c("wales_areas" = "ltla21_name")) |>
  filter(!is.na(ltla21_code)) |>
  mutate(year = "2021-22 and 2022-23") |>
  mutate(activity_levels_met_percentage = as.numeric(activity_levels_met_percentage)) |>
  select(
    ltla24_code = ltla21_code,
    activity_levels_met_percentage,
    year
  )

lives_physical_activity <- lives_physical_activity |>
  mutate(domain = "lives") |>
  mutate(subdomain = "behavioural risk factors") |>
  mutate(is_higher_better = TRUE)


# ---- Save output to data/ folder ----
usethis::use_data(lives_physical_activity, overwrite = TRUE)
