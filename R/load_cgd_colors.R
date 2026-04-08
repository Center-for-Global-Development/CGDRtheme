#' Return named CGD brand colors
#'
#' Returns a named character vector containing the primary and secondary
#' CGD brand colors used throughout the package.
#'
#' @return A named character vector of hex color values.
#' @export

load_cgd_colors <- function() {
  return(cgd_colors_internal())
}
