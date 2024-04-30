# Imported libraries
library(tidyverse)

# Load data
yearly <- read.csv("data/yearly_deaths_by_clinic.csv")
monthly <- read.csv("data/monthly_deaths.csv")

# add proportion deaths
yearly <- yearly %>%
  mutate(proportion_deaths = deaths / births)
monthly <- monthly %>%
  mutate(proportion_deaths = deaths / births, date = as.Date(date))

# plot two DataFrames
ggplot(yearly, aes(x = year, y = proportion_deaths, color = clinic)) + 
  geom_line() + ggtitle("Fig 1")

ggplot(monthly, aes(x = date, y = proportion_deaths)) + 
  geom_line() + ggtitle("Fig 2")

# add handwashing started to monthly and plot it
monthly <- monthly %>% mutate(handwashing_started = date >= as.Date("1847-06-01"))

ggplot(monthly, aes(x = date,y = proportion_deaths, color = handwashing_started)) + geom_line() + ggtitle("Fig 3")

# 2x2 for mean of deaths
monthly_summary <- monthly %>% group_by(handwashing_started) %>%
  summarize(MeanProportionOfDeaths = mean(proportion_deaths))

