% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{places_pharmacy_travel_time}
\alias{places_pharmacy_travel_time}
\title{Travel time to pharmacies (2025)}
\format{
A data frame with 22 rows and 3 variables:
\describe{
\item{ltla24_code}{Local Authority Code}
\item{pharmacy_mean_travel_time}{Mean travel time (in minutes) to the nearest
pharmacy among all the MSOAs within a Local Authority}
\item{year}{Year the data was last updated}
\item{domain}{Indicator domain - lives, people, or places}
\item{subdomain}{Indicator subdomain}
\item{is_higher_better}{Does higher scores correspond to better outcomes}
...
}
}
\source{
\url{https://openstreetmap.org/}
}
\usage{
places_pharmacy_travel_time
}
\description{
A dataset containing the average (median) travel time (in minutes) to the nearest
pharmacy in each Local Authority. This is based on the travel time to the
nearest sports centre in each MSOA within a Local Authority.
}
\details{
Travel times are calculated using the TravelTime API (https://traveltime.com/apis/distance-matrix)
and are based on travelling by public transport on a weekday morning.
}
\keyword{datasets}
