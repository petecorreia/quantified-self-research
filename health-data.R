library(tidyverse)
library(ggthemes)
library(zoo)

Data <- read.csv(file="/Users/petecorreia/Desktop/health-data.csv")
Data$date <- as.Date(Data$start, format = "%d-%b-%Y")
Data$distance <- as.numeric(Data$distance)
Data$distance_ma <- rollmean(Data$distance, k = 30, fill = NA)

Data %>% 
  ggplot() +
    geom_point(aes(date, distance), alpha = 0.25, size = 0.25) +
    geom_line(aes(date, distance_ma), color = 'red') +
    scale_x_date(breaks = date_breaks("6 months"),
                 labels = date_format("%b %Y")) +
    labs(title = "Distance", x = "", y = "KM", color = "Type") + 
    theme_tufte(base_family = "Helvetica", ticks=FALSE) +
    scale_colour_few()
