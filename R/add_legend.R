#' Show a legend with CGD styling
#'
#' @param position Legend position such as `"top"`, `"bottom"`, `"left"`, or `"right"`.
#' @param justification Legend justification passed to ggplot2.
#'
#' @return A ggplot theme modification.
#' @export

add_legend = function(position, justification) {

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

  theme(
    legend.position= position,
    legend.justification = justification,
    legend.text = element_text(family = "Sofia Pro Light Italic",
                               size = 12,
                               colour = teal_black),
    legend.title = element_blank(),
  )
}
