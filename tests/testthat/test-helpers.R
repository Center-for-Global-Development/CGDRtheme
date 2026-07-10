test_that("add_labels returns the right layer types", {
  expect_s3_class(add_labels(len, "bar"), "ggproto")
  expect_s3_class(add_labels(len, "stacked"), "ggproto")
  line <- add_labels(len, "line")
  expect_type(line, "list")
  expect_length(line, 2)
  expect_identical(line[[2]]$legend.position, "none")
})

test_that("add_labels rejects unknown chart types", {
  expect_error(add_labels(len, "pie"), "must be one of")
})

test_that("add_labels works with any label column name on line charts", {
  df <- data.frame(x = rep(1:3, 2), y = c(1:3, 4:6),
                   g = rep(c("a", "b"), each = 3))
  df$series_name <- ifelse(df$x == 3, df$g, NA)
  p <- ggplot2::ggplot(df, ggplot2::aes(x, y, group = g)) +
    ggplot2::geom_line(ggplot2::aes(colour = g)) +
    add_labels(series_name, "line")
  expect_no_error(ggplot2::ggplot_build(p))
})

test_that("bar labels place above positive and below negative bars", {
  df <- data.frame(x = c("a", "b"), y = c(5, -5))
  p <- ggplot2::ggplot(df, ggplot2::aes(x, y)) +
    ggplot2::geom_col() +
    add_labels(y, "bar")
  built <- ggplot2::ggplot_build(p)
  vjust <- built$data[[2]]$vjust
  expect_identical(vjust, c(-0.5, 1.5))
})

test_that("contrast_ink flips label ink on dark fills", {
  expect_identical(contrast_ink("#006970"), "#FFFFFF")
  expect_identical(contrast_ink("#FEE8BF"),
                   load_cgd_colors()[["teal_black"]])
  expect_length(contrast_ink(c("#006970", "#FEE8BF")), 2)
})

test_that("add_separator_line validates its arguments", {
  expect_s3_class(add_separator_line("vertical", 3), "ggproto")
  expect_s3_class(add_separator_line("horizontal", 3), "ggproto")
  expect_error(add_separator_line("diagonal", 3), "should be one of")
  expect_error(add_separator_line("vertical"), "required")
})

test_that("add_grid_lines returns a theme for every flag combination", {
  expect_s3_class(add_grid_lines(), "theme")
  expect_s3_class(add_grid_lines(horizontal = TRUE), "theme")
  expect_s3_class(add_grid_lines(horizontal = TRUE, vertical = TRUE), "theme")
  expect_error(add_grid_lines(horizontal = "yes"), "TRUE or FALSE")
})

test_that("add_annotations validates by type", {
  expect_s3_class(
    add_annotations("text", text = "hi", text_x_position = 1,
                    text_y_position = 2),
    "ggproto")
  expect_s3_class(
    add_annotations("segment",
                    segment_x_position_start = 1, segment_x_position_end = 2,
                    segment_y_position_start = 1, segment_y_position_end = 2),
    "ggproto")
  expect_error(add_annotations("text"), "need")
  expect_error(add_annotations("segment"), "need")
  expect_error(add_annotations("arrow"), "should be one of")
})

test_that("wrap_axis_text supports both axes and legacy arguments", {
  x_scale <- wrap_axis_text(width = 8)
  expect_s3_class(x_scale, "ScaleDiscretePosition")
  y_scale <- wrap_axis_text(width = 8, axis = "y")
  expect_true("x" %in% x_scale$aesthetics)
  expect_true("y" %in% y_scale$aesthetics)
  legacy <- wrap_axis_text(add_space = TRUE, column = letters, num_text = 4)
  expect_true("x" %in% legacy$aesthetics)
  expect_identical(legacy$labels("abcdefgh"), "abcd\nefgh")
  expect_error(wrap_axis_text(width = 0), "positive")
})

test_that("add_legend defaults work and hide the title", {
  lg <- add_legend()
  expect_identical(lg$legend.position, "right")
  expect_s3_class(lg$legend.title, "element_blank")
})

test_that("change_boxplot_color composes a lightened fill scale", {
  df <- data.frame(x = c("a", "b"), y = c(1, 2))
  p <- ggplot2::ggplot(df, ggplot2::aes(x, y, fill = x)) +
    ggplot2::geom_boxplot()
  expect_s3_class(change_boxplot_color(p), "ggplot")
  expect_error(change_boxplot_color("not a plot"), "ggplot object")
})
