# ---- Load packages ----
library(tidyverse)
library(statswalesr)

# ---- Scrape data from stats wales ----
# Source:https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles
df <- statswales_get_dataset("hlth5072")

# ---- Clean data ----
# Filtered dataset includes percentage of adults (age 16+) who claim to have had <30 minutes of physical activity the previous week, age standardised
# For Year, data from 2021-22 & 2022-23 has been combined
hl_sedentary_behaviour <- df |>
  filter(str_starts(Variable_ItemName_ENG, "Active less than 30 minutes in previous week") &
           str_starts(Measure_ItemName_ENG, "Percentage") & # Filters column to include only percentage of adults, excludes data on sample and confidence intervals
           str_starts(Year_SortOrder, "14") & # Filters column to only include 2021-22 and 2022-23
           str_starts(Standardisation_ItemName_ENG, "Age standardised") &
           str_starts(Area_Code, "W0")) |> # Filters column to only include local authority codes
  select(ltla21_code = Area_Code,
         `Percent adults active less than 30 minutes last week` = Data,
         Year = Year_ItemName_ENG)

# ---- Save output to data/ folder ----
usethis::use_data(hl_sedentary_behaviour, overwrite = TRUE)
