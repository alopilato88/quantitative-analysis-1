# Script to generate practice data

# Helper function 

calc_se <- function(
  r2,
  var
) {
  total_var <- var(var) / r2
  error_var <- total_var - r2
  return(sqrt(error_var))
}

set.seed(57483)

n <- 500

# Generate exogenous variables --------------------------------------------

prob_ease_use <- dnorm(1:7, mean = 4, sd = 2) / sum(dnorm(1:7, mean = 4, sd = 2))
v1_ease_use <- sample(1:7, size = n, replace = TRUE, prob = prob_ease_use)
v2_prev_exp <- sample(0:1, size = n, replace = TRUE, prob = c(.75, .25))
v3_skill_level <- sample(c("low", "moderate", "high"), 
                         size = n, replace = TRUE,
                         prob = c(.25, .60, .15))
v3_skill_level_low <- dplyr::if_else(v3_skill_level == "low", 1, 0)
v3_skill_level_high <- dplyr::if_else(v3_skill_level == "high", 1, 0)
prob_engage <- dnorm(1:7, mean = 5, sd = 2) / sum(dnorm(1:7, mean = 5, sd = 2))
v4_engage <- sample(1:7, size = n, replace = TRUE, prob = prob_engage)

data <-
  tibble::tibble(
    v1_ease_use,
    v2_prev_exp,
    v3_skill_level,
    v3_skill_level_low,
    v3_skill_level_high,
    v4_engage
  )

# Generate endogenous variables -------------------------------------------

# Perceived usefulness
b_use_ease <- .35
v5_perc_useful <- b_use_ease * v1_ease_use 
v5_perc_useful <- v5_perc_useful + rnorm(n, mean = 0, sd = calc_se(r2 = .30, var = v5_perc_useful))

data <- 
  data|>
  dplyr::mutate(
    v5_perc_useful = dplyr::case_when(
      v5_perc_useful <= qnorm(.05, mean = mean(v5_perc_useful), sd = sd(v5_perc_useful)) ~ 1,
      v5_perc_useful <= qnorm(.15, mean = mean(v5_perc_useful), sd = sd(v5_perc_useful)) ~ 2,
      v5_perc_useful <= qnorm(.25, mean = mean(v5_perc_useful), sd = sd(v5_perc_useful)) ~ 3,
      v5_perc_useful <= qnorm(.40, mean = mean(v5_perc_useful), sd = sd(v5_perc_useful)) ~ 4,
      v5_perc_useful <= qnorm(.60, mean = mean(v5_perc_useful), sd = sd(v5_perc_useful)) ~ 5,
      v5_perc_useful <= qnorm(.80, mean = mean(v5_perc_useful), sd = sd(v5_perc_useful)) ~ 6,
      TRUE ~ 7
    )
  )

# Behavioral intentions
b_intent_useful <- .15
b_intent_ease <- .15
b_intent_useful_exp <- .40
b_intent_ease_exp <- .30

data <- 
  data |>
  dplyr::mutate(
    v1_ease_use_cent = v1_ease_use - mean(v1_ease_use),
    v5_perc_useful_cent = v5_perc_useful - mean(v5_perc_useful),
    v6_beh_intent = b_intent_useful * v5_perc_useful_cent + b_intent_ease * v1_ease_use_cent + 
      b_intent_useful_exp * v5_perc_useful_cent * v2_prev_exp + b_intent_ease_exp * v1_ease_use_cent * v2_prev_exp,
    v6_beh_intent = v6_beh_intent + rnorm(n, mean = 0, sd = calc_se(r2 = .30, var = v6_beh_intent)),
    v6_beh_intent = dplyr::case_when(
      v6_beh_intent <= qnorm(.05, mean = mean(v6_beh_intent), sd = sd(v6_beh_intent)) ~ 1,
      v6_beh_intent <= qnorm(.15, mean = mean(v6_beh_intent), sd = sd(v6_beh_intent)) ~ 2,
      v6_beh_intent <= qnorm(.25, mean = mean(v6_beh_intent), sd = sd(v6_beh_intent)) ~ 3,
      v6_beh_intent <= qnorm(.55, mean = mean(v6_beh_intent), sd = sd(v6_beh_intent)) ~ 4,
      v6_beh_intent <= qnorm(.80, mean = mean(v6_beh_intent), sd = sd(v6_beh_intent)) ~ 5,
      v6_beh_intent <= qnorm(.90, mean = mean(v6_beh_intent), sd = sd(v6_beh_intent)) ~ 6,
      TRUE ~ 7
    )
  )

