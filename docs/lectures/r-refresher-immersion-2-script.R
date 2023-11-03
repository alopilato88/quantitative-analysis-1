
# Load packages -----------------------------------------------------------

library(tidyverse)
library(peopleanalytics)

# Download Datasets -------------------------------------------------------

# Here is an example of how to access a dataset from the peopleanalytics package:

data_demographics <- peopleanalytics::demographics |>
  tibble::as_tibble()

# You can also find a lot of datasets in the R package datasets

data_mt_cars <- datasets::mtcars |>
  tibble::as_tibble()

# Find another dataset to explore in either the peopleanalytics or datasets packages.

# Exploratory Data Analysis -----------------------------------------------

# Look at the propotion of men and women in data_demographics

table(data_demographics$gender) |> 
  prop.table()

# Find the means and standard deviations of other variables in any of your datasets

mean(data_demographics$age)
sd(data_demographics$age)

data_demographics |>
  dplyr::group_by(
    ed_lvl
  ) |>
  dplyr::summarize(
    mean_age = mean(age)
  )

# Try correlating some variables together

cor(data_mt_cars[, c("mpg", "cyl", "hp")])

# Creating plots with base R ----------------------------------------------

# R has several built in plot functions that are OK. We will learn about a better 
# plotting package later today.

# We can use hist() to create a histogram

hist(data_mt_cars$mpg)

# Try looking at histograms of other variables 

# We can use plot() to create a scatter plot

plot(data_mt_cars$wt, data_mt_cars$mpg)

# Linear Regression -------------------------------------------------------

# Fit some regression models using your various datasets. Take a second to interpret the results.

mod_age <- lm(age ~ ed_field, data = data_demographics)

# We can create a new ed_field variable that is a factor and has its reference 
# level set to "Life Sciences".

data_demographics <- 
  data_demographics |>
  dplyr::mutate(
    ed_field_new = as.factor(ed_field),
    ed_field_new = relevel(ed_field_new, ref = "Life Sciences")
  )

mod_age_new <- lm(age ~ ed_field_new, data = data_demographics)

# Join together peopleanalyics data ---------------------------------------

data_benefits <- peopleanalytics::benefits |>
  tibble::as_tibble()

data_combine <- 
  data_demographics |>
  dplyr::left_join(
    data_benefits, 
    by = "employee_id"
  )

mod_trainings <- lm(trainings ~ ed_lvl, data_combine)
