library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)
library(fastDummies)
library(ash)
library(markovchain)


#######################################
# Function for checking events by zone
#######################################
event_zones <- function(event_type, as_df){
  # Parameters
  #   event_type: type of event we want to count
  #   as_df: boolean variable to define if we want the data to be returned
  #              as a dataframe with x,y coordinates or a matrix with counted values
  
  # Divide the rink
  M <- 12 #width
  N <- 16 #length
  
  # Trim Data:
  events <- data %>% 
    filter(Event == event_type) %>% 
    select(game_id,game_second,Event,X.Coordinate,Y.Coordinate,X.Coordinate.2,Y.Coordinate.2)
  
  
  # Count Event Ocurrences by sector:
  ab <- matrix( c(-100,-42.5,100,42.5), 2, 2) # 2X2 Matrix with intervals
  nbin <- c(M,N)    #Number of bins 
  x <- cbind(events$X.Coordinate,events$Y.Coordinate) # 2D vector to bin
  bins <- bin2(x, ab, nbin)
  
  output <- matrix(unlist(bins$nc), ncol = 16, byrow = TRUE)
  grid <- as.data.frame(output)
  names(grid) <- c(1:N)
  grid <- as.matrix(grid)
  
  # Plottable df:
  x <- c(1:N)
  y <- c(1:M)
  d = expand.grid(x=x,y=y)
  d$count <- 0
  for (i in 1:N) {
    for (j in 1:M) {
      d$count[which(d$x == i & d$y == j)] <- output[j,i]
    }
    
  }
  
  
  # Output depending on selection
  if (as_df == 1)
    return(d)
  else
    return(grid)
  
# code for plotting:
#  ggplot(test, aes(x, y, fill = count)) 
#  + geom_raster(hjust = 0, vjust = 0) +
#  scale_x_discrete() +scale_y_discrete()
  
}


####################################################################
# Fit a Markov Chain Model to our data to reveal transition matrix
####################################################################

chain <- data[order(data$game_id,data$game_second),]
chain <- chain %>% 
  select(game_id,game_second,Event)

sequence<-chain$Event
sequenceMatr<-createSequenceMatrix(sequence,sanitize=T)
mcFitMLE<-markovchainFit(data=sequence)
mcFitBSP<-markovchainFit(data=sequence,method="bootstrap",nboot=5, name="Bootstrap Mc")

t_matrix_mle <- mcFitMLE$estimate@transitionMatrix
t_matrix_bootstrap <- mcFitBSP$estimate@transitionMatrix




