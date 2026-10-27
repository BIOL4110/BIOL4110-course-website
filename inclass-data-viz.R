

library(gapminder)
library(tidyverse)


gapminder <- gapminder
write_csv(gapminder, "gapminder.csv")

str(gapminder)


gapminder <- read_csv("gapminder.csv")






gapminder |> 
  ggplot(aes(x = year, y = lifeExp, color = continent)) + geom_point()


gapminder2 <- gapminder |> 
  group_by(year, continent) |> 
  summarise(life_exp_mean = mean(lifeExp))

ggplot(gapminder2, aes(x = year, y = life_exp_mean, color = continent)) + geom_line()



gapminder |> 
  ggplot(aes(x = year, y = lifeExp, color = country)) + geom_line() +
  theme(legend.position = "none")


gapminder |> 
  group_by(continent, year) |> 
  summarise(mean_life_exp = mean(lifeExp)) |> 
  ggplot(aes(x = year, y = mean_life_exp, color = continent, group = continent)) + geom_line()
















gapminder |> 
  ggplot(aes(x = year, y = lifeExp, fill = continent)) + geom_bar(stat = "identity")
