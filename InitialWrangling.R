# Necessary libraries
library(dplyr)
library(stringr)
library(tidyr)
library(lubridate)

# Data wrangling
calendar <- read.csv("/home/stat041s18_airbnb/Data/calendar.csv") %>%
  select(-available) %>%
  mutate(price = as.character(price)) %>%
  mutate(price = as.numeric(str_replace(price, "\\$", ""))) %>%
  mutate(date = ymd(date))

listing <- read.csv("/home/stat041s18_airbnb/Data/listings.csv")

listing_select <- listing %>%
  select(id, neighbourhood_cleansed, neighbourhood_group_cleansed, room_type, accommodates, price, availability_30, availability_60, availability_90, availability_365) %>%
  mutate(price = as.character(price)) %>%
  mutate(price = as.numeric(str_replace(price, "\\$", "")))

write.csv(listing_select, file = "/home/stat041s18_airbnb/merged_airbnb.csv")

listing_plot2 <- listing %>%
  select(id, neighbourhood_cleansed, neighbourhood_group_cleansed, room_type, accommodates)

merged_plot2 <- left_join(calendar, listing_plot2, by = c("listing_id" = "id")) 
write.csv(merged_plot2, file = "/home/stat041s18_airbnb/merged_plot2.csv")
