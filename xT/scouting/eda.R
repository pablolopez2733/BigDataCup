setwd("~/GitHub/BigDataCup")

library(dplyr)
library(magrittr)

actions <- read.csv("xT/scouting/xt_table.csv")

actions %<>%
  mutate(
    goal = if_else(type_name == 'Shot' & success == 1,1,0)
  )

players = actions %>% 
  group_by(Player ) %>%
  summarise(
    xTa = sum(xTa,na.rm = T),
    Team = unique(Team),
    Goals = sum(goal,na.rm = T)
  ) %>% ungroup() %>% arrange(desc(xTa))

players %>% lm(formula=
                 Goals ~ xTa)  %>% summary()

players %>% head(10)

players %>% ggplot(aes(x=xTa,y=Goals)) +
  geom_point() + 
  geom_smooth(method='lm')+
  theme_bw()

teams = actions %>% 
  group_by(Team) %>%
  summarise(
    xTa = sum(xTa,na.rm = T),
    Team = unique(Team),
    Goals = sum(goal,na.rm = T)
  ) %>% ungroup() %>% arrange(desc(xTa))
 
teams %>% lm(formula=
                  Goals ~ xTa)  %>% summary()

teams %>% ggplot(aes(x=xTa,y=Goals)) +
  geom_point() + 
  geom_smooth(method='lm')+
  theme_bw()

teams %>% tail(18)%>% ggplot(aes(x=xTa,y=Goals)) +
  geom_point() + 
  geom_smooth(method='lm')+
  theme_bw()

actions %>% lm(
  formula =
    xTa ~ as.factor(type_name)
) %>% summary()

performances = actions %>% 
  group_by( game_id ,Team) %>%
  summarise(
    xTa = sum(xTa,na.rm = T),
    Team = unique(Team),
    Goals = sum(goal,na.rm = T)
  ) %>% ungroup() %>% arrange(desc(xTa))

performances %>% lm(formula=
               Goals ~ xTa)  %>% summary()

performances %>% ggplot(aes(x=xTa,y=Goals)) +
  geom_point() + 
  geom_smooth(method='lm')+
  theme_bw()
