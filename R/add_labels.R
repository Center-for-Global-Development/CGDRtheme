#' A function
#'
#' @param label xxx
#' @param chart_type xxx
#' @importFrom ggplot2 geom_text aes position_stack
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
    geom_text_repel(aes(label = label),
                    nudge_x = 0.1,
                    na.rm = TRUE,
                    family = "Sofia Pro Light Italic",
                    segment.color = NA)
  }
}
