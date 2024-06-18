#' A function
#'
#' @param orientation horizontal or vertical
#' @param intercept constant where the line will fall
#' @importFrom ggplot2 geom_vline geom_hline
#' @export

add_separator_line = function(orientation, intercept) {

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

  if(orientation == 'vertical') {
    geom_vline(xintercept = intercept, linetype="longdash",
               color = teal_gray, size=convert_to_pt(1))
  } else if(orientation == 'horizontal') {
    geom_hline(yintercept = intercept, linetype="longdash",
               color = teal_gray, size=convert_to_pt(1))
  } else {
    print('Please check the parameters used.')
  }


}
