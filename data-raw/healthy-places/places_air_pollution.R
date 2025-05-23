# ---- Load packages ----
library(tidyverse)
library(geographr)

# ---- Get and clean data ----
# Wales LTLA Code
wales_ltla25 <- lookup_ward21_ltla21 |>
  filter(str_starts(ltla21_code, "W")) |>
  distinct(ltla21_code, .keep_all = TRUE) |>
  select(
    ltla25_name = ltla21_name,
    ltla25_code = ltla21_code
  )

# Air Pollution data
# Source: https://uk-air.defra.gov.uk/data/pcm-data

air_pollution_raw <-
  read_csv(
    "https://uk-air.defra.gov.uk/datastore/pcm/popwmpm252019byUKlocalauthority.csv",
    skip = 2
  )

# Use the anthropogenic component for health burden calculations
air_pollution <-
  air_pollution_raw |>
  select(
    ltla25_name = `Local Authority`,
    air_pollution_weighted = `PM2.5 2019 (anthropogenic)`
  )

# Join datasets
places_air_pollution <-
  wales_ltla25 |>
  left_join(air_pollution, by = "ltla25_name") |>
  select(
    ltla24_code = ltla25_code,
    air_pollution_weighted
  ) |>
  mutate(year = "2019")

places_air_pollution <- places_air_pollution |>
  mutate(domain = "places") |>
  mutate(subdomain = "living conditions") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(places_air_pollution, overwrite = TRUE)
