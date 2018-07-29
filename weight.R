library(tidyverse)
library(scales)
library(ggthemes)
library(zoo)

Data <- read.csv("data/multiple-daily-metrics.csv")
Data$date <- as.Date(Data$start, format = "%d-%b-%Y")
Data$weight_kg <- as.numeric(Data$weight_kg)
Data$weight_clean <- as.numeric(Data$weight_kg)
Data$weight_clean[Data$weight_clean == 0] <- NA
Data$weight_kg_ma <- rollmean(Data$weight_clean, k = 2, fill = NA)

Data %>% 
  ggplot() +
    geom_point(aes(date, weight_kg), alpha = 0.25, size = 0.25) +
    geom_line(aes(date, weight_kg_ma), color = 'red') +
    scale_x_date(breaks = date_breaks("6 months"),
                 labels = date_format("%b %Y")) +
    labs(title = "Weight", x = "", y = "Kg", color = "Type") + 
    theme_tufte(base_family = "Helvetica", ticks=FALSE) +
    scale_colour_few()
