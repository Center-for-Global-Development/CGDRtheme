#' CGD color and fill scales
#'
#' Apply a CGD palette to a single plot without changing session defaults.
#' Discrete scales fail with an informative error when the chart needs more
#' colors than the palette provides, rather than silently recycling colors.
#'
#' @param palette Name of a CGD palette; one of the names returned by
#'   [load_cgd_palette()], e.g. `"categorical"`, `"sequential3"`,
#'   `"polar2"`, or `"stoplight"`.
#' @param discrete Use a discrete scale (the default) or interpolate the
#'   palette into a continuous gradient.
#' @param reverse Reverse the palette order.
#' @param lighten Amount to lighten the palette colors, between 0 and 1
#'   (e.g. `scale_fill_cgd(lighten = 0.5)` for boxplot fills).
#' @param ... Passed on to [ggplot2::discrete_scale()] or
#'   [ggplot2::scale_colour_gradientn()] / [ggplot2::scale_fill_gradientn()].
#'
#' @return A ggplot scale object.
#' @importFrom ggplot2 discrete_scale scale_colour_gradientn scale_fill_gradientn
#' @importFrom colorspace lighten
#' @export

scale_colour_cgd <- function(palette = "categorical", discrete = TRUE,
                             reverse = FALSE, lighten = 0, ...) {
  cgd_scale("colour", palette, discrete, reverse, lighten, ...)
}

#' @rdname scale_colour_cgd
#' @export
scale_color_cgd <- scale_colour_cgd

#' @rdname scale_colour_cgd
#' @export
scale_fill_cgd <- function(palette = "categorical", discrete = TRUE,
                           reverse = FALSE, lighten = 0, ...) {
  cgd_scale("fill", palette, discrete, reverse, lighten, ...)
}

cgd_scale <- function(aesthetic, palette, discrete, reverse, lighten, ...) {
  pal <- cgd_palettes_internal()[[palette]]
  if (is.null(pal)) {
    stop("Unknown CGD palette \"", palette, "\". Available palettes: ",
         paste(names(cgd_palettes_internal()), collapse = ", "), ".",
         call. = FALSE)
  }
  if (reverse) pal <- rev(pal)
  if (lighten > 0) pal <- colorspace::lighten(pal, lighten)

  if (discrete) {
    ggplot2::discrete_scale(aesthetic, palette = cgd_discrete_palette(pal, palette), ...)
  } else if (aesthetic == "colour") {
    ggplot2::scale_colour_gradientn(colours = pal, ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = pal, ...)
  }
}

# Returns a palette function that fails loudly instead of recycling colors:
# repeated colors would assign the same color to different categories, which
# misleads readers.
cgd_discrete_palette <- function(pal, palette_name) {
  force(pal)
  force(palette_name)
  function(n) {
    if (n > length(pal)) {
      stop("The chart needs ", n, " colors but the CGD \"", palette_name,
           "\" palette has only ", length(pal), ". Combine smaller ",
           "categories (e.g. into an \"Other\" group), facet the chart, ",
           "or encode the extra categories some other way.",
           call. = FALSE)
    }
    pal[seq_len(n)]
  }
}
