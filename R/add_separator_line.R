#' Add a separator line
#'
#' @param orientation Either `"horizontal"` or `"vertical"`.
#' @param intercept Axis intercept where the line should be drawn.
#'
#' @return A ggplot line layer.
#' @importFrom ggplot2 geom_vline geom_hline
#' @export

add_separator_line = function(orientation, intercept) {
  colors <- cgd_colors_internal()

  if(orientation == 'vertical') {
    geom_vline(xintercept = intercept, linetype="longdash",
               color = colors[["teal_gray"]], size=convert_to_pt(1))
  } else if(orientation == 'horizontal') {
    geom_hline(yintercept = intercept, linetype="longdash",
               color = colors[["teal_gray"]], size=convert_to_pt(1))
  } else {
    print('Please check the parameters used.')
  }


}
