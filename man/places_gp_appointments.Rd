% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{places_gp_appointments}
\alias{places_gp_appointments}
\title{Ease of getting GP appointments at a convenient time (2021-22)}
\format{
An object of class \code{tbl_df} (inherits from \code{tbl}, \code{data.frame}) with 20 rows and 6 columns.
}
\source{
\url{https://www.gov.wales/national-survey-wales-results-viewer}
}
\usage{
places_gp_appointments
}
\description{
The percentage of people finding it very difficult to get a GP appointment
at a convenient time. Data is from the National Survey for Wales 2021-22,
based on the question "How easy or difficult was it to get a convenient
appointment?"
}
\details{
The data is provided for Local Health Boards. We spread this data across each
Local Authority within the Health Boards.

#' @format A data frame with 22 rows and 3 variables:
\describe{
\item{ltla24_code}{Local Authority Code}
\item{gp_appointments_very_difficult}{Percentage of people reporting it was
very difficult to get a GP appointment at a convenient time}
\item{year}{Year the survey was conducted}
\item{domain}{Indicator domain - lives, people, or places}
\item{subdomain}{Indicator subdomain}
\item{is_higher_better}{Does higher scores correspond to better outcomes}
...
}
}
\keyword{datasets}
