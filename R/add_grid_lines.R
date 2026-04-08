#' Add major grid lines to a plot
#'
#' @param horizontal Add horizontal major grid lines.
#' @param vertical Add vertical major grid lines.
#'
#' @return A ggplot theme modification.
#' @export

add_grid_lines = function(horizontal = FALSE, vertical = FALSE) {

  teal <- "#0B4C5B"
  gold <- "#FFB52C"
  teal_gray <- "#85A5AD"
  light_teal <- "#006970"
  cream <- "#F3F6F7"
  dark_gray <- "#394649"
  teal_black <- "#1A272A"

  ## SECONDARY
  blue <- "#2D99B5"
  light_blue <- "#BFDEE0"
  light_gold <- "#FEE8BF"
  light_gray <-  "#DFE0E2"
  red <- "#D15553"
  green <- "#00896C"

  if(horizontal == TRUE & vertical == FALSE) {
    theme(panel.grid.major.y = element_line(color = light_gray,
                                            linewidth = 0.3527777778))
  } else if (horizontal == FALSE & vertical == TRUE) {
    theme(panel.grid.major.x = element_line(color = light_gray,
                                            linewidth = 0.3527777778))
  } else if (horizontal == TRUE & vertical == TRUE) {
    theme(panel.grid.major.x = element_line(color = light_gray,
                                            linewidth = 0.3527777778),
          panel.grid.major.y = element_line(color = light_gray,
                                            linewidth = 0.3527777778)
    )
  }
}
