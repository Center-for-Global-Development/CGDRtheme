#' A function
#'
#' @param label xxx
#' @param chart_type xxx
#' @importFrom ggplot2 geom_text aes
#' @export

add_labels <- function(label, chart_type) {
  if(chart_type == "bar") {
    geom_text(aes(label=label),
              vjust=-0.5
              #position = position_stack(vjust = .5)
              )
  }
}
