#' Add a dotted trend line
#'
#' @param method Smoothing method passed to `ggplot2::geom_smooth()`.
#'
#' @return A ggplot smooth layer.
#' @importFrom ggplot2 geom_smooth
#' @export

add_trend_line <- function(method) {

  gold <- "#FFB52C"

  geom_smooth(method = method,
              color = gold,
              linetype = "dotted",
              se = FALSE)
}
