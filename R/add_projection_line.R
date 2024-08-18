#' A function
#'
#' @param df xxx
#' @importFrom ggplot2 geom_line
#' @export

add_projection_line <- function(df) {
  geom_line(data = df,
            linetype="dashed")
}
