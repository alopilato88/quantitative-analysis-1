### --- Assignment 1 --- ###

# Install and load R packages
install.packages("tidyverse")

# Load required R packages
library(tibble)
library(readr)

# Read in the data from the class site
data_ai <- read_csv("https://alopilato88.github.io/quantitative-analysis-1/assignments/01-assignment-data.csv")

# View our data frame 
View(data_ai)

# 1. What is the sample size of your dataset (hint: It's the number of rows)? 

nrow(data_ai)

# 2. How many variables are in your dataset (hint: It's the number of columns)? 

ncol(data_ai)

# 3. What is the mean and standard deviation of perceived_ease_use?

mean(data_ai$perceived_ease_use) # mean() is a function that calculates the mean of a random variable.
sd(data_ai$perceived_ease_use) # sd() is a function that calculates the standard deviation of a random variable.

# 4. What is the mean and standard deviation for perceived_useful?

# 5. What is the mean and standard deviation for behavioral_intention?

# 6a. What is the correlation between perceived_useful and perceived_ease_of_use? 

# cor() is a function that calculates the correlation between two random variables
# The cor() function requires two arguments: an x variable and a y variable.
# Below we tell R the x variable = data$perceived_useful and y variable = data_ai$perceived_ease_use.
# You can read the $ operator as go into the data frame: data_ai and select the variable to the right of the $ sign.
# data_ai$perceived_useful means go into data_ai and select the column perceived_useful

cor(x = data_ai$perceived_useful, y = data_ai$perceived_ease_use) 

# 6b. In your own words, write out an interpretation of the correlation you calculated in 6a. 

# 7a. What is the correlation between perceived_useful and behavioral_intention? 

# 7b. In your own words, write out an interpretation of the correlation you calculated in 7a. 

# 8a. What is the correlation between perceived_ease_use and behavioral_intention? 

# 8b. In your own words, write out an interpretation of the correlation you calculated in 8a. 

# 9a. Estimate a simple regression model that uses perceived_ease_use to predict behavioral_intention.

# The lm() function used below fits a linear regression model. The lm() code translated to the following
# regression model: behvioral_intention = B0 + B1*perceived_ease_use. 
# In general the structure of the lm() function will look like lm(outcome_variable ~ predictor_variable, data = your_data)
# In R, everyhing to the left of the ~ sign is an outcome variable and everything to the right is a predictor variable.

model_1 <- lm(behavioral_intention ~ perceived_ease_use, data = data_ai)

# 9b. Print out the results of your regression model and write out an interpretation of the effect of perceived_ease_use on
#     behavioral_intentions.

summary(model_1)

# 9c. What is the R-squared value for model_1? Write out an interpretation of the R-squared.

# 10a. Estimate a simple regression model that uses perceived_useful to predict behavioral_intention. Name the model: model_2.

# 10b. Print out the results of your regression model and write out an interpretation of the effect of perceived_useful on
#     behavioral_intentions.

# 10c. What is the R-squared value for model_2? Write out an interpretation of the R-squared.

# 11a. Estimate a multiple regression model that uses perceived_useful and perceived_ease_use to predict behavioral_intention.

model_3 <- lm(behavioral_intention ~ perceived_ease_use + perceived_useful, data = data_ai)

# 11b. Print out the results of your multiple regression model and write out an interpretation of both partial regression 
#      coefficients.

# 11c. What is the R-squared value for model_3? Write out an interpretation of the R-squared.

