

### In class Sep 29 2026

library(tidyverse)
library(gapminder)

<- 

gapminder <- gapminder

class(gapminder)
str(gapminder)
dim(gapminder)




gapminder_rearranged <- gapminder |> 
  select(year, country, continent, everything()) 

gapminder_rearranged <- gapminder |> 
  select(starts_with("co"), everything()) 

unique(gapminder$year)


### pull out observations from the year 2007

gapminder |> 
  filter(year == 2007) |> View()

gapminder |> 
  filter(year == 2007, country == "Peru") |> View()

gapminder |> 
  filter(lifeExp < 50) |> View()


gapminder |> 
  mutate(total_gdp = pop*gdpPercap) |> View()


# Write a single command (which can span multiple lines and includes pipes) that will produce a data frame that has the African values for lifeExp, country and year, but not for other Continents. How many rows does your data frame have and why? How else could you check that this worked properly?


gapminder_africa <- gapminder |> 
  filter(continent == "Africa") |> 
  select(lifeExp, country, year) |> View()


gapminder_africa_oceania <- gapminder |> 
  filter(continent == "Africa" | continent == "Oceania") |> 
  select(lifeExp, country, year)
gapminder |> 
  filter(year != 2007) |> 
  select(lifeExp, country, year)

gapminder |> 
  filter(country == "Turkey") |> View()


### split-apply-combine

gapminder |> 
  group_by(continent, year) |> 
  summarise(shortest_life_exp = min(lifeExp)) |> View()


length(unique(gapminder$country))


View(gapminder_rearranged)

dim(gapminder_narrow)




