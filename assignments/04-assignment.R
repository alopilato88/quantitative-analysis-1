
# Setup 

library(tidyverse)
library(boot)
library(ggthemes)

data_ai <- readr::read_csv("https://alopilato88.github.io/quantitative-analysis-1/assignments/04-assignment-data.csv")


# Question 1

## Q1: Estimate a regression model that uses `behavioral_intention` and `positive_attitude_ai` 
## to predict `perceived_freq_use`. Intrepret the model results.
  

# Question 2

## Q2: Use the functions `hatvalues` and `rstudent` to calculate the hat-values and studentized residuals 
## from the model you estimated in Question 1. What is the largest hat-value and residual in your data?
  
## Create two separate plots: a plot for the residuals where the X-axis is the observation number and 
## the y-axis is the studentized residual and a plot for the hat-values where the 
## X-axis is the observation number and y-axis is the hat-value.**
  

# Question 3

## Q3: Use the function `cooks.distance` to calculate the Cook's distance values. 
## Plot the values. Can you identify any influentional observations?


# Question 4

## Q4: Use the `predict` function to calculate the predicted values from the model you 
## estimated in Quesiton 1, then plot the predicted values (X-axis) against the 
## studentized residuals (Y-axis) you calculated in Question 2. Do you see a pattern 
## or does the plot look more like a random cloud of points?


# Question 5

## Q5: Plot a histogram of the residuals from the model you estimated in Question 1. 
## Do the residuals look normally distributed?


# Question 6

## Q6: Use histograms to explore the distributions of `actual_usage` and `sales_last_month`. 
## What do you notice about the distributions of these variables?


# Question 7

## Q7: Estimate a regression model that uses `behavioral_intention` and `positive_attitude_ai` 
## to predict `actual_usage`. Intrepret the model results.


# Question 8

## Q8: Use the functions `hatvalues` and `rstudent` to calculate the hat-values and 
## studentized residuals from the model you estimated in Question 7. 
## What is the largest hat-value and residual in your data?

## Create two separate plots: a plot for the residuals where the X-axis is the observation number 
## and the y-axis is the studentized residual and a plot for the hat-values where 
## the X-axis is the observation number and y-axis is the hat-value.


## Question 9

## Q8: Use the function `cooks.distance` to calculate the Cook's distance values. 
## Plot the values. Can you identify any influentional observations?
  

# Question 10

## Q10: Use the `predict` function to calculate the predicted values from the model 
## you estimated in Question 7, then plot the predicted values (X-axis) against 
## the studentized residuals (Y-axis) you calculated in Question 8. 
## Do you see a pattern or does the plot look more like a random cloud of points?
  

# Question 11

## Q11: Plot a histogram of the residuals from the model you estimated in Question 7. 
## Do the residuals look normally distributed?
  

# Question 12

## Q12: Estimate the the indirect effect that `perceived_useful` has on 
## `actual_usage` through `behavioral_intention`.
  

# Question 13

## Q13: Estimate a regression model that uses `engagement`, `perceived_freq_use`, `actual_usage`, 
## `skill_level`, and `office_region` to predict `sales_last_month`. Interpret the model results.
  

# Question 14

## Q14: Use plots of residuals from the model you estimated in Question 13 to determine 
## if any of the linear regression assumptions are violated.


# Question 15

## Q15: From your residual plots, it should appear that the residuals suffer from 
## some extreme observations. To adjust for this, transform your dependent variable, 
## `sales_last_month`, into a new variable using the `log` function. 
## Name this new variable `log_sales_last_month`. Refit your regression model using 
## the new dependent variable.
  

# Question 16

## Q16: Use plots of residuals from the model you estimated in Question 15 to determine 
## if any of the linear regression assumptions are violated.


# Question 17

## Q17: From your residual plots, it should appear that there are some observations that 
## still are not explained well by the regression model. Try adding in some new interaction terms:
  
## 1. `engagement * skill_level` 
## 2. `actual_usage * skill_level`
## 3. `perceived_freq_use * skill_level`

## Remove the interaction if not all the component terms 
## (e.g. perceived_freq_use:skill_level_low & perceived_freq_use:skill_level_moderate) are 
## not significant. This will be your final model.
  
## Once you have estimated your final model, plot the residuals and decide if your residuals 
## indicate that your final model fits better than your previous models. Why or why not?
  

# Question 18

## Q18: Calculate the effects of `actual_usage` when `skill_level` is low, moderate, and high.**
  

# Question 19

## Q19: Write up the results of your final model. You will want to talk about what 
## varibles significantly predict `log_sales_last_month`, what variables interact with `skill_level` 
## and how that alters their effects, and the overall fit of the model.
  


