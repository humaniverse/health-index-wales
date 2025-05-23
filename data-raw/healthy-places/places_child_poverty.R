# ---- Laod packages ----
library(tidyverse)
library(readODS)
library(httr)

# ---- Get and clean data ----
# Child Poverty
# Source: https://www.gov.uk/government/statistics/children-in-low-income-families-local-area-statistics-2014-to-2022

url <- "https://assets.publishing.service.gov.uk/media/641c5cdb5155a200136ad550/children-in-low-income-families-local-area-statistics-2014-to-2022.ods"

temp_ods <- tempfile(fileext = ".ods")
GET(url, write_disk(temp_ods, overwrite = TRUE))
child_poverty_raw <- read_ods(temp_ods, sheet = 8, skip = 9)


places_child_poverty <- child_poverty_raw |>
  filter(str_starts(`Area Code`, "W")) |>
  mutate(year = "2022") |>
  select(
    ltla24_code = "Area Code",
    child_poverty_percentage = `Percentage of children \nFYE 2022\n(%)\n[p] [note 3]`,
    year
  ) |>
  mutate(child_poverty_percentage = child_poverty_percentage * 100)

places_child_poverty <- places_child_poverty |>
  mutate(domain = "places") |>
  mutate(subdomain = "economic and working conditions") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(places_child_poverty, overwrite = TRUE)
