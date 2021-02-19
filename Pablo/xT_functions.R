library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)
library(fastDummies)
library(ash)



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
# Account for defensive xT and created xT
####################################################################
olympics_xt <- read.csv("C:/Users/pablo/Desktop/GithubRepos/BigDataCup/xT/olympics/xt_table.csv")
nhl_xt <- read.csv("C:/Users/pablo/Desktop/GithubRepos/BigDataCup/xT/nwhl/xt_table.csv")
scouting_xt <- read.csv("C:/Users/pablo/Desktop/GithubRepos/BigDataCup/xT/scouting/xt_table.csv")

# add game_id
nhl_xt <- nhl_xt %>% 
  group_by(game_date,Home.Team,Away.Team) %>% 
  mutate(game_id = cur_group_id())



# add game seconds
nhl_xt <- nhl_xt %>% 
  separate(Clock, sep = ":" , into = c("min","sec"))

nhl_xt$min <- as.numeric(nhl_xt$min)
nhl_xt$sec <- as.numeric(nhl_xt$sec)

nhl_xt <- nhl_xt %>% 
  mutate(clock_seconds = ((60-sec) + (20-min)*60)) %>% 
  mutate(game_second = ((60-sec) + (19-min)*60 + (Period-1)  *1200))

nhl_xt <- nhl_xt[order(nhl_xt$game_id,nhl_xt$game_second),]

#add created xT
nhl_xt <- nhl_xt %>% 
  mutate(
    created_xT = lead(xTa)-xTa
  )

# quienes previenen xT...
# takeaways, shots and detail1 = , puck recovery, dump in and detail1 = , faceoff win,
#checar que esto debe ser con created_xT no con xTa
test <- nhl_xt
test$aux <- ifelse(is.na(test$xTa),NA,1)
test <- test %>% dplyr::mutate(xTa = replace_na(xTa, 0))
test$cxt <- ave(test$xTa, cumsum(is.na(test$aux)), FUN = cumsum)





