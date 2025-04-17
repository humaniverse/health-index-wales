#' @importFrom tibble tibble
NULL


#' Average Measurement of Anxiety Out of 10 (2022-23)
#'
#' A dataset containing statistics of personal ratings on feelings of
#' anxiety out of 10, by Council (2022-23).
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla25_code}{Local Authority Code}
#' \item{anxiety_score_out_of_10}{Average personal ratings on feelings of
#' anxiety out of 10 - 10 is most anxious, 1 is least anxious}
#' \item{year}{Time period}
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/datasets/wellbeing-local-authority/editions/time-series/versions/4}
"people_anxiety"


#' Percentage Rate of Diabetes (Diabetes mellitus (patients aged 17+)) (2024)
#'
#' A dataset containing statistics on the percentage of people who self-reported
#' as having Diabetes mellitus (aged 17+) in Welsh Council Areas.
#' 
#' To note: StatsWales Disease Prevalence data only captures disease prevalence 
#' in a 'snapshot', or a single point of time. This means the year data 
#' represents when the data was extracted, not the period covered.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla25_code}{Local Authroity Code}
#' \item{diabetes_percentage}{Percentage of people who 
#' self-reported as having Diabetes mellitus}
#' \item{year}{Snapshot of a single point in time in 2024 - specifically 1
#' April 2024}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/GMS-Contract/diseaseregisters-by-localhealthboard}
#'
"people_diabetes"


#' Average Measurement of Happiness Out of 10 (2022-23)
#'
#' A dataset containing statistics of personal ratings on feelings of
#' happiness out of 10, by Council (2022-23).
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla25_code}{Local Authority Code}
#' \item{happiness_score_out_of_10}{Average personal ratings on feelings of
#' happiness out of 10 - 10 is most happy, 1 is least happy}
#' \item{year}{Time period}
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/datasets/wellbeing-local-authority/editions/time-series/versions/4}
"people_happiness"


#' Average Measurement of Life Satisfaction Out of 10 (2022-23)
#'
#' A dataset containing statistics of personal ratings on feelings of
#' life satisfaction out of 10, by Council (2022-23).
#'
#' @format A data frame with 11 rows and 3 variables:
#' \describe{
#' \item{ltla25_code}{Local Authority Code}
#' \item{satisfaction_score_out_of_10}{Average personal ratings on feelings of
#' life satisfaction out of 10 - 10 is most satisfied, 1 is least satisfied}
#' \item{year}{Time period}
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/datasets/wellbeing-local-authority/editions/time-series/versions/4}
"people_life_satisfaction"


#' Average Measurement of Life Worthwhileness Out of 10 (2022-23)
#'
#' A dataset containing statistics of personal ratings on feelings of
#' life worthwhileness out of 10, by Council (2022-23).
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla25_code}{Local Authority Code}
#' \item{worthwhile_score_out_of_10}{Average personal ratings on feelings of
#' life worthwhileness out of 10 - 10 is most worthwhile, 1 is least worthwhile}
#' \item{year}{Time period}
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/datasets/wellbeing-local-authority/editions/time-series/versions/4}
"people_life_worthwhileness"


#' Sedentary behaviour Wales 2021-2023
#'
#' Dataset containing information about the percentage of sedentary adults in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Percent adults active less than 30 minutes last week}{Percentage of people aged 16 and over in each local authority claiming to have exercised for less than 30 minutes the previous week, age standardised}
#'   \item{Year}{Time frame}
#' .  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles}
"hl_sedentary_behaviour"


#' Teenage Pregnancy Wales 2021-2023
#'
#' Dataset containing information about the percentage of teenage pregnancies in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code of usual residence}
#'   \item{Percentage teenage pregnancies}{Percentage of conceptions for women aged 15-17, based on quarterly numbers of conceptions aged 15-17 and ONS population estimates. Conception includes live or still births and legal abortions, does not include miscarriages or illegal abortions}
#'   \item{Year}{Time frame}
#' .  ...
#' }
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/conceptionandfertilityrates/datasets/quarterlyconceptionstowomenagedunder18englandandwales}
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/populationestimatesforukenglandandwalesscotlandandnorthernireland}
"hl_teenage_pregnancy"


#' Percentage of children (Under 16) in Absolute Poverty in Wales (2022)
#'
#' A dataset containing statistics on the percentage of children under 16 experiencing
#' absolute poverty, by Local Authority, 2022.
#'
#' Absolute poverty refers to people living in households with income below 60% of median income in a base year, usually 2010/11.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla21_code}{Local Authority Code}
#' \item{percentage_children_absolute_poverty}{Annual percentage of children (under 16) assessed as living in absolute poverty in 2022}
#' \item{year}{Date}
#'
#' ...
#' }
#' @source \url{https://www.gov.uk/government/statistics/children-in-low-income-families-local-area-statistics-2014-to-2022}
"hp_child_poverty"

