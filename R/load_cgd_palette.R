#' Return all packaged CGD palettes
#'
#' @return A named list of palette vectors.
#' @export

load_cgd_palette <- function() {
  return(cgd_palettes_internal())
}
