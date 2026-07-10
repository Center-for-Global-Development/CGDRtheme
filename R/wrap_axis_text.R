#' Wrap long axis labels
#'
#' Wraps discrete axis labels onto multiple lines. Labels with spaces wrap at
#' word boundaries; set `break_words = TRUE` to also insert breaks inside
#' long unbroken words.
#'
#' The preferred arguments are `width`, `break_words`, and `axis`:
#' `wrap_axis_text(width = 12)` or
#' `wrap_axis_text(width = 8, break_words = TRUE, axis = "y")`.
#' The older `add_space`/`column`/`num_text` arguments are kept for backward
#' compatibility.
#'
#' @param add_space Deprecated name for `break_words`.
#' @param column Deprecated and ignored (labels come from the plot's data).
#' @param num_text Deprecated name for `width`.
#' @param axis Which axis to wrap: `"x"` (default) or `"y"`.
#' @param width Target line width in characters (default 10).
#' @param break_words When `TRUE`, insert breaks inside long labels that have
#'   no spaces.
#'
#' @return A discrete x or y scale with wrapped labels.
#' @importFrom ggplot2 scale_x_discrete scale_y_discrete
#' @import stringr
#' @importFrom scales wrap_format
#' @export

wrap_axis_text <- function(add_space = FALSE, column = NULL, num_text = 10,
                           axis = c("x", "y"), width = NULL,
                           break_words = NULL) {
  axis <- match.arg(axis)
  if (is.null(width)) width <- num_text
  if (is.null(break_words)) break_words <- isTRUE(add_space)
  if (!is.numeric(width) || width < 1) {
    stop("`width` must be a positive number of characters.", call. = FALSE)
  }

  labeller <- if (break_words) {
    function(labels) {
      chunked <- gsub(paste0("(.{", width, "})"), "\\1 ", labels)
      str_wrap(sub("\\s+$", "", chunked), width = width)
    }
  } else {
    wrap_format(width)
  }

  if (axis == "x") {
    scale_x_discrete(labels = labeller)
  } else {
    scale_y_discrete(labels = labeller)
  }
}
