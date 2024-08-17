#' A function
#'
#'
#' @return setup_plot
#' @importFrom ggplot2 element_blank theme_bw theme element_text element_line element_rect margin unit
#' @export

setup_plot <- function() {

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

  categorical = c(light_teal, gold, blue, light_blue, light_gold, teal_gray,
                  dark_gray, light_gray)
  polar = c(light_teal, gold)

  # Create default theme for plots
  ggplot2::theme_set(set_theme())

  r_to_pt = ggplot2::.pt

  ggplot2::update_geom_defaults("text", list(family = "Sofia Pro Light Italic",
                                             size = 12/r_to_pt))
  ggplot2::update_geom_defaults("label", list(family = "Sofia Pro Light Italic",
                                              size = 12/r_to_pt))
  ggplot2::update_geom_defaults("bar", list(fill = light_teal))
  ggplot2::update_geom_defaults("col", list(fill = light_teal))
  ggplot2::update_geom_defaults("point", list(colour = light_teal, size = 3))
  ggplot2::update_geom_defaults("line", list(colour = light_teal, linewidth = 4/r_to_pt))
  ggplot2::update_geom_defaults("step", list(colour = light_teal, size = 1))
  ggplot2::update_geom_defaults("path", list(colour = light_teal, size = 1))
  ggplot2::update_geom_defaults("boxplot", list(fill = light_teal))
  ggplot2::update_geom_defaults("density", list(fill = light_teal))
  ggplot2::update_geom_defaults("violin", list(fill = light_teal))
  ggplot2::update_geom_defaults("sf", list(fill = light_teal, color = "white", size = 0.1))

  options(ggplot2.discrete.fill = categorical)
  options(ggplot2.discrete.colour = categorical)
  options(ggplot2.continuous.colour= polar)
  options(ggplot2.continuous.fill = polar)

  
}

