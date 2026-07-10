#' CGD ggplot2 theme
#'
#' A complete ggplot2 theme implementing the CGD data visualization style
#' guide. Add it to a single plot with `+ theme_cgd()`, or apply it to every
#' plot in the session with [setup_plot()]. Pair it with
#' [scale_colour_cgd()] / [scale_fill_cgd()] to get CGD colors on a single
#' plot without changing session defaults.
#'
#' The theme is built on [ggplot2::theme_minimal()] so that elements it does
#' not set explicitly (legend keys, tick marks, and so on) still inherit
#' sensible base text, line, and rectangle settings.
#'
#' @return A complete ggplot theme object.
#' @importFrom ggplot2 %+replace% theme_minimal theme element_blank
#'   element_text element_line element_rect margin unit
#' @export

theme_cgd <- function() {
  colors <- cgd_colors_internal()
  fonts <- cgd_fonts()

  ggplot2::theme_minimal(base_size = 12, base_family = fonts$regular) %+replace%
    ggplot2::theme(

      # plot attributes

      plot.title = element_text(family = fonts$title,
                                size = 18,
                                colour = colors[["teal"]],
                                face = "bold",
                                margin = margin(b = 8),
                                hjust = 0),
      plot.subtitle = element_text(family = fonts$regular,
                                   size = 13,
                                   colour = colors[["dark_gray"]],
                                   margin = margin(b = 15),
                                   hjust = 0),
      plot.caption = element_text(family = fonts$light,
                                  face = "italic",
                                  size = 10,
                                  colour = colors[["dark_gray"]],
                                  margin = margin(t = 12),
                                  hjust = 0),
      plot.title.position = "plot",
      plot.caption.position = "plot",
      plot.background = element_rect(fill = "transparent", color = NA),
      plot.margin = grid::unit(c(4, 4, 2, 4), "mm"),

      # axis attributes

      axis.text = element_text(family = fonts$regular,
                               size = 12,
                               colour = colors[["teal_black"]]),
      axis.title = element_text(family = fonts$medium,
                                size = 14,
                                colour = colors[["teal"]]),
      axis.title.x = element_text(margin = margin(t = 10)),
      axis.title.y = element_text(angle = 90, margin = margin(r = 10)),
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

      # panel and facet attributes

      panel.border = element_blank(),
      panel.spacing = unit(1, "lines"),
      panel.background = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      strip.background = element_blank(),
      strip.text = element_text(family = fonts$medium,
                                size = 12,
                                colour = colors[["teal"]],
                                margin = margin(b = 6))
    )
}
