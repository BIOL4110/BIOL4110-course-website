

### In class notes, class 9

library(tidyverse)
library(tidymodels)
library(gapminder)
library(broom)



(my_lm <- lm(mpg ~ wt, data = mtcars))
my_lm


tidy(my_lm)



augment(my_lm) %>% 
  print(n = 5)


?augment()

augment(my_lm, newdata = tibble(wt = 3:5))


glance(my_lm)



predict(my_lm) %>% 
  unname() %>% 
  head(5)


?unname()

predict(my_lm, newdata = tibble(wt = 3:5)) %>% 
  unname()


coef(my_lm)


names(my_lm)


summary(my_lm)
names(summary(my_lm))


summary(my_lm)$adj.r.squared


ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm") 



gapminder_Zimbabwe <- gapminder %>% 
  filter(country == "Zimbabwe")

gapminder_Zimbabwe %>% 
  ggplot(aes(x = year, y = lifeExp)) + 
  geom_point()


ggplot(gapminder_Zimbabwe, aes(year,lifeExp)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)


ggplot(gapminder_Zimbabwe, aes(year,lifeExp)) +
  geom_point() +
  geom_smooth(method = "lm",
              formula = y ~ poly(x,2), 
              se = F)


?poly
