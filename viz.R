# Before working with this script, run the data_wrangling.R and the plot_rink.R scripts
library(RColorBrewer)
library(ggforce)
library(ggplot2)
# NHL_blue <-"darkblue"
# NHL_red <- "red"
# NHL_light_blue <- "#32a8a4"
NHL_blue <-"white"
NHL_red <- "white"
NHL_light_blue <- "white"


###########################
# Plot shots and goals
##########################

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


# Plot and visulize like in the xT model
ggplot(shots,aes(x=X.Coordinate,y=Y.Coordinate)) + stat_bin_2d(bins = c(16,12),hjust = 0, vjust = 0)


####################################################################################################
# Plot xT model results
####################################################################################################
frame <- read.csv("C:/Users/pablo/Desktop/GithubRepos/BigDataCup/xT_model-Adrian/frame_plot.csv")
frame <- frame %>% select(-X)
# Center frame
frame <- frame %>%
  mutate(
    x = x-100,
    y = y-42.5
  )


colors <- RColorBrewer::brewer.pal(name='YlOrRd',n=9)
alt_red <- "#1f0202"
alt_yellow <- "#fffb00"

xt_viz <- ggplot() +
  geom_tile(data=frame,aes(x,y,fill=xt)) + 
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
  geom_line(aes(x = c(-72, 72), y = c(42.5, 42.5)),color = "white") + # Top
  geom_line(aes(x = c(-72, 72), y = c(-42.5, -42.5)),color = "white") + # Bottom
  geom_line(aes(x = c(-100, -100), y = c(-14.5, 14.5)),color = "white") + # Left
  geom_line(aes(x = c(100, 100), y = c(-14.5, 14.5)),color = "white") + # Right
  geom_arc(aes(x0 = 72, y0 = 14.5, start = pi / 2, end = 0, r = 28),color = "white") + # Top-Right
  geom_arc(aes(x0 = 72, y0 = -14.5, start = pi, end =  pi / 2, r = 28),color = "white") + # Bottom-Right
  geom_arc(aes(x0 = -72, y0 = 14.5, start = - pi / 2, end = 0, r = 28),color = "white") + # Top-Left
  geom_arc(aes(x0 = -72, y0 = -14.5, start = pi, end =  3 * pi / 2, r = 28),color = "white") + # Bottom-Left
  
  theme_bw() +
  theme(panel.grid = element_blank()) + 
  #scale_fill_gradient(low = alt_red,high = alt_yellow) +
  scale_fill_gradientn(colours=c("black", "red","yellow"))+
  
  # Fixed scale for the coordinate system  
  coord_fixed()
  
  
xt_viz

