#' Show a legend with CGD styling
#'
#' Legends are already visible by default; use this helper to reposition one
#' or to apply the CGD legend styling (which hides the legend title). To hide
#' a legend, use `theme(legend.position = "none")`.
#'
#' @param position Legend position such as `"top"`, `"bottom"`, `"left"`, or `"right"`.
#' @param justification Legend justification passed to ggplot2.
#'
#' @return A ggplot theme modification.
#' @export

add_legend = function(position = "right", justification = "top") {
  colors <- cgd_colors_internal()
  fonts <- cgd_fonts()

  theme(
    legend.position= position,
    legend.justification = justification,
    legend.text = element_text(family = fonts$light,
                               face = "italic",
                               size = 12,
                               colour = colors[["teal_black"]]),
    legend.title = element_blank(),
  )
}
