library(tidyverse)
library(scales)
library(ggthemes)
library(zoo)

Data <- read.csv("data/multiple-daily-metrics.csv")
Data$date <- as.Date(Data$start, format = "%d-%b-%Y")
Data$steps_count <- as.numeric(Data$steps_count)
Data$steps_count_ma <- rollmean(Data$steps_count, k = 30, fill = NA)

Data %>% 
  ggplot() +
    geom_point(aes(date, steps_count), alpha = 0.25, size = 0.25) +
    geom_line(aes(date, steps_count_ma), color = 'red') +
    scale_x_date(breaks = date_breaks("6 months"),
                 labels = date_format("%b %Y")) +
    labs(title = "Steps", x = "", y = "Count", color = "Type") + 
    theme_tufte(base_family = "Helvetica", ticks=FALSE) +
    scale_colour_few()
