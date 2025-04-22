# ---- Load packages ----
library(tidyverse)
library(readxl)
library(httr)


# ---- Get and clean data ----
# Disability Daily Activities data
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/healthandwellbeing/bulletins/disabilityenglandandwales/census2021#:~:text=In%20Wales%2C%20in%202021%2C%20a,(21.2%25%2C%20567%2C000).

tf <- tempfile(fileext = ".xlsx")
download.file("https://www.ons.gov.uk/visualisations/dvc2218/disability_fig2/datadownload.xlsx", tf, mode = "wb")

disability_daily_activities_raw <- read_excel(tf, skip = 4)

people_disability_daily_activities <- disability_daily_activities_raw |>
  filter(str_starts(`Area code`, "W")) |>
  mutate(across(c(`\r\nDisabled under the Equality Act: Day-to-day activities limited a lot\r\n2021\r\n(age-standardised proportion)`:`Not disabled under the Equality Act\r\n2021\r\n(age-standardised proportion)`), as.numeric),
         disability_activities_limited_percentage = `\r\nDisabled under the Equality Act: Day-to-day activities limited a lot\r\n2021\r\n(age-standardised proportion)` + `\r\nDisabled under the Equality Act: Day-to-day activities limited a little\r\n2021\r\n(age-standardised proportion)`,
         year = "2021") |>
  select(ltla25_code = `Area code`,
         disability_activities_limited_percentage,
         year)


# ---- Save output to data/ folder ----
usethis::use_data(people_disability_daily_activities, overwrite = TRUE)
