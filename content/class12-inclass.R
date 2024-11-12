

###

library(palmerpenguins)
library(readr)
library(readxl)
library(tidyverse)
library(here)


penguins <- penguins

write_csv(penguins, "data/penguins.csv")


read_csv("penguins.csv")

thing <- read_delim("penguins.csv", delim = ",")


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
