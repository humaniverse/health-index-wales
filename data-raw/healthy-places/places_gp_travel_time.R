library(tidyverse)
library(geographr)
library(osmdata)
library(jsonlite)
library(httr)
library(sf)
library(traveltimeR)

Sys.setenv(TRAVELTIME_ID = "<INSERT YOUR ID HERE>")
Sys.setenv(TRAVELTIME_KEY = "<INSERT YOUR API KEY HERE>")

# ---- Fetch GPs in Wales ----
# Bounding box for Wales
wales_bb <-
  getbb("Wales")

# Search for GPs
GPs <- opq(wales_bb, timeout = 1000) %>%
  add_osm_feature("amenity", "doctors") %>%
  osmdata_sf()

# Get Local Authorities in Great Britain for the next step
gb_lad <-
  boundaries_ltla21 |>
  filter(!str_detect(ltla21_code, "^N"))

# Some GPs are in Northern Ireland - remove them from the dataset
wales_GPs <-
  GPs$osm_points[gb_lad, ] |>
  select(osm_id)

# - Test plot to check GP locations -
# gb_lad |>
#   ggplot() +
#   geom_sf(
#     fill = NA,
#     colour = "black"
#   ) +
#   geom_sf(
#     data = wales_GPs,
#     inherit.aes = FALSE
#   )

# Local Authorities in Wales, plus England LADs on the Welsh border
border_lads <- paste(c(
  "Cheshire East",
  "Cheshire West",
  "Forest of Dean",
  "Herefordshire",
  "Shropshire",
  "Wirral"
), collapse = "|")

wales_lad <-
  gb_lad |>
  filter(str_detect(ltla21_code, "^W") | str_detect(ltla21_name, border_lads))

# Calculate neighbours for each Welsh Locaal Authority (plus bordering English LADs)
neighbours <- st_touches(wales_lad)

# Look up the Local Authority each GP is in
wales_GPs_lad <-
  st_join(wales_GPs, wales_lad) |>
  filter(!is.na(ltla21_code)) |>
  mutate(
    # Round coords to 3 decimal points to save memory
    lat = st_coordinates(geometry)[, 2] |> round(3),
    lng = st_coordinates(geometry)[, 1] |> round(3)
  ) |>
  st_drop_geometry() |>
  as_tibble() |>
  select(
    ltla21_code,
    osm_id,
    lat,
    lng
  )

# ---- Population-weighted centroids for MSOAs ----
# Source: https://geoportal.statistics.gov.uk/datasets/ons::middle-layer-super-output-areas-december-2021-ew-population-weighted-centroids-1/about
msoa21_centroids_raw <- read_sf("https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Middle_Super_Output_Areas_DEC_2021_EW_PWC/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson")

# Convert to lats and longs
msoa21_centroids <-
  msoa21_centroids_raw |>
  mutate(
    # Round coords to 3 decimal points to save memory
    lat = st_coordinates(geometry)[, 2] |> round(3),
    lng = st_coordinates(geometry)[, 1] |> round(3)
  ) |>
  st_drop_geometry() |>
  select(
    msoa21_code = MSOA21CD,
    lat,
    lng
  )

# ---- Calculate travel time between data zones and GPs ----
# Taking each Local Authority in Wales one at a time,
# calculate the travel distance/time from the MSOAs  within that LAD
# to each GP in the LAD as well as in neighbouring LADs

# Set up tibbles to store results
GP_travel_time <- tibble()

# lookup_msoa21_ltla22 <-
lookup_msoa21_ltla24 <-
  # geographr::lookup_postcode_oa21_lsoa21_msoa21_ltla22 |>
  geographr::lookup_postcode_oa_lsoa_msoa_ltla_2025 |> # Above lookup appears to be outdated
  # distinct(msoa21_code, ltla22_code)
  distinct(msoa21_code, ltla24_code)

