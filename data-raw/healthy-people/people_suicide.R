# ---- Load packages ----
library(tidyverse)
library(httr)
library(readxl)


# ---- Get and clean data ----
# Suicide data
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/suicidesbylocalauthority

tf <- tempfile(fileext = ".xlsx")
download.file(
  "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/suicidesbylocalauthority/current/local.xlsx",
  tf,
  mode = "wb"
)

suicide_raw <- read_excel(tf, sheet = 6, skip = 6)


people_suicide <- suicide_raw |>
  filter(
    str_starts(`Area Code \r\n[note 2]`, "W"),
    `Area Code \r\n[note 2]` != "W92000004"
  ) |>
  mutate(year = "2021-2023") |>
  select(
    ltla24_code = `Area Code \r\n[note 2]`,
    suicide_rate_per_100k = `2021 to 2023 \r\nRate per 100,000 \r\n[note 4]`,
    year
  ) |>
  mutate(suicide_rate_per_100k = as.numeric(suicide_rate_per_100k))

people_suicide <- people_suicide |>
  mutate(domain = "people") |>
  mutate(subdomain = "mental health") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(people_suicide, overwrite = TRUE)
