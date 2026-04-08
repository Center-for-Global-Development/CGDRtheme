#' Convert a point size for ggplot geoms
#'
#' @param size Size in typographic points.
#'
#' @return Numeric size in ggplot's internal units.
#' @export

convert_to_pt = function(size) {
  r_to_pt = ggplot2::.pt

  size_in_pt = size/r_to_pt

  return(size_in_pt)
}
