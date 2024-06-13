#' A function
#'
#'
#' @return color_palette
#' @export

load_cgd_palette <- function() {

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

  cgd_palette <- list(
    categorical = c(light_teal, gold, blue, light_blue, light_gold, teal_gray,
                    dark_gray, light_gray),
    sequential1 = c(light_teal),
    sequential2 = c(light_blue, light_teal),
    sequential3 = c(light_gray, light_blue, light_teal),
    sequential4 = c(light_gray, light_blue, light_teal, dark_gray),
    sequential8 = c(light_gray, teal_gray, light_blue, blue, light_teal,
                    teal, dark_gray, teal_black),
    polar1 = c(light_teal),
    polar2 = c(light_teal, gold),
    polar3 = c(light_teal, teal_gray, gold),
    polar4 = c(light_teal, teal_gray, light_gold, gold),
    polar5 = c(light_teal, teal_gray, light_blue, light_gold, gold),
    stoplight = c(green, gold, red)
  )

  return(cgd_palette)
}
