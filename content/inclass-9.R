

### In class notes, class 9

library(tidyverse)
library(tidymodels)
library(gapminder)
library(broom)


my_lm <- lm(mpg ~ wt, data = mtcars)
class(my_lm)
str(my_lm)

my_lm
summary(my_lm)



(my_lm <- lm(mpg ~ wt, data = mtcars))
my_lm



tidy(my_lm)



tidy(my_lm)


augment(my_lm) %>% 
  print(n = 5)



augment(my_lm) %>% 
  print(n = 5)

augment(my_lm, newdata = tibble(wt = 3:5)) 
?augment()

df2 <- augment(my_lm, newdata = tibble(wt = 1:6), se_fit = TRUE)


df2 %>% 
  ggplot(aes(x = wt, y = .fitted)) + geom_line() +
  geom_point(aes(x = wt, y = mpg), data = mtcars, color = "red")



mtcars %>% 
  ggplot(aes(x = wt, y = mpg)) + geom_point() +
  geom_smooth(method = "lm", color = "orange") +
  geom_line(aes(x = wt, y = .fitted), data = df2, color = "pink")




names(my_lm)
my_lm$coefficients



?geom_smooth()
glance(my_lm)

?augment



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
