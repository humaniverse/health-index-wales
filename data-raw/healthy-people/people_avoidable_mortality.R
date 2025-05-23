# ---- Load packages ----
library(tidyverse)
library(httr)
library(readxl)
library(geographr)

# ---- Get and clean data ----
# Wales LA Code
wales_la <- lookup_ltla22_ltla23 |>
  filter(str_starts(ltla23_code, "W"))


# Avoidable Mortality data
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/causesofdeath/datasets/avoidablemortalitybylocalauthorityinenglandandwales

tf <- tempfile(fileext = ".xlsx")
download.file("https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/healthandsocialcare/causesofdeath/datasets/avoidablemortalitybylocalauthorityinenglandandwales/2022/avoidablemortalitybylocalauthority2022postcheckgc.xlsx", tf, mode = "wb")

avoidable_mortality_raw <- read_excel(tf, sheet = 5, skip = 6)

avoidable_mortality <- avoidable_mortality_raw |>
  filter(
    str_starts(`Area Code`, "W"),
    `Area Code` != "W92000004",
    Sex == "Persons"
  )

# Join datasets
people_avoidable_mortality <- avoidable_mortality |>
  left_join(wales_la, by = c("Area Code" = "ltla22_code")) |>
  mutate(year = "2020-2022") |>
  select(
    ltla24_code = ltla23_code,
    avoidable_deaths_per_100k = `Rate per 100,000 population\r\n2020-2022`,
    year
  )

people_avoidable_mortality <- people_avoidable_mortality |>
  mutate(domain = "people") |>
  mutate(subdomain = "mortality") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(people_avoidable_mortality, overwrite = TRUE)
