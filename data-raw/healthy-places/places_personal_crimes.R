# ---- Load packages ----
library(tidyverse)
library(geographr)
library(httr)
library(readxl)

# ---- Get and clean data ----
# Wales LTLA and Postcode data
wales_lookup <- lookup_ltla24_csp24_pfa24 |>
  filter(str_starts(pfa24_code, "W"))


# Low-Level Crime data
# Source: https://www.ons.gov.uk/peoplepopulationandcommunity/crimeandjustice/datasets/policeforceareadatatables

tf <- tempfile(fileext = ".xlsx")
download.file(
  "https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/crimeandjustice/datasets/policeforceareadatatables/yearendingseptember2024/policeforceareatablesyearendingseptember2024final.xlsx",
  tf,
  mode = "wb"
)

personal_crime_raw <- read_excel(tf, sheet = 6, skip = 7)

personal_crime <- personal_crime_raw |>
  filter(
    str_starts(`Area Code`, "W"),
    `Area Code` != "W92000004"
  ) |>
  mutate(
    across(
      c(
        `Total recorded crime (excluding fraud)\r\n [note 2]`:`Miscellaneous crimes against society`
      ),
      as.numeric
    ),
    personal_crime_rate_per_1k = rowMeans(
      across(c(
        `Violence against the person`,
        `Sexual offences`,
        `Criminal damage and arson`
      )),
      na.rm = TRUE
    ),
    year = "2023-2024"
  )


# Join datasets
places_personal_crime <- personal_crime |>
  left_join(wales_lookup, by = c("Area Code" = "pfa24_code")) |>
  select(
    ltla24_code,
    personal_crime_rate_per_1k,
    year
  )

places_personal_crime <- places_personal_crime |>
  mutate(domain = "places") |>
  mutate(subdomain = "crime") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(places_personal_crime, overwrite = TRUE)
