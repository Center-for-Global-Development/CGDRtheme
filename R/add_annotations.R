#' Add branded plot annotations
#'
#' @param type Either `"text"` or `"segment"`.
#' @param text Annotation text for `type = "text"`.
#' @param text_x_position X position for text annotation.
#' @param text_y_position Y position for text annotation.
#' @param segment_x_position_start Starting x position for a segment annotation.
#' @param segment_x_position_end Ending x position for a segment annotation.
#' @param segment_y_position_start Starting y position for a segment annotation.
#' @param segment_y_position_end Ending y position for a segment annotation.
#'
#' @return A ggplot annotation layer.
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
  colors <- cgd_colors_internal()

  if(type == "text") {
    annotate("text",
             x = text_x_position,
             y = text_y_position,
             label = text,
             family = "Sofia Pro Light Italic",
             colour = colors[["teal_black"]],
             size = convert_to_pt(12))
  } else if(type == "segment") {
    annotate("segment",
             x = segment_x_position_start,
             xend = segment_x_position_end,
             y = segment_y_position_start,
             yend = segment_y_position_end,
             colour = colors[["teal_gray"]],
             size = convert_to_pt(1))
  }
}
