# Libraries:
library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)

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

  




goals <- data %>% 
  filter(Event == "Goal")

goals_scatter <- ggplot(goals , aes(x=X.Coordinate, y=Y.Coordinate , color = Detail.1)) +
  geom_point()

goals_scatter