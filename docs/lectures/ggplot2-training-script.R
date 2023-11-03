# Load packages -----------------------------------------------------------

library(tidyverse)
library(ggplot2)
library(peopleanalytics)
library(ggthemes)

# Load datasets -----------------------------------------------------------

data_to_trend <- 
  peopleanalytics::turnover_trends |>
  tibble::as_tibble()

# Build a scatter plot ----------------------------------------------------

# ggplot2 works by first creating a blank plot area that we can then add layers to:

ggplot2::ggplot(data = data_to_trend)

# We can start adding layers starting with mapping our data to axes

ggplot2::ggplot(
  data = data_to_trend,
  ggplot2::aes(
    x = year,
    y = turnover_rate
  )
)

# Still no plot though...
# We need to add a geometric object or geom in ggplot2 speak

ggplot2::ggplot(
  data = data_to_trend,
  ggplot2::aes(
    x = year,
    y = turnover_rate
  )
) + 
  ggplot2::geom_point()

# This still is still not a great plot...what to do? 
# We could decide to look at month as the X variable:

ggplot2::ggplot(
  data = data_to_trend,
  ggplot2::aes(
    x = month,
    y = turnover_rate
  )
) + 
  ggplot2::geom_point()

# Not great, but let's keep going.
# Maybe we should differentiate the plot by job_lvl:

ggplot2::ggplot(
  data = data_to_trend,
  ggplot2::aes(
    x = month,
    y = turnover_rate,
    color = as.factor(level)
  )
) + 
  ggplot2::geom_point()

# Hmm, we can still make it better. 
# Maybe we should have separate plots for each year?

ggplot2::ggplot(
  data = data_to_trend,
  ggplot2::aes(
    x = month,
    y = turnover_rate,
    color = as.factor(level)
  )
) + 
  ggplot2::geom_point() + 
  ggplot2::facet_grid(
    1 ~ year
  )

# Still not great, can we incorporate the type of job too?
ggplot2::ggplot(
  data = data_to_trend,
  ggplot2::aes(
    x = month,
    y = turnover_rate,
    color = as.factor(level)
  )
) + 
  ggplot2::geom_point() +
  ggplot2::facet_grid(
    job ~ year
  ) 

# We are getting somewhere, but can we add a smooth line for reference?
ggplot2::ggplot(
  data = data_to_trend,
  ggplot2::aes(
    x = month,
    y = turnover_rate,
    color = as.factor(level)
  )
) + 
  ggplot2::geom_point() +
  ggplot2::facet_grid(
    job ~ year
  ) +
  ggplot2::geom_smooth(
    se = FALSE
  )

# Looking better (kind of). Maybe we can make the points a bit more transparent:

ggplot2::ggplot(
  data = data_to_trend,
  ggplot2::aes(
    x = month,
    y = turnover_rate,
    color = as.factor(level)
  )
) + 
  ggplot2::geom_point(
    alpha = .50
  ) +
  ggplot2::facet_grid(
    job ~ year
  ) +
  ggplot2::geom_smooth(
    se = FALSE
  )

# Great! Now let's add a theme using ggthemes

ggplot2::ggplot(
  data = data_to_trend,
  ggplot2::aes(
    x = month,
    y = turnover_rate,
    color = as.factor(level)
  )
) + 
  ggplot2::geom_point(
    alpha = .50
  ) +
  ggplot2::facet_grid(
    job ~ year
  ) +
  ggplot2::geom_smooth(
    se = FALSE
  ) + 
  ggthemes::scale_color_colorblind()

# Finally lets add some labels!

ggplot2::ggplot(
  data = data_to_trend,
  ggplot2::aes(
    x = month,
    y = turnover_rate,
    color = as.factor(level)
  )
) + 
  ggplot2::geom_point(
    alpha = .50
  ) +
  ggplot2::facet_grid(
    job ~ year
  ) +
  ggplot2::geom_smooth(
    se = FALSE
  ) + 
  ggthemes::scale_color_colorblind() + 
  ggplot2::labs(
    x = "Month",
    y = "Turnover Rate",
    color = "Job Level",
    title = "Monthly Turnover Rates by Year",
    subtitle = "Rates by Job Type and Level"
  )


