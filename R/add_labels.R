#' Add data labels using CGD defaults
#'
#' Labels are placed according to the chart type:
#'
#' * `"bar"`: above positive bars and below negative bars.
#' * `"stacked"`: centered in each segment, formatted as a percentage, with
#'   the label color flipping to white on dark segments. The plot must map
#'   `fill` in its plot-level `aes()` so the text layer can see each
#'   segment's fill color.
#' * `"line"`: next to the line ends via `ggrepel`. Rows with `NA` labels are
#'   skipped, and the legend is hidden since the lines are labeled directly.
#'
#' @param label Unquoted column in the plot data to use for label text
#'   (e.g. `add_labels(len, "bar")`). A detached vector such as `df$len` also
#'   works for backward compatibility, but a column reference is safer
#'   because it follows any filtering, reordering, or faceting of the plot
#'   data.
#' @param chart_type One of `"bar"`, `"stacked"`, or `"line"`.
#'
#' @return A ggplot layer (or list of layer and theme) for use with `+`.
#' @importFrom ggplot2 geom_text aes position_stack theme after_stat after_scale
#' @importFrom ggrepel geom_text_repel
#' @importFrom rlang enquo
#' @import scales
#' @export

add_labels <- function(label, chart_type) {
  label <- rlang::enquo(label)

  if(chart_type == "bar") {
    geom_text(aes(label = !!label,
                  vjust = after_stat(ifelse(y < 0, 1.5, -0.5))))
  } else if(chart_type == "stacked") {
    geom_text(aes(label = scales::percent(!!label, accuracy = 1),
                  colour = after_scale(contrast_ink(fill))),
              position = position_stack(vjust = .5)
    )
  } else if(chart_type == "line") {
    fonts <- cgd_fonts()
    list(
      geom_text_repel(aes(label = !!label),
                      nudge_x = 0.1,
                      na.rm = TRUE,
                      family = fonts$light,
                      fontface = "italic",
                      segment.color = NA),
      theme(legend.position = "none")
    )
  } else {
    stop('`chart_type` must be one of "bar", "stacked", or "line".')
  }
}

# `y` and `fill` are computed columns referenced inside after_stat()/
# after_scale(); declare them so R CMD check knows they are not globals.
utils::globalVariables(c("y", "fill"))

# Pick a label ink with enough contrast against a segment fill: white on
# dark fills, near-black on light ones. Uses WCAG relative luminance.
contrast_ink <- function(fill) {
  channels <- grDevices::col2rgb(fill) / 255
  channels <- ifelse(channels <= 0.04045,
                     channels / 12.92,
                     ((channels + 0.055) / 1.055)^2.4)
  luminance <- 0.2126 * channels[1, ] + 0.7152 * channels[2, ] +
    0.0722 * channels[3, ]
  unname(ifelse(luminance < 0.2, "#FFFFFF",
                cgd_colors_internal()[["teal_black"]]))
}
