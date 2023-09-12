
# Load packages -----------------------------------------------------------

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

# Read data from site -----------------------------------------------------

data_ai <- readr::read_csv("https://alopilato88.github.io/quantitative-analysis-1/data/03-lecture-data.csv")

# Exploring Simple & Multiple Reg. ----------------------------------------

model_1 <- lm(freq_use_ai ~ tech_anx, data = data_ai)
model_2 <- lm(freq_use_ai ~ beh_intent_ai, data = data_ai)
model_3 <- lm(freq_use_ai ~ tech_anx + beh_intent_ai, data = data_ai)

# Creating Predicted Scores & Error ---------------------------------------

data_pred <- 
  data_ai |> 
  dplyr::select(
    employee_id,
    tech_anx,
    beh_intent_ai,
    freq_use_ai
  ) |>
  dplyr::mutate(
    predicted_freq_use_ai = predict(model_3),
    error = freq_use_ai - predicted_freq_use_ai,
    predicted_freq_use_ai = round(predicted_freq_use_ai, 2),
    error = round(error, 2)
  )

# The Multiple Correlation Coefficient ------------------------------------

data_ai_pred <-
  data_ai |>
  dplyr::mutate(
    pred_y = predict(model_3)
  )

# Calculate correlation between observed and predicted scores
data_ai_pred |>
  dplyr::select(
    freq_use_ai,
    pred_y
  )

# The effects of rescaling variables --------------------------------------

data_ai <- 
  data_ai |>
  dplyr::mutate(
    tech_anx_rescale = (1/100) * (tech_anx - 1)
  )

model_4 <- lm(freq_use_ai ~ tech_anx_rescale + beh_intent_ai, data = data_ai)

data_ai |> dplyr::select(tech_anx, tech_anx_rescale) |> dplyr::distinct() |> 
  dplyr::arrange(tech_anx)

# Standardizing Variables -------------------------------------------------

data_ai <- 
  data_ai |>
  dplyr::mutate(
    tech_anx_scale = (tech_anx - mean(tech_anx)) / sd(tech_anx),
    beh_intent_ai_scale = (beh_intent_ai - mean(beh_intent_ai)) / sd(beh_intent_ai),
    freq_use_ai_scale = (freq_use_ai - mean(freq_use_ai)) / sd(freq_use_ai)
  )

model_scale <- lm(freq_use_ai_scale ~ tech_anx_scale + beh_intent_ai_scale, data_ai)


# Estimating Semipartial Correlation --------------------------------------

sp_cor_mat <-
  data_ai |>
  dplyr::select(
    freq_use_ai,
    tech_anx,
    beh_intent_ai
  ) |>
  ppcor::spcor()

sp_cor_mat <- sp_cor_mat$estimate^2 |> round(3)
r2 <- round(summary(model_3)$r.squared, 2)

sp_ai_table <- 
  tibble::tibble(
    Metric = c("Overall R-Squared", "Semipartial r-squared: Behvioral Intent.", "Semipartial r-squared: Tech. Anx."),
    Value = c(round(summary(model_3)$r.squared, 2), sp_cor_mat["freq_use_ai", "beh_intent_ai"], sp_cor_mat["freq_use_ai", "tech_anx"])
  ) |>
  dplyr::mutate(
    `R-Squared % Change` = 100*round((r2 - (r2 - Value))/(r2 - Value), 2)
  )

sp_ai_table[1, "R-Squared % Change"] <- 0
