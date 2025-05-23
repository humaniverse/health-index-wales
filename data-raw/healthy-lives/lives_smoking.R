# ---- Load packages ----
library(tidyverse)
library(geographr)

# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22

# Smoking data
# Source: https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles/adultlifestyles-by-healthboard-from-202021
smoking_raw <- read_csv(
  "data-raw/healthy-lives/raw-data/adult_lifestyle.csv",
  skip = 8
)

smoking <- smoking_raw |>
  slice(2:5) |>
  filter(`...2` == "Smoker") |>
  pivot_longer(
    cols = everything(),
    names_to = "wales_areas",
    values_to = "smoking_percentage"
  )

# Join datasets
lives_smoking <- smoking |>
  left_join(wales_hb_ltla, by = c("wales_areas" = "ltla21_name")) |>
  filter(!is.na(ltla21_code)) |>
  mutate(year = "2021-22 and 2022-23") |>
  mutate(smoking_percentage = as.numeric(smoking_percentage)) |>
  select(
    ltla24_code = ltla21_code,
    smoking_percentage,
    year
  )

lives_smoking <- lives_smoking |>
  mutate(domain = "lives") |>
  mutate(subdomain = "behavioural risk factors") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(lives_smoking, overwrite = TRUE)
