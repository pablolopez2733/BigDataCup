# Libraries:
library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)
library(fastDummies)

# Read Data:
data <- read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/hackathon_womens.csv")
scouting <- read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/hackathon_scouting.csv")


# Center coordinates on (0,0)
data <- data %>% 
  mutate(
    X.Coordinate = (X.Coordinate - 100),
    Y.Coordinate = (Y.Coordinate - 42.5),
    X.Coordinate.2 = (X.Coordinate - 100),
    Y.Coordinate.2 = (Y.Coordinate - 42.5),
  )


# add game ids:
data <- data %>% 
  group_by(game_date,Home.Team,Away.Team) %>% 
  mutate(game_id = cur_group_id())


# add game seconds
data <- data %>% 
  separate(Clock, sep = ":" , into = c("min","sec"))

data$min <- as.numeric(data$min)
data$sec <- as.numeric(data$sec)

data <- data %>% 
  mutate(clock_seconds = ((60-sec) + (20-min)*60)) %>% 
  mutate(game_second = ((60-sec) + (19-min)*60 + (Period-1)  *1200))


# add binary columns for each event type
data <- dummy_cols(data, select_columns = "Event")






