

### dates and times in R

library(tidyverse)
library(nycflights13)
library(lubridate)

d3 <- "Oct 1 2013"
str(d3)


d1 <- mdy("Oct 1 2013")
str(d1)

d2 <- mdy("October 1st 2013")

d2 <- ymd("2024-11-05")
str(d2)
str(d2)



today()
now()

flights_demo <- flights %>% 
  select(year, month, day, hour, minute, flight, carrier)

head(flights_demo)



ymd_hms("2017-01-31 20:11:59")




new_sched_dep_time <- mdy_hm("Oct 1 2013 9:00", tz = "America/New_York")
(new_sched_dep_time <- mdy_hm("Oct 1 2013 9:00", tz = "America/New_York"))


### create a new mini tibble with the same column names as flights_demo



new_flight <- tribble( ~year, ~month, ~day, ~hour, ~minute, ~flight, ~carrier,
                       year(new_sched_dep_time), month(new_sched_dep_time),
                       day(new_sched_dep_time), hour(new_sched_dep_time), minute(new_sched_dep_time), 123, "AC")

(new_flight <- tribble(~year, ~month, ~day, ~hour, ~minute, ~flight, ~carrier, 
                       year(new_sched_dep_time), month(new_sched_dep_time), 
                       day(new_sched_dep_time), hour(new_sched_dep_time), 
                       minute(new_sched_dep_time), 123, "AC"))
str(new_flight)

flights_demo <- bind_rows(flights_demo, new_flight)

sched_dep_time <- ymd_hm("2013 October 1 9:00", tz = "America/New_York")
new_dep_time <- ymd_hm("2013 October 1 9:15", tz = "America/New_York")

thing <- new_dep_time - sched_dep_time
thing
str(thing)

new_thing <- as.duration(new_dep_time - sched_dep_time)
str(new_thing)

new_thing/dminutes(1)



?dminutes


new_sched_dep_time <- ymd_hm("2013 October 1 9:00", tz = "America/New_York")
new_dep_time <- ymd_hm("2013 Oct 1 9:15", tz = "America/New_York")
str(new_dep_time)

new_dep_time - 



 "2013 Oct 1 9:15" - "2013 October 1 9:00"


flights_demo2 <- flights %>% 
  select(year, month, day, dep_time, sched_dep_time, dep_delay)

str(flights_demo2)

head(flights_demo2)






new_sched_dep_time <- ymd_hm("2013 October 1 9:00", tz = "America/New_York")
new_dep_time <- ymd_hm("2013 Oct 1 9:15", tz = "America/New_York")

thing <- new_dep_time - new_sched_dep_time 

(duration_delay <- as.duration(new_dep_time - new_sched_dep_time))

str(duration_delay)


duration_delay/dminutes(1)



library(gapminder)
library(tidyverse)
library(forcats)
library(palmerpenguins)

penguins %>% 
  pull(species) %>% 
  levels()


flights %>% 
  select(time_hour, everything()) %>% View


penguins %>% 
  ggplot(aes(x = species)) + geom_bar()


penguins %>% 
  mutate(species = fct_infreq(species)) %>% 
  ggplot(aes(x = species)) + geom_bar()



penguins %>% 
  mutate(species = fct_infreq(species)) %>% 
  ggplot(aes(x = fct_infreq(species))) + geom_bar()


gapminder %>% 
  filter(continent == "Asia",
         year == 2007) %>% 
  ggplot(aes(x = country, y = gdpPercap)) + geom_point() +
  coord_flip() +
  scale_y_continuous(labels = scales::dollar_format()) +
  ylab("GDP per capita")





library(gapminder)
str(gapminder)



gapminder %>% 
  filter(continent == "Asia",
         year == 2007) %>% 
  # mutate(country = fct_reorder(country, gdpPercap)) %>% 
  ggplot(aes(x = fct_reorder(country, gdpPercap), y = gdpPercap)) + geom_point() +
  coord_flip()



gapminder %>% 
  filter(continent == "Asia",
         year == 2007) %>% 
  mutate(country = fct_reorder(country, gdpPercap)) %>% 
  ggplot(aes(x = country, y = gdpPercap)) + geom_point() +
  coord_flip() +
  scale_y_continuous(labels = scales::dollar_format()) +
  ylab("GDP per capita")


gapminder %>% 
  mutate(highlight = fct_other(country, keep = c("Canada", "India"))) %>%
  ggplot(aes(x = continent, y = gdpPercap)) + geom_boxplot() +
  scale_y_log10() + geom_jitter(aes(colour = highlight,
                                    alpha = highlight), width = 0.25) +
  scale_alpha_manual("", values = c(1, 1, 0.1)) + scale_colour_discrete("")

gapminder %>% 
  mutate(highlight = fct_other(country, keep = c("Canada", "India")),
         continent = fct_reorder(continent, gdpPercap)) %>% 
  ggplot(aes(x = continent, y = gdpPercap)) + geom_boxplot(outlier.shape = NA) +
  scale_y_log10() +
  geom_jitter(aes(colour = highlight,
                  alpha = highlight), width = 0.25) +
  scale_alpha_manual("", values = c(1, 1, 0.1)) +
  scale_colour_discrete("")


### back to penguins

penguins %>% 
  mutate(species = species %>% 
           fct_recode("Adélie" = "Adelie") %>% 
           fct_expand("Emperor", "King")) %>% 
  ggplot(aes(x = species)) + geom_bar() +
  scale_x_discrete( drop = FALSE)

