#' Return the base CGD ggplot theme
#'
#' @return A complete ggplot theme object.
#' @importFrom ggplot2 element_blank theme_bw theme element_text element_line element_rect margin unit
#' @export

set_theme <- function() {
  colors <- cgd_colors_internal()
  fonts <- cgd_fonts()

  ggplot2::theme(

    # plot attributes

    plot.title = ggplot2::element_text(family = fonts$title,
                                       size = 18,
                                       colour = colors[["teal"]],
                                       face = "bold",
                                       margin = margin(0,0,15,0),
                                       hjust = 0),
    plot.title.position = "plot",
    plot.background = element_rect(fill = "transparent", color = NA),
    plot.margin=grid::unit(c(4,4,2,4), "mm"),

    # axis attributes

    axis.text = element_text(family = fonts$regular,
                            size = 12,
                            colour = colors[["teal_black"]]),
    axis.title = element_text(family = fonts$medium,
                             size = 14,
                             colour = colors[["teal"]]),
    axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)),
    axis.title.y = element_text(angle = 90,
                                margin = margin(t = 0, r = 10, b = 0, l = 0)),
    axis.ticks.length = unit(0, "pt"),
    axis.line = element_line(linewidth = 0.5, colour = colors[["teal_black"]]),

    # legend attributes
    #
    # Legends are shown by default so that color-mapped charts stay
    # readable. Helpers that add direct labels turn them off, and
    # add_legend()/theme() can reposition or hide them.

    legend.position = "right",
    legend.justification = "top",
    legend.text = element_text(family = fonts$light,
                               face = "italic",
                               size = 12,
                               colour = colors[["teal_black"]]),
    legend.title = element_text(family = fonts$medium,
                                size = 12,
                                colour = colors[["teal"]]),
    legend.background = element_blank(),
    legend.key = element_blank(),

    # panel attributes

    panel.border = element_blank(),
    panel.spacing.x=unit(0, "lines"),
    panel.spacing.y=unit(0, "lines"),
    panel.background = ggplot2::element_blank(),
    panel.grid = NULL,
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),

    complete = TRUE
  )
}
