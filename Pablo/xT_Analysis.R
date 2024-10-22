library(tidyverse)
library(ggplot2)
library(ggforce)
library(formattable)
library(gt)
library(fastDummies)
library(brew)
library(dplyr)

df <- read.csv("C:/Users/pablo/Desktop/GithubRepos/BigDataCup/analysis_possessionid.csv")
df <- df %>% filter(!is.na(nxT_added))
# Plot sequence ==========================
NHL_blue <-"black"
NHL_red <- "black"
NHL_light_blue <- "#32a8a4"

scout  <- read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/hackathon_scouting.csv")
scout <- dummy_cols(scout, select_columns = "Event")
scout <- scout %>% 
  mutate(
    assist = ifelse((Event == "Play" & lead(Event)== "Goal"),1,0)
  )

# standarize coordinates
df <- df %>% 
  mutate(
    start_x = (start_x - 100),
    start_y = (start_y - 42.5),
    end_x = (end_x - 100),
    end_y = (end_y - 42.5),
  )

# add playid
df <- df %>% group_by(Team,turnover, play_id = cumsum(turnover)) %>%
  mutate(play_id = ifelse(turnover == 0 & as.numeric(row_number()) == 1, 1, turnover)) %>%
  ungroup() %>% mutate(play_id = cumsum(play_id))

# use a play for viz
mxnt <- df[which(df$nxT_added==max(df$nxT_added)),]
heads <- df %>% 
  #filter(type_name == "Pass" & lead(type_name)=="Goal" ) %>% 
  arrange(desc(nxT_added)) %>% 
  head(20)

assists <- scout %>% filter(assist == 1)

play <- df %>% 
  filter(possession_id == "142112Sudbury Wolves")
play <- play %>% head(4)
play$nxT_added[which(play$Player == "Quinton Byfield")] <- 0.054676825


