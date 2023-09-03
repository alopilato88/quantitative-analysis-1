set.seed(4352)

plot_alpha <- .50
plot_fill <- "#3F72AF"
plot_color <- "#112D4E"
plot_xlim <- c(-18, 18)

n <- 1000
x <- sample(1:7, n, replace = TRUE)
b <- 1
var_xb <- var(x*b)
std_error <- 9
y <- 2 + b*x  + rnorm(n, sd = sqrt(std_error))

data <- 
  tibble::tibble(
    x = x,
    y = y
  ) |>
  dplyr::mutate(
    y_cond_mean = 2 + x
  )

ggplot2::ggplot(
  data = data,
  ggplot2::aes(x = y, y = x)
) + 
  ggplot2::geom_point() + 
  geom_norm_density(
    mean = 3,
    sd = sqrt(9),
    scale = 5,
    fun = scaled_dnorm,
    y_offset = 1,
    color = plot_color,
    fill = plot_fill,
    alpha = plot_alpha
  ) +
  geom_norm_density(
    mean = 4,
    sd = sqrt(9),
    scale = 5,
    fun = scaled_dnorm,
    y_offset = 2,
    color = plot_color,
    fill = plot_fill,
    alpha = plot_alpha
  ) +
  geom_norm_density(
    mean = 5,
    sd = sqrt(9),
    scale = 5,
    fun = scaled_dnorm,
    y_offset = 3,
    color = plot_color,
    fill = plot_fill,
    alpha = plot_alpha
  ) +
  geom_norm_density(
    mean = 6,
    sd = sqrt(9),
    scale = 5,
    fun = scaled_dnorm,
    y_offset = 4,
    color = plot_color,
    fill = plot_fill,
    alpha = plot_alpha
  ) +
  geom_norm_density(
    mean = 7,
    sd = sqrt(9),
    scale = 5,
    fun = scaled_dnorm,
    y_offset = 5,
    color = plot_color,
    fill = plot_fill,
    alpha = plot_alpha
  ) +
  geom_norm_density(
    mean = 8,
    sd = sqrt(9),
    scale = 5,
    fun = scaled_dnorm,
    y_offset = 6,
    color = plot_color,
    fill = plot_fill,
    alpha = plot_alpha
  ) +
  geom_norm_density(
    mean = 9,
    sd = sqrt(9),
    scale = 5,
    fun = scaled_dnorm,
    y_offset = 7,
    color = plot_color,
    fill = plot_fill,
    alpha = plot_alpha
  ) +
  ggplot2::coord_flip() + 
  ggplot2::geom_line(
    data = data.frame(x = 0:8, y = 2 + 0:8),
    color = plot_color,
    lwd = 1.5
  ) + 
  ggplot2::geom_point(
    data = data.frame(x = 1:7, y = 2 + 1:7),
    size = 4,
    shape = "circle",
    group = 1,
    color = plot_fill,
    fill = plot_color
  ) +
  lecture_ggplot_theme_barplot
