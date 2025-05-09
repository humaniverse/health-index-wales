#' @importFrom tibble tibble
NULL

#' Rate of Patient Admissions for Alcohol Related Conditions per 100k (2023/24)
#'
#' A dataset containing statistics on the rate of patient admissions for
#' all alcohol-related admissions per 100k in each Welsh Council, 2023/24.
#'
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{alcohol_admissions_rate_per_100k}{Rate of patient admissions per 100k
#' population, based on population numbers per Local Authority}
#' \item{year}{Time period}
#'
#' ...
#' }
#' @source \url{https://phw.nhs.wales/publications/publications1/data-mining-wales-the-annual-profile-for-substance-misuse-2023-2024/}
#'
"lives_alcohol_misuse"


#' Percentage of Cancer Screening Uptake (2021-22)
#'
#' A dataset containing statistics on the percentage of cancer screening uptake
#' for bowel, breast, and cervical cancer in each Welsh Council, 2021-22.
#'
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{total_cancer_screening_percentage}{Percentage of cancer screening
#' uptake; breast, bowel, and cervical cancer.}
#' \item{year}{Time period}
#'
#' ...
#' }
#' @source \url{https://phw.nhs.wales/services-and-teams/screening/bowel-screening/programme-reports/uptake-coverage-by-local-authority-and-health-boards/}
#' @source \url{https://phw.nhs.wales/services-and-teams/cervical-screening-wales/information-resources/programme-reports/uptake-coverage-by-local-authority-and-health-boards/}
#' @source \url{https://phw.nhs.wales/services-and-teams/screening/breast-screening/programme-reports/uptake-coverage-by-local-authority-and-health-boards/}
#'
"lives_cancer_screening"


#' Percentage of Pupil Absences (2023/24)
#'
#' A dataset containing statistics on the percentage of unauthorised school
#' absences.
#'
#' To note: England's Health Index records the percentage of pupils (at
#' state-funded primary and secondary, and special schools) who are persistent
#' absentees, that is, have overall absences equating to 10% or more of their
#' possible sessions. However, Wales only records percentage of half-day
#' sessions missed for unauthorised absence for primary and secondary schools.
#' This has been used as best proxy.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{total_pupil_absence_percentage}{Percentage of unauthorised school
#' absences across primary and secondary schools}
#' \item{year}{School Year}
#'
#' ...
#' }
#' @source \url{https://www.gov.wales/absenteeism-primary-schools-september-2023-august-2024}
#' @source \url{https://www.gov.wales/absenteeism-secondary-schools-september-2023-august-2024}
#'
"lives_pupil_absence"


#' Percentage of People that Eat Healthy (2021-22 and 2022-23)
#'
#' A dataset containing statistics on fruit and vegetable consumption in
#' each Welsh Council, 2021-22 and 2022-23.
#'
#' To note: England's Health Index captures percentage of healthy eating per
#' year, but Wales only has data combining over a 2 year period.
#'
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{healthy_eating_percentage}{Percentage of people that consume
#' 5 portions or more of fruit and vegetable per day}
#' \item{year}{Time periods combined}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles/adultlifestyles-by-healthboard-from-202021}
#'
"lives_healthy_eating"

#' Percentage of Current Smokers (2021-21 and 2022-23)
#'
#' A dataset containing statistics on smoking status in
#' each Welsh Council, 2021-21 and 2022-23.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{smoking_percentage}{Percentage of people that are current smokers}
#' \item{year}{Time periods over a 2 year period}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles/adultlifestyles-by-healthboard-from-202021}
#'
"lives_smoking"


#' Percentage of People Exhibiting Sedentary Behaviour (Very Low Activity Levels)
#' (2021-22 and 2022-23)
#'
#' A dataset containing statistics on very low activity levels (less than 30
#' minutes a week) in each Council, 2021-22 and 2022-23.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{sedentary_behaviour_percentage}{Percentage of people with very low
#' activity levels, defined as less than 30 minutes activity a week}
#' \item{year}{Time periods over a 2 year period}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/National-Survey-for-Wales/Population-Health/Adult-Lifestyles/adultlifestyles-by-healthboard-from-202021}
"lives_sedentary_behaviour"


#' Percentage of Babies Born Not at a Healthy Birth Weight (2023)
#'
#' A dataset containing percentage babies born not at a healthy birth weight
#' (<2,500g).
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{low_birth_weight_percentage}{Percentage of babies born not at a healthy
#' birth weight (<2,500g)}
#' \item{year}{Year}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/Community-Child-Health/livebirthstowelshresidents-by-localhealthboard-birthweight}
"lives_low_birth_weight"


#' Mortality all causes rate per 100k (2023)
#'
#' A dataset containing statistics from an age-sex standardised rate for all
#' causes of mortality per 100k, by Council (2023).
#'
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{all_deaths_per_100k}{age-sex standardised rate for all causes of
#' mortality per 100k}
#' \item{year}{Year}
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/deathsregisteredinenglandandwalesseriesdrreferencetables}
#'
"people_all_mortality"


#' Average Measurement of Anxiety Out of 10 (2022-23)
#'
#' A dataset containing statistics of personal ratings on feelings of
#' anxiety out of 10, by Council (2022-23).
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{anxiety_score_out_of_10}{Average personal ratings on feelings of
#' anxiety out of 10 - 10 is most anxious, 1 is least anxious}
#' \item{year}{Time period}
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/datasets/wellbeing-local-authority/editions/time-series/versions/4}
"people_anxiety"


#' Rate of Avoidable Deaths per 100k (2020-2022)
#'
#' A dataset containing statistics on age-standardised death rates per 100k, by
#' Welsh Council (2020-2022).
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{avoidable_deaths_per_100k}{Age-standardised avoidable mortality rates per
#' 100k}
#' \item{year}{3-year aggregate period}
#'
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/healthandsocialcare/causesofdeath/datasets/avoidablemortalitybylocalauthorityinenglandandwales}
"people_avoidable_mortality"


#' Percentage Rate of Cancer (2024)
#'
#' A dataset containing statistics on the percentage of people who self-reported
#' as having Cancer in Welsh Council Areas.
#'
#' To note: StatsWales Disease Prevalence data only captures disease prevalence
#' in a 'snapshot', or a single point of time. This means the year data
#' represents when the data was extracted, not the period covered.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla25_code}{Local Authroity Code}
#' \item{cancer_percentage}{Percentage of people who
#' self-reported as having Cancer}
#' \item{year}{Snapshot of a single point in time in 2024 - specifically 1
#' April 2024}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/GMS-Contract/diseaseregisters-by-localhealthboard}
#'
"people_cancer"


#' Percentage Rate of Dementia (2024)
#'
#' A dataset containing statistics on the percentage of people who self-reported
#' as having Dementia in Welsh Council Areas.
#'
#' To note: StatsWales Disease Prevalence data only captures disease prevalence
#' in a 'snapshot', or a single point of time. This means the year data
#' represents when the data was extracted, not the period covered.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla25_code}{Local Authroity Code}
#' \item{dementia_percentage}{Percentage of people who
#' self-reported as having Dementia}
#' \item{year}{Snapshot of a single point in time in 2024 - specifically 1
#' April 2024}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/GMS-Contract/diseaseregisters-by-localhealthboard}
#'
"people_dementia"


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
#' \item{ltla24_code}{Local Authroity Code}
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
#' \item{ltla24_code}{Local Authority Code}
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
#' \item{ltla24_code}{Local Authority Code}
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
#' \item{ltla24_code}{Local Authority Code}
#' \item{worthwhile_score_out_of_10}{Average personal ratings on feelings of
#' life worthwhileness out of 10 - 10 is most worthwhile, 1 is least worthwhile}
#' \item{year}{Time period}
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/datasets/wellbeing-local-authority/editions/time-series/versions/4}
"people_life_worthwhileness"


#' Percentage Rate of Mental Health Conditions (2024)
#'
#' A dataset containing statistics on the percentage of people who self-reported
#' as having a Mental Health Condition (aged 16+) in Welsh Council Areas.
#'
#' To note: StatsWales Disease Prevalence data only captures disease prevalence
#' in a 'snapshot', or a single point of time. This means the year data
#' represents when the data was extracted, not the period covered.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla25_code}{Local Authroity Code}
#' \item{mental_health_percentage}{Percentage of people who
#' self-reported as having a Mental Health Condition}
#' \item{year}{Snapshot of a single point in time in 2024 - specifically 1
#' April 2024}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/GMS-Contract/diseaseregisters-by-localhealthboard}
#'
"people_mental_health"


#' Percentage Rate of Musculoskeletal Conditions (Rheumatoid Arthritis
#' (patients aged 16+)) (2024)
#'
#' A dataset containing statistics on the percentage of people who self-reported
#' as having Rheumatoid Arthritis (aged 16+) in Welsh Council Areas.
#'
#' To note: StatsWales Disease Prevalence data only captures disease prevalence
#' in a 'snapshot', or a single point of time. This means the year data
#' represents when the data was extracted, not the period covered.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla25_code}{Local Authroity Code}
#' \item{musculoskeletal_conditions_percentage}{Percentage of people who
#' self-reported as having Rheumatoid Arthritis}
#' \item{year}{Snapshot of a single point in time in 2024 - specifically 1
#' April 2024}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/GMS-Contract/diseaseregisters-by-localhealthboard}
#'
"people_musculoskeletal_conditions"


#' Percentage Rate of Respiratory Conditions (Asthma and COPD) (2024)
#'
#' A dataset containing statistics on the percentage of people who self-reported
#' as having asthma and/or COPD in Welsh Council Areas.
#'
#' To note: StatsWales Disease Prevalence data only captures disease prevalence
#' in a 'snapshot', or a single point of time. This means the year data
#' represents when the data was extracted, not the period covered.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla25_code}{Local Authroity Code}
#' \item{respiratory_conditions_percentage}{Percentage of people who self-reported
#' as having asthma and/or COPD}
#' \item{year}{Snapshot of a single point in time in 2024 - specifically 1
#' April 2024}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Health-and-Social-Care/NHS-Primary-and-Community-Activity/GMS-Contract/diseaseregisters-by-localhealthboard}
#'
"people_respiratory_conditions"


#' Death Rate per 100k from Suicide (2021-2023)
#'
#' A dataset containing statistics on death rate per 100k by suicide, by Welsh
#' Council.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{suicide_rate_per_100k}{Deaths from suicide (16+). Age standardised
#' rate per 100,000.}
#' \item{year}{Time period - 3 year aggregate}
#'
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/suicidesbylocalauthority}
"people_suicide"


#' Percentage of Absolute Child Poverty (2022)
#'
#' A dataset containing statistics on the percentage of children under 16
#' experiencing absolute poverty, living in absolute low income families, by
#' Local Authority, 2022.
#'
#' Absolute poverty refers to people living in households with income below 60%
#' of median income in a base year, usually 2010/11.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{child_poverty_percentage}{Percentage of children (aged 16 and under)
#' living in absolute low income families}
#' \item{year}{Date}
#'
#' ...
#' }
#' @source \url{https://www.gov.uk/government/statistics/children-in-low-income-families-local-area-statistics-2014-to-2022}
"places_child_poverty"


#' Percentage Household Overcrowding (2021)
#'
#' A dataset containing statistics on the percentage of households experiencing
#' household overcrowding, per Council (2021).
#' Household overcrowding is  defined as households with an occupancy rating of
#' -1 or lower.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{percentage_households_overcrowding}{Percentage of households
#' experiencing household overcrowding}
#' \item{year}{Year}
#'
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/housing/datasets/overcrowdingandunderoccupancybyhouseholdcharacteristicsenglandandwalescensus2021}
"places_household_overcrowding"


#' Air pollution (2019)
#'
#' A dataset containing population-weighted annual mean PM2.5 data for 2019, by
#' Welsh Council Area. Uses the anthropogenic component.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{air_pollution_weighted}{Population-weighted annual mean PM2.5}
#' \item{year}{Year}
#'
#' ...
#' }
#' @source \url{https://uk-air.defra.gov.uk/data/pcm-data}
"places_air_pollution"


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


#' Road safety (2023)
#'
#' A dataset containing number of people killed or injured in each Welsh Council
#' Area in 2023 (latest revised and checked data available).
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla25_code}{Local Authority Code}
#' \item{road_accident_count}{Number of people killed or injured, per Local
#' Authority}
#' \item{year}{Year}
#'
#' ...
#' }
#' @source \url{https://statswales.gov.wales/Catalogue/Transport/Roads/Road-Accidents/Casualties/numberofcasualties-by-quarter-year-localauthority-policeforce}
"places_road_safety"


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


