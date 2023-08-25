#' lecture_ggplot_theme
#' 
lecture_ggplot_theme_1 <- 
  ggplot2::theme(
    plot.background = element_rect(fill = "#F9F7F7", colour = "#F9F7F7"),
    panel.background = element_rect(fill = "#F9F7F7"),
    axis.line.x = element_line(colour = "#3D3C42"),
    axis.line.y = ggplot2::element_blank(),
    panel.grid.minor = element_line(colour = "#F9F7F7"),
    panel.grid.major = element_line(colour = "#F9F7F7"),
    axis.ticks.y = ggplot2::element_line(linewidth = 0),
    axis.text.y = ggplot2::element_blank(),
    axis.text.x = ggplot2::element_blank()
  )

lecture_ggplot_theme_barplot <- 
  ggplot2::theme(
    plot.background = element_rect(fill = "#F9F7F7", colour = "#F9F7F7"),
    panel.background = element_rect(fill = "#F9F7F7"),
    axis.line.x = element_line(colour = "#3D3C42"),
    axis.line.y = ggplot2::element_blank(),
    panel.grid.minor = element_line(colour = "#F9F7F7"),
    panel.grid.major = element_line(colour = "#F9F7F7"),
    legend.text = ggplot2::element_blank(),
    legend.title = ggplot2::element_blank(),
    legend.position = "none"
  )

