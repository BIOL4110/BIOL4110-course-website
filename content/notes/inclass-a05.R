


#### Introduction to dplyr

library(tidyverse)
library(gapminder)


gapminder


class(gapminder)

## filter() takes logical expressions and returns the rows for which all are TRUE
filter(gapminder, lifeExp < 30)


# filter(gapminder, country == "Rwanda", year > 1979)
# filter(gapminder, country %in% c("Rwanda", "Afghanistan"))

# excerpt <- gapminder[241:252, ] ## why is this bad?
# It is not self-documenting. What is so special about rows 241 through 252?
# It is fragile. This line of code will produce different results if someone changes the row order of gapminder, e.g. sorts the data earlier in the script.


filter(gapminder, country == "Canada") ## this is better

## let's meet the pipe!
gapminder %>% head()

## This is equivalent to head(gapminder). The pipe operator takes the thing on the left-hand-side and pipes it into the function call on the right-hand-side – literally,
## drops it in as the first argument.

# select(gapminder, year, lifeExp)

## And here’s the same operation, but written with the pipe operator and piped through head()

# gapminder %>%
#   select(year, lifeExp) %>%
#   head(4)


# gapminder %>%
#   filter(country == "Cambodia") %>%
#   select(year, lifeExp)



# # gapminder %>%
# arrange(year, country)

# my_gap %>%
#   filter(year == 2007) %>%
#   arrange(lifeExp)


# my_gap %>%
#   filter(year == 2007) %>%
#   arrange(desc(lifeExp))


# my_gap %>%
#   rename(life_exp = lifeExp,
#          gdp_percap = gdpPercap,
#          gdp_percap_rel = gdpPercapRel)


# You’ve seen simple use of select(). There are two tricks you might enjoy:
#   
#   select() can rename the variables you request to keep.
# select() can be used with everything() to hoist a variable up to the front of the tibble.


# my_gap %>%
#   filter(country == "Burundi", year > 1996) %>% 
#   select(yr = year, lifeExp, gdpPercap) %>% 
#   select(gdpPercap, everything())



# group_by() adds extra structure to your dataset – grouping information – which lays the groundwork for computations within the groups.
# summarize() takes a dataset with n observations, computes requested summaries, and returns a dataset with 1 observation.
# 
# mutate() and summarize() will honor groups.