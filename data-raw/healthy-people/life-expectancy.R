# ---- Load packages ----
library(tidyverse)
library(readxl)
library(httr)


# ---- Get and clean data ----
# Life Expectancy data
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/healthandlifeexpectancies/datasets/lifeexpectancyforlocalareasofgreatbritain


tf <- tempfile(fileext = ".xlsx")
download.file("https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/healthandsocialcare/healthandlifeexpectancies/datasets/lifeexpectancyforlocalareasofgreatbritain/between2001to2003and2021to2023/lifeexpectancylocalareas.xlsx", tf, mode = "wb")

life_expectancy_raw <- read_excel(tf, sheet = 4, skip = 5)

people_life_expectancy <- life_expectancy_raw |>
  filter(
    Period == "2021 to 2023",
    str_starts(`Area code`, "W"),
    `Age group` == "<1",
    `Area code` != "W92000004",
    `Area type` == "Local Areas"
  ) |>
  group_by(`Area code`) |>
  mutate(life_expectancy_combined = mean(`Life expectancy`, na.rm = TRUE)) |>
  ungroup() |>
  distinct(`Area code`, .keep_all = TRUE) |>
  select(
    ltla25_code = `Area code`,
    life_expectancy_combined,
    year = `Period`
  )


# ---- Save output to data/ folder ----
usethis::use_data(people_life_expectancy, overwrite = TRUE)
