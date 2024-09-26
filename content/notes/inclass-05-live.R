


library(tidyverse)
library(gapminder)


gap <- gapminder

gap
class(gap)
dim(gap)
names(gap)


head(gap)
tail(gap)


gap %>% 
  filter(lifeExp < 29, country %in% c("Rwanda", "Afghanistan")) %>% 
  select(year:pop) %>% View


names(gap)


gap2 <- gap %>% 
  rename(life_exp = lifeExp,
         gpd_percap = gdpPercap) %>%
  mutate(country_gdp = pop*gpd_percap) %>% 
  select(country_gdp, everything())



gap %>% 
  group_by(continent, country) %>% 
  summarize(min_life_exp = min(lifeExp),
            max_life_exp = max(lifeExp),
            mean_life_exp = mean(lifeExp)) %>% View()


gap %>% 
  group_by(country) %>% 
arrange(year) %>% 
mutate(rel_growth = last(pop) - first(pop)) %>% View
  

?first()




  







