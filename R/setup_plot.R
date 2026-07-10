#' Set CGD plotting defaults for the current R session
#'
#' Applies the CGD theme, geom defaults, and default ggplot2 scales for the
#' rest of the session. The state it replaces is snapshotted on the first
#' call, and [reset_plot()] restores it.
#'
#' For a single plot, prefer the composable equivalents: `+ theme_cgd()` and
#' `+ scale_colour_cgd()` / `+ scale_fill_cgd()`.
#'
#' @return Invisibly returns `NULL`.
#' @importFrom ggplot2 theme_set theme_get update_geom_defaults
#'   scale_colour_gradient scale_fill_gradient
#' @export

setup_plot <- function() {
  colors <- cgd_colors_internal()

  geom_defaults <- cgd_geom_defaults()
  snapshot_session(names(geom_defaults))

  ggplot2::theme_set(theme_cgd())

  for (geom in names(geom_defaults)) {
    ggplot2::update_geom_defaults(geom, geom_defaults[[geom]])
  }

  options(ggplot2.discrete.fill = function(...) scale_fill_cgd(...))
  options(ggplot2.discrete.colour = function(...) scale_colour_cgd(...))

  gradient_custom_colour <- function() {
    scale_colour_gradient(low = colors[["light_teal"]],
                          high = colors[["gold"]])
  }
  gradient_custom_fill <- function() {
    scale_fill_gradient(low = colors[["light_teal"]],
                        high = colors[["gold"]])
  }

  options(ggplot2.continuous.colour = gradient_custom_colour)
  options(ggplot2.continuous.fill = gradient_custom_fill)

  invisible(NULL)
}

#' Restore the plotting defaults replaced by setup_plot()
#'
#' Puts back the theme, geom defaults, and ggplot2 scale options that were in
#' effect before the first [setup_plot()] call in this session.
#'
#' @return Invisibly returns `NULL`.
#' @export

reset_plot <- function() {
  snap <- .cgd_session$snapshot
  if (is.null(snap)) {
    message("setup_plot() has not been called this session; nothing to reset.")
    return(invisible(NULL))
  }

  ggplot2::theme_set(snap$theme)
  for (geom in names(snap$geoms)) {
    assign("default_aes", snap$geoms[[geom]], envir = find_geom(geom))
  }
  options(snap$options)
  .cgd_session$snapshot <- NULL

  invisible(NULL)
}

# Default aesthetics applied to each geom by setup_plot(). Covers the geoms
# CGD charts commonly use so that none falls back to off-brand ggplot
# defaults (see also theme_cgd() for theme elements).
cgd_geom_defaults <- function() {
  colors <- cgd_colors_internal()
  fonts <- cgd_fonts()
  r_to_pt <- ggplot2::.pt

  list(
    text = list(family = fonts$light, fontface = "italic", size = 12 / r_to_pt),
    label = list(family = fonts$light, fontface = "italic", size = 12 / r_to_pt),
    bar = list(fill = colors[["light_teal"]]),
    col = list(fill = colors[["light_teal"]]),
    point = list(colour = colors[["light_teal"]], size = 3),
    line = list(colour = colors[["light_teal"]], linewidth = 4 / r_to_pt),
    step = list(colour = colors[["light_teal"]], linewidth = 1),
    path = list(colour = colors[["light_teal"]], linewidth = 1),
    boxplot = list(fill = colors[["teal_gray"]], colour = colors[["light_teal"]]),
    errorbar = list(colour = colors[["light_teal"]]),
    density = list(fill = colors[["light_teal"]]),
    violin = list(fill = colors[["light_teal"]]),
    area = list(fill = colors[["light_teal"]]),
    ribbon = list(fill = colors[["light_blue"]]),
    segment = list(colour = colors[["light_teal"]]),
    tile = list(fill = colors[["light_teal"]]),
    smooth = list(colour = colors[["light_teal"]], fill = colors[["light_gray"]]),
    sf = list(fill = colors[["light_teal"]], colour = "white", linewidth = 0.1)
  )
}

# Session-state snapshot so reset_plot() can undo setup_plot().
.cgd_session <- new.env(parent = emptyenv())

cgd_option_keys <- c(
  "ggplot2.discrete.fill", "ggplot2.discrete.colour",
  "ggplot2.continuous.colour", "ggplot2.continuous.fill"
)

snapshot_session <- function(geom_names) {
  if (!is.null(.cgd_session$snapshot)) {
    return(invisible(NULL))
  }
  .cgd_session$snapshot <- list(
    theme = ggplot2::theme_get(),
    geoms = stats::setNames(
      lapply(geom_names, function(geom) find_geom(geom)$default_aes),
      geom_names
    ),
    options = stats::setNames(
      lapply(cgd_option_keys, getOption),
      cgd_option_keys
    )
  )
  invisible(NULL)
}

find_geom <- function(name) {
  obj <- paste0("Geom", toupper(substring(name, 1, 1)), substring(name, 2))
  get(obj, envir = asNamespace("ggplot2"))
}
