# ---- Load packages ----
library(tidyverse)
library(geographr)


# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22


# Low Birth Weight data
# Source: https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Community-Child-Health/livebirthstowelshresidents-by-localhealthboard-birthweight

low_birth_weight_raw <- read_csv(
  "data-raw/healthy-lives/raw-data/low_birth_weight.csv",
  skip = 6
)


low_birth_weight <- low_birth_weight_raw |>
  mutate(
    low_birth_weight_total = (`<2000g` + `2000-2499g`),
    low_birth_weight_percentage = (low_birth_weight_total / Total) * 100,
    year = "2023"
  )


# Join datasets
lives_low_birth_weight <- low_birth_weight |>
  left_join(wales_hb_ltla, by = c("...3" = "ltla21_name")) |>
  filter(!is.na(ltla21_code)) |>
  select(
    ltla24_code = ltla21_code,
    low_birth_weight_percentage,
    year
  )

lives_low_birth_weight <- lives_low_birth_weight |>
  mutate(domain = "lives") |>
  mutate(subdomain = "physiological risk factors") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(lives_low_birth_weight, overwrite = TRUE)
