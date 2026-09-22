

###

library(palmerpenguins)
library(readr)
library(readxl)
library(tidyverse)
library(here)
library(gapminder)





our_penguins <- penguins
write_csv(our_penguins, "data-processed/our_penguins.csv")


our_penguins2 <- read_csv("data-processed/our_penguins.csv")


our_penguins3 <- read_delim("data-processed/our_penguins.csv", delim =",")


here()
here("data-processed", "our_penguins.csv")

thing2 <- read_csv(here("data-processed", "our_penguins.csv"))



penguins <- penguins

write_csv(penguins, "data/penguins.csv")


read_csv("penguins.csv")

thing <- read_delim("penguins.csv", delim = ",")


our_penguins %>% 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) + geom_point() +
  geom_smooth(method = "lm")


my_model <- lm(body_mass_g ~ flipper_length_mm, data = our_penguins)
my_model
class(my_model)
saveRDS(my_model, file = "output/mymodel.rds")

saveRDS(my_model, file = here("output", "mymodel.rds"))


read.csv("penguins.csv")


here()


here("data", "penguins.csv")

read_csv(here("data", "penguins.csv"))


### read excel


## rbinary


my_model <- lm(body_mass_g ~ flipper_length_mm, data = penguins)


saveRDS(my_model, file = here("output", "mymodel.rds"))


my_model_again <- readRDS(here("output", "mymodel.rds"))

library(fs)
(gap_tsv <- path_package("gapminder", "extdata", "gapminder.tsv"))


library(gapminder)

gapminder_life_exp <- gapminder %>% 
  group_by(country, continent) %>% 
  summarize(max_life_exp = max(lifeExp)) %>%
  ungroup() 

levels(gapminder_life_exp$country)


gap_life_exp_reorder <- gapminder_life_exp %>% 
  mutate(country = fct_reorder(country, max_life_exp))


gap_life_exp_reorder <- gap_life_exp %>% 
  mutate(country = fct_reorder(country, life_exp))



write_csv(gap_life_exp_reorder, "data-processed/gap2.csv")
saveRDS(gap_life_exp_reorder, "data-processed/gap2.rds")

gap3 <- readRDS("data-processed/gap2.rds")

head(levels(gap3$country))


gap_life_exp <- readRDS("gap_life_exp.rds")






# gap3 <- read_csv("data-processed/gap2.csv", stringsAsfactors = TRUE)
gap3 <- read_csv("data-processed/gap2.csv", col_types = cols(col_factor(), col_factor(), col_integer()))

head(levels(gap3$country))
str(gap3)

head(levels(gap_life_exp_reorder$country))

?read_csv()



?fct_reorder






head(gapminder_life_exp)

View(gapminder_life_exp)


gap_life_exp <- gapminder %>%
  group_by(country, continent) %>% 
  summarise(life_exp = max(lifeExp)) %>% 
  ungroup()


gap_life_exp


gap_life_exp <- gap_life_exp %>% 
  mutate(country = fct_reorder(country, life_exp))



head(levels(gap_life_exp$country))
head(gap_life_exp)

View(gap_life_exp)


saveRDS(gap_life_exp, "gap_life_exp.rds")


rm(gap_life_exp)
gap_life_exp
#> Error in eval(expr, envir, enclos): object 'gap_life_exp' not found
gap_life_exp <- readRDS("gap_life_exp.rds")
gap_life_exp


levels(gap_life_exp$country)