#' Percentage of Households Experiencing Overcrowding in Wales (2021 Census)
#'
#' A dataset containing statistics on the percentage of households in each LA that are experiencing overcrowding, 2021.
#'
#' Overcrowding is defined as households with an occupancy rating of -1 or less,
#' which implies that a household has at least one fewer bedroom than required.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla21_code}{Local Authority Code}
#' \item{percentage_households_overcrowding}{Percentage of households assessed
#' as overcrowded at the time of the 2021 Census, per Local Authroity}
#' \item{year}{Date}
#'
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/housing/datasets/overcrowdingandunderoccupancybyhouseholdcharacteristicsenglandandwalescensus2021/census2021/hou04dataset.xlsx}
"hp_household_overcrowding"

#' Travel time to GPs (2025)
#'
#' A dataset containing the average (median) travel time (in minutes) to the nearest
#' GP in each Local Authority. This is based on the travel time to the
#' nearest GP in each MSOA within a Local Authority.
#'
#' Travel times are calculated using the TravelTime API (https://traveltime.com/apis/distance-matrix)
#' and are based on travelling by public transport on a weekday morning.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla24_code}{Local Authority Code}
#'   \item{gp_mean_travel_time}{Mean travel time (in minutes) to the nearest
#'   GP among all the MSOAs within a Local Authority}
#'   \item{year}{Year the data was last updated}
#'   ...
#' }
#' @source \url{https://openstreetmap.org/}
#'
"places_gp_travel_time"

#' Travel time to pharmacies (2025)
#'
#' A dataset containing the average (median) travel time (in minutes) to the nearest
#' pharmacy in each Local Authority. This is based on the travel time to the
#' nearest sports centre in each MSOA within a Local Authority.
#'
#' Travel times are calculated using the TravelTime API (https://traveltime.com/apis/distance-matrix)
#' and are based on travelling by public transport on a weekday morning.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla24_code}{Local Authority Code}
#'   \item{pharmacy_mean_travel_time}{Mean travel time (in minutes) to the nearest
#'   pharmacy among all the MSOAs within a Local Authority}
#'   \item{year}{Year the data was last updated}
#'   ...
#' }
#' @source \url{https://openstreetmap.org/}
#'
"places_pharmacy_travel_time"

#' Travel time to sports facilities (2025)
#'
#' A dataset containing the average (mean) travel time (in minutes) to the nearest
#' sports centre in each Local Authority. This is based on the travel time to the
#' nearest sports centre in each MSOA within a Local Authority.
#'
#' Travel times are calculated using the TravelTime API (https://traveltime.com/apis/distance-matrix)
#' and are based on travelling by public transport on a weekday morning.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla24_code}{Local Authority Code}
#'   \item{sports_centre_mean_travel_time}{Mean travel time (in minutes) to the nearest
#'   sports centre among all the MSOAs within a Local Authority}
#'   \item{year}{Year the data was last updated}
#'   ...
#' }
#' @source \url{https://openstreetmap.org/}
#'
"places_sports_centre_travel_time"

#' Internet access (2024)
#'
#' Percentage of residential premises in each Local Authority that are below the
#' Universal Service Obligation (USO) for broadband: no access to download speeds
#' at or above 10 Mbit/s and upload speeds at or above 1 Mbit/s from fixed
#' broadband or a Wireless Internet Service Provider (WISP) or Mobile FWA
#' (including non-matched records and zero predicted speeds).
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla24_code}{Local Authority code}
#'   \item{poor_internet_access_percentage}{% of premises below the Universal
#'   Service Obligation (USO) for broadband}
#'   \item{year}{Year the data was last updated}
#'   ...
#' }
#' @source \url{https://www.ofcom.org.uk/}
#'
"places_internet_access"

#' Ease of getting GP appointments at a convenient time (2021-22)
#'
#' The percentage of people finding it very difficult to get a GP appointment
#' at a convenient time. Data is from the National Survey for Wales 2021-22,
#' based on the question "How easy or difficult was it to get a convenient
#' appointment?"
#'
#' The data is provided for Local Health Boards. We spread this data across each
#' Local Authority within the Health Boards.
#'
#' #' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla24_code}{Local Authority Code}
#'   \item{gp_appointments_very_difficult}{Percentage of people reporting it was
#'   very difficult to get a GP appointment at a convenient time}
#'   \item{year}{Year the survey was conducted}
#'   ...
#' }
#' @source \url{https://www.gov.wales/national-survey-wales-results-viewer}
"places_gp_appointments"

##' Percentage of People Experiencing Unemployment (2023-24)
#'
#' A dataset containing statistics on the percentage of people experiencing
#' unemployment, excluding students.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla25_code}{Local Authority Code}
#' \item{unemployment_percentage}{Percentage of people experiencing unemployment
#' excluding students. Ages 16-64.}
#' \item{year}{September 2023 to September 2024}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Business-Economy-and-Labour-Market/People-and-Work/Economic-Inactivity/economicinactivityratesexcludingstudents-by-welshlocalarea-year}
#'
"places_unemployment"

