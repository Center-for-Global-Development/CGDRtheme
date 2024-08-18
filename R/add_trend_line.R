#' A function
#'
#' @param method xxx
#' @importFrom ggplot2 geom_smooth
#' @export

add_trend_line <- function(method) {

  gold <- "#FFB52C"

  geom_smooth(method = method,
              color = gold,
              linetype = "dotted",
              se = FALSE)
}
