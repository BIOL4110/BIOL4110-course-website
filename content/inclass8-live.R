

library(fivethirtyeight)
library(tidyverse)


drinks_tbl1 <- as_tibble(drinks) %>% 
  select(!total_litres_of_pure_alcohol)


drinks_tbl2 <- drinks_tbl1 %>%
  pivot_longer(cols=ends_with("_servings"), names_to = "Alcohol",
               names_pattern = "(.*)_servings", values_to="Servings") %>% 
  mutate(Alcohol=str_to_title(Alcohol))


drinks_tbl2 %>% 
  ggplot(aes(x = Servings)) + geom_histogram() + 
  facet_wrap( ~ Alcohol)


library(bakeoff)

ratings_tbl1 <- ratings %>% 
  mutate(ep_id = row_number()) %>%
  select(ep_id, everything()) %>%
  select(ep_id, viewers_7day, series, episode)


head(ratings_tbl1)


series_labels <- ratings_tbl1 %>% 
  mutate(series = as.factor(series)) %>% 
  group_by(series) %>% 
  summarize(y_position = median(viewers_7day) + 1,
            x_position = mean(ep_id))

View(series_labels)


# make the plot

ratings_tbl1 %>% 
  mutate(series = as.factor(series)) %>% 
  ggplot(aes(x = ep_id, y = viewers_7day, fill = series)) +
  geom_col(alpha = 0.9) + 
  ggtitle("7-day viewership across series 1-10") +
  geom_text(data = series_labels, aes(label = series,
                                      x = x_position,
                                      y= y_position)) +
  theme_classic() +
  scale_fill_manual(values = bakeoff_palette(),
                    guide = "none") +
  xlab("Episode Number") + ylab("7 day viewership")



ratings_tbl1b <- ratings_tbl1 %>% 
  group_by(series) %>% 
  filter(episode == 1 | episode == max(episode)) %>% 
  ungroup() %>% 
  mutate(episode_fl = recode(episode, `1` = "first", .default = "last"))


View(ratings_tbl1b)


ratings_tbl2 <- ratings_tbl1b %>% 
  pivot_wider(id_cols = series,
             names_from = episode_fl,
             values_from = viewers_7day)

ratings_tbl1b %>% 
  pivot_wider(id_cols = series,
              names_from = episode_fl,
              values_from = c(viewers_7day, ep_id)) %>% View

View(ratings_tbl2)

ratings_tbl2 %>% 
  mutate(percent_change = (last-first) / first) %>% 
  mutate(series = as.factor(series)) %>% 
  ggplot(aes(x = fct_rev(series), y = percent_change)) + 
  geom_col(fill = bakeoff::bakeoff_colors("baltic"), alpha = .5) +
  labs(x = "Series", y = "% Increase in Viewers, First to Last Episode") +
  ggtitle("% Increase in Viewers from Premiere to Finale") + 
  scale_y_continuous(labels = scales::percent) +
  coord_flip() + theme_classic()



ratings_tbl2 <- ratings_tbl1 %>%
  mutate(series=as.factor(series)) %>% 
  group_by(series) %>% filter(episode == 1 | episode == max(episode)) %>%
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


table4a %>% 
  pivot_longer(cols = c(`1999`, `2000`),
               names_to = "year",
               values_to = "cases") %>% View
 






