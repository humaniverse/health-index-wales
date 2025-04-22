# ---- Load packages ----
library(tidyverse)
library(httr)
library(readxl)


# ---- Get and clean data ----
# Teenage Pregnancy data
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/conceptionandfertilityrates/datasets/conceptionstatisticsenglandandwalesreferencetables

tf <- tempfile(fileext = ".xlsx")
download.file("https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/conceptionandfertilityrates/datasets/conceptionstatisticsenglandandwalesreferencetables/2021/conceptions2021dataset.xlsx", tf, mode = "wb")

teenage_pregnancy_raw <- read_excel(tf, sheet = 10, skip = 8)

lives_teenage_pregnancy <- teenage_pregnancy_raw |>
  filter(
    str_starts(`Code`, "W"),
    `Code` != "W92000004"
  ) |>
  mutate(year = "2021") |>
  select(
    ltla25_code = `Code`,
    teenage_pregnancies_per_1k = `2021 Conceptions at ages under 18 \r\nConception rate per 1,000 women in age-group`,
    year
  )


# ---- Save output to data/ folder ----
usethis::use_data(lives_teenage_pregnancy, overwrite = TRUE)
