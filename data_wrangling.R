# Libraries:
library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)
library(fastDummies)

# Read Data:
data <- read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/hackathon_womens.csv")
scouting <- read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/hackathon_scouting.csv")
nwhl <- read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/hackathon_nwhl.csv")


# add cell of ocurrence to each event
l <- 16
w <- 12
x1 <- (data$X.Coordinate) / 200 * l
y1 <- (data$Y.Coordinate) / 85 * w
x2 <- (data$X.Coordinate.2) / 200 * l
y2 <- (data$Y.Coordinate.2) / 85 *w

data$x1_cell <- ceiling(x1)
data$y1_cell <- ceiling(y1)
data$x2_cell <- ceiling(x2)
data$y2_cell <- ceiling(y2)



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


  








