# ---- Load packages ----
library(tidyverse)
library(geographr)


# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22

# Sedentary Behaviour data
# Source: https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles/adultlifestyles-by-healthboard-from-202021

sedentary_behaviour_raw <- read_csv(
  "data-raw/healthy-lives/raw-data/adult_lifestyle.csv",
  skip = 8
)

sedentary_behaviour <- sedentary_behaviour_raw |>
  slice(18:20) |>
  filter(`...2` == "Active less than 30 minutes in previous week") |>
  pivot_longer(
    cols = everything(),
    names_to = "wales_areas",
    values_to = "sedentary_behaviour_percentage"
  )


# Join datasets
lives_sedentary_behaviour <- sedentary_behaviour |>
  left_join(wales_hb_ltla, by = c("wales_areas" = "ltla21_name")) |>
  filter(!is.na(ltla21_code)) |>
  mutate(year = "2021-22 and 2022-23") |>
  mutate(sedentary_behaviour_percentage = as.numeric(sedentary_behaviour_percentage)) |>
  select(ltla24_code = ltla21_code, sedentary_behaviour_percentage, year)

lives_sedentary_behaviour <- lives_sedentary_behaviour |>
  mutate(domain = "lives") |>
  mutate(subdomain = "behavioural risk factors") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(lives_sedentary_behaviour, overwrite = TRUE)
