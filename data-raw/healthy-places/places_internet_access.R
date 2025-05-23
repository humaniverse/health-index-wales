# Internet access indicator is based on the Universal Service Obligation (USO)
# for broadband: the percentage of premises with no access to download speeds at
# or above 10 Mbit/s and upload speeds at or above 1 Mbit/s from fixed broadband
# or a Wireless Internet Service Provider (WISP) or Mobile FWA (including 
# non-matched records and zero predicted speeds)
library(tidyverse)
library(httr2)

# ---- Download broadband coverage data ----
# Source: https://www.ofcom.org.uk/phones-and-broadband/coverage-and-speeds/connected-nations-2024/data-downloads-2024/
download <- tempfile(fileext = ".zip")

request("https://www.ofcom.org.uk/siteassets/resources/documents/research-and-data/multi-sector/infrastructure-research/connected-nations-2024/data-downloads/202407-fixed-coverage-uk-nations-laua-pcon-r01.zip?v=386549") |>
  req_perform(download)

unzip(download, exdir = tempdir())

list.files(tempdir())

coverage <- read_csv(file.path(tempdir(), "202407_fixed_laua_res_coverage_r01.csv")) # Residential properties

places_internet_access <- 
  coverage |> 
  select(
    ltla24_code = laua,
    poor_internet_access_percentage = `% of premises below the USO`  # USO = Universal Service Obligation for broadband
  ) |> 
  filter(str_detect(ltla24_code, "^W")) |> 
  mutate(year = 2024)

places_internet_access <- places_internet_access |>
  mutate(domain = "places") |>
  mutate(subdomain = "access to services") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(places_internet_access, overwrite = TRUE)
