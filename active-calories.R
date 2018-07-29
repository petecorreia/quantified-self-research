library(tidyverse)
library(scales)
library(ggthemes)
library(zoo)

Data <- read.csv("data/multiple-daily-metrics.csv")
Data$date <- as.Date(Data$start, format = "%d-%b-%Y")
Data$active_calories_kcal <- as.numeric(Data$active_calories_kcal)
Data$active_calories_kcal_ma <- rollmean(Data$active_calories_kcal, k = 30, fill = NA)

Data %>% 
  ggplot() +
    geom_point(aes(date, active_calories_kcal), alpha = 0.25, size = 0.25) +
    geom_line(aes(date, active_calories_kcal_ma), color = 'red') +
    scale_x_date(breaks = date_breaks("6 months"),
                 labels = date_format("%b %Y")) +
    labs(title = "Active Calories", x = "", y = "Kcal", color = "Type") + 
    theme_tufte(base_family = "Helvetica", ticks=FALSE) +
    scale_colour_few()
