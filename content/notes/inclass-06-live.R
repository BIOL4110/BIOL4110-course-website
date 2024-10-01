

library(tidyverse)
library(gapminder)


gapminder <- gapminder


gapminder %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp, shape = continent)) + geom_point(alpha = 0.7, color = "red") +
  scale_x_log10(labels = scales::dollar_format()) +
  scale_y_continuous(breaks=c(55,65,75)) +
  theme_minimal() + ylab("Life expectancy") + xlab("GDP per capita") + labs(title = "my graph") +
  theme(legend.position= "none") +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5, hjust=1))
