

library(palmerpenguins)
library(gapminder)
library(tidyverse)




View(penguins)

dim(penguins)

penguins_long <- penguins |> 
  pivot_longer(cols = c("bill_depth_mm", "bill_length_mm", "body_mass_g", "flipper_length_mm"),
               names_to = "measurement_type",
               values_to = "value")

dim(penguins_long)




penguins_long <- penguins |> 
  pivot_longer(cols = c("bill_depth_mm", "bill_length_mm", "body_mass_g", "flipper_length_mm"),
             names_to = "measurement_type",
             values_to = "value")




penguins_long |> 
  ggplot(aes(x = species, y = value, fill = species)) + geom_boxplot(alpha = 0.7) +
  facet_wrap( ~ measurement_type, scales = "free") + xlab("Species") + ylab("Measurement value") + theme(legend.position = "none")



View(penguins_long)

unique(penguins_long$measurement_type)





penguins_long |> 
  ggplot(aes(x = species, y = value, fill = species, color = species)) + geom_boxplot() +
  facet_wrap(~ measurement_type, scales = "free")

library(gapminder)  


### only include north american countries, and years after but including 2002, only retain the lifeExp, country, year

north_america <- c("Canada", "United States", "Mexico")

gap_subset <- gapminder |> 
  filter(country %in% north_america,
         year >= 2002) |> 
  select(country, year, lifeExp)


gap_subset <- gapminder |> 
  filter(country %in% c("Canada", "United States", "Mexico"),
         year >= 2002) |> 
  select(country, year, lifeExp)
dim(gap_subset)



View(gap_subset)




gap_subset <- gapminder |> 
  filter(country %in% c("Canada", "Mexico", "United States")) |> 
  filter(year >= 2002) |> 
  select(country, year, lifeExp)

### make it wider, with separate columns for life expectancy in each country

life_exp_wider <- gap_subset |> 
  pivot_wider(names_from = country,
              values_from = lifeExp)


View(life_exp_wider)


gap_wide <- gap_subset |> 
  pivot_wider(names_from = country,
              values_from = lifeExp,
              names_glue = "{country}_{.value}")

View(gap_wide)




gap_wide <- gap_subset |> 
  pivot_wider(names_from = country,
              values_from = lifeExp
                  )

gap_wide |> 
  pivot_longer(cols = c("Canada", "Mexico", "United States"),
               names_to = "country",
               values_to = "lifeExp")


### graph life expectancy over time

gap_wide |> 
  ggplot(aes(x = year, y = lifeExp)) + geom_point()

gap_long <- gap_wide |> 
  pivot_longer(cols = c("Canada", "Mexico", "United States"),
               names_to = "country",
               values_to = "lifeExp")

View(gap_long)




View(gap_subset)

?pivot_wider()

length(unique(gap_subset$country))
