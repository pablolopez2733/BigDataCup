library(ggplot2)
library(dplyr)

setwd("~/GitHub/BigDataCup/expanded xT")
data=read.csv('comparing_methods.csv')

data %>% lm(formula=
              xT ~ xTa) %>% summary()

data %>% lm(formula=
              xT ~ nxTa) %>% summary()

data %>% lm(formula=
              xTa ~ nxTa) %>% summary()

data %>% ggplot(aes(x=xTa,y=xT)) + 
  geom_point(color='gray60',alpha=.3)+
  geom_smooth(color='black',method = 'lm',fill='lightblue',alpha=.3)+
  theme_bw()

