# Before working with this script, run the data_wrangling.R and the plot_rink.R scripts


# Shots
shots <- data %>% 
  filter(Event == "Goal" | Event == "Shot") 


# Shots and Goals Location plot
shots_scatter <- ggplot(shots , aes(x=X.Coordinate, y=Y.Coordinate , color = Detail.1)) +
  gg_rink() +
  geom_point(aes(color = Event, shape = Event),
             position = "jitter", size = 1.5, alpha = 0.8) +
  theme(
    plot.title = element_text(size = 13.5 , hjust = 0.5),
    plot.subtitle = element_text(size = 11,hjust = 0.5),
    plot.caption = element_text(size= 10, family = "Trebuchet MS",color = "grey20",hjust = 0.9),
    axis.line=element_blank(),
    axis.text.x=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks=element_blank(),
    axis.title.x=element_blank(),
    axis.title.y=element_blank(),
  )+
  labs(title = "Shot Locations for Big Data Cup sample of \n Women´s NCAA and Olympics game data ",
       subtitle = "Shots: 1671  | Goals: 56",
       caption = "Data: Stathlete´s Big Data Cup",
       x = NULL,
       y = NULL) +
  scale_color_manual(values = c("Shot" = "gray", "Goal" = "green"),
                     name = NULL) +
  scale_shape_manual(values = c("Shot" = 4, "Goal" = 16),
                     name = NULL) +
  scale_x_continuous(breaks = seq(0, 100, by = 10)) +
  scale_y_continuous(breaks = seq(-40, 40, by = 10))


shots_scatter


