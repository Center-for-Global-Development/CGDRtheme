#' Return colors from a CGD palette
#'
#' @param palette_name Name of the palette to retrieve.
#' @param n Number of colors to return. Defaults to the full palette.
#' @param type Whether to return a discrete subset or a continuous interpolation.
#'
#' @return A character vector of hex color values.
#' @export

cgd_palette <- function(palette_name, n, type = c("discrete", "continuous")) {
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

  cdg_colors <- list(
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

  type <- match.arg(type)

  pal <- cdg_colors[[palette_name]]
  if (is.null(pal))
    stop("Palette not found.")

  if (missing(n)) {
    n <- length(pal)
  }

  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what palette can offer")
  }

  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal)(n),
                discrete = pal[1:n]
  )
  structure(out, class = "palette", name = palette_name)

}
