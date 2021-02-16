library(ggplot2)
library(plotly)

data=read.csv('xt/nwhl/for_interactive.csv')%>%
  mutate(
    x = x-7.5,
    y = y-3.5
  )

data$y %>% max()

color_lines = 'gray20'
# Plot

probs <- ggplot()+
  geom_tile(data=data,
            aes(x = x,y = y, fill=xt,
                text = sprintf("Shot Probability: %s<br>Move Probability: %s<br>Score Probability: %s",
                               round(shot_prob,2), round(move_prob,2), round(score_prob,2)))) +
  scale_fill_gradientn(colours=c("white","lightgreen",'darkgreen')) + 
  theme_bw()

ggplotly(probs)





