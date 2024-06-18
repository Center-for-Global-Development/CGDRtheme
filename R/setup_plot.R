#' A function
#'
#'
#' @return default_theme
#' @importFrom ggplot2 element_blank theme_bw theme element_text element_line element_rect margin unit
#' @export

setup_plot = function(
) {

  teal <- "#0B4C5B"
  gold <- "#FFB52C"
  teal_gray <- "#85A5AD"
  light_teal <- "#006970"
  cream <- "#F3F6F7"
  dark_gray <- "#394649"
  teal_black <- "#1A272A"

  ## SECONDARY
  blue <- "#2D99B5"
  light_blue <- "#BFDEE0"
  light_gold <- "#FEE8BF"
  light_gray <-  "#DFE0E2"
  red <- "#D15553"
  green <- "#00896C"

  # Create default theme for plots
  default_theme = theme_bw() +
    theme(
      plot.margin=grid::unit(c(4,4,2,4), "mm"),
      panel.border = element_blank(),
      axis.text = element_text(family = "Sofia Pro Regular",
                               size = 12,
                               colour = teal_black),
      axis.title = element_text(family = "Sofia Pro Medium",
                                size = 14,
                                colour = teal),
      axis.title.y = element_text(vjust = 2),
      axis.title.x = element_text(vjust = -0.5),
      axis.ticks.length = unit(0, "pt"),
      axis.line = element_line(linewidth = 0.5, colour = teal_black),
      panel.spacing.x=unit(0, "lines"),
      panel.spacing.y=unit(0, "lines"),
      panel.background = element_rect(fill = "transparent"),
      plot.background = element_rect(fill = "transparent", color = NA),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      text = element_text(family = "Sofia Pro Bold",
                          size = 18,
                          colour = teal),
      legend.position = "none",
      plot.title.position = "plot",
      plot.title = element_text(margin=margin(0,0,15,0)),
    )
  return(default_theme)
}

