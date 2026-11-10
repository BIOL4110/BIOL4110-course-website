library(tidyverse)
library(broom)

mtcars
View(mtcars)


library(tidyverse)
library(broom)


View(mtcars)

mtcars |> 
  ggplot(aes(x = wt, y = mpg)) + geom_point() +
  geom_smooth(method = "lm")

fit <- lm(mpg ~ wt, data = mtcars)

class(fit)
str(fit)

tidy_output <- tidy(fit, conf.int = "TRUE")

View(tidy_output)

predictions <- augment(fit)

View(predictions)


mtcars |> 
  ggplot(aes(x = wt, y = mpg)) + geom_point()+
  # geom_smooth(method = "lm") +
  geom_line(aes(x = wt, y = .fitted), data = predictions, color = "green")

glance(fit)




library(palmerpenguins)
penguins

fit_penguins <- lm(bill_depth_mm ~ bill_length_mm, data = penguins)

tidy(fit_penguins)
glance(fit_penguins)

penguins |> 
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) + geom_point()+ geom_smooth(method = "lm")










fit <- lm(mpg ~ wt, data = mtcars)
str(fit)
summary(fit)

summary(fit)

mtcars |> 
  ggplot(aes(x = wt, y = mpg)) + geom_point() +
  geom_smooth(method = "lm")

summary(fit)

tidy(fit, conf.int = TRUE) |> 
  View()

fitted <- augment(fit)
fitted <- augment(fit)

fitted |> 
  ggplot(aes(x = wt, y = mpg)) + geom_point() +
  geom_smooth(method = 'lm') +
  geom_line(aes(x = wt, y = .fitted), color = "green") 




glance(fit)


library(gapminder)

zimbabwe <- gapminder |> 
  filter(country == "Zimbabwe")

zimbabwe |> 
  ggplot(aes(x = year, y = lifeExp)) +geom_point() + geom_smooth(method = "lm")

zimbabwe |> 
  ggplot(aes(x = year, y = lifeExp)) +geom_point() + 
  geom_smooth(method = "lm",
              formula = y ~ poly(x,2), 
              se = T)

zimbabwe |> 
  ggplot(aes(x = year, y = lifeExp)) +geom_point() + geom_smooth()


library(palmerpenguins)
penguin_lm <- lm(body_mass_g ~ flipper_length_mm, data = penguins)


augment(penguin_lm) |>
  select(body_mass_g, flipper_length_mm, .fitted, .resid) |>
  print(n = 5) |> View()

augment(penguin_lm) |>
  ggplot(aes(x = .fitted, y = .resid)) +
  geom_point(na.rm = TRUE) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(x = "Fitted values", y = "Residuals") +
  theme_minimal()


ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(na.rm = TRUE) +
  geom_smooth(method = "lm", se = TRUE, na.rm = TRUE) +
  labs(
    x = "Flipper length (mm)",
    y = "Body mass (g)"
  ) +
  theme_minimal()

augment(penguin_lm, newdata = tibble(flipper_length_mm = c(180, 200, 220)))


mod2 <- lm(bill_length_mm ~ bill_depth_mm, data = penguins)

summary(mod2)

penguins |> 
  ggplot(aes(x = bill_depth_mm, y = bill_length_mm)) + geom_point() + geom_smooth(method = "lm")

augment(mod2, newdata = tibble(bill_depth_mm = c(14, 17, 20))) |> View()

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g, colour = species)) +
  geom_point(na.rm = TRUE) +
  geom_smooth(method = "lm", se = FALSE, na.rm = TRUE) +
  labs(
    x = "Flipper length (mm)",
    y = "Body mass (g)",
    colour = "Species"
  ) +
  theme_minimal()
