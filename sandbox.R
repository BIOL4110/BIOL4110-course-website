

install.packages("gradethis")
remotes::install_github("rstudio/gradethis")


library(gradethis)
library(testthat)


my_life_university <- (2020 - 2016) / (2020 - 1998) * 100



grade_this( {
  expect_gte(my_life_university, 0)
          expect_lte(my_life_university, 100)
  })




grade_this({
  if (identical(.result, mean(1:10))) {
    pass("Great work! You calculated the average of the first ten integers.")
  }
  fail()
})
