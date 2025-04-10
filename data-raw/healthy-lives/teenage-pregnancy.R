# ---- Load packages ----
library(tidyverse)
library(readxl)
library(httr)
library(demographr)

# ---- Scrape URL ----
# ---- Source: https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/conceptionandfertilityrates/datasets/quarterlyconceptionstowomenagedunder18englandandwales ----
pregnancy_url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/conceptionandfertilityrates/datasets/quarterlyconceptionstowomenagedunder18englandandwales/januarytojune2022/quarterlyconceptionsq1q22022.xlsx"

# ---- Download and read URL as temp file ----
pregnancy_temp_file <- tempfile(fileext = ".xlsx")
download.file(pregnancy_url, pregnancy_temp_file, mode = "wb")
pregnancy_data <- read_excel(pregnancy_temp_file)

# ---- Clean pregnancy data ----
# Create dataset for ltlas with available data for all quarters of the year
teenage_pregnancy_2021 <- read_excel(pregnancy_temp_file, sheet = "Table_1", range = "A8:I205") |>
  filter(str_starts(`Area of usual residence Code`, "W0") & # Filter column for only welsh ltlas
           !str_starts(`Area of usual residence Code`, "W06000009") & # Filter column to exclude ltlas with missing data for 2021
           !str_starts(`Area of usual residence Code`, "W06000021")) |>
  mutate(across(c(`Dec 2021`, `Sept 2021`, `June 2021`, `March 2021`), ~ as.numeric(.))) |> # Convert data to numeric
  mutate(`number of pregnancies` = `Dec 2021` + `Sept 2021` + `June 2021` + `March 2021`) |> # Add data for each 2021 quarter to get number of pregnancies for whole year
  mutate(Year = "2021") |> # Add year column
  select(`Area of usual residence Code`, `number of pregnancies`, `Year`)

#Create dataset for ltlas with missing data for 2021
#Instead uses data from 2020
teenage_pregnancy_2020 <- read_excel(pregnancy_temp_file, sheet = "Table_1", range = "A8:M205") |> # Read correct excel sheet
  filter(str_starts(`Area of usual residence Code`, "W06000021") | str_starts(`Area of usual residence Code`, "W06000009")) |> # Filter column to only include welsh ltlas with missing data for 2021
  mutate(across(c(`Dec 2020`, `Sept 2020`, `June 2020`, `March 2020`), ~ as.numeric(.))) |> # Convert data to numeric
  mutate(`number of pregnancies` = `Dec 2020` + `Sept 2020` + `June 2020` + `March 2020`) |> # Add data for each 2020 quarter to get number of pregnancies for whole year
  mutate(Year = "2020") |> #Add year column
  select(`Area of usual residence Code`, `number of pregnancies`, `Year`)

#Join the 2021 and 2020 datasets
teenage_pregnancy <- rbind(teenage_pregnancy_2021, teenage_pregnancy_2020)

# ---- Load population file ----
#Source: https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland
population_url <- "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland/mid2011tomid2022/myebtablesuk20112022.xlsx"

# ---- Download and read URL as temp file ----
population_temp_file <- tempfile(fileext = ".xlsx")
download.file(population_url, population_temp_file, mode = "wb")
population_data <- read_excel(population_temp_file)

#Clean population data
#Population women aged 15-17 column adds population aged 15, 16 and 17 for each ltla
population_data <- read_excel(population_temp_file, sheet = "MYEB1", range = "A2:Q65704") |>
  filter(str_starts(ladcode23, "W0") &  # Filter column for welsh local authority codes
           str_starts(sex, "F") &     # Filter column for females
           (str_starts(age, "15") | str_starts(age, "16") | str_starts(age, "17"))) |> # Filter column for only ages 15-17
  select(`Area of usual residence Code` = ladcode23,       
         age,
         population_2021) |>
  group_by(`Area of usual residence Code`) |>
  summarize("population women aged 15-17" = sum(population_2021), .groups = 'drop') # Groups by ltla code and adds the population for each age, then drops grouping
        
#Join population dataset to pregnancy dataset
pregnancy_population_data <- inner_join(teenage_pregnancy, population_data, by = "Area of usual residence Code")

# ---- Clean joined dataset
hl_teenage_pregnancy <- pregnancy_population_data |>
  mutate(`Percentage teenage pregnancies` = (`number of pregnancies` / `population women aged 15-17`) * 100) |> # Calculate as rate
  select("ltla21_code" = `Area of usual residence Code`,
         `Percentage teenage pregnancies`,
         `Year`) |>
  arrange(ltla21_code) # Arrange in order of ltla code

# ---- Save output to data/ folder ----
usethis::use_data(hl_teenage_pregnancy, overwrite = TRUE)  
