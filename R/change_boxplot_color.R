#' Apply a lighter CGD palette to a boxplot
#'
#' @param plot A ggplot object containing a boxplot layer with fill aesthetics.
#'
#' @return A ggplot object with a manual fill scale applied.
#' @importFrom colorspace lighten
#' @importFrom ggplot2 scale_fill_manual
#' @export

change_boxplot_color <- function(plot) {

  lightened_palette <- colorspace::lighten(
    cgd_palette(palette_name = "categorical"),
    0.5
  )
  plot_new <- plot +
    scale_fill_manual(values = lightened_palette)
  return(plot_new)

}
