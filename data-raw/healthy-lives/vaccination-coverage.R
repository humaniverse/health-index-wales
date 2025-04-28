# ---- Load packages ----
library(tidyverse)
library(geographr)


# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22


# Vaccination Coverage data
# Source: https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/flying-start/childrenlivinginflyingstartnonflyingstartareaswhoarefullyimmunisedbytheir4thbirthday-by-localauthority

temp_zip <- tempfile(fileext = ".zip")
temp_dir <- tempdir()

download.file("https://statswales.gov.wales/Download/File?fileName=HLTH1257.zip", destfile = temp_zip, mode = "wb")

unzip(temp_zip, exdir = temp_dir)

unzipped_files <- list.files(temp_dir, full.names = TRUE)
print(unzipped_files)

vaccination_coverage_raw <- read_csv(unzipped_files[2])


vaccination_coverage <- vaccination_coverage_raw |>
  filter(`Year_ItemName_ENG_STR` == "2023-24",
         `FlyingStartStatus_ItemName_ENG_STR` == "All areas",
         `Measure_ItemName_ENG_STR` == "Percentage",
         `Area_AltCode1_STR`!= "W92000004")


# Join datasets
lives_child_vaccination_coverage <- vaccination_coverage |>
  left_join(wales_hb_ltla, by = c("Area_ItemName_ENG_STR" = "ltla21_name")) |>
  select(ltla25_code = ltla21_code,
         child_vaccination_coverage_percentage = Data_DEC,
         year = Year_ItemName_ENG_STR)


# ---- Save output to data/ folder ----
usethis::use_data(lives_child_vaccination_coverage, overwrite = TRUE)
