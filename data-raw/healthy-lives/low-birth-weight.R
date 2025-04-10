# ---- Loading packages ----
library(tidyverse)
library(devtools)
library(statswalesr)

# ---- Scrape URL from stats wales ----
# Source: https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Community-Child-Health
df <- statswales_get_dataset("hlth1211")

# ---- Clean data ----
# Filtered dataset includes percentage of low weight births (< 2500g) in Wales
hl_low_birth_weight <- df |>
  filter(str_starts(Year_ItemName_ENG, "2023") & # Filter for most recent data
    str_starts(Area_AltCode1, "W0")) # Filter to only include Welsh ltlas
    str_starts(Measure_ItemNotes_ENG, "Percentage of singleton births") |> # Filter for total number of singleton births (one birth, rather than twins)
  select(
    "ltla21_code" = Area_AltCode1,
    "Low birth weight" = Data,
    "Year" = Year_ItemName_ENG
  ) |>
  arrange(ltla21_code) # Arrange in order of ltla code

# ---- Saving to the data/ folder ----
usethis::use_data(hl_low_birth_weight, overwrite = TRUE)
