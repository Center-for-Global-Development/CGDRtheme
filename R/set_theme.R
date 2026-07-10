#' Return the base CGD ggplot theme (alias)
#'
#' Kept for backward compatibility; identical to [theme_cgd()], which is the
#' preferred name.
#'
#' @return A complete ggplot theme object.
#' @export

set_theme <- function() {
  theme_cgd()
}
