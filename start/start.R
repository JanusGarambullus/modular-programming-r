
# This submodule contains the script for data collection, cleaning and general data manipulation

# Load packages
library(tidyverse)
library(mice)

# Collect data
data <- read_csv2("https://perso.telecom-paristech.fr/eagan/class/igr204/data/Camera.csv")

data <- data[-1,]

data <- data %>% rename(model = Model, 
                        release_date = `Release date`,
                        max_resolution = `Max resolution`,
                        low_resolution = `Low resolution`,
                        effective_pixels = `Effective pixels`,
                        zoom_wide = `Zoom wide (W)`,
                        zoom_tele = `Zoom tele (T)`,
                        norm_focus_range = `Normal focus range`,
                        macro_focus_range = `Macro focus range`,
                        storage = `Storage included`,
                        weight = `Weight (inc. batteries)`,
                        dimensions = Dimensions,
                        price = Price)

# Convert variables to numeric
model <- data$model
data <- data %>%
  select(-model) %>% 
  mutate_if(is.character, as.numeric) %>%
  mutate(model = model) %>% 
  select(model, everything())

# There are 7 missing values 
missing <- data %>% filter_all(any_vars(is.na(.)))

# We can see the 7 missing values. I will impute these using KNN.
data_impute <- mice(data, m = 5, method = "cart")
complete_data <- complete(data_impute, 2)

data <- complete_data
