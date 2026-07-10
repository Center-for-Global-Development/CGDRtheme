#' Add a separator line
#'
#' @param orientation Either `"vertical"` or `"horizontal"`.
#' @param intercept Axis intercept where the line should be drawn.
#'
#' @return A ggplot line layer.
#' @importFrom ggplot2 geom_vline geom_hline
#' @export

add_separator_line = function(orientation = c("vertical", "horizontal"),
                              intercept) {
  orientation <- match.arg(orientation)
  if (missing(intercept)) {
    stop("`intercept` is required: the axis value where the line is drawn.",
         call. = FALSE)
  }
  colors <- cgd_colors_internal()

  if(orientation == 'vertical') {
    geom_vline(xintercept = intercept, linetype="longdash",
               color = colors[["teal_gray"]], linewidth=convert_to_pt(1))
  } else {
    geom_hline(yintercept = intercept, linetype="longdash",
               color = colors[["teal_gray"]], linewidth=convert_to_pt(1))
  }
}
