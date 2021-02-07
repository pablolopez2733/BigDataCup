# Plotting a full NHL Rink------------------------------------------------------------------
function () {
  
  # Plotting an NHL rink completely following the NHL rule book:
  # https://cms.nhl.bamgrid.com/images/assets/binary/308893668/binary-file/file.pdf
  # Line widths, lengths, colours, all followed as closely as possible
  
  ggplot() +
    
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
    
    # Fixed scale for the coordinate system  
    coord_fixed()
}

# Draw half rink---------------------------------------------------------------------------------------
library(ggplot2)

gg_rink <- function(side = "right", specs = "nhl"){
  
  ### this function uses ggplot's annotate()
  # to draw the rink.
  # I recommend calling this function PRIOR to invoking
  # geoms for data so that the points aren't covered
  # by the annotations
  
  ### inputs:
  #     1. side = which side to plot: "right" (default) or "left"
  #     2. specs = which rink size to use: "nhl" (default) or "iihf" for
  #        international
  
  # check inputs
  side <- tolower(side)
  specs <- tolower(specs)
  stopifnot(side %in% c("right", "left"))
  stopifnot(specs %in% c("nhl", "iihf"))
  
  side <- switch(side,
                 "right" = 1,
                 "left" = -1)
  
  nsteps <- 1001 # line resolution for drawing circles/segments
  circle <- seq(0, 2*pi, length = nsteps) # angles to draw a circle
  
  switch(specs,
         "nhl" = {
           # NHL specifications
           # all units in feet
           
           ### rink boundaries ###
           ## assumed to be standard 200x85ft dimensions
           x_max <- 100
           y_max <- 42.5
           y_min <- -y_max
           # blue line 75' from end boards
           x_blue <- x_max - 75
           # goal line 11' from end boards
           x_goal <- x_max - 11
           
           ### parameter setup
           ## corners rounded in arc of circle with 28' radius
           r_corner <- 28
           
           ## crease semi-circle
           # 6' radius from center of goal line starting 4.5' out
           crease_end <- 4.5
           r_crease <- 6
           # deepest point of net is 40"
           net_depth <- 40/12
           # crease is 8' long; goal posts 6' apart
           goal_post_start <- 6/2
           crease_start_y <- 8/2
           # inner crease lines begin 4' from goal line
           # extend 5" into crease
           crease_small_start <- 4
           crease_small_length <- 5/12
           
           ## face-off circle dots and lines
           # dot locations: 20' from goal line, 22' in each y direction
           x_dot_dist <- 20
           y_faceoff_dot <- 22
           # face-off circle radius 15'
           r_faceoff <- 15
           # hash marks 2' long, 5'7" apart
           hash_length <- 2
           hash_space <- 67/12
           # circle inner lines:
           # x-direction: lines 4' apart, so start 2' from dot
           # y-direction: lines 18" apart, so start 9" from dot
           inner_start_x <- 2
           inner_start_y <- 1.5/2
           # lines parallel to side boards: 4' long
           par_side_length <- 4
           # lines parallel to end boards: 3' long
           par_end_length <- 3
           
           ## other parameters
           # neutral zone dots are 5' from blue line, 44' apart
           x_dot_neutral <- 5
           # ref circle 5m radius
           r_ref <- 5
           ## trapezoid (NHL only)
           # begins 8' from each goal post
           # bottom base is 28' long
           y_traps_start <- goal_post_start + 8
           y_traps_end <- 14
         },
         "iihf" = {
           # IIHF specifications
           # all units in meters
           
           ### rink boundaries ###
           ## assumed to be standard 60x30m dimensions
           x_max <- 30
           y_max <- 15
           y_min <- -y_max
           # blue line 22.86m from end boards, 30cm wide
           x_blue <- x_max - 22.86
           # goal line 4m from end boards
           x_goal <- x_max - 4
           
           ### parameter setup
           ## corners rounded in arc of circle with 8.5m radius
           r_corner <- 8.5
           
           ## crease semi-circle
           # 183cm radius from center of goal line starting 137cm out
           crease_end <- 1.37
           r_crease <- 1.83
           # deepest point of net is 1.12m
           net_depth <- 1.12
           # crease is 244cm long; goal posts 183.5cm apart
           goal_post_start <- 1.835/2
           crease_start_y <- 2.44/2
           # inner crease lines begin 122cm from goal line
           # extend 13m into crease
           crease_small_start <- 1.22
           crease_small_length <- 0.13
           
           ## face-off circle dots and lines
           # dot locations: 6m from goal line, 7m in each y direction
           x_dot_dist <- 6
           y_faceoff_dot <- 7
           # face-off circle radius 4.5m
           r_faceoff <- 4.5
           # hash marks 60cm long, 170cm apart
           hash_length <- 0.6
           hash_space <- 1.7
           # circle inner lines:
           # x-direction: lines 120cm apart, start 60cm from dot
           # y-direction: lines 45cm apart, so start 22.5cm from dot
           inner_start_x <- 0.6
           inner_start_y <- 0.225
           # lines parallel to side boards: 120cm long
           par_side_length <- 1.2
           # lines parallel to end boards: 90cm long
           par_end_length <- 0.9
           
           ## other parameters
           # neutral zone dots are 1.5m from blue line
           x_dot_neutral <- 1.5
           # ref circle 3m radius
           r_ref <- 3
         }
  )
  
  ## corners
  curve_angle <- seq(pi/2, 0, length = nsteps)
  curve_angle_last <- curve_angle[nsteps]
  # y coord at end of curve to connect ends
  y_curve_end <- (y_max - r_corner) + r_corner*sin(curve_angle_last)
  # for goal line, find y coord when x is at goal line
  goal_angle <- acos(
    (x_goal - (x_max - r_corner))/r_corner
  )
  y_goal <- (y_max - r_corner) + r_corner*sin(goal_angle)
  
  ## crease
  crease_angles <- seq(
    pi - acos(crease_end/r_crease),
    pi + acos(crease_end/r_crease),
    length = nsteps
  )
  
  ## face-off circle
  x_faceoff_dot <- x_goal - x_dot_dist
  # find y coord on circle where hashes begin
  y_hash <- r_faceoff*sin(
    acos((hash_space/2)/r_faceoff)
  )
  
  ### create list of components to pass to ggplot
  list(
    theme_minimal(),
    theme(panel.grid = element_blank()),
    ### blue line
    annotate(
      "segment",
      x = x_blue*side, y = y_max,
      xend = x_blue*side, yend = y_min,
      color = "blue", size = 2
    ),
    ### ref crease
    annotate(
      "path",
      x = r_ref*cos(seq(pi/2, 0, length = nsteps))*side,
      y = y_min + r_ref*sin(seq(pi/2, 0, length = nsteps)),
      color = "red"
    ),
    ### face-off circle, center ice
    annotate(
      "path",
      x = r_faceoff*cos(seq(pi/2, -pi/2, length = nsteps))*side,
      y = r_faceoff*sin(seq(pi/2, -pi/2, length = nsteps)),
      color = "blue"
    ),
    ### center line:
    annotate(
      "segment",
      x = 0, y = y_max,
      xend = 0, yend = y_min,
      color = "red", size = 2
    ),
    switch(specs,
           "nhl" = annotate(
             # dashed white lines atop center line (NHL only)
             "segment",
             x = 0, y = y_max,
             xend = 0, yend = y_min,
             color = "white", size = 0.5, linetype = "dashed"
           ),
           "iihf" = annotate(
             # 50cm space between lines around center dot
             "segment",
             x = 0, y = 0.5,
             xend = 0, yend = -0.5,
             color = "white", size = 2.5
           )
    ),
    ### face-off dot, center ice
    annotate(
      "point",
      x = 0,
      y = 0,
      color = "blue", size = 1
    ),
    ### neutral zone dots
    annotate(
      "point",
      x = (x_blue - x_dot_neutral)*side,
      y = y_faceoff_dot*c(1, -1),
      color = "red", size = 1
    ),
    ### side boards
    annotate(
      "segment",
      x = 0, y = c(y_min, y_max),
      # stop where corner curve begins
      xend = (x_max - r_corner)*side, yend = c(y_min, y_max),
      size = 1
    ),
    ### ends
    # goal line
    annotate(
      "segment",
      x = x_goal*side, y = y_goal,
      xend = x_goal*side, yend = -y_goal,
      color = "red"
    ),
    # connect ends
    annotate(
      "segment",
      x = x_max*side, y = y_curve_end,
      xend = x_max*side, yend = -y_curve_end,
      size = 1
    ),
    # corners rounded in arc of circle
    # starting point: (x_max, y_max) - r_circle from pi/2 to 0
    annotate(
      "path",
      x = ((x_max - r_corner) + r_corner*cos(curve_angle))*side,
      y = (y_max - r_corner) + r_corner*sin(curve_angle),
      size = 1
    ),
    annotate(
      "path",
      x = ((x_max - r_corner) + r_corner*cos(curve_angle))*side,
      y = -((y_max - r_corner) + r_corner*sin(curve_angle)),
      size = 1
    ),
    ### crease
    annotate(
      "segment",
      x = x_goal*side,
      y = crease_start_y*c(-1, 1),
      xend = (x_goal - crease_end)*side,
      yend = crease_start_y*c(-1, 1),
      col = "red"
    ),
    # crease lines
    annotate(
      "segment",
      x = (x_goal - crease_small_start)*side,
      y = crease_start_y*c(-1, 1),
      xend = (x_goal - crease_small_start)*side,
      yend = (crease_start_y - crease_small_length)*c(-1, 1),
      col = "red"
    ),
    # semi-circle starting 137cm out with 183cm radius from center of goal line
    annotate(
      "path",
      x = (x_goal + r_crease*cos(crease_angles))*side,
      y = r_crease*sin(crease_angles),
      col = "red"
    ),
    if (specs == "nhl") {
      ### restricted area (NHL only)
      annotate(
        "segment",
        x = x_goal*side, y = y_traps_start*c(-1, 1),
        xend = x_max*side, yend = y_traps_end*c(-1, 1),
        color = "red"
      )
    },
    ### net
    annotate(
      "segment",
      x = x_goal*side,
      y = goal_post_start*c(-1, 1),
      xend = (x_goal + net_depth)*side,
      yend = goal_post_start*c(-1, 1)
    ),
    annotate(
      "segment",
      x = (x_goal + net_depth)*side,
      y = -goal_post_start,
      xend = (x_goal + net_depth)*side,
      yend = goal_post_start
    ),
    ### face-off circles
    # dot
    annotate(
      "point",
      x = x_faceoff_dot*side,
      y = y_faceoff_dot*c(1, -1),
      col = "red",
      size = 1
    ),
    # circles 
    annotate(
      # top
      "path",
      x = side*(x_faceoff_dot + r_faceoff*cos(circle)),
      y = y_faceoff_dot + r_faceoff*sin(circle),
      col = "red"
    ),
    annotate(
      # bottom
      "path",
      x = side*(x_faceoff_dot + r_faceoff*cos(circle)),
      y = -(y_faceoff_dot + r_faceoff*sin(circle)),
      col = "red"
    ),
    # hashes
    annotate(
      "segment",
      x = side*(
        x_faceoff_dot + (hash_space/2)*rep(c(1, -1), each = 4)
      ),
      y = (y_faceoff_dot + y_hash*c(1, -1))*rep(c(1, 1, -1, -1), times = 2),
      xend = side*(
        x_faceoff_dot + (hash_space/2)*rep(c(1, -1), each = 4)
      ),
      yend = (y_faceoff_dot + (y_hash + hash_length)*c(1, -1))*
        rep(c(1, 1, -1, -1), times = 2),
      col = "red"
    ),
    ## inner lines
    # parallel to side boards
    annotate(
      # parallel to side boards
      "segment",
      x = side*(
        x_faceoff_dot + inner_start_x*rep(c(1, -1), each = 4)
      ),
      y = (y_faceoff_dot + inner_start_y*c(1, -1))*
        rep(c(1, 1, -1, -1), times = 2),
      xend = side*(
        x_faceoff_dot + (inner_start_x + par_side_length)*
          rep(c(1, -1), each = 4)
      ),
      yend = (y_faceoff_dot + inner_start_y*c(1, -1))*
        rep(c(1, 1, -1, -1), times = 2),
      col = "red"
    ),
    annotate(
      # parallel to end boards
      "segment",
      x = side*(
        x_faceoff_dot + inner_start_x*rep(c(1, -1), each = 4)
      ),
      y = (y_faceoff_dot + inner_start_y*c(1, -1))*
        rep(c(1, 1, -1, -1), times = 2),
      xend = side*(
        x_faceoff_dot + inner_start_x*rep(c(1, -1), each = 4)
      ),
      yend = (y_faceoff_dot + (inner_start_y + par_end_length)*c(1, -1))*
        rep(c(1, 1, -1, -1), times = 2),
      col = "red"
    )
  )
}



