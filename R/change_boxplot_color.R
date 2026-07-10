#' Apply a lighter CGD palette to a boxplot
#'
#' Kept for backward compatibility. Prefer adding
#' `scale_fill_cgd(lighten = 0.5)` to the plot directly, which composes with
#' `+` like other ggplot components.
#'
#' @param plot A ggplot object containing a boxplot layer with fill aesthetics.
#'
#' @return A ggplot object with a lightened CGD fill scale applied.
#' @export

change_boxplot_color <- function(plot) {
  if (!inherits(plot, "ggplot")) {
    stop("`plot` must be a ggplot object.", call. = FALSE)
  }
  plot + scale_fill_cgd(lighten = 0.5)
}
