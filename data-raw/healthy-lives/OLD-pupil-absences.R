# DATA NEEDS TO BE UPDATED AND REWORKED FOR 2023/24 COHORT AND COMBINED INTO
# ONE INDICATOR




# PRIMARY SCHOOL INTERN DATA


# ---- Load packages ----
library(tidyverse)
library(httr)
library(readODS)
library(dplyr)
library(readxl)

# ---- Scrape primary schools URL ----
# Source: https://www.gov.wales/absenteeism-primary-schools-september-2022-august-2023
# Create temporary directory and file path
temp_dir <- tempdir()
temp_file <- file.path(temp_dir, "absenteeism.ods")

# Download primary absences file to the temporary directory
download.file("https://www.gov.wales/sites/default/files/statistics-and-research/2024-03/absenteeism-from-primary-schools-september-2022-to-august-2023-113.ods", 
              destfile = temp_file)

# ---- Clean primary data ----
primary_data <- read_ods(temp_file, sheet = 10, range = "A4:J92")|> # Read correct sheet
  filter(str_ends(Measure, "missed")) |> # Filter for rows including missed half days (absences)
  select(`Local authority`,
         `Primary percentage of absences` = `2022/23` # Select required columns
  )

#Rename Vale of Glamorgan so it works for join
primary_data$`Local authority`[primary_data$`Local authority` == "The Vale of Glamorgan"] <- "Vale of Glamorgan"

# ---- Scrape ltla lookup file ----
# Because dataset only include ltla names, we need ltla codes
# Specify the URL
#Source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# Download the file to a temporary location
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")

#Only include relevant columns
code_lookup <- read_excel(temp_file, range = "A5:D366")|>
  filter(str_starts(`LA code`, "W0")) # Filter to only include Welsh ltlas

# ---- Join ltla lookup to absence dataset ----
joined_data <- left_join(primary_data, code_lookup, by = c("Local authority" = "LA name"))

# ---- Clean joined dataset ----
hl_primary_pupil_absences <- joined_data |>
  select(ltla21_code = `LA code`,
         `Primary percentage of absences`) |>
  mutate(Year = "2022/23") |> # Create year column
  arrange(ltla21_code)

# ---- Save output to data/ folder ----
usethis::use_data(hl_primary_pupil_absences, overwrite = TRUE)         



# SECONDARY SCHOOL INTERN DATA


# ---- Load packages ----
library(tidyverse)
library(httr)
library(readODS)
library(dplyr)

# ---- Scrape secondary schools URL ----
# Source:https://www.gov.wales/absenteeism-secondary-schools-september-2022-august-2023
# Create temporary directory and file path
temp_dir <- tempdir()
temp_file <- file.path(temp_dir, "absenteeism.ods")

# Download primary absences file to the temporary directory
download.file("https://www.gov.wales/sites/default/files/statistics-and-research/2023-10/absenteeism-from-secondary-schools-september-2022-to-august-2023-revised-936.ods", 
              destfile = temp_file)

# ---- Clean secondary data ----
secondary_data <- read_ods(temp_file, sheet = 10, range = "A4:J92") |> # Read correct sheet
  filter(str_ends(Indicator, "missed")) |> # Filter for rows including missed half days (absences)
  select(`Local authority`,
         `Secondary percentage of absences` = `2022/23 [r]` # Select required columns
  )

# Rename Vale of Glamorgan and Cardiff so it works for join
secondary_data$`Local authority`[secondary_data$`Local authority` == "The Vale of Glamorgan"] <- "Vale of Glamorgan"
secondary_data$`Local authority`[secondary_data$`Local authority` == "Cardiff [r]"] <- "Cardiff"

# ---- Scrape ltla lookup file ----
# Because dataset only include ltla names, we need ltla codes
# Specify the URL
# Source:https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# Download the file to a temporary location
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")

# Select only relevant columns
code_lookup <- read_excel(temp_file, range = "A5:D366")|>
  filter(str_starts(`LA code`, "W0"))  # Filter to only include Welsh ltlas

# ---- Join ltla lookup to absence dataset ----
joined_data <- left_join(secondary_data, code_lookup, by = c("Local authority" = "LA name"))

# ---- Clean joined dataset ----
hl_secondary_pupil_absences <- joined_data |>
  select(ltla21_code = `LA code`,
         `Secondary percentage of absences`) |>
  mutate(Year = "2022/23") |> # Create year column
  arrange(ltla21_code)

# ---- Save output to data/ folder ----
usethis::use_data(hl_secondary_pupil_absences, overwrite = TRUE) 
