# ---- Load ----
library(tidyverse)
library(httr)
library(readxl)
library(geographr)
library(sf)

source("R/utils.R")

wales_lookup <-
  boundaries_lad %>%
  as_tibble() %>%
  select(starts_with("lad")) %>%
  filter_codes(lad_code, "^W")

# ---- Extract data ----
# Source: https://www.ons.gov.uk/datasets/wellbeing-local-authority/editions/time-series/versions/1
GET(
  "https://download.ons.gov.uk/downloads/datasets/wellbeing-local-authority/editions/time-series/versions/1.xlsx",
  write_disk(tf <- tempfile(fileext = ".xlsx"))
)

anxiety_raw <-
  read_excel(tf, sheet = "Dataset", skip = 2)

# The 'Average (mean)' estimate provides the score out of 0-10. The other estimates are
# thresholds (percentages) described in the QMI: https://www.ons.gov.uk/peoplepopulationandcommunity/wellbeing/methodologies/personalwellbeingintheukqmi
anxiety <-
  anxiety_raw %>%
  filter(Estimate == "Average (mean)") %>%
  filter(MeasureOfWellbeing == "Anxiety") %>%
  select(
    lad_code = `Geography code`,
    anxiety_score_out_of_10 = `2019-20`
  ) %>%
  right_join(wales_lookup) %>%
  select(-lad_name)

write_rds(anxiety, "data/vulnerability/health-inequalities/wales/healthy-people/anxiety.rds")