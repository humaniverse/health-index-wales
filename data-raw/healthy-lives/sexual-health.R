# ---- Load packages ----
library(tidyverse)
library(readxl)
library(httr)
library(geographr)
library(demographr)


# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22

# Wales Population Data
wales_population <- read_csv(
  "data-raw/healthy-lives/raw-data/wales-hb-populations.csv"
) |>
  select(lhb22_name = ...2, population = `All ages...15`) |>
  slice(-1:-3) |>
  mutate(population = as.numeric(population))

# Sexual Health data
# Source: https://phw.nhs.wales/publications/publications1/sexual-health-trends-in-wales-annual-report-2024/
sexual_health_raw <- read_excel(
  "data-raw/healthy-lives/raw-data/sexual_health.xlsx"
)

# SEXUAL HEALTH TESTING RATE
testing_number <- sexual_health_raw |>
  slice(12:19) |>
  mutate(
    `...2` = case_when(
      `...2` == "ABUHB" ~ "Aneurin Bevan University Health Board",
      `...2` == "BCUHB" ~ "Betsi Cadwaladr University Health Board",
      `...2` == "CTMUHB" ~ "Cwm Taf Morgannwg University Health Board",
      `...2` == "CVUHB" ~ "Cardiff and Vale University Health Board",
      `...2` == "HDUHB" ~ "Hywel Dda University Health Board",
      `...2` == "PTB" ~ "Powys Teaching Health Board",
      `...2` == "SBUHB" ~ "Swansea Bay University Health Board",
      TRUE ~ `...2`
    )
  ) |>
  filter(`...2` != "Unknown") |>
  select(lhb22_name = ...2, count = `2023`)

# Calculate rate per 100,000
testing_rate <-
  testing_number |>
  left_join(wales_population) |>
  mutate(testing_rate_per_100k = (count / population) * 100000) |>
  select(lhb22_name, testing_rate_per_100k)


# DIAGNOSIS RATE CHLAMYDIA
diagnosis_chlamydia <- read_excel(
  "data-raw/healthy-lives/raw-data/sexual_health.xlsx",
  sheet = 2
) |>
  slice(9:15) |>
  mutate(
    `...2` = case_when(
      `...2` == "ABUHB" ~ "Aneurin Bevan University Health Board",
      `...2` == "BCUHB" ~ "Betsi Cadwaladr University Health Board",
      `...2` == "CTMUHB" ~ "Cwm Taf Morgannwg University Health Board",
      `...2` == "CVUHB" ~ "Cardiff and Vale University Health Board",
      `...2` == "HDUHB" ~ "Hywel Dda University Health Board",
      `...2` == "PTB" ~ "Powys Teaching Health Board",
      `...2` == "SBUHB" ~ "Swansea Bay University Health Board",
      TRUE ~ `...2`
    )
  ) |>
  select(
    lhb22_name = `...2`,
    chlamydia_diagnosis_rate_per_100k = `2023`
  )


# DIAGNOSIS RATE GONORRHOEA
diagnosis_gonorrhoea <- read_excel(
  "data-raw/healthy-lives/raw-data/sexual_health.xlsx",
  sheet = 3
) |>
  slice(9:15) |>
  mutate(
    `...2` = case_when(
      `...2` == "ABUHB" ~ "Aneurin Bevan University Health Board",
      `...2` == "BCUHB" ~ "Betsi Cadwaladr University Health Board",
      `...2` == "CTMUHB" ~ "Cwm Taf Morgannwg University Health Board",
      `...2` == "CVUHB" ~ "Cardiff and Vale University Health Board",
      `...2` == "HDUHB" ~ "Hywel Dda University Health Board",
      `...2` == "PTB" ~ "Powys Teaching Health Board",
      `...2` == "SBUHB" ~ "Swansea Bay University Health Board",
      TRUE ~ `...2`
    )
  ) |>
  select(
    lhb22_name = `...2`,
    gonorrhoea_diagnosis_rate_per_100k = `2023`
  )


# DIAGNOSIS RATE SYPHILIS
diagnosis_syphilis <- read_excel(
  "data-raw/healthy-lives/raw-data/sexual_health.xlsx",
  sheet = 4
) |>
  slice(9:15) |>
  mutate(
    `...2` = case_when(
      `...2` == "ABUHB" ~ "Aneurin Bevan University Health Board",
      `...2` == "BCUHB" ~ "Betsi Cadwaladr University Health Board",
      `...2` == "CTMUHB" ~ "Cwm Taf Morgannwg University Health Board",
      `...2` == "CVUHB" ~ "Cardiff and Vale University Health Board",
      `...2` == "HDUHB" ~ "Hywel Dda University Health Board",
      `...2` == "PTB" ~ "Powys Teaching Health Board",
      `...2` == "SBUHB" ~ "Swansea Bay University Health Board",
      TRUE ~ `...2`
    )
  ) |>
  select(
    lhb22_name = `...2`,
    syphilis_diagnosis_rate_per_100k = `2023`
  )


# Join datasets
lives_sexual_health <- diagnosis_chlamydia |>
  left_join(diagnosis_gonorrhoea) |>
  left_join(diagnosis_syphilis) |>
  left_join(testing_rate) |>
  mutate(
    sexual_health_testing_diagnosis_rate_per_100k = (chlamydia_diagnosis_rate_per_100k +
      gonorrhoea_diagnosis_rate_per_100k +
      syphilis_diagnosis_rate_per_100k +
      testing_rate_per_100k) /
      4,
    year = "2023"
  ) |>
  left_join(wales_hb_ltla) |>
  select(
    ltla24_code = ltla21_code,
    sexual_health_testing_diagnosis_rate_per_100k,
    year
  )

# ---- Save output to data/ folder ----
usethis::use_data(lives_sexual_health, overwrite = TRUE)
