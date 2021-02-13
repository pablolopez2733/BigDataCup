library(dplyr)
library(magrittr)

data_ <- read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/hackathon_nwhl.csv")

#center coordinates (0,0) and rename
data <- data_ %>% 
  mutate(
    # X.Coordinate = (X.Coordinate - 100),
    # Y.Coordinate = (Y.Coordinate - 42.5),
    # X.Coordinate.2 = if_else(!is.na(X.Coordinate.2),(X.Coordinate.2 - 100),NA_real_),
    # Y.Coordinate.2 = if_else(!is.na(Y.Coordinate.2),(Y.Coordinate.2 - 42.5),NA_real_),
  )  %>% 
  rename(
    start_x = X.Coordinate,
    start_x_2 = X.Coordinate.2,
    start_y = Y.Coordinate,
    start_y_2 = Y.Coordinate.2
)

# add game ids:
data %<>% 
  group_by(game_date,Home.Team,Away.Team) %>% 
  mutate(game_id = cur_group_id())

#success field
data %<>%
  mutate(
    success =
      case_when(
      Event == 'Shot'~0,
      Event == 'Goal'~1,
      Event == 'Play'~1,
      Event == 'Incomplete Play'~0,
      Event == 'Takeaway'~1,
      Event == 'Puck Recovery'~1,
      Event == 'Dump In/Out'~0,
      Event == 'Zone Entry'~1,
      Event == 'Faceoff Win'~1,
      Event == 'Penalty Taken'~1
    )
  )


# changes to follow similar structure as soccer data
data %<>% 
  rename(
    type_name = Event
  )

data$type_name %>% unique()

# Some changes to fit model
data %<>% mutate(
  type_name = if_else(type_name == 'Faceoff Win','Faceoff',type_name),
  t = Team,
  Team = if_else(type_name == 'Faceoff',lag(Team),Team),
  success = if_else(type_name == 'Faceoff' & Team != t,0,success),
  type_name = if_else(type_name %in% c('Play','Incomplete Play'),'Pass',type_name),
  type_name = if_else(type_name == 'Goal','Shot',type_name),
  success = if_else(type_name == 'Zone Entry' & lead(Team) != Team,0,success)
)

# end_x & end_y
data %<>% 
  group_by(
    game_id,Team
  ) %>% 
  mutate(
    end_x = if_else(type_name=='Pass' & success==1,
                    start_x_2,
                    lead(start_x)),
    end_y = if_else(type_name=='Pass' & success==1,
                    start_y_2,
                    lead(start_y))
  ) %>% ungroup() %>% select(
    -Detail.1,-Detail.2,-Detail.3,-Detail.4,-Home.Team.Skaters,-Away.Team.Skaters,
    -start_x_2,-start_y_2,-Player.2,-t
    )

t=data %>% filter(success==0)
write.csv(data,'~/GitHub/BigDataCup/xT_model-Adrian/data_nwhl.csv',row.names = F)

