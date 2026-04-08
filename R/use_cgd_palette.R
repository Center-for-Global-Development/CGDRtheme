#' Return colors from a CGD palette
#'
#' @param palette_name Name of the palette to retrieve.
#' @param n Number of colors to return. Defaults to the full palette.
#' @param type Whether to return a discrete subset or a continuous interpolation.
#'
#' @return A character vector of hex color values.
#' @export

cgd_palette <- function(palette_name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  pal <- cgd_palettes_internal()[[palette_name]]
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
