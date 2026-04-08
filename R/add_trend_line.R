#' Add a dotted trend line
#'
#' @param method Smoothing method passed to `ggplot2::geom_smooth()`.
#'
#' @return A ggplot smooth layer.
#' @importFrom ggplot2 geom_smooth
#' @export

add_trend_line <- function(method) {
  colors <- cgd_colors_internal()

  geom_smooth(method = method,
              color = colors[["gold"]],
              linetype = "dotted",
              se = FALSE)
}
