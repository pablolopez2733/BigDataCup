setwd("~/GitHub/BigDataCup/xT")

library(dplyr)
library(magrittr)

a=read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/hackathon_nwhl.csv")
b=read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/hackathon_womens.csv")
c=read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/hackathon_scouting.csv")
d=rbind(a,b,c)

data__ = d %>%  
  group_by(game_date,Home.Team,Away.Team) %>% 
  mutate(game_id = cur_group_id()) %>% ungroup()


# data_ <- read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/hackathon_nwhl.csv") %>%  
#   group_by(game_date,Home.Team,Away.Team) %>% 
#   mutate(game_id = cur_group_id()) %>% ungroup()


#rename
data <- data__  %>% 
  rename(
    start_x = X.Coordinate,
    start_x_2 = X.Coordinate.2,
    start_y = Y.Coordinate,
    start_y_2 = Y.Coordinate.2,
    type_name = Event
  )


#success field
data %<>%
  mutate(
    success =
      case_when(
        type_name == 'Shot'~0,
        type_name == 'Goal'~1,
        type_name == 'Play'~1,
        type_name == 'Incomplete Play'~0,
        type_name == 'Takeaway'~1,
        type_name == 'Puck Recovery'~1,
        type_name == 'Dump In/Out'~0,
        type_name == 'Zone Entry'~1,
        type_name == 'Faceoff Win'~1,
        type_name == 'Penalty Taken'~1
      )
  ) %>% mutate(
    t = Team,
    p = Player,
    type_name = if_else(type_name == 'Faceoff Win','Faceoff',type_name),
    Team = if_else(type_name == 'Faceoff' & lag(Period) == Period, lag(Team), Team),
    Player = if_else(type_name == 'Faceoff' & lag(Period) == Period, lag(Player), Player),
    Team = if_else(is.na(Team),t,Team),
    Player = if_else(is.na(Player),p,Player),
    success = if_else(type_name == 'Faceoff' & Team != t, 0, success),
    type_name = if_else(type_name %in% c('Play','Incomplete Play'),'Pass',type_name),
    type_name = if_else(type_name == 'Goal','Shot',type_name),
    success = if_else(type_name == 'Zone Entry' & Detail.1 == 'Dumped',0,success)
  )


# end_x & end_y
data %<>% 
  group_by(
    game_id,Period
  ) %>% 
  mutate(
    end_x = if_else(type_name=='Pass' & success==1,
                    start_x_2,
                    lead(start_x)),
    end_y = if_else(type_name=='Pass' & success==1,
                    start_y_2,
                    lead(start_y))
    ) %>% 
  ungroup() %>%
  mutate(
    #handling some Na's just in case
    Team = if_else(is.na(Team),t,Team),
    Player = if_else(is.na(Player),p,Player),
    success = if_else(is.na(success) & lead(Team)==Team & Period == lead(Period), 1, success),
    end_x = if_else(is.na(end_x)  &  lead(Team) == Team & lead(Period) == Period, lead(start_x),end_x),
    end_y = if_else(is.na(end_y) & lead(Team) == Team & lead(Period) == Period, lead(start_y),end_y),
    end_x = if_else(lead(Team) != Team & success == 0 & type_name %in% c('Pass','Zone Entry'), as.integer(200 - end_x), end_x),
    end_y = if_else(lead(Team) != Team & success == 0 & type_name %in% c('Pass','Zone Entry'), as.integer(85 - end_y), end_y),
  ) %>% 
  select(
    -Detail.1,-Detail.2,-Detail.3,-Detail.4,-Home.Team.Skaters,-Away.Team.Skaters,
    -start_x_2,-start_y_2,-Player.2,-t,-p
  )

#Drop na's
data %<>% na.omit()


#Save
write.csv(data,'data_test_turnover.csv',row.names = F)