# Create plot
v <- ggplot()+
  geom_path(data = play,
            aes(x=start_x, y = start_y, colour = nxT_added),
            size = 1.5,
            arrow = arrow(type = "open", 
                          angle = 30,
                          length = unit(0.5, "cm")))+
  scale_colour_gradient(low = "gray", high = "orange",name = 'nxT added')+
  geom_point(data = play, aes(x=start_x, y = start_y, fill = factor(Player)),
             shape = 21,
             size = 4)+
  labs(title = "Visualizing nxT added in a play")+
  theme_bw() +
  theme(panel.grid = element_blank(),axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank()) + 
  #scale_colour_brewer(palette = "Greens") +

  ############################Plot Rink##############################################
  # Plot rink
  # Faceoff circles
  geom_circle(aes(x0 = 0, y0 = 0, r = 15), colour = NHL_blue, size = 2 / 12) + # Centre
  geom_circle(aes(x0 = 69, y0 = 22, r = 15), colour = NHL_red, size = 2 / 12) + # Top-Right
  geom_circle(aes(x0 = 69, y0 = -22, r = 15), colour = NHL_red, size = 2 / 12) + # Bottom-Right
  geom_circle(aes(x0 = -69, y0 = 22, r = 15), colour = NHL_red, size = 2 / 12) + # Top-Left
  geom_circle(aes(x0 = -69, y0 = -22, r = 15), colour = NHL_red, size = 2 / 12) + # Bottom-Left
  
  # Hash marks in T-R/B-R/T-L/B-R order, groups of four
  geom_tile(aes(x = 66.125, y = 37.77, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = 66.125, y = 6.23, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = 71.875, y = 37.77, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = 71.875, y = 6.23, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = 66.125, y = -37.77, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = 66.125, y = -6.23, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = 71.875, y = -37.77, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = 71.875, y = -6.23, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = -66.125, y = 37.77, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = -66.125, y = 6.23, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = -71.875, y = 37.77, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = -71.875, y = 6.23, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = -66.125, y = -37.77, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = -66.125, y = -6.23, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = -71.875, y = -37.77, width = 2 / 12, height = 2), fill = NHL_red) +
  geom_tile(aes(x = -71.875, y = -6.23, width = 2 / 12, height = 2), fill = NHL_red) +
  
  # Centre line
  geom_tile(aes(x = 0, y = 0, width = 1, height = 85), fill = NHL_red) + # Centre line
  
  # Faceoff dots - Plot AFTER centre lines for centre ice circle to show up above
  geom_circle(aes(x0 = 0, y0 = 0, r = 6 / 12), colour = "#FF99B4", fill = "#FF99B4", size = 0) + # Centre dot with unique red
  geom_circle(aes(x0 = 69, y0 = 22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Top-Right
  geom_circle(aes(x0 = 69, y0 = -22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Bottom-Right
  geom_circle(aes(x0 = -69, y0 = 22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Top-Left
  geom_circle(aes(x0 = -69, y0 = -22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Bottom-Left
  
  geom_circle(aes(x0 = 20.5, y0 = 22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Neutral Top-Right
  geom_circle(aes(x0 = 20.5, y0 = -22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Neutral Bottom-Right
  geom_circle(aes(x0 = -20.5, y0 = 22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Neutral Top-Left
  geom_circle(aes(x0 = -20.5, y0 = -22, r = 1), colour = NHL_red, fill = NHL_red, size = 0) + # Neutral Bottom-Left
  
  # Ells surrounding faceoff dots
  geom_tile(aes(x = 65, y = 22.83, width = 4, height = 2 / 12), fill = NHL_red) + # Top-Right
  geom_tile(aes(x = 73, y = 22.83, width = 4, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = 65, y = 21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = 73, y = 21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = 66.92, y = 24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  geom_tile(aes(x = 71.08, y = 24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  geom_tile(aes(x = 66.92, y = 19.75, width = 2 / 12, height = 3), fill = NHL_red) +
  geom_tile(aes(x = 71.08, y = 19.75, width = 2 / 12, height = 3), fill = NHL_red) +
  
  geom_tile(aes(x = 65, y = -22.83, width = 4, height = 2 / 12), fill = NHL_red) + # Bottom-Right
  geom_tile(aes(x = 73, y = -22.83, width = 4, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = 65, y = -21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = 73, y = -21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = 66.92, y = -24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  geom_tile(aes(x = 71.08, y = -24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  geom_tile(aes(x = 66.92, y = -19.75, width = 2 / 12, height = 3), fill = NHL_red) +
  geom_tile(aes(x = 71.08, y = -19.75, width = 2 / 12, height = 3), fill = NHL_red) +
  
  geom_tile(aes(x = -65, y = 22.83, width = 4, height = 2 / 12), fill = NHL_red) + # Top-Left
  geom_tile(aes(x = -73, y = 22.83, width = 4, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = -65, y = 21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = -73, y = 21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = -66.92, y = 24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  geom_tile(aes(x = -71.08, y = 24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  geom_tile(aes(x = -66.92, y = 19.75, width = 2 / 12, height = 3), fill = NHL_red) +
  geom_tile(aes(x = -71.08, y = 19.75, width = 2 / 12, height = 3), fill = NHL_red) +
  
  geom_tile(aes(x = -65, y = -22.83, width = 4, height = 2 / 12), fill = NHL_red) + # Bottom-Left
  geom_tile(aes(x = -73, y = -22.83, width = 4, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = -65, y = -21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = -73, y = -21.17, width = 4, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = -66.92, y = -24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  geom_tile(aes(x = -71.08, y = -24.25, width = 2 / 12, height = 3), fill = NHL_red) +
  geom_tile(aes(x = -66.92, y = -19.75, width = 2 / 12, height = 3), fill = NHL_red) +
  geom_tile(aes(x = -71.08, y = -19.75, width = 2 / 12, height = 3), fill = NHL_red) +
  
  # Referee crease
  geom_arc(aes(x0 = 0, y0 = -42.5, start = -pi / 2, end = pi / 2, r = 10), colour = NHL_red) +
  
  # Left goalie crease
  geom_tile(aes(x = -86.75, y = 0, width = 4.5, height = 8), fill = NHL_light_blue) +
  geom_arc_bar(aes(x0 = -89, y0 = 0, start = atan(4.5/4) - 0.01, end = pi - atan(4.5 / 4) + 0.01, r0 = 4, r = 6), fill = NHL_light_blue, colour = NHL_light_blue, size = 1 / 12) + # manually adjusted arc
  geom_tile(aes(x = -86.75, y = -4, width = 4.5, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = -86.75, y = 4, width = 4.5, height = 2 / 12), fill = NHL_red) +
  geom_arc(aes(x0 = -89, y0 = 0, start = atan(4.5/4) - 0.01, end = pi - atan(4.5 / 4) + 0.01, r = 6), colour = NHL_red, size = 2 / 12) + # manually adjusted arc
  geom_tile(aes(x = -85, y = 3.75, width = 2 / 12, height = 0.42), fill = NHL_red) +
  geom_tile(aes(x = -85, y = -3.75, width = 2 / 12, height = 0.42), fill = NHL_red) +
  
  # Right goalie crease
  geom_tile(aes(x = 86.75, y = 0, width = 4.5, height = 8), fill = NHL_light_blue) +
  geom_arc_bar(aes(x0 = 89, y0 = 0, start = -atan(4.5/4) + 0.01, end = -pi + atan(4.5 / 4) - 0.01, r0 = 4, r = 6), fill = NHL_light_blue, colour = NHL_light_blue, size = 1 / 12) + # manually adjusted arc
  geom_tile(aes(x = 86.75, y = -4, width = 4.5, height = 2 / 12), fill = NHL_red) +
  geom_tile(aes(x = 86.75, y = 4, width = 4.5, height = 2 / 12), fill = NHL_red) +
  geom_arc(aes(x0 = 89, y0 = 0, start = -atan(4.5/4) + 0.01, end = -pi + atan(4.5 / 4) - 0.01, r = 6), colour = NHL_red, size = 2 / 12) + # manually adjusted arc
  geom_tile(aes(x = 85, y = 3.75, width = 2 / 12, height = 0.42), fill = NHL_red) +
  geom_tile(aes(x = 85, y = -3.75, width = 2 / 12, height = 0.42), fill = NHL_red) +
  
  # Goalie nets placed as rectangles
  geom_tile(aes(x = -90.67, y = 0, width = 3.33, height = 6), fill = "#E5E5E3") + # Left # with grey fills
  geom_tile(aes(x = 90.67, y = 0, width = 3.33, height = 6), fill = "#E5E5E3") + # Right
  
  # Trapezoids
  geom_polygon(aes(x = c(-100, -100, -89, -89), y = c(10.92, 11.08, 7.08, 6.92)), fill = NHL_red) + # Left
  geom_polygon(aes(x = c(-100, -100, -89, -89), y = c(-10.92, -11.08, -7.08, -6.92)), fill = NHL_red) + # Left 
  geom_polygon(aes(x = c(100, 100, 89, 89), y = c(10.92, 11.08, 7.08, 6.92)), fill = NHL_red) + # Right
  geom_polygon(aes(x = c(100, 100, 89, 89), y = c(-10.92, -11.08, -7.08, -6.92)), fill = NHL_red) + # Right
  
  # Lines
  geom_tile(aes(x = -25.5, y = 0, width = 1, height = 85), fill = NHL_blue) + # Left Blue line
  geom_tile(aes(x = 25.5, y = 0, width = 1, height = 85),  fill = NHL_blue) + # Right Blue line
  geom_tile(aes(x = -89, y = 0, width = 2 / 12, height = 73.50), fill = NHL_red) + # Left goal line (73.5 value is rounded from finding intersect of goal line and board radius)
  geom_tile(aes(x = 89, y = 0, width = 2 / 12, height = 73.50), fill = NHL_red) + # Right goal line
  
  # Borders as line segments - plotted last to cover up line ends, etc.
  geom_line(aes(x = c(-72, 72), y = c(42.5, 42.5))) + # Top
  geom_line(aes(x = c(-72, 72), y = c(-42.5, -42.5))) + # Bottom
  geom_line(aes(x = c(-100, -100), y = c(-14.5, 14.5))) + # Left
  geom_line(aes(x = c(100, 100), y = c(-14.5, 14.5))) + # Right
  geom_arc(aes(x0 = 72, y0 = 14.5, start = pi / 2, end = 0, r = 28)) + # Top-Right
  geom_arc(aes(x0 = 72, y0 = -14.5, start = pi, end =  pi / 2, r = 28)) + # Bottom-Right
  geom_arc(aes(x0 = -72, y0 = 14.5, start = - pi / 2, end = 0, r = 28)) + # Top-Left
  geom_arc(aes(x0 = -72, y0 = -14.5, start = pi, end =  3 * pi / 2, r = 28)) + # Bottom-Left
##########################################################################################  

  
  # Fixed scale for the coordinate system  
  coord_fixed()
v

ggsave('C:/Users/pablo/Desktop/GithubRepos/BigDataCup/Pablo/playviz.png'
       , dpi = 400)
# credit table
total_added <- sum(play$nxT_added[which(play$nxT_added>0)])
credit <- play %>% 
  select(Player, type_name,nxT_added) %>% 
  mutate(credit = (nxT_added/total_added) *100) %>% 
  mutate_at(vars(credit), funs(round(., 2)))

credit$nxT_added[which(credit$Player == "Quinton Byfield")] <- NA
credit$credit[which(credit$Player == "Quinton Byfield")] <- NA
credit$type_name[which(credit$Player == "Quinton Byfield")] <- "Goal"



credit %>%
  gt() %>% 
  cols_label(
    credit = "net nxT change %",
    type_name = "Event",
    nxT_added = "nxT added"
  ) %>% 
  tab_header( 
    title = "nxT Credit Distribution in a Sunbury Wolves goal", # ...with this title
    subtitle = "") %>% 
  #nxt
  data_color( # Update cell colors...
    columns = vars(credit), # ...for dose column 
    colors = scales::col_numeric( # <- bc it's numeric
      palette = c(
        "white","orange"), # A color scheme (gradient)
      domain = c(0,100) # Column scale endpoints
    )) %>% 
  #nxt
  data_color( # Update cell colors...
    columns = vars(nxT_added), # ...for dose column 
    colors = scales::col_numeric( # <- bc it's numeric
      palette = c(
        "white","#52bdfa"), # A color scheme (gradient)
      domain = c(0,0.055) # Column scale endpoints
    )) %>% 
  fmt_missing(
    columns = vars(nxT_added,credit),
    missing_text = "-"
  ) %>% 
  gtsave("credit_table.png",path = "C:/Users/pablo/Desktop/GithubRepos/BigDataCup/Pablo")

  




################Table for xt comparison####################################
tb <- read.csv("C:/Users/pablo/Desktop/GithubRepos/BigDataCup/analysis_possessionid.csv")
tb <- tb %>% filter(!is.na(nxT_added))

pt <- tb %>% 
  group_by(Player) %>% 
  summarise(
    team = last(Team),
    total_nxT = sum(nxT_added),
    plays = n(),
    nxt_per_play = total_nxT/plays
  ) %>% 
  filter(plays > 50) %>% 
  arrange(desc(nxt_per_play)) 

scout  <- read.csv("https://raw.githubusercontent.com/bigdatacup/Big-Data-Cup-2021/main/hackathon_scouting.csv")
scout <- dummy_cols(scout, select_columns = "Event")
scout <- scout %>% 
  mutate(
    assist = ifelse((Event == "Play" & lead(Event)== "Goal"),1,0)
  )


pl_trad <- scout %>% 
  group_by(Player) %>% 
  summarise(
    assists = sum(assist),
    pass_p = sum(Event_Play)/(sum(`Event_Incomplete Play`)+sum(Event_Play)),
    goals = sum(Event_Goal),
    takeaways = sum(Event_Takeaway)
  )



ft <- merge(pl_trad, pt, by = "Player") %>% 
  arrange(desc(nxt_per_play))
Rank <- seq(1,nrow(ft))

td <- as.data.frame(cbind(Rank,ft))
td <- td %>%
  mutate_at(vars(nxt_per_play), funs(round(., 4))) %>% 
  mutate_at(vars(total_nxT), funs(round(., 2)))

# Table==========================
td %>% 
  head(20) %>% 
  gt() %>% 
  cols_label(
    assists = "Assists",
    team = "Team",
    goals = "Goals",
    takeaways = "Takeaways",
    pass_p = "Succesful Pass %",
    total_nxT = "nxT",
    nxt_per_play = "nxT per play"
  ) %>% 
  cols_hide(
    columns = vars(
      pass_p, plays,assists,goals,takeaways)
  ) %>% 
  tab_header( 
    title = "Top 20 Players in Net Expected Threat generated by play", # ...with this title
    subtitle = "Minimum 50 plays") %>% 
  #nxt
  data_color( # Update cell colors...
    columns = vars(nxt_per_play), # ...for dose column 
    colors = scales::col_numeric( # <- bc it's numeric
      palette = c(
        "white","orange"), # A color scheme (gradient)
      domain = c(0.008,0.003) # Column scale endpoints
    )) %>% 
  data_color( # Update cell colors...
    columns = vars(total_nxT), # ...for dose column 
    colors = scales::col_numeric( # <- bc it's numeric
      palette = c(
        "white","orange"), # A color scheme (gradient)
      domain = c(0.19,1.35) # Column scale endpoints
    )) %>% 
  tab_source_note(
    source_note = md("Data: 40 game BDC scouting dataset.")
  ) %>% 
   
  #gtsave("top20nxt.pdf",path = "C:/Users/pablo/Desktop/GithubRepos/BigDataCup/Pablo")
  gtsave("top20nxtpgame.png",path = "C:/Users/pablo/Desktop/GithubRepos/BigDataCup/Pablo")
  

#############Pass viz#########################################

