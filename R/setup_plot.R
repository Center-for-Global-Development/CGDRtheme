#' Set CGD plotting defaults for the current R session
#'
#' Applies the CGD theme, geom defaults, and default ggplot2 scales.
#'
#' @return Invisibly returns `NULL`.
#' @importFrom ggplot2 discrete_scale scale_colour_gradient scale_fill_gradient
#' @export

setup_plot <- function() {
  colors <- cgd_colors_internal()
  categorical_palette <- cgd_palettes_internal()[["categorical"]]

  # Create default theme for plots
  ggplot2::theme_set(set_theme())

  r_to_pt = ggplot2::.pt

  ggplot2::update_geom_defaults("text", list(family = "Sofia Pro Light Italic",
                                             size = 12/r_to_pt))
  ggplot2::update_geom_defaults("label", list(family = "Sofia Pro Light Italic",
                                              size = 12/r_to_pt))
  ggplot2::update_geom_defaults("bar", list(fill = colors[["light_teal"]]))
  ggplot2::update_geom_defaults("col", list(fill = colors[["light_teal"]]))
  ggplot2::update_geom_defaults("point", list(colour = colors[["light_teal"]], size = 3))
  ggplot2::update_geom_defaults("line", list(colour = colors[["light_teal"]], linewidth = 4/r_to_pt))
  ggplot2::update_geom_defaults("step", list(colour = colors[["light_teal"]], size = 1))
  ggplot2::update_geom_defaults("path", list(colour = colors[["light_teal"]], size = 1))
  ggplot2::update_geom_defaults("boxplot", list(fill = colors[["teal_gray"]],
                                                colour = colors[["light_teal"]]))
  ggplot2::update_geom_defaults("density", list(fill = colors[["light_teal"]]))
  ggplot2::update_geom_defaults("violin", list(fill = colors[["light_teal"]]))
  ggplot2::update_geom_defaults("sf", list(fill = colors[["light_teal"]], color = "white", size = 0.1))

  custom.fill <- function(n) {
    palette = categorical_palette
    if (n > length(palette))
      warning('palette has duplicated colours because categories > 8')
    rep(palette, length.out=n)
  }
  scale_custom_fill <- function(aesthetics, scale_name= "custom", ..., palette = custom.fill) discrete_scale(aesthetics = aesthetics, scale_name, ..., palette = palette)
  scale_custom_fill_2 <- function(...) scale_custom_fill("fill", ...)

  custom.colour <- function(n) {
    palette = categorical_palette
    if (n > length(palette))
      warning('palette has duplicated colours because categories > 8')
    rep(palette, length.out=n)
  }
  scale_custom_colour <- function(aesthetics, scale_name= "custom", ..., palette = custom.colour) discrete_scale(aesthetics = aesthetics, scale_name, ..., palette = palette)
  scale_custom_colour_2 <- function(...) scale_custom_colour("colour", ...)

  options(ggplot2.discrete.fill = scale_custom_fill_2)
  options(ggplot2.discrete.colour = scale_custom_colour_2)

  gradient_custom_colour <- function(){
    scale_colour_gradient(low = colors[["light_teal"]],
                          high = colors[["gold"]])
  }
  gradient_custom_fill <- function(){
    scale_fill_gradient(low = colors[["light_teal"]],
                        high = colors[["gold"]])
  }

  options(ggplot2.continuous.colour= gradient_custom_colour)
  options(ggplot2.continuous.fill = gradient_custom_fill)

}
