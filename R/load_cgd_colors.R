#' A function
#'
#'
#' @return colors
#' @export

load_cgd_colors <- function() {

  ## CGD Color Palette
  ## PRIMARY
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

  primary <- c(
    teal <- "#0B4C5B",
    gold <- "#FFB52C",
    teal_gray <- "#85A5AD",
    light_teal <- "#006970",
    cream <- "#F3F6F7",
    dark_gray <- "#394649",
    teal_black <- "#1A272A"
  )

  secondary <- list(
    blue,
    light_blue,
    light_gold,
    light_gray,
    red,
    green
  )

  colors = c(primary, secondary)
  return(primary)
}
