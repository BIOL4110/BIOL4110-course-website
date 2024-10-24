

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
