# ---- Load packages ----
library(tidyverse)
library(geographr)

# ---- Get and clean data ----
# Wales LTLA Code
wales_ltla25 <- lookup_ward21_ltla21 |>
  filter(str_starts(ltla21_code, "W")) |>
  distinct(ltla21_code, .keep_all = TRUE) |>
  select(
    ltla25name = ltla21_name,
    ltla25_code = ltla21_code
  )


# Unemployment data
# Source: https://statswales.gov.wales/Catalogue/Business-Economy-and-Labour-Market/People-and-Work/Economic-Inactivity/economicinactivityratesexcludingstudents-by-welshlocalarea-year

temp_zip <- tempfile(fileext = ".zip")
temp_dir <- tempdir()

download.file("https://statswales.gov.wales/Download/File?fileName=ECON0006.zip", destfile = temp_zip, mode = "wb")

unzip(temp_zip, exdir = temp_dir)

unzipped_files <- list.files(temp_dir, full.names = TRUE)
print(unzipped_files)

unemployment_raw <- read_csv(unzipped_files[1])

unemployment <- unemployment_raw |>
  filter(
    Age_Code_STR == "16To64",
    Gender_ItemName_ENG_STR == "Persons",
    Year_ItemName_ENG_STR == "Year ending 30 Sep 2024",
    Measure_ItemName_ENG_STR == "Economic inactivity rate (excluding students)"
  )

# Join datasets
places_unemployment <- unemployment |>
  left_join(wales_ltla25, by = c("Area_Code_STR" = "ltla25_code")) |>
  filter(!is.na(ltla25name)) |>
  mutate(year = "2023-24") |>
  select(
    ltla25_code = Area_Code_STR,
    unemployment_percentage = Data_DEC,
    year
  )


# ---- Save output to data/ folder ----
usethis::use_data(places_unemployment, overwrite = TRUE)
