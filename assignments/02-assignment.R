### --- Assignment 1 --- ###

# Load the tidyverse packages
library("tidyverse")

# Read in the data from the class site
data_ai <- readr::read_csv("https://alopilato88.github.io/quantitative-analysis-1/assignments/02-assignment-data.csv")

# View our data frame 
View(data_ai)

# 1. What is the sample size of your dataset (hint: It's the number of rows)? 

# 2. How many variables are in your dataset (hint: It's the number of columns)? 

# 3a. Use the functions summarize (from dplyr), mean, and sd to calculate means and sds for perceived_ease_use and perceived_useful. (Some of the code has been started.)

data_ai |>
summarize(
  mean_perceived_ease_use = mean(perceived_ease_use),
  sd_perceived_ease_use = sd(perceived_ease_use)
)

# 3b. Describe what the |> operator is doing in the code above.

# 4a. Estimate a multiple regression model that uses perceived_useful and perceived_ease_use to predict behavioral_intention. Save the model in an object named: model_1

model_1 <- lm(behavioral_intention ~ perceived_useful_stand + perceived_ease_use, data = data_ai)

# 4b. Use the summary function to print out the results of your model and write out: 

## 4b1: What is the null hypothesis being tested for both perceived_useful & perceived_ease_use? 

## 4b2: Can you reject the null hypothesis? If yes, why? If no, why? 

# 4c. Calculate the confidence intervals for all three regression coefficients (intercept and two slopes) in model_1.

confint(model_1)

# 4d. What information does the confidence interval for perceived_useful give you? 

# 5. Finish the code below to create standardized variables for perceived_ease_use and behavioral_intention. 
#    Name the standardized variables: perceived_ease_use_stand and behavioral_intention_stand.

data_ai <- 
  data_ai |>
  mutate(
    perceived_useful_stand = (perceived_useful - mean(perceived_useful)) / sd(perceived_useful),
  )

# 6a. Estimate a multiple regression model that uses perceived_useful_stand and perceived_ease_use_stand to predict behavioral_intention_stand. 
#     Save the model in an object named: model_2

# 6b. Use the summary function to print out the results of your model and write out: 

## 6b1: Do your conclusions about the significance of perceived_useful and perceived_ease_use change compared to the conclusions you made from model_1? 

## 6b2: Are the t values in model_2 for the regression coefficients (intercept and slopes) different from model_1? If so, which ones are different?

## 6b3: Is the model_2 multiple R-squared value different than the model_1 multiple R-squared value? 

# 7a. Use the summarize function to calculate means for behavioral_intention when previous_exp = Yes and previous_exp = No: 

data_ai |>
  group_by(
    previous_exp
  ) |>
  summarize(
    mean_behavioral_intention = mean(behavioral_intention)
  )

# 7b. Add-on to code above to calculate both the mean and sd for behavioral_intention when previous_exp = Yes and previous_exp = No:

# 7c. Do the group means look different from one another? 

# 8. Finish the function below to create an indicator variable from previous_exp:

data_ai <-
  data_ai |>
  dplyr::mutate(
    previous_exp_ind = if_else(previous_exp == "no", 1, )
  )

# 9a. Estimate a simple regression model using previous_exp_ind to predict behavioral_intention. Call it model_3.

model_3 <- lm(behavioral_intention ~ previous_exp_ind, data = data_ai)

# 9b. Interpret the regression coefficient for previous_exp_ind. What is it telling you? 

# 9c. What null hypothesis is being tested by previous_exp_ind? Can we reject the null hypothesis? Why or why not?

# 10. Estimate a simple regression model using previous_exp (NOT previous_exp_ind) to predict behavioral_intention. Call it model_4.
#     Is anything different about model_4 compared to model_3? (Hint: Is the reference category for previous_exp different from previous_exp_ind?)

# Bonus: 

# Create two new R objects: 
#   behavioral_intention_exp_yes, which contains only behavioral_intention responses for the group where previous_exp == "yes"
#   behavioral_intention_exp_no, which contains only the behavioral_intention responses for the group where previous_exo == "no".
#
# Estimate a t-test to test if the means of the new objects are different. Some of the code is started below:

behavioral_intention_exp_yes <- data_ai$behavioral_intention[data_ai$previous_exp == "yes"]
behavioral_intention_exp_no <- # Finish this line of code

# Finish this line of code. Hint: What variable is it missing? 
t_test_result <- t.test(behavioral_intention_exp_yes, , var.equal = TRUE)

# Compare the results of the t-test to those from model_4. Are the t-values and degrees of freedom different? How about the p-value? 




