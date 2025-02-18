setwd("~/GitHub/BigDataCup")

library(RColorBrewer)
library(ggforce)
library(ggplot2)
library(dplyr)

frame <- read.csv("xT/nwhl/frame_plot.csv")%>%
  mutate(
    x = (x/10)-100,
    y = (y/10)-42.5
  )

color_lines = "white"

xt_viz <- ggplot() +
  geom_tile(data=frame,aes(x,y,fill=xt)) + 
  # Faceoff circles
  geom_circle(aes(x0 = 0, y0 = 0, r = 15), colour = color_lines, size = 2 / 4) + # Centre
  geom_circle(aes(x0 = 69, y0 = 22, r = 15), colour = color_lines, size = 2 / 4) + # Top-Right
  geom_circle(aes(x0 = 69, y0 = -22, r = 15), colour = color_lines, size = 2 / 4) + # Bottom-Right
  geom_circle(aes(x0 = -69, y0 = 22, r = 15), colour = color_lines, size = 2 / 4) + # Top-Left
  geom_circle(aes(x0 = -69, y0 = -22, r = 15), colour = color_lines, size = 2 / 4) + # Bottom-Left
  
  # Hash marks in T-R/B-R/T-L/B-R order, groups of four
  geom_tile(aes(x = 66.125, y = 37.77, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = 66.125, y = 6.23, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = 71.875, y = 37.77, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = 71.875, y = 6.23, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = 66.125, y = -37.77, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = 66.125, y = -6.23, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = 71.875, y = -37.77, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = 71.875, y = -6.23, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = -66.125, y = 37.77, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = -66.125, y = 6.23, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = -71.875, y = 37.77, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = -71.875, y = 6.23, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = -66.125, y = -37.77, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = -66.125, y = -6.23, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = -71.875, y = -37.77, width = 2 / 6, height = 2), fill = color_lines) +
  geom_tile(aes(x = -71.875, y = -6.23, width = 2 / 6, height = 2), fill = color_lines) +
  
  # Centre line
  geom_tile(aes(x = 0, y = 0, width = 1, height = 85), fill = color_lines) + # Centre line
  
  # Faceoff dots - Plot AFTER centre lines for centre ice circle to show up above
  geom_circle(aes(x0 = 0, y0 = 0, r = 6 / 12), colour = "#FF99B4", fill = "#FF99B4", size = 0) + # Centre dot with unique red
  geom_circle(aes(x0 = 69, y0 = 22, r = 1), colour = color_lines, fill = color_lines, size = 0) + # Top-Right
  geom_circle(aes(x0 = 69, y0 = -22, r = 1), colour = color_lines, fill = color_lines, size = 0) + # Bottom-Right
  geom_circle(aes(x0 = -69, y0 = 22, r = 1), colour = color_lines, fill = color_lines, size = 0) + # Top-Left
  geom_circle(aes(x0 = -69, y0 = -22, r = 1), colour = color_lines, fill = color_lines, size = 0) + # Bottom-Left
  
  geom_circle(aes(x0 = 20.5, y0 = 22, r = 1), colour = color_lines, fill = color_lines, size = 0) + # Neutral Top-Right
  geom_circle(aes(x0 = 20.5, y0 = -22, r = 1), colour = color_lines, fill = color_lines, size = 0) + # Neutral Bottom-Right
  geom_circle(aes(x0 = -20.5, y0 = 22, r = 1), colour = color_lines, fill = color_lines, size = 0) + # Neutral Top-Left
  geom_circle(aes(x0 = -20.5, y0 = -22, r = 1), colour = color_lines, fill = color_lines, size = 0) + # Neutral Bottom-Left
  
  # Ells surrounding faceoff dots
  geom_tile(aes(x = 65, y = 22.83, width = 4, height = 2 / 8), fill = color_lines) + # Top-Right
  geom_tile(aes(x = 73, y = 22.83, width = 4, height = 2 / 8), fill = color_lines) +
  geom_tile(aes(x = 65, y = 21.17, width = 4, height = 2 / 8), fill = color_lines) +
  geom_tile(aes(x = 73, y = 21.17, width = 4, height = 2 / 8), fill = color_lines) +
  geom_tile(aes(x = 66.92, y = 24.25, width = 2 / 8, height = 3), fill = color_lines) +
  geom_tile(aes(x = 71.08, y = 24.25, width = 2 / 8, height = 3), fill = color_lines) +
  geom_tile(aes(x = 66.92, y = 19.75, width = 2 / 8, height = 3), fill = color_lines) +
  geom_tile(aes(x = 71.08, y = 19.75, width = 2 / 8, height = 3), fill = color_lines) +
  
  geom_tile(aes(x = 65, y = -22.83, width = 4, height = 2 / 12), fill = color_lines) + # Bottom-Right
  geom_tile(aes(x = 73, y = -22.83, width = 4, height = 2 / 12), fill = color_lines) +
  geom_tile(aes(x = 65, y = -21.17, width = 4, height = 2 / 12), fill = color_lines) +
  geom_tile(aes(x = 73, y = -21.17, width = 4, height = 2 / 12), fill = color_lines) +
  geom_tile(aes(x = 66.92, y = -24.25, width = 2 / 12, height = 3), fill = color_lines) +
  geom_tile(aes(x = 71.08, y = -24.25, width = 2 / 12, height = 3), fill = color_lines) +
  geom_tile(aes(x = 66.92, y = -19.75, width = 2 / 12, height = 3), fill = color_lines) +
  geom_tile(aes(x = 71.08, y = -19.75, width = 2 / 12, height = 3), fill = color_lines) +
  
  geom_tile(aes(x = -65, y = 22.83, width = 4, height = 2 / 12), fill = color_lines) + # Top-Left
  geom_tile(aes(x = -73, y = 22.83, width = 4, height = 2 / 12), fill = color_lines) +
  geom_tile(aes(x = -65, y = 21.17, width = 4, height = 2 / 12), fill = color_lines) +
  geom_tile(aes(x = -73, y = 21.17, width = 4, height = 2 / 12), fill = color_lines) +
  geom_tile(aes(x = -66.92, y = 24.25, width = 2 / 12, height = 3), fill = color_lines) +
  geom_tile(aes(x = -71.08, y = 24.25, width = 2 / 12, height = 3), fill = color_lines) +
  geom_tile(aes(x = -66.92, y = 19.75, width = 2 / 12, height = 3), fill = color_lines) +
  geom_tile(aes(x = -71.08, y = 19.75, width = 2 / 12, height = 3), fill = color_lines) +
  
  geom_tile(aes(x = -65, y = -22.83, width = 4, height = 2 / 12), fill = color_lines) + # Bottom-Left
  geom_tile(aes(x = -73, y = -22.83, width = 4, height = 2 / 12), fill = color_lines) +
  geom_tile(aes(x = -65, y = -21.17, width = 4, height = 2 / 12), fill = color_lines) +
  geom_tile(aes(x = -73, y = -21.17, width = 4, height = 2 / 12), fill = color_lines) +
  geom_tile(aes(x = -66.92, y = -24.25, width = 2 / 12, height = 3), fill = color_lines) +
  geom_tile(aes(x = -71.08, y = -24.25, width = 2 / 12, height = 3), fill = color_lines) +
  geom_tile(aes(x = -66.92, y = -19.75, width = 2 / 12, height = 3), fill = color_lines) +
  geom_tile(aes(x = -71.08, y = -19.75, width = 2 / 12, height = 3), fill = color_lines) +
  
  # Referee crease
  geom_arc(aes(x0 = 0, y0 = -42.5, start = -pi / 2, end = pi / 2, r = 10), colour = color_lines) +
  
  # Left goalie crease
  geom_arc(aes(x0 = -89, y0 = 0, start = atan(4.5/4) - 0.01, end = pi - atan(4.5 / 4) + 0.01, r = 6), colour = color_lines, size = 2 / 4) + # manually adjusted arc
  geom_line(aes(x = c(-84.755, -89), y = c(-4, -4)),color = color_lines, size = 2 / 4) +
  geom_line(aes(x = c(-84.755, -89), y = c(4, 4)),color = color_lines, size = 2 / 4) +

  # Right goalie crease
  geom_line(aes(x = c(84.755, 89), y = c(-4, -4)),color = color_lines, size = 2 / 4) +
  geom_line(aes(x = c(84.755, 89), y = c(4, 4)),color = color_lines, size = 2 / 4) +
  geom_arc(aes(x0 = 89, y0 = 0, start = -atan(4.5/4) + 0.01, end = -pi + atan(4.5 / 4) - 0.01, r = 6), colour = color_lines, size = 2 / 4) + # manually adjusted arc
  
  #L ratio: 12.50
  #W ratio: 10.625
  #

  # Goalie nets placed as rectangles
  geom_tile(aes(x = -90.67, y = 0, width = 3.33, height = 6), fill = "white") +
  geom_tile(aes(x = 90.67, y = 0, width = 3.33, height = 6), fill = "white") +
  
  # (192.335*16)/200 = 15.3868
  # (189.005*16)/200 = 15.1204
  
  # Trapezoids
  geom_polygon(aes(x = c(-100, -100, -89, -89), y = c(10.92, 11.08, 7.08, 6.92)), color = color_lines,fill=NA) + # Left
  geom_polygon(aes(x = c(-100, -100, -89, -89), y = c(-10.92, -11.08, -7.08, -6.92)), color = color_lines,fill=NA) + # Left 
  geom_polygon(aes(x = c(100, 100, 89, 89), y = c(10.92, 11.08, 7.08, 6.92)), color = color_lines,fill=NA) + # Right
  geom_polygon(aes(x = c(100, 100, 89, 89), y = c(-10.92, -11.08, -7.08, -6.92)), color = color_lines,fill=NA) + # Right
  
  # Lines
  geom_tile(aes(x = -25.5, y = 0, width = 1, height = 85), fill = color_lines) + # Left Blue line
  geom_tile(aes(x = 25.5, y = 0, width = 1, height = 85),  fill = color_lines) + # Right Blue line
  geom_tile(aes(x = -89, y = 0, width = 2 / 12, height = 73.50), fill = color_lines) + # Left goal line (73.5 value is rounded from finding intersect of goal line and board radius)
  geom_tile(aes(x = 89, y = 0, width = 2 / 12, height = 73.50), fill = color_lines) + # Right goal line
  
  # Borders as line segments - plotted last to cover up line ends, etc.
  geom_line(aes(x = c(-72, 72), y = c(42.5, 42.5)),color = color_lines) + # Top
  geom_line(aes(x = c(-72, 72), y = c(-42.5, -42.5)),color = color_lines) + # Bottom
  geom_line(aes(x = c(-100, -100), y = c(-14.5, 14.5)),color = color_lines) + # Left
  geom_line(aes(x = c(100, 100), y = c(-14.5, 14.5)),color = color_lines) + # Right
  geom_arc(aes(x0 = 72, y0 = 14.5, start = pi / 2, end = 0, r = 28),color = color_lines) + # Top-Right
  geom_arc(aes(x0 = 72, y0 = -14.5, start = pi, end =  pi / 2, r = 28),color = color_lines) + # Bottom-Right
  geom_arc(aes(x0 = -72, y0 = 14.5, start = - pi / 2, end = 0, r = 28),color = color_lines) + # Top-Left
  geom_arc(aes(x0 = -72, y0 = -14.5, start = pi, end =  3 * pi / 2, r = 28),color='white') + # Bottom-Left
  
  #cover edges
  #TR
  geom_arc_bar(aes(x0 = 72, y0 = 14.5, start = pi / 2, end = 0, r0 = 28, r = 35), 
               fill = 'white', colour = 'white', size = 1 / 12) +
  geom_tile(aes(x = 97, y = 39, width = 8, height = 8), fill = "white") +
  #TL
  geom_arc_bar(aes(x0 = -72, y0 = 14.5, start = - pi / 2, end = 0, r0 = 28, r = 35), 
               fill = color_lines, colour = color_lines, size = 1 / 12) +
  
  geom_tile(aes(x = -97, y = 39, width = 8, height = 8), fill = "white") +
  #BR
  geom_arc_bar(aes(x0 = 72, y0 = -14.5, start = pi, end = pi/2, r0 = 28, r = 35),
               fill = 'white', colour = 'white', size = 1 / 12) +
  
  geom_tile(aes(x = 97, y = -40, width = 8, height = 8), fill = "white") +

  #BL
  geom_arc_bar(aes(x0 = -72, y0 = -14.5, start = pi, end =  3 * pi / 2, r0 = 28, r = 35),
               fill = 'white', colour = 'white', size = 1 / 12) +
  
  geom_tile(aes(x = -96.5, y = -39, width = 8, height = 8), fill = "white") +
  
  theme_bw() +
  theme(
    panel.grid = element_blank(),
    axis.line=element_blank(),axis.text.x=element_blank(),
    axis.text.y=element_blank(),axis.ticks=element_blank(),
    axis.title.x=element_blank(),
    axis.title.y=element_blank(),
    panel.border = element_blank(), 
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title = element_text(hjust=0.5),
    legend.position = 'top'
    ) + 
  scale_fill_gradientn(colours=c("black", "red","yellow"))+
  
  # Fixed scale for the coordinate system  
  coord_fixed() + 
  labs(
    title= 'Distribution of expected threat (xT) across rink - NWHL',
    fill = 'xT'
  ) 

xt_viz + ggsave('xT/plotsnwhl.png',width=7,height=7,dpi=700)



