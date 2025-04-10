# ---- Load packages ----
library(tidyverse)
library(readxl)
library(devtools)

# ---- Scrape URL ----
# Source: https://phw.nhs.wales/services-and-teams/child-measurement-programme/cmp-2022-23/
cmp_url <- "https://phw.nhs.wales/services-and-teams/child-measurement-programme/cmp-2022-23/2-cmp-data-2022-2023/"

# ---- Download and read URL as temp file ----
temp_file <- tempfile(fileext = ".xlsx")
download.file(cmp_url, temp_file, mode = "wb")

# ---- Clean data ----
# Create variable for unwanted rows
unwanted_rows <- c(
  "Wales", "Least deprived fifth", "Next least deprived",
  "Middle deprived", "Next most deprived", "Most deprived fifth",
  "Betsi Cadwaladr UHB", "Swansea Bay UHB", "Cwm Taf Morgannwg UHB",
  "Cardiff and Vale UHB", "Hywel Dda UHB", "Aneurin Bevan UHB"
)

# Filter dataset
reception_overweight_obese <- read_excel(temp_file, sheet = "3b", range = "A4:J38") |> # Select correct tab on excel spreadsheet
  filter(!Geography %in% unwanted_rows) |> # Filter to only include rows with ltlas
  mutate(Geography = recode(Geography, "Powys THB" = "Powys")) |> # Change name for Powys so works for join
  select(Geography,
         percentage_overweight_obese = `91st centile and above (%)`) # Select only required columns

# ---- Scrape ltla lookup file ----
# Because dataset only include ltla names, we want ltla codes
# Specify the URL
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup
url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/migrationwithintheuk/datasets/userinformationenglandandwaleslocalauthoritytoregionlookup/june2020/lasregionew2021lookup.xlsx"

# Download the file to a temporary location
temp_file <- tempfile(fileext = ".xlsx")
download.file(url, temp_file, mode = "wb")
temp_ltla_file <- tempfile(fileext = ".xlsx")

# Only include relevant columns
code_lookup <- read_excel(temp_file, range = "A5:D366")|>
  filter(str_starts(`LA code`, "W0")) |> # Only include Welsh ltlas
  select(`LA code`, `LA name`)

# ---- Join ltla lookup to reception overweight obese dataset ----
hl_reception_overweight_obese <- left_join(code_lookup, reception_overweight_obese, by = c("LA name" = "Geography")) |>
  mutate(Year = "2022-2023") |> # Add year column
  select(-`LA name`)

# ---- Saving to data/ folder using usethis:: ----
usethis::use_data(hl_reception_overweight_obese, overwrite = TRUE)