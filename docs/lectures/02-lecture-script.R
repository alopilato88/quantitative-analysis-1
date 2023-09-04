
# Load packages -----------------------------------------------------------

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

# Read data from site -----------------------------------------------------

data_ai <- readr::read_csv("https://alopilato88.github.io/quantitative-analysis-1/data/intro_simple_reg_data.csv")

# Exploring Response Distributions ----------------------------------------

plot_explore_att <- 
  ggplot2::ggplot(
    data = data_ai |>
      dplyr::mutate(
        x_label = paste0(pos_attitude_ai, " - ", pos_attitude_ai_label)
      ) |>
      dplyr::summarize(
        count = dplyr::n(),
        .by = x_label
      ) |>
      dplyr::mutate(
        total = sum(count),
        prop = round(count / total, 2),
        per = 100 * prop
      ),
    ggplot2::aes(
      x = x_label,
      y = per
    )
  ) +
  geom_bar(
    stat = "identity"
  ) + 
  ggplot2::ylim(0, 40) +
  ggplot2::labs(
    x = "General Attitude Towards AI",
    y = "Response Percentage",
    title = "Response Distribution for General Attitude Towards AI"
  ) + 
  ggplot2::theme(
    axis.text.x = element_text(angle = 90)
  )

plot_explore_freq <- 
  ggplot2::ggplot(
    data = data_ai |>
      dplyr::mutate(
        y_label = paste0(freq_use_ai, " - ", freq_use_ai_label)
      ) |>
      dplyr::summarize(
        count = dplyr::n(),
        .by = y_label
      ) |>
      dplyr::mutate(
        total = sum(count),
        prop = round(count / total, 2),
        per = 100 * prop
      ),
    ggplot2::aes(
      x = y_label,
      y = per
    )
  ) +
  geom_bar(
    stat = "identity"
  ) + 
  ggplot2::ylim(0, 30) +
  ggplot2::labs(
    x = "Frequency of AI Tool Use",
    y = "Response Percentage",
    title = "Response Distribution for Frequency of AI Tool Use"
  ) + 
  ggplot2::theme(
    axis.text.x = element_text(angle = 90)
  )

# View plots
plot_explore_att
plot_explore_freq

# Creating the jittered scatter plot 
plot_scatter <- 
  ggplot2::ggplot(
    data = data_ai |>
      dplyr::mutate(
        scale_x = paste0(pos_attitude_ai, " - ", pos_attitude_ai_label)
      ),
    ggplot2::aes(
      x = as.factor(pos_attitude_ai),
      y = freq_use_ai
    )
  ) + 
  ggplot2::geom_jitter(
    width = .4,
    height = .6,
    alpha = .50
  ) +
  ggplot2::labs(
    x = "General AI Attitude",
    y = "Frequency of AI Tool Use"
  )

plot_scatter

# Plotting Conditional Distributions --------------------------------------

data_cond_dist <- 
  data_ai |>
  dplyr::summarize(
    count = dplyr::n(),
    .by = c(pos_attitude_ai, freq_use_ai)
  ) |>
  dplyr::group_by(
    pos_attitude_ai
  ) |>
  dplyr::mutate(
    total = sum(count),
    prop = count / total,
    prop = round(prop, 2),
    per = 100 * prop,
    x = factor(pos_attitude_ai, levels = c(1:7))
  )

ggplot2::ggplot(
  data = data_cond_dist |>
    dplyr::mutate(
      x_label = dplyr::case_when(
        x == 1 ~ "1 - Completely Disagree",
        x == 2 ~ "2 - Strongly Disagree",
        x == 3 ~ "3 - Disagree",
        x == 4 ~ "4 - Neutral",
        x == 5 ~ "5 - Agree",
        x == 6 ~ "6 - Strongly Agree",
        TRUE ~ "Completely Agree"
      )
    ),
  ggplot2::aes(
    x = as.factor(freq_use_ai),
    y = per
  )
) + 
  ggplot2::facet_wrap(x_label ~ .) +
  ggplot2::geom_bar(
    stat = "identity",
  ) +
  ggplot2::labs(
    x = "Frequency of AI Tool Use",
    y = "Response Percentage"
  )

# Visualizing Mean Dependence ---------------------------------------------

data_mean_plot <- 
  data_ai |>
  dplyr::summarize(
    y_mean = mean(freq_use_ai),
    .by = pos_attitude_ai
  )

plot_jitter_mean <- 
  ggplot2::ggplot(
    data = data_ai |>
      dplyr::mutate(
        x_label = paste0(pos_attitude_ai, " - ", pos_attitude_ai_label)
      ),
    ggplot2::aes(
      x = as.factor(x_label),
      y = freq_use_ai
    )
  ) + 
  ggplot2::geom_jitter(
    width = .4,
    height = .6,
    alpha = .50
  )  + 
  ggplot2::geom_point(
    data = data_mean_plot,
    ggplot2::aes(
      x = pos_attitude_ai, 
      y = y_mean
    ),
    size = 5
  ) +
  ggplot2::theme(
    axis.text.x = element_text(angle = 90)
  ) +
  ggplot2::labs(
    x = "Frequency of AI Tool Use",
    y = "Response Percentage"
  )

# Estimating the regression model -----------------------------------------

mod_ai <- lm(freq_use_ai ~ pos_attitude_ai, data = data_ai)
mod_ai |> summary() # Getting the model output

# Standardizing the varraibles 
data_ai <-
  data_ai |>
  dplyr::mutate(
    pos_attitude_ai_scale = (pos_attitude_ai - mean(pos_attitude_ai)) / sd(pos_attitude_ai),
    freq_use_ai_scale = scale(freq_use_ai)[,1]
  )

# Estimating the regression model with standardized variables
mod_scale <- lm(freq_use_ai_scale ~ pos_attitude_ai_scale, data_ai)
reg_coef <- mod_scale$coefficients[2] |> round(2)
cor_coef <- cor(data_ai$pos_attitude_ai, data_ai$freq_use_ai) |> round(2)
tibble::tibble(`Reg. Coef.` = reg_coef, `Corr. Coef` = cor_coef)