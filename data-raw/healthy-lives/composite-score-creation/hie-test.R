#Load packages
library(healthyr)
library(tidyverse)

#Load data
data("england_health_index_indicators")
view(england_health_index_indicators)

#Filter data
hie <- england_health_index_indicators |>
  filter(str_starts(year, "2021"),
         str_starts(indicator, "Physical") |
         str_starts(indicator, "Alcohol") |
         str_starts(indicator, "Cancer scr") |
         str_starts(indicator, "Drug") |
         str_starts(indicator, "Healthy") |
         str_starts(indicator, "Early") |
         str_starts(indicator, "Young") |
         str_starts(indicator, "Physical") |
         str_starts(indicator, "Sed") |
         str_starts(indicator, "Pupil") |
         str_starts(indicator, "Low birth") |
         str_starts(indicator, "Over") |
         str_starts(indicator, "Smoking") |
         str_starts(indicator, "Teen") |
         str_starts(indicator, "Child v")) 

#Rotate
hie_wide <- hie |>
  pivot_wider(names_from = indicator, values_from = value) |>
  dplyr::select(-year)

#Standardise
hie_standard <- function(dataset, value_column) {
  # Standardize the selected column and return the modified dataset
  dataset <- dataset |>
    dplyr::mutate(!!sym(value_column) := (dataset[[value_column]] - mean(dataset[[value_column]], na.rm = TRUE)) / sd(dataset[[value_column]], na.rm = TRUE))
  
  return(dataset)
}

# Standardize each of the columns in the dataset
for (value_column in value_columns) {
  cat("Processing column:", value_column, "\n")
  hie_standardised <- hie_standard(hie_wide, value_column)
}

#Adjust direction
hie_standardised <- hie_standardised |>
  mutate(across(c(`Alcohol misuse`,
                  `Drug misuse`,
                  `Sedentary behaviour`,
                  `Smoking`,
                  `Pupil absences`,
                  `Teenage pregnancy`,
                  `Low birth weight`,
                  `Overweight and obesity in adults`,
                  `Overweight and obesity in children`), 
                ~ . * -1)) |>
  dplyr::select(-starts_with("ltla21_code"))

#Run pca
#Visually confirm that indicators are correlated
corr_matrix <- cor(hie_standardised) #Creates the correlation matrix
ggcorrplot(corr_matrix) #Creates a correlation matrix heatmap

#KMO and Bartlett's test
#KMO score is 0.5
#Barlett's test p-value is 0
kmo_result <- KMO(hie_standardised)
bartlett_result <- cortest.bartlett(hie_standardised)
print(kmo_result)
print(bartlett_result)
