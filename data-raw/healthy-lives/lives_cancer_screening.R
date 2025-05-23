# ---- Load packages ----
library(tidyverse)
library(geographr)
library(httr2)
library(readxl)

# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22

# Bowel screening data
# Source: https://phw.nhs.wales/services-and-teams/screening/bowel-screening/programme-reports/uptake-coverage-by-local-authority-and-health-boards/
bowel_url <- "https://phw.nhs.wales/services-and-teams/screening/bowel-screening/programme-reports/uptake-coverage-by-local-authority-and-health-boards/bsw-uptake-by-ua-and-hb-2021-22/"
download <- tempfile(fileext = ".xls")

request(bowel_url) |>
  req_perform(download)

bowel_raw <- read_excel(download, sheet = 2, skip = 2)

bowel <- bowel_raw |>
  left_join(wales_hb_ltla, by = c("Unitary Authority Name" = "ltla21_name")) |>
  select(
    ltla24_code = ltla21_code,
    bowel_screening_percentage = `Uptake %`
  ) |>
  filter(!is.na(ltla24_code))

# Cervical screening data
# Source: https://phw.nhs.wales/services-and-teams/cervical-screening-wales/information-resources/programme-reports/uptake-coverage-by-local-authority-and-health-boards/
cervical_url <- "https://phw.nhs.wales/services-and-teams/cervical-screening-wales/information-resources/programme-reports/uptake-coverage-by-local-authority-and-health-boards/csw-coverage-by-ua-and-hb-2021-22/"
download <- tempfile(fileext = ".xls")

request(cervical_url) |>
  req_perform(download)

cervical_raw <- read_excel(download, sheet = 2, skip = 2)

cervical <- cervical_raw |>
  mutate(
    `Unitary Authority Name` = case_when(
      `Unitary Authority Name` == "Anglesey" ~ "Isle of Anglesey",
      TRUE ~ `Unitary Authority Name`
    )
  ) |>
  left_join(wales_hb_ltla, by = c("Unitary Authority Name" = "ltla21_name")) |>
  select(
    ltla24_code = ltla21_code,
    cervical_screening_percentage = `Coverage %`
  ) |>
  filter(!is.na(ltla24_code))

# Breast screening data
# Source: https://phw.nhs.wales/services-and-teams/screening/breast-screening/programme-reports/uptake-coverage-by-local-authority-and-health-boards/
breast_url <- "https://phw.nhs.wales/services-and-teams/screening/breast-screening/programme-reports/uptake-coverage-by-local-authority-and-health-boards/uptake-coverage-by-local-authority-and-health-boards-as-at-may-2021/"
download <- tempfile(fileext = ".xls")

request(cervical_url) |>
  req_perform(download)

breast_raw <- read_excel(download, sheet = 2, skip = 2)

breast <- breast_raw |>
  mutate(
    `Unitary Authority Name` = case_when(
      `Unitary Authority Name` == "Anglesey" ~ "Isle of Anglesey",
      TRUE ~ `Unitary Authority Name`
    )
  ) |>
  left_join(wales_hb_ltla, by = c("Unitary Authority Name" = "ltla21_name")) |>
  select(
    ltla24_code = ltla21_code,
    breast_screening_percentage = `Coverage %`
  ) |>
  filter(!is.na(ltla24_code))

# Join datasets
lives_cancer_screening <- cervical |>
  left_join(bowel) |>
  left_join(breast) |>
  pivot_longer(!ltla24_code) |>
  summarise(
    total_cancer_screening_percentage = mean(value),
    .by = ltla24_code
  ) |>
  mutate(year = "2021-22")

lives_cancer_screening <- lives_cancer_screening |>
  mutate(domain = "lives") |>
  mutate(subdomain = "protective measures") |>
  mutate(is_higher_better = TRUE)

# ---- Save output to data/ folder ----
usethis::use_data(lives_cancer_screening, overwrite = TRUE)
