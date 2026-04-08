#' Add major grid lines to a plot
#'
#' @param horizontal Add horizontal major grid lines.
#' @param vertical Add vertical major grid lines.
#'
#' @return A ggplot theme modification.
#' @export

add_grid_lines = function(horizontal = FALSE, vertical = FALSE) {
  colors <- cgd_colors_internal()

  if(horizontal == TRUE & vertical == FALSE) {
    theme(panel.grid.major.y = element_line(color = colors[["light_gray"]],
                                            linewidth = 0.3527777778))
  } else if (horizontal == FALSE & vertical == TRUE) {
    theme(panel.grid.major.x = element_line(color = colors[["light_gray"]],
                                            linewidth = 0.3527777778))
  } else if (horizontal == TRUE & vertical == TRUE) {
    theme(panel.grid.major.x = element_line(color = colors[["light_gray"]],
                                            linewidth = 0.3527777778),
          panel.grid.major.y = element_line(color = colors[["light_gray"]],
                                            linewidth = 0.3527777778)
    )
  }
}