#' Average rates of Personal Crime per 1k (2023-2024)
#'
#' A dataset containing statistics on the mean rate of personal crime (Violence
#' against the person, sexual offences, and criminal damage and arson) per
#' 1,000, per Welsh Local Authority.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{personal_crime_rate_per_1k}{Average rate of low-level-crime (Violence
#' against the person, sexual offences, and criminal damage and arson)}
#' \item{year}{September 2023 - September 2024}
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/crimeandjustice/datasets/policeforceareadatatables}
#'
"places_personal_crime"


#' Average rates of Low-Level Crime per 1k (2023-2024)
#'
#' A dataset containing statistics on the mean rate of low-level crime (bicycle
#' theft and shoplifting) per 1,000, per Welsh Local Authority.
#'
#' @format A data frame with 22 rows and 3 variables:
#' \describe{
#' \item{ltla24_code}{Local Authority Code}
#' \item{low_level_crime_rate_per_1k}{Average rate of low-level-crime (bicycle
#' theft and shoplifting)}
#' \item{year}{September 2023 - September 2024}
#' ...
#' }
#' @source \url{https://www.ons.gov.uk/peoplepopulationandcommunity/crimeandjustice/datasets/policeforceareadatatables}
#'
"places_low_level_crime"


#' Percentage of People Experiencing Unemployment (2023-24)
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