# Start loop at row 7; the first six rows are the English LADs
# We don't need to calculate travel times within them
for (i in 7:nrow(wales_lad)) {
  current_ltla_code <- wales_lad[i, ]$ltla21_code

  current_msoa_codes <-
    lookup_msoa21_ltla22 |>
    filter(ltla22_code == current_ltla_code) |>
    distinct(msoa21_code) |>
    pull(msoa21_code)

  current_msoa_centroids <-
    msoa21_centroids |>
    filter(msoa21_code %in% current_msoa_codes)

  # Get GPs in the current LAD and its neighbouring LADs
  current_neighbours <-
    wales_lad[neighbours[[i]], ] |>
    pull(ltla21_code)

  current_GPs <-
    wales_GPs_lad |>
    filter(ltla21_code %in% c(current_ltla_code, current_neighbours)) |>
    # We'll combine the GPs with Intermediate Zones - use the same column name for IDs
    rename(id = osm_id)

  # Loop through each Intermediate Zones in the current Local Authority,
  # calculating travel time to the current set of GPs
  for (msoa in 1:nrow(current_msoa_centroids)) {
    current_msoa_centroid <-
      current_msoa_centroids |>
      slice(msoa) |>
      rename(id = msoa21_code)

    # Need to make a list of locations with the `traveltimeR::make_locations()` function
    # First we must collate the current set of locations into a single dataframe
    current_locations_df <- bind_rows(current_msoa_centroid, current_GPs)

    # Then use the approach shown in Travel Time's R package readme: https://docs.traveltime.com/api/sdks/r
    current_locations <- apply(current_locations_df, 1, function(x) {
      make_location(id = x["id"], coords = list(
        lat = as.numeric(x["lat"]),
        lng = as.numeric(x["lng"])
      ))
    })
    current_locations <- unlist(current_locations, recursive = FALSE)

    current_search <-
      make_search(
        id = str_glue("search {current_msoa_centroid$id}"), # Make up an ID for the search so each search is unique
        departure_location_id = current_msoa_centroid$id,
        arrival_location_ids = as.list(current_GPs$id),
        travel_time = 10800, # 3 hours (in seconds)
        properties = list("travel_time"),
        arrival_time_period = "weekday_morning",
        transportation = list(type = "public_transport")
      )

    current_result <- time_filter_fast(locations = current_locations, arrival_one_to_many = current_search)

    # Convert JSON result to a data frame
    current_result_df <- fromJSON(current_result$contentJSON, flatten = TRUE)

    # Some MSOAs can't reach any GPs - ignore them
    if (length(current_result_df$results$locations[[1]]) > 0) {
      current_travel_time <-
        current_result_df$results$locations[[1]] |>
        as_tibble() |>
        mutate(
          # `travel_time` column is in seconds; convert to minutes
          travel_time_mins = properties.travel_time / 60,
          msoa21_code = current_msoa_centroid$id
        ) |>
        select(msoa21_code, osm_id = id, travel_time_mins)

      GP_travel_time <- bind_rows(GP_travel_time, current_travel_time)
    }

    print(str_glue("Finished MSOA {msoa} of {nrow(current_msoa_centroids)}"))
    Sys.sleep(2)
  }

  # Save progress to disc after each LAD
  # NOTE: Please manually delete these files once the loop completes
  write_csv(GP_travel_time, str_glue("data-raw/healthy-places/GP_travel_time-{i-6}.csv"))

  print(str_glue("Finished Local Authority {i - 6} of {nrow(wales_lad) - 6}"))
}

# Save the complete dataset for travel time from MSOAs to GPs
# This won't be available in the R package itself but want to keep it in the GitHub repo
# since it takes quite a while to calculate
# write_csv(GP_travel_time, "data-raw/healthy-places/GP_travel_time.csv")
write_csv(GP_travel_time, "data-raw/healthy-places/raw-data/GP_travel_time.csv")

# GP_travel_time <- read_csv("data-raw/healthy-places/GP_travel_time.csv")
GP_travel_time <- read_csv("data-raw/healthy-places/raw-data/GP_travel_time.csv")

# ---- Calculate travel time at MSOA level ----
msoa_wales <- lookup_postcode_oa_lsoa_msoa_ltla_2025 |>
  filter(str_starts(msoa21_code, "W")) |>
  distinct(msoa21_code)

places_gp_travel_time_msoa <- GP_travel_time |>
  group_by(msoa21_code) |>
  summarise(
    gp_mean_travel_time = mean(travel_time_mins, na.rm = TRUE)
  ) |>
  ungroup() |>
  right_join(msoa_wales, by = "msoa21_code") |> # Include all Welsh MSOAs
  mutate(
    gp_mean_travel_time = replace_na(gp_mean_travel_time, 999), # 999 means unreachable
    is_within_3_hours = gp_mean_travel_time != 999,
    year = year(now()),
    domain = "places",
    subdomain = "access to services",
    is_higher_better = FALSE
  )

# ---- Calculate travel time at Local Authority Level ----
# Look up Local Authorities for each MSOA and GP
GP_travel_time <-
  GP_travel_time |>
  left_join(lookup_msoa21_ltla24)

# What are the mean travel times within each MSOA (within each Local Authority)?
gp_travel_time_mean <-
  GP_travel_time |>
  select(-osm_id) |> # We don't need to know the GP ID for this
  group_by(msoa21_code, ltla24_code) |>
  summarise(
    mean_travel_time_mins = mean(travel_time_mins, na.rm = TRUE)
  ) |>
  ungroup() |>
  distinct()

# Calculate average (mean) travel time for each Local Authority
places_gp_travel_time <-
  gp_travel_time_mean |>
  group_by(ltla24_code) |>
  summarise(mean_travel_time = mean(mean_travel_time_mins, na.rm = TRUE)) |>
  ungroup() |>
  mutate(year = year(now())) |>
  rename(
    ltla24_code = ltla22_code,
    gp_mean_travel_time = mean_travel_time
  )

places_gp_travel_time <- places_gp_travel_time |>
  mutate(domain = "places") |>
  mutate(subdomain = "access to services") |>
  mutate(is_higher_better = FALSE)


# ---- Save output to data/ folder ----
usethis::use_data(places_gp_travel_time, overwrite = TRUE)
usethis::use_data(places_gp_travel_time_msoa, overwrite = TRUE)
