% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{quantise}
\alias{quantise}
\title{Quantise a vector of ranks}
\usage{
quantise(vec, num_quantiles = 10, highest_quantile_worst = TRUE)
}
\arguments{
\item{vec}{The vector of ranks to quantise}

\item{num_quantiles}{The Number of quantiles}

\item{highest_quantile_worst}{Should a high quantile represent the worst
outcome?}
}
\value{
A vector containing the risk quantiles
}
\description{
Quantise a vector of ranks
}
