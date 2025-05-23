# ---- Load packages ----
library(tidyverse)
library(geographr)
library(httr)
library(readxl)

# ---- Get and clean data ----
# Wales LTLA and Postcode data
wales_lookup <- lookup_ltla24_csp24_pfa24 |>
  filter(str_starts(pfa24_code, "W"))


# Drug Misuse data
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/crimeandjustice/datasets/policeforceareadatatables

tf <- tempfile(fileext = ".xlsx")
download.file(
  "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/crimeandjustice/datasets/policeforceareadatatables/yearendingdecember2024/policeforceareatablesyedecember2024.xlsx",
  tf,
  mode = "wb"
)

drug_misuse_raw <- read_excel(tf, sheet = 6, skip = 7)

drug_misuse <- drug_misuse_raw |>
  filter(
    str_starts(`Area Code`, "W"),
    `Area Code` != "W92000004"
  )


# Join datasets
lives_drug_misuse <- drug_misuse |>
  left_join(wales_lookup, by = c("Area Code" = "pfa24_code")) |>
  mutate(year = "2024") |>
  select(
    ltla24_code,
    drug_misuse_per_1k = `Drug offences`,
    year
  ) |>
  mutate(drug_misuse_per_1k = as.numeric(drug_misuse_per_1k))

lives_drug_misuse <- lives_drug_misuse |>
  mutate(domain = "lives") |>
  mutate(subdomain = "behavioural risk factors") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(lives_drug_misuse, overwrite = TRUE)