# Visualizing a Regression Model ------------------------------------------

# First lets create some fake data:
set.seed(4245)
n <- 500

x <- rnorm(n, mean = 0, sd = 1)
z <- rnorm(n, mean = 0, sd = 1)

y <- .2*x + .2*z + -.3 * x * z
sd_e <- sqrt(var(y)*.80 / (1 - .80))
y <- y + rnorm(n, mean = 0, sd = sd_e)

data_fake <- 
  tibble::tibble(
    x = x, 
    z = z, 
    y = y
  )

# Let's check our fake data
mod <- lm(y ~ x * z, data = data_fake)

# Ok let's build a linear plot with x & y first 

# Set our plot
ggplot2::ggplot(
  data = data_fake,
  ggplot2::aes(
    x = x,
    y = y
  )
)
  
# Add points and a line
ggplot2::ggplot(
  data = data_fake,
  ggplot2::aes(
    x = x,
    y = y
  )
) +
  ggplot2::geom_point() + 
  ggplot2::geom_smooth(
    method = lm,
    formula = y ~ x
  )

# Add some better color, aesthetics, and labels
ggplot2::ggplot(
  data = data_fake,
  ggplot2::aes(
    x = x,
    y = y
  )
) +
  ggplot2::geom_point(
    alpha = .60,
    color = "darkgrey"
  ) + 
  ggplot2::geom_smooth(
    method = lm,
    formula = y ~ x
  ) + 
  ggthemes::theme_economist() + 
  ggplot2::labs(
    x = "Predictor Variable",
    y = "Outcome Variable",
    title = "Scatterplot of X & Y"
  )


# Visualizing a moderated regression model --------------------------------

# First here is my custom theme: 
lecture_ggplot_theme_moderation_plot <- 
  ggplot2::theme(
    plot.background = element_rect(fill = "#F9F7F7", colour = "#F9F7F7"),
    panel.background = element_rect(fill = "#F9F7F7"),
    axis.line.x = element_line(colour = "#3D3C42"),
    axis.line.y = ggplot2::element_blank(),
    panel.grid.minor = element_line(colour = "#F9F7F7"),
    panel.grid.major = element_line(colour = "#F9F7F7"),
    legend.background = element_rect(fill = "#F9F7F7", color = "black"),
    strip.background = element_rect(fill = "#F9F7F7", color = "black")
  )

plot_fill <- "#3F72AF"
plot_color <- "#112D4E"

# Restructure the data a bit:
data_fake_moderator <- 
  data_fake |>
  dplyr::mutate(
    rank = dplyr::percent_rank(z),
    group = dplyr::case_when(
      rank <= .36 ~ "Low",
      rank >= .84 ~ "High",
      TRUE ~ NA_character_
    )
  ) |>
  tidyr::drop_na(
    group
  )

ggplot2::ggplot(
  data = data_fake_moderator,
  ggplot2::aes(
    x = x,
    y = y, 
    color = group
  )
) + 
  ggplot2::geom_point() + 
  ggplot2::geom_smooth(
    method = "lm",
    formula = y ~ x, 
    se = FALSE
  ) 

# Add a custom theme 
ggplot2::ggplot(
  data = data_fake_moderator,
  ggplot2::aes(
    x = x,
    y = y, 
    color = group
  )
) + 
  ggplot2::geom_point() + 
  ggplot2::geom_smooth(
    method = "lm",
    formula = y ~ x, 
    se = FALSE
  )  + 
  lecture_ggplot_theme_moderation_plot + 
  ggplot2::labs(
    x = "Predictor Variable",
    y = "Outcome Variable",
    color = "Moderator Group"
  )




