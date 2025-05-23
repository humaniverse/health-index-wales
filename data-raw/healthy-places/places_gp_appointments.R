# Ease of getting a GP appointment at convenient time
# From the National Survey for Wales 2021-22
# 
# Q: "How easy or difficult was it to get a convenient appointment?"
# A: Very easy; fairly easy; fairly difficult; very difficult
# 
# This question wasn't asked in the latest survey (2022-23)
# 
# Before running this code to update the data, you'll need to manually download
# the National Survey for Wales results:
# 1. Download the 'Results viewer: full-year survey' from https://www.gov.wales/national-survey-wales-results-viewer
# 2. This is an .xlsb file (a binary Excel worksheet). Open it in Excel and save
#    it to .xlsx format so the {readxl} package can open it.
#
# This data is for Local Health Boards; we will cast it to Local Authorities
library(tidyverse)
library(geographr)
library(readxl)

# ---- Create Local Health Board to Local Authority lookup ----
lhb_ltla_lookup <- 
  geographr::lookup_ltla21_lhb22 |> 
  select(lhb22_name, ltla21_code)

# ---- Load GP appointment data ----
# excel_sheets("data-raw/healthy-places/national-survey-results-viewer.xlsx")

# Manually figured out the cell range from the Results Viewer Excel file
gp_data <- read_excel("data-raw/healthy-places/raw-data/national-survey-results-viewer.xlsx", sheet = "Results", range = "A151:E158")

gp_data <- gp_data |> 
  rename(lhb22_name = `...1`)  

# ---- Join datasets ----
# We'll use the percentage of people reporting that it was 'very difficult' to
# get a GP appointment at a convenient time
places_gp_appointments <-
  gp_data |>
  left_join(lhb_ltla_lookup) |>
  select(ltla24_code = ltla21_code, gp_appointments_very_difficult = `Very difficult`) |>
  mutate(year = "2021-22") |>
  filter(!is.na(ltla24_code))

places_gp_appointments <- places_gp_appointments |>
  mutate(domain = "places") |>
  mutate(subdomain = "access to services") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(places_gp_appointments, overwrite = TRUE)
