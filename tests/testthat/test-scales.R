test_that("scale_colour_cgd and scale_fill_cgd build discrete scales", {
  df <- data.frame(x = 1:3, y = 1:3, g = letters[1:3])
  p <- ggplot2::ggplot(df, ggplot2::aes(x, y, colour = g)) +
    ggplot2::geom_point() +
    scale_colour_cgd()
  built <- ggplot2::ggplot_build(p)
  used <- unique(built$data[[1]]$colour)
  expect_length(used, 3)
  expect_true(all(used %in% cgd_palette("categorical")))
})

test_that("more categories than palette colors fails loudly", {
  df <- data.frame(x = 1:9, y = 1:9, g = letters[1:9])
  p <- ggplot2::ggplot(df, ggplot2::aes(x, y, colour = g)) +
    ggplot2::geom_point() +
    scale_colour_cgd()
  expect_error(ggplot2::ggplot_build(p), "needs 9 colors")
})

test_that("scale_fill_cgd supports lighten and reverse", {
  pal_fun <- scale_fill_cgd(lighten = 0.5)$palette
  expect_false(any(pal_fun(3) %in% cgd_palette("categorical")))
  pal_rev <- scale_fill_cgd(reverse = TRUE)$palette
  expect_identical(pal_rev(8), rev(as.character(cgd_palette("categorical"))))
})

test_that("continuous CGD scales interpolate the palette", {
  df <- data.frame(x = 1:5, y = 1:5, v = 1:5)
  p <- ggplot2::ggplot(df, ggplot2::aes(x, y, colour = v)) +
    ggplot2::geom_point() +
    scale_colour_cgd(palette = "sequential3", discrete = FALSE)
  expect_s3_class(p$scales$scales[[1]], "ScaleContinuous")
  expect_no_error(ggplot2::ggplot_build(p))
})

test_that("unknown palettes error with the available names", {
  expect_error(scale_fill_cgd("nope"), "Available palettes")
})
