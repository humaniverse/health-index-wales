# ---- Load packages ----
library(tidyverse)

# ---- Get and clean data ----
# Life Satisfaction
# Source: https://www.ons.gov.uk/datasets/wellbeing-local-authority/editions/time-series/versions/4

life_satisfaction_raw <- read_csv("https://download.ons.gov.uk/downloads/datasets/wellbeing-local-authority/editions/time-series/versions/4.csv")

people_life_satisfaction <- life_satisfaction_raw |>
  filter(
    str_starts(`administrative-geography`, "W"),
    MeasureOfWellbeing == "Life satisfaction",
    `yyyy-yy` == "2022-23",
    `wellbeing-estimate` == "average-mean"
  ) |>
  filter(`administrative-geography` != "W92000004") |>
  select(
    ltla24_code = `administrative-geography`,
    satisfaction_score_out_of_10 = `v4_3`,
    year = `Time`
  )

people_life_satisfaction <- people_life_satisfaction |>
  mutate(domain = "people") |>
  mutate(subdomain = "personal wellbeing") |>
  mutate(is_higher_better = TRUE)


# ---- Save output to data/ folder ----
usethis::use_data(people_life_satisfaction, overwrite = TRUE)

