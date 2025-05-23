# ---- Load packages ----
library(tidyverse)
library(geographr)
library(httr)
library(readxl)


# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22


# Alcohol Misuse data
# Source: https://phw.nhs.wales/publications/publications1/data-mining-wales-the-annual-profile-for-substance-misuse-2023-2024/

alcohol_misuse_raw <- read_excel("data-raw/healthy-lives/raw-data/alcohol_misuse.xlsx")

alcohol_misuse <- alcohol_misuse_raw |>
  mutate(
    `Local Authority` = str_remove(`Local Authority`, "^The\\s+"),
    year = "2023/24"
  )


# Join datasets
lives_alcohol_misuse <- alcohol_misuse |>
  left_join(wales_hb_ltla, by = c("Local Authority" = "ltla21_name")) |>
  select(
    ltla24_code = ltla21_code,
    alcohol_admissions_rate_per_100k = `EASR per 100,000 population 2023/24`,
    year
  ) |>
  filter(!is.na(ltla24_code))

lives_alcohol_misuse <- lives_alcohol_misuse |>
  mutate(domain = "lives") |>
  mutate(subdomain = "behavioural risk factors") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(lives_alcohol_misuse, overwrite = TRUE)
