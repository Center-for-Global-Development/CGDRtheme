#' Add a dashed projection line
#'
#' @param df Data frame containing the projected portion of the series.
#'
#' @return A ggplot line layer.
#' @importFrom ggplot2 geom_line
#' @export

add_projection_line <- function(df) {
  geom_line(data = df,
            linetype="dashed")
}
