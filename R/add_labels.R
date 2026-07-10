#' Add data labels using CGD defaults
#'
#' For `chart_type = "line"` the legend is also hidden, since the lines are
#' labeled directly on the plot.
#'
#' @param label Vector or column used for label text. For `chart_type =
#'   "line"` the plot data must contain a column named `label`.
#' @param chart_type One of `"bar"`, `"stacked"`, or `"line"`.
#'
#' @return A ggplot layer (or list of layer and theme) for use with `+`.
#' @importFrom ggplot2 geom_text aes position_stack theme
#' @importFrom ggrepel geom_text_repel
#' @import scales
#' @export

add_labels <- function(label, chart_type) {
  if(chart_type == "bar") {
    geom_text(aes(label=label),
              vjust=-0.5
              #position = position_stack(vjust = .5)
              )
  } else if(chart_type == "stacked") {
    geom_text(aes(label=scales::percent(label, accuracy = 1)),
              position = position_stack(vjust = .5)
    )
  } else if(chart_type == "line") {
    fonts <- cgd_fonts()
    list(
      geom_text_repel(aes(label = label),
                      nudge_x = 0.1,
                      na.rm = TRUE,
                      family = fonts$light,
                      fontface = "italic",
                      segment.color = NA),
      theme(legend.position = "none")
    )
  }
}
