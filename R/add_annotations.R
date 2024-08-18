#' A function
#'
#' @param type xxx
#' @param text xxx
#' @param text_x_position xxx
#' @param text_y_position xxx
#' @param segment_x_position_start xxx
#' @param segment_x_position_end xxx
#' @param segment_y_position_start xxx
#' @param segment_y_position_end xxx
#' @importFrom ggplot2 annotate
#' @export

add_annotations <- function(type,
                            text=NA,
                            text_x_position=NA,
                            text_y_position=NA,
                            segment_x_position_start=NA,
                            segment_x_position_end=NA,
                            segment_y_position_start=NA,
                            segment_y_position_end=NA) {

  teal_black <- "#1A272A"
  teal_gray <- "#85A5AD"

  if(type == "text") {
    annotate("text",
             x = text_x_position,
             y = text_y_position,
             label = text,
             family = "Sofia Pro Light Italic",
             colour = teal_black,
             size = convert_to_pt(12))
  } else if(type == "segment") {
    annotate("segment",
             x = segment_x_position_start,
             xend = segment_x_position_end,
             y = segment_y_position_start,
             yend = segment_y_position_end,
             colour = "#85A5AD",
             size = convert_to_pt(1))
  }
}


