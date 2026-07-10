#' Add major grid lines to a plot
#'
#' @param horizontal Add horizontal major grid lines.
#' @param vertical Add vertical major grid lines.
#'
#' @return A ggplot theme modification.
#' @export

add_grid_lines = function(horizontal = FALSE, vertical = FALSE) {
  if (!is.logical(horizontal) || !is.logical(vertical)) {
    stop("`horizontal` and `vertical` must be TRUE or FALSE.", call. = FALSE)
  }
  colors <- cgd_colors_internal()
  grid_line <- element_line(color = colors[["light_gray"]],
                            linewidth = 0.3527777778)

  theme(
    panel.grid.major.y = if (isTRUE(horizontal)) grid_line else element_blank(),
    panel.grid.major.x = if (isTRUE(vertical)) grid_line else element_blank()
  )
}
