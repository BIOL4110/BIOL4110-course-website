### in class notes October 1

library(tidyverse)
library(gapminder)

gapminder2 <- gapminder

class(gapminder)
str(gapminder)



gap_country <- gapminder |> 
  select(starts_with("co"), everything())

gapminder |> 
  dplyr::select(country) |> View()


no_africa <- gapminder |> 
  filter(continent != "Africa") |> 
  droplevels()

levels(no_africa$continent)

gapminder |> 
  filter(continent != "Africa", year == 2007) 


gapminder |> 
  mutate(country_total_gdp = pop*gdpPercap) |>
  select(contains("total"), everything()) |> View()


#Write a single command (which can span multiple lines and includes pipes) that will produce a data frame that has the African values for lifeExp, country and year, but not for other Continents. How many rows does your data frame have and why? How else could you check that this worked properly?

challenge_1 <- gapminder |> 
  filter(continent == "Africa") |> 
  select(continent, lifeExp, year)

str(challenge_1)
dim(challenge_1)


# Now, repeat the exercise above, but include values for lifeExp, country, and year for both Africa and Oceania, but not the other continents. How many rows does this data frame have and why?

challenge_2 <- gapminder |> 
  filter(continent == "Africa" | continent == "Oceania") |> 
  select(lifeExp, country, year)

selected_countries <- c("Africa", "Oceania")
str(selected_countries)

challenge2b <- gapminder |> 
  filter(continent %in% c("Africa", "Oceania"))

challenge2b <- gapminder |> 
  filter(continent %in% selected_countries)

gapminder |> 
  group_by(continent) |> 
  summarise(lowest_life_exp = min(lifeExp))



oceania <- gapminder |> 
  filter(continent == "Oceania") |> 
  droplevels()

levels(oceania$country)

dim(challenge_2)
