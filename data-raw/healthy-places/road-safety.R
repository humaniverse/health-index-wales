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

# Road Safety data
# Source: https://statswales.gov.wales/Catalogue/Transport/Roads/Road-Accidents/Casualties/numberofcasualties-by-quarter-year-localauthority-policeforce

temp_zip <- tempfile(fileext = ".zip")
temp_dir <- tempdir()

download.file("https://statswales.gov.wales/Download/File?fileName=TRAN0180.zip", destfile = temp_zip, mode = "wb")

unzip(temp_zip, exdir = temp_dir)

unzipped_files <- list.files(temp_dir, full.names = TRUE)
print(unzipped_files)

road_safety_raw <- read_csv(unzipped_files[3])

road_safety <- road_safety_raw |>
  filter(
    `AgeGroup_ItemName_ENG_STR` == "All ages",
    `Gender_ItemName_ENG_STR` == "Total",
    `Date_ItemName_ENG_STR` == "2023",
    `TypeofVehicle_ItemName_ENG_STR` == "All road users",
    `Severity_ItemName_ENG_STR` == "All severities",
    `ByHighwaysAgency_ItemName_ENG_STR` == "All roads"
  )

# Join datasets
places_road_safety <- road_safety |>
  left_join(wales_ltla25, b = c("Area_Code_STR" = "ltla25_code")) |>
  filter(!is.na(ltla25name)) |>
  mutate(year = "2023") |>
  select(
    ltla25_code = Area_Code_STR,
    road_accident_count = Data_INT,
    year
  )

# ---- Save output to data/ folder ----
usethis::use_data(places_road_safety, overwrite = TRUE)
