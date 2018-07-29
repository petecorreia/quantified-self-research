library(tidyverse)
library(scales)
library(ggthemes)
library(zoo)

Data <- read.csv("data/multiple-daily-metrics.csv")
Data$date <- as.Date(Data$start, format = "%d-%b-%Y")
Data$heart_rate_count_min <- as.numeric(Data$heart_rate_count_min)
Data$heart_rate_count_min_ma <- rollmean(Data$heart_rate_count_min, k = 30, fill = NA)

Data %>% 
  ggplot() +
    geom_point(aes(date, heart_rate_count_min), alpha = 0.25, size = 0.25) +
    geom_line(aes(date, heart_rate_count_min_ma), color = 'red') +
    scale_x_date(breaks = date_breaks("6 months"),
                 labels = date_format("%b %Y")) +
    labs(title = "Heart Rate", x = "", y = "BPM", color = "Type") + 
    theme_tufte(base_family = "Helvetica", ticks=FALSE) +
    scale_colour_few()
