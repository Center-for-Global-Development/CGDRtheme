#' A function
#'
#' @param plot xxx
#' @importFrom colorspace lighten
#' @importFrom ggplot2 scale_fill_manual
#' @export

change_boxplot_color <- function(plot) {

  lightened_palette = lighten(cgd_palette(palette_name = "categorical"), 0.5)
  plot_new <- plot +
    scale_fill_manual(values=lightened_palette)
  return(plot_new)

}
