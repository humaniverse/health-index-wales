#--- method --------------------------------------------------------------------
#
# Strategy adapted from:
# https://www.oecd-ilibrary.org/docserver/9789264043466-en.pdf?expires=1732447217&id=id&accname=guest&checksum=C9FB3C0E94A6DE6D49C811382692119B
#

#--- libraries -----------------------------------------------------------------

library(tidyverse)
library(stringi)
library(psych)


#--- prepare indicators --------------------------------------------------------

# load
files <- list.files("data", pattern = "^(lives|places|people).*\\.rda", full.names = TRUE)
raw   <- Map(function(x) get(load(x)), files)

stopifnot(all(lengths(raw  ) == 6))

# combine
raw <- Map(setNames, raw, list(c("ltla24_code", "value", "year", "domain", "subdomain", "is_higher_better")))
raw <- Map(cbind, raw, indicator = str_replace(basename(names(raw)), "\\.rda$", ""))
raw <- do.call(rbind, raw)

# clean up
indicators <- as_tibble(raw) |>
  # flip higher = worse to higher = better
  mutate(value = if_else(is_higher_better, value, -value)) |>
  select(-year, -is_higher_better) |>
  # transform to z-scores
  group_by(indicator) |>
  mutate(value = scale(value)[,1]) |>
  ungroup() |>
  # impute missing with mean (mean is 0 after z-score transform)
  mutate(value = if_else(is.na(value), 0, value))


#--- create subdomains using pca -----------------------------------------------

build_pc_indicators <- function(x) {
  # NOTE: if only one indicator - return it
  if(ncol(x) == 1) {
    return(x[[1]])
  }
  # pca
  # center and scale to make sure all indicators are weighted equally
  pca <- prcomp(x, center = TRUE, scale. = TRUE)
  # determine the number of components selected (cummulative variance > 60 %)
  npc <- which(cumsum(round(pca$sdev^2 / sum(pca$sdev^2) * 100)) > 60)[1]

  # factors
  # NOTE: based on replication from OECD toy dataset example
  # NOTE: using psych::principal() since it aligned with OECD results
  fa <- principal(cor(x), npc)
  # variance explained by each factor
  fw <- fa$Vaccounted[1,] / sum(fa$Vaccounted[1,])

  # square loadings and make sure they sum to 1
  l <- apply(unclass(fa$loadings)^2, 2, function(x) x/sum(x))
  # for each indicator only leave the highest weight
  l[l < apply(l, 1, max)] <- 0
  # scale again so each factor sums to 1
  l <- apply(l, 2, function(x) x/sum(x))
  # multiply by variance explain
  # NOTE: not sure why, but it's in the OECD example
  l <- l * fw[col(l)]

  # indicator weights
  w <- apply(l, 1, max)

  # final score
  colSums(t(x) * w)
}

subdomains <- indicators |>
  mutate(subdomain = paste0(domain, "_", str_replace_all(subdomain, " ", "_"))) |>
  select(-domain) |>
  group_split(subdomain) |>
  map(pivot_wider, names_from = indicator, values_from = value, values_fill = 0) |>
  map(~ mutate(.x, pcscore = build_pc_indicators(.x[,-c(1:2)]))) |>
  map(~ select(.x, ltla24_code, subdomain, pcscore)) |>
  map(~ rename(.x, !!.x$subdomain[1] := pcscore)) |>
  map(~ select(.x, -subdomain)) |>
  reduce(left_join)


#--- construct index scores ----------------------------------------------------

quantise <- function(x) {
  findInterval(x, quantile(x, seq(0,1,0.1)), rightmost.closed = TRUE)
}


scores <- tibble(ltla24_code = subdomains$ltla24_code) |>
  # healthy lives
  mutate(healthy_lives_score     = rowSums(select(subdomains, starts_with("lives")))) |>
  mutate(healthy_lives_rank      = rank(healthy_lives_score)) |>
  mutate(healthy_lives_quantile  = quantise(healthy_lives_rank)) |>
  # healthy places
  mutate(healthy_places_score    = rowSums(select(subdomains, starts_with("places")))) |>
  mutate(healthy_places_rank     = rank(healthy_places_score)) |>
  mutate(healthy_places_quantile = quantise(healthy_places_rank)) |>
  # healthy people
  mutate(healthy_people_score    = rowSums(select(subdomains, starts_with("people")))) |>
  mutate(healthy_people_rank     = rank(healthy_people_score)) |>
  mutate(healthy_people_quantile = quantise(healthy_people_rank)) |>
  # combined
  mutate(health_inequalities_score    = rowSums(select(subdomains, starts_with(c("lives","places","people"))))) |>
  mutate(health_inequalities_rank     = rank(health_inequalities_score)) |>
  mutate(health_inequalities_quantile = quantise(health_inequalities_rank))


#--- save ----------------------------------------------------------------------

wales_health_index            <- scores
wales_health_index_subdomains <- subdomains
wales_health_index_indicators <- indicators

usethis::use_data(wales_health_index,            overwrite = TRUE)
usethis::use_data(wales_health_index_subdomains, overwrite = TRUE)
usethis::use_data(wales_health_index_indicators, overwrite = TRUE)
