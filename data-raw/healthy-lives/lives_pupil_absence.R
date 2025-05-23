# ---- Load packages ----
library(tidyverse)
library(readODS)
library(geographr)

# ---- Get and clean data ----
# Wales LTLA and HB Codes
wales_hb_ltla <- lookup_ltla21_lhb22 |>
  select(ltla24_code = ltla21_code, ltla24_name = ltla21_name)

# Primary School Absenteeism data
# Source: https://www.gov.wales/absenteeism-primary-schools-september-2023-august-2024
primary_absenteeism_link <- "https://www.gov.wales/sites/default/files/statistics-and-research/2024-12/absenteeism-from-primary-schools-september-2023-to-august-2024-649.ods"
tempfile_p <- tempfile(fileext = ".ods")
download.file(primary_absenteeism_link, destfile = tempfile_p, mode = "wb")

primary_absenteeism_raw <- read_ods(tempfile_p, sheet = 10, skip = 3)

primary_absenteeism <- primary_absenteeism_raw |>
  filter(
    Measure == "Percentage of half-day sessions missed for unauthorised absence"
  ) |>
  select(ltla24_name = `Local authority`, primary_absence = `2023/24`)


# Secondary School Absenteeism data
# Source: https://www.gov.wales/absenteeism-secondary-schools-september-2023-august-2024
secondary_absenteeism_link <- "https://www.gov.wales/sites/default/files/statistics-and-research/2024-09/absenteeism-from-secondary-schools-september-2023-to-august-2024.ods"
tempfile_s <- tempfile(fileext = ".ods")
download.file(secondary_absenteeism_link, destfile = tempfile_s, mode = "wb")

secondary_absenteeism_raw <- read_ods(tempfile_s, sheet = 10, skip = 3)

secondary_absenteeism <- secondary_absenteeism_raw |>
  filter(
    Attribute ==
      "Percentage of half-day sessions missed for unauthorised absence"
  ) |>
  select(ltla24_name = `Local authority`, secondary_absence = `2023/24`)

# Join absenteeism data
pupil_absenteeism <- primary_absenteeism |>
  left_join(secondary_absenteeism) |>
  mutate(ltla24_name = str_remove(ltla24_name, "^The\\s+"))

# Join absenteeism and geographic data
lives_pupil_absence <- pupil_absenteeism |>
  left_join(wales_hb_ltla) |>
  summarise(
    total_pupil_absence_percentage = mean(c(
      primary_absence,
      secondary_absence
    )),
    .by = ltla24_code
  ) |>
  mutate(year = "2023/24")

lives_pupil_absence <- lives_pupil_absence |>
  mutate(domain = "lives") |>
  mutate(subdomain = "children and young people") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(lives_pupil_absence, overwrite = TRUE)
