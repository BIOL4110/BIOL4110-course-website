

library(tidyverse)
library(gapminder)
library(gsheet)

#First tibble

df1 <- tibble(ID = 1:3,
              Name = c("Sophie", "Josh", "Alex"))

df2 <- tibble(ID = 2:4,
              Age = c(20, 50, 31))

df1
df2


new_df <- left_join(df1, df2, by  = "ID")
new_df

new_df2 <- right_join(df1, df2, by = "ID")
new_df2

new_df3 <- left_join(df2, df1, by = "ID")


identical(new_df2, new_df3)

thing4 <- inner_join(df1, df2, by = "ID")
thing4


thing5 <- full_join(df1, df2, by = "ID")
thing5

thing6 <- semi_join(df1, df2, by = "ID")
thing6

thing7 <- anti_join(df1, df2, by = "ID")

thing8 <- bind_rows(df1, df2)

thing8

df1

thing9 <- bind_cols(df1, df2)
thing9

df3 <- tibble(ID = 1:5, Height = c(175, 176, 190, 155, 160))

df3

thing10 <- full_join(df1, df2, by = "ID") %>%
  full_join(df3, by = "ID")

thing10


full_join(df1, df2, df3, by = "ID")


df4 <- tibble(FirstName = c("Sophie", "Josh", "Alex"),
                          LastName = c("Wang", "Smith", "Smith"),
                            Age = c(42, 20, 50))
df4

df5 <- tibble(First_name = c("Josh","Alex","Sophie"),        
              Last_name=c("Smith","Smith","Jones"),
              Height = c(167,190,155))

df5

thing11 <- full_join(df4, df5, by = c("FirstName" = "First_name", "LastName" = "Last_name"))
thing11

thing12 <- full_join(df4, df5, by = c("LastName" = "Last_name"))
thing12

# First tibble
df6 <- tibble(Number = 1:3,                     
              Letter = c("A", "B","C"))


df6
# Second tibble
df7 <- tibble(Number = 2:4,                      
              Letter = c("B","C","D"))

df7


intersect(df6, df7)


union(df6, df7)


setdiff(df6$Number, df7$Number)

set.seed(1)
x <- rnorm(5)
model1 <- tibble(x = x, yhat = 2.1 + 3.2 * x)
model2 <- tibble(x = x, yhat = 1.5 + 2.9 * x)

model1
model2


left_join(model1, model2, by = "x")


