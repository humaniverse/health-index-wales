# ---- Load packages ----
library(tidyverse)
library(geographr)

# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22


# High Blood Pressure data
# Source: https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/GMS-Contract/diseaseregisters-by-localhealthboard

temp_zip <- tempfile(fileext = ".zip")
temp_dir <- tempdir()

download.file("https://statswales.gov.wales/Download/File?fileName=HLTH1113.zip", destfile = temp_zip, mode = "wb")

unzip(temp_zip, exdir = temp_dir)

unzipped_files <- list.files(temp_dir, full.names = TRUE)
print(unzipped_files)

high_blood_pressure_raw <- read_csv(unzipped_files[2])


high_blood_pressure <- high_blood_pressure_raw |>
  filter(
    `Year_Code_INT` == "2024",
    `Register_ItemName_ENG_STR` == "Hypertension",
    `Measure_ItemName_ENG_STR` == "Prevalence rate (%)"
  )


# Join datasets
lives_high_blood_pressure <- high_blood_pressure |>
  left_join(wales_hb_ltla, by = c("Area_ItemName_ENG_STR" = "lhb22_name")) |>
  filter(!is.na(ltla21_code)) |>
  select(
    ltla24_code = ltla21_code,
    high_blood_pressure_percentage = Data_DEC,
    year = Year_Code_INT
  )

lives_high_blood_pressure <- lives_high_blood_pressure |>
  mutate(domain = "lives") |>
  mutate(subdomain = "physiological risk factors") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(lives_high_blood_pressure, overwrite = TRUE)
