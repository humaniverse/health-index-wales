# ---- Load packages ----
library(tidyverse)
library(geographr)

# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22


# Respiratory Conditions data
# Source: https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/GMS-Contract/diseaseregisters-by-localhealthboard

temp_zip <- tempfile(fileext = ".zip")
temp_dir <- tempdir()

download.file(
  "https://statswales.gov.wales/Download/File?fileName=HLTH1113.zip",
  destfile = temp_zip,
  mode = "wb"
)

unzip(temp_zip, exdir = temp_dir)

unzipped_files <- list.files(temp_dir, full.names = TRUE)

respiratory_conditions_raw <- read_csv(unzipped_files[2])


respiratory_conditions <- respiratory_conditions_raw |>
  filter(
    `Year_Code_INT` == "2024",
    `Register_ItemName_ENG_STR` %in%
      c("Asthma", "Chronic obstructive pulmonary disease"),
    `Measure_ItemName_ENG_STR` == "Prevalence rate (%)"
  ) |>
  group_by(Area_ItemName_ENG_STR) |>
  mutate(
    respiratory_conditions_percentage = mean(Data_DEC, na.rm = TRUE)
  ) |>
  ungroup() |>
  distinct(respiratory_conditions_percentage, .keep_all = TRUE)


# Join datasets
people_respiratory_conditions <- respiratory_conditions |>
  left_join(wales_hb_ltla, by = c("Area_ItemName_ENG_STR" = "lhb22_name")) |>
  filter(!is.na(ltla21_code)) |>
  select(
    ltla24_code = ltla21_code,
    respiratory_conditions_percentage,
    year = Year_Code_INT
  )

people_respiratory_conditions <- people_respiratory_conditions |>
  mutate(domain = "people") |>
  mutate(subdomain = "physical health conditions") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(people_respiratory_conditions, overwrite = TRUE)
