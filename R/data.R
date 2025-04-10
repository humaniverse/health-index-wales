#' @importFrom tibble tibble
NULL


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

#' Secondary Pupil Absences Wales 2022/2023
#'
#' Dataset containing information about the percentage of absences for secondary school students in Wales for the academic year 2022/2023 up until the late May bank holiday
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Secondary percentage of absences}{Percentage of half day sessions missed for secondary school students, aged 11-15, for the academic year up until the late May bank holiday (due to effect of exams in May and June on absences), in Wales}
#'   \item{Year}{Academic year (until late May bank holiday)}
#' .  ...
#' }
#' @source \url{https://www.gov.wales/absenteeism-secondary-schools-september-2022-august-2023}
"hl_secondary_pupil_absences"

#' Smoking Wales 2021-2023
#'
#' Dataset containing information about the percentage of smokers in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Percent smokers}{Percentage of people aged 16 and over in each local authority who are self-reported smokers, age standardised}
#'   \item{Year}{Time frame}
#' .  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles}
"hl_smoking"

#' Physical activity Wales 2021-2023
#'
#' Dataset containing information about the percentage of physically active adults in Wales
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{Percent adults active at least 150 minutes last week}{Percentage of people aged 16 and over in each local authority claiming to have exercised for at least 150 minutes the previous week, age standardised}
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles}
"hl_physical_activity"


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


#' Low-Level Crime Scores for Wales
#'
#' A dataset containing low-level crime scores for local authorities in Wales.
#' The low-level crime score is calculated as the sum of bicycle theft and shoplifting.
#'
#' @description
#' Note: The combined authority for Cwm Taf has been split into its respective
#' local authorities, Merthyr Tydfil and Rhondda Cynon Taf. This adjustment was made
#' because the data for Cwm Taf was originally documented as a combined local authority.
#' The data values for rows 18 and 19, corresponding to these local authorities,
#' remain unchanged.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{local_authority_code}{Character. The code for the local authority.}
#'   \item{local_authority_name}{Character. The name of the local authority.}
#'   \item{low_level_crime_score}{Numeric. The personal crime score, as calculated according to Health Index England, is the sum of Bicycle Theft and Shoplifting.This score is measured per 1,000 persons, based on the ONS mid-year population estimates for the local authority region. A lower score is better as it indicates lower crime for the region.}
#'   \item{low_level_crime_per_1k}{Numeric. The rate of low-level crime (bicycle theft and shoplifting) per 1,000 population, based on the ONS mid-year population estimates for the local authority region. A lower rate is better as it indicates lower crime for the region.}
#'   \item{year}{Year. The year relevant to the data snapshot.}
#' }
#' @source \url{https://www.ons.gov.uk/} and \url{https://opendata.arcgis.com/}
"hp_low_level_crimes"

#' Personal Crime Scores for Wales
#'
#' A dataset containing personal crime scores for local authorities in Wales.
#' The personal crime score is calculated as the sum of violence against the person,
#' sexual offences, and robbery.
#'
#' @description
#' Note: The combined authority for Cwm Taf has been split into its respective
#' local authorities, Merthyr Tydfil and Rhondda Cynon Taf. This adjustment was made
#' because the data for Cwm Taf was originally documented as a combined local authority.
#' The data values for rows 18 and 19, corresponding to these local authorities,
#' remain unchanged.
#'
#' @format A data frame with the following columns:
#' \describe{
#'   \item{local_authority_code}{Character. The code for the local authority.}
#'   \item{local_authority_name}{Character. The name of the local authority.}
#'   \item{personal_crime_per_1k}{Numeric. The rate of personal crime (violence against the person, sexual offences, robbery, theft against the person, criminal damage and arson) per 1,000 population, based on the ONS mid-year population estimates for the local authority region. A lower rate is better as it indicates lower crime for the region.}
#'   \item{year}{Year. The year relevant to the data snapshot}
#' }
#' @source \url{https://www.ons.gov.uk/} and \url{https://opendata.arcgis.com/}
"hp_personal_crime"


#' Low Birth Weight Percentage by year Wales
#'
#' Dataset containing information about the percentage of live births under 2500g in Wales
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#'   \item{ltla21_code}{Area code}
#'   \item{percentage_low_birth_weight}{The percentage of singleton live births under 2500g in each local authority of Wales}
#'   \item{Year}{Time frame}
#' .  ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles}
"hl_low_birth_weight"


#' Percentage of Overweight and Obese Children (aged 4-5) in Wales
#'
#' Dataset containing information about the percentage of overweight and obese children in Wales aged 4-5 (reception age)
#' @format A data frame with 22 rows and 3 variables:
#' \describe
#' Note: The local authority name for Powys in the original dataset was written as Powys THB representing the Teaching Health Board.
#' The name was changed for consistency as Powys THB and Powys County Council cover the same areas.
#'   \item{ltla21_code}{Area code}
#'   \item{percentage_overweight_obese}{The percentage of overweight and obese children in the 91st centile aged 4-5 in each local authority of Wales}
#'   \item{Year}{Time frame}
#' .  ...
#' }
#' @source \url {https://phw.nhs.wales/services-and-teams/child-measurement-programme/cmp-2022-23/}
"hl_reception_overweight_obese"

#' Rates of Rough Sleepers in Wales (2023-24)
#'
#' A dataset containing statistics on rates of rough sleepers per 1,000 individuals, by
#' Local Authority, 2023-2024.
#'
#' Rough sleepers are defined as persons who are sleeping overnight in the open air
#' (such as shop doorways, bus shelters or parks) or in buildings, vehicles or other
#' places not designed for habitation (such as stairwells, barns, sheds, car parks, tents, cars/vans).
#'
#' Mid-year population estimates for 2023 are used.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla22_code}{Local Authority Code}
#' \item{rough_sleepers_per_1k_population}{Annual rate of people assessed as rough sleepers per 1,000
#' individuals in the Local Authority}
#' \item{year}{Date}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Housing/Homelessness/homelessness-accommodation-provision-and-rough-sleeping/roughsleepers-by-localauthority}
#' and \url{https://statswales.gov.wales/Catalogue/Population-and-Migration/Population/Estimates/Local-Authority/populationestimates-by-localauthority-year}
"hp_rough_sleepers"

#'
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
