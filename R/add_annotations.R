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

add_annotations <- function(type = c("text", "segment"),
                            text=NA,
                            text_x_position=NA,
                            text_y_position=NA,
                            segment_x_position_start=NA,
                            segment_x_position_end=NA,
                            segment_y_position_start=NA,
                            segment_y_position_end=NA) {
  type <- match.arg(type)
  colors <- cgd_colors_internal()

  if(type == "text") {
    if (is.na(text) || is.na(text_x_position) || is.na(text_y_position)) {
      stop("Text annotations need `text`, `text_x_position`, and ",
           "`text_y_position`.", call. = FALSE)
    }
    fonts <- cgd_fonts()
    annotate("text",
             x = text_x_position,
             y = text_y_position,
             label = text,
             family = fonts$light,
             fontface = "italic",
             colour = colors[["teal_black"]],
             size = convert_to_pt(12))
  } else {
    if (is.na(segment_x_position_start) || is.na(segment_x_position_end) ||
        is.na(segment_y_position_start) || is.na(segment_y_position_end)) {
      stop("Segment annotations need all four `segment_*_position_*` ",
           "arguments.", call. = FALSE)
    }
    annotate("segment",
             x = segment_x_position_start,
             xend = segment_x_position_end,
             y = segment_y_position_start,
             yend = segment_y_position_end,
             colour = colors[["teal_gray"]],
             linewidth = convert_to_pt(1))
  }
}
