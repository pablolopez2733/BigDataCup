library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)
library(fastDummies)
library(ash)

# Divide the rink
M <- 12 #width
N <- 16 #length

# Trim Data:
events <- data %>% 
  select(game_id,game_second,Event,X.Coordinate,Y.Coordinate,X.Coordinate.2,Y.Coordinate.2)


# Count Event Ocurrences by sector:

ab <- matrix( c(-100,-42.5,100,42.5), 2, 2) # 2X2 Matrix with intervals
nbin <- c( M, N)    #Number of bins 
x <- cbind(events$X.Coordinate,events$Y.Coordinate) # 2D vector to bin
bins <- bin2(x, ab, nbin)

output <- matrix(unlist(bins$nc), ncol = 16, byrow = TRUE)
grid <- as.data.frame(output)