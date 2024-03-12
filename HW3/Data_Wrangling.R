
# Load Package ------------------------------------------------------------
library(gapminder)
library(tidyverse)
library(ggrepel)
library(ggpubr)
library(RColorBrewer)

# library(firatheme)


# Set up the working Directory --------------------------------------------
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))



# Load the data -----------------------------------------------------------
gdp_pcap <- read_csv("../Data/gdp_pcap.csv")
roads_paved <- read_csv("../Data/roads_paved_percent_of_total_roads.csv")
Geographies <- read_csv("../Data/Data Geographies - v2 - by Gapminder - list-of-countries-etc.csv")


# Merge the data ----------------------------------------------------------
# change the country name to match the name in Geographies
gdp_pcap <- gdp_pcap %>% mutate(
  country = case_when(
    country == "UK" ~ "United Kingdom",
    country == "USA" ~ "United States",
    country == "UAE" ~ "United Arab Emirates",
    country == "North Macedonia" ~ "Macedonia, FYR",
    TRUE ~ country
  )
)

# change the country name to match the name in Geographies
roads_paved <- roads_paved %>% mutate(
  country = case_when(
    country == "UK" ~ "United Kingdom",
    country == "USA" ~ "United States",
    country == "UAE" ~ "United Arab Emirates",
    country == "North Macedonia" ~ "Macedonia, FYR",
    TRUE ~ country
  )
)

# mutate the columns to numeric
gdp_pcap <- gdp_pcap %>%
  mutate(across(-country, as.numeric))

roads_paved <- roads_paved %>%
  mutate(across(-country, as.numeric))

tidy_gdp<- gdp_pcap %>% 
  pivot_longer(!country, names_to = "Year", values_to = "GDP per cap")

tidy_road<- roads_paved %>% 
  pivot_longer(!country, names_to = "Year", values_to = "Paved Roads")

final_data <- tidy_road %>%
  left_join(Geographies, by = c("country" = "name")) 

ff_data <- final_data %>%
  left_join(tidy_gdp, by = c("country", "Year") ) %>% 
  # make the column Paved Roads aubtracted by 100
  mutate(`Paved Roads` = `Paved Roads` / 100) 


