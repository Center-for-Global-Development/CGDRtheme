#' A function
#'
#' @param size size in pt
#'
#' @export

convert_to_pt = function(size) {

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

  r_to_pt = ggplot2::.pt

  size_in_pt = size/r_to_pt

  return(size_in_pt)
}
