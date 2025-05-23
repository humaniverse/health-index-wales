# ---- Load packages ----
library(tidyverse)
library(geographr)


# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22


# Overweight and Obese Children data
# Source: https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/flying-start/prevalenceofchildrenin-healthy-weight-categoriesforchildrenaged4to5yearsresidentwithinflyingstartandnonflyingstartareas-by-localauthority

temp_zip <- tempfile(fileext = ".zip")
temp_dir <- tempdir()

download.file("https://statswales.gov.wales/Download/File?fileName=HLTH1259.zip", destfile = temp_zip, mode = "wb")

unzip(temp_zip, exdir = temp_dir)

unzipped_files <- list.files(temp_dir, full.names = TRUE)
print(unzipped_files)

overweight_obesity_children_raw <- read_csv(unzipped_files[2])


overweight_obesity_children <- overweight_obesity_children_raw |>
  filter(
    `Year_ItemName_ENG_STR` == "2022/23",
    `Measure_ItemName_ENG_STR` == "All children",
    `Area_AltCode1_STR` != "W92000004"
  ) |>
  group_by(Area_AltCode1_STR) |>
  mutate(healthy_weight_percentage = mean(Data_DEC, na.rm = TRUE)) |>
  ungroup() |>
  distinct(Area_AltCode1_STR, .keep_all = TRUE) |>
  mutate(overweight_obesity_child_percentage = 100 - healthy_weight_percentage)


# Join datasets
lives_overweight_obesity_children <- overweight_obesity_children |>
  left_join(wales_hb_ltla, by = c("Area_ItemName_ENG_STR" = "ltla21_name")) |>
  select(
    ltla24_code = ltla21_code,
    overweight_obesity_child_percentage,
    year = Year_ItemName_ENG_STR
  )

lives_overweight_obesity_children <- lives_overweight_obesity_children |>
  mutate(domain = "lives") |>
  mutate(subdomain = "physiological risk factors") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(lives_overweight_obesity_children, overwrite = TRUE)