# Use behaviors 
b_obs_use_intent <- .60

data <- 
  data |>
  dplyr::mutate(
    v7_obs_use = rpois(n, lambda = exp(-1 + b_obs_use_intent * v6_beh_intent - .70 * rnorm(n, mean = 0, sd = 1)))
  )

# Perceived use 
b_perc_use_intent <- .45
b_perc_use_obs_use <- .05

data <- 
  data |>
  dplyr::mutate(
    v8_freq_use = b_perc_use_intent * v6_beh_intent + b_perc_use_obs_use * v7_obs_use,
    v8_freq_use = v8_freq_use + rnorm(n, mean = 0, sd = calc_se(r2 = .60, var = v8_freq_use)),
    v8_freq_use = dplyr::case_when(
      v8_freq_use <= qnorm(.05, mean = mean(v8_freq_use), sd = sd(v8_freq_use)) ~ 1,
      v8_freq_use <= qnorm(.10, mean = mean(v8_freq_use), sd = sd(v8_freq_use)) ~ 2,
      v8_freq_use <= qnorm(.20, mean = mean(v8_freq_use), sd = sd(v8_freq_use)) ~ 3,
      v8_freq_use <= qnorm(.50, mean = mean(v8_freq_use), sd = sd(v8_freq_use)) ~ 4,
      v8_freq_use <= qnorm(.80, mean = mean(v8_freq_use), sd = sd(v8_freq_use)) ~ 5,
      TRUE ~ 6
    )
  )

# Sales
b_sales_obs_use <- .40
b_sales_obs_use_skill_low <- -.10
b_sales_obs_use_skill_high <- .30
b_sales_obs_use_engage <- .10

data <- 
  data |>
  dplyr::mutate(
    v4_engage_scale = (v4_engage - mean(v4_engage))/sd(v4_engage),
    v7_obs_use_scale = (v7_obs_use - mean(v7_obs_use))/sd(v7_obs_use),
    v9_sales = rlnorm(
      n = n,
      meanlog = 5.4 + b_sales_obs_use * v7_obs_use_scale + b_sales_obs_use_engage * v4_engage_scale * v7_obs_use_scale + 
        b_sales_obs_use_skill_low * v7_obs_use_scale * v3_skill_level_low + 
        b_sales_obs_use_skill_high * v7_obs_use_scale * v3_skill_level_high,
      sdlog = .60
    )
  )

data_final <- 
  data |>
  dplyr::select(
    perceived_ease_use = v1_ease_use, 
    previous_exp = v2_prev_exp,
    skill_level = v3_skill_level, 
    engagement = v4_engage,
    perceived_useful = v5_perc_useful,
    behavioral_intention = v6_beh_intent,
    actual_usage = v7_obs_use, 
    perceived_freq_use = v8_freq_use,
    sales_last_month = v9_sales
  ) |>
  dplyr::mutate(
    previous_exp = dplyr::if_else(previous_exp == 1, "yes", "no"),
    sales_last_month = round(sales_last_month, 2),
    skill_level = as.factor(skill_level),
    skill_level = relevel(skill_level, ref = "moderate")
  ) |>
  dplyr::mutate(
    employee_id = sample(100000:999999, size = n),
    positive_attitude_ai = sample(1:7, size = n, replace = TRUE, prob = dnorm(1:7, mean = 4.5, sd = 1.5)/sum(dnorm(1:7, mean = 4.5, sd = 1.5))),
    office_region = sample(c("north america", "asia", "europe"), size = n, replace = TRUE, prob = c(.75, .10, .15))
  ) |>
  dplyr::relocate(
    employee_id
  )
