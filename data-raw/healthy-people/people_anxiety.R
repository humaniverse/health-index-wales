# ---- Load packages ----
library(tidyverse)

# ---- Get and clean data ----
# Anxiety
# Source: https://www.ons.gov.uk/datasets/wellbeing-local-authority/editions/time-series/versions/4

anxiety_raw <- read_csv("https://download.ons.gov.uk/downloads/datasets/wellbeing-local-authority/editions/time-series/versions/4.csv")

people_anxiety <- anxiety_raw |>
  filter(
    str_starts(`administrative-geography`, "W"),
    MeasureOfWellbeing == "Anxiety",
    `yyyy-yy` == "2022-23",
    `wellbeing-estimate` == "average-mean"
  ) |>
  filter(`administrative-geography` != "W92000004") |>
  select(
    ltla24_code = `administrative-geography`,
    anxiety_score_out_of_10 = `v4_3`,
    year = `Time`
  )

people_anxiety <- people_anxiety |>
  mutate(domain = "people") |>
  mutate(subdomain = "personal wellbeing") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(people_anxiety, overwrite = TRUE)
