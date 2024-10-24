
### In class October 17


library(tidyverse)
library(fivethirtyeight)

drinks_tbl1 <- as_tibble(drinks) %>% 
  select(!total_litres_of_pure_alcohol)
head(drinks_tbl1)


library(bakeoff)

ratings_tbl1 <- ratings %>% 
  mutate(ep_id = row_number()) %>% 
  select(ep_id, viewers_7day, series, episode) 

head(ratings_tbl1)


series_labels <- ratings_tbl1 %>% 
  mutate(series=as.factor(series)) %>%
  group_by(series) %>% 
  summarize(y_position = median(viewers_7day) + 1,
            x_position = mean(ep_id))

# make the plot
ratings_tbl1 %>%
  mutate(series=as.factor(series)) %>% 
  ggplot(aes(x = ep_id, y = viewers_7day, fill = series)) +
  geom_col(alpha = .9) + 
  ggtitle("7-Day Viewership across Series 1-10") +
  geom_text(data = series_labels, aes(label = series,
                                      x = x_position, 
                                      y = y_position)) +
  theme_classic() +  
  scale_fill_manual(values = bakeoff_palette(), 
                    guide = "none") +
  xlab("Episode Number") + 
  ylab("7-Day Viewership (millions)")



ratings_tbl2 <- ratings_tbl1 %>% mutate(series=as.factor(series)) %>% 
  group_by(series) %>%
  filter(episode == 1 | episode == max(episode)) %>%
  ungroup() %>%
  mutate(episode = recode(episode, `1` = "first", .default = "last")) %>%
  pivot_wider(id_cols=series, names_from=episode, values_from=viewers_7day)


ratings_tbl2 %>% 
  mutate(pct_change = (last - first)/first) %>% 
  ggplot(aes(x = fct_rev(series), y=pct_change)) + 
  geom_col(fill = bakeoff::bakeoff_colors("baltic"), alpha = .5) + 
  labs(x = "Series", y = "% Increase in Viewers, First to Last Episode") +
  ggtitle("% Increase in Viewers from Premiere to Finale") + 
  scale_y_continuous(labels = scales::percent) +
  theme_classic() + 
  coord_flip() 



ratings_tbl1 <- ratings_tbl1 %>% 
  group_by(series) %>% 
  filter(episode == 1 | episode == max(episode)) %>%
  ungroup() %>% 
  mutate(episode_fl = recode(episode, `1` = "first", .default = "last"))

head(ratings_tbl1)


ratings_tbl2 <- ratings_tbl1 %>% 
  pivot_wider(id_cols = series, 
              names_from = episode_fl, 
              values_from = viewers_7day)

head(ratings_tbl2)


ratings_tbl1 %>% 
  pivot_wider(id_cols = series, 
              names_from=episode_fl, 
              values_from=c(viewers_7day, ep_id))

table4a


table4a %>% 
  pivot_longer(cols = c(`1999`, `2000`), 
                         names_to = "year", 
                         values_to = "cases")


?rename_with

who_demo <- who2 %>% 
  select(country, year, starts_with("sp")) %>% 
  rename_with(function(x) 
    str_remove(x, pattern="sp_"), 
    starts_with("sp")) %>% 
  filter(year %in% c(1999, 2000)) %>% 
  filter(country %in% c("Afghanistan", "Brazil", "China"))

head(who_demo)


who_demo2 <- who_demo %>% 
  pivot_longer(cols = !(country:year),
                          names_to = c("gender", "age"),
                          names_sep = "_",
                          values_to = "cases")


who_demo2 %>% 
  ggplot(aes(x = year, y = cases, color = gender)) + geom_point() + geom_path() +
  facet_wrap( ~ age)


head(household)


household %>%
  pivot_longer(cols = -family, 
                           names_to = c(".value", "child"), 
                           names_sep = "_")


household %>%
  pivot_longer(cols = -family, 
                           names_to = c(".value", "child"), 
                           names_sep = "_", 
                           values_drop_na = TRUE)


table3


table3b <- table3 %>% 
  separate(col = rate,
           into = c("cases", "population size"))




View(table3b)




(table5 <- table3 %>%
    separate(col = rate, 
    into = c("cases", "population")))


library(gapminder)


View(gapminder)


gapminder %>% 
  unite(c("country", "continent"), sep = "_", col = "country_continent_combo", remove = FALSE) %>% 
  head()


gapminder %>% 
  separate(col = year, into = c("century", "decade"), sep = -1) %>% View
