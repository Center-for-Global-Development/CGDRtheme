#' Show a legend with CGD styling
#'
#' @param position Legend position such as `"top"`, `"bottom"`, `"left"`, or `"right"`.
#' @param justification Legend justification passed to ggplot2.
#'
#' @return A ggplot theme modification.
#' @export

add_legend = function(position, justification) {
  colors <- cgd_colors_internal()

  theme(
    legend.position= position,
    legend.justification = justification,
    legend.text = element_text(family = "Sofia Pro Light Italic",
                               size = 12,
                               colour = colors[["teal_black"]]),
    legend.title = element_blank(),
  )
}
