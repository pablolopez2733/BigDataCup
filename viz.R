# Before working with this script, run the data_wrangling.R and the plot_rink.R scripts


# Goals
shots <- data %>% 
  filter(Event == "Goal" | Event == "Shot")


shots_scatter <- ggplot(shots , aes(x=X.Coordinate, y=Y.Coordinate , color = Detail.1)) +
  gg_rink() +
  geom_point(aes(color = Event, shape = Event),
             position = "jitter", size = 1.5, alpha = 0.7) +
  labs(title = "Big Data Cup Dataset Shot Locations",
       x = NULL,
       y = NULL) +
  scale_color_manual(values = c("Shot" = "gray", "Goal" = "green"),
                     name = NULL) +
  scale_shape_manual(values = c("Shot" = 4, "Goal" = 16),
                     name = NULL) +
  scale_x_continuous(breaks = seq(0, 100, by = 10)) +
  scale_y_continuous(breaks = seq(-40, 40, by = 10)) +
  theme(
    plot.title = element_text(size = 10,hjust = 0),
    plot.subtitle = element_text(size = 5.5,hjust = 0),
    axis.title = element_text(size = 5.5, family = "Trebuchet MS",color = "grey20"),
    plot.caption = element_text(size= 4.5, family = "Trebuchet MS",color = "grey20",hjust = 0),
    legend.key.size =unit(.75,"line")
  )


shots_scatter