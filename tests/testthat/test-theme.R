test_that("theme_cgd is a complete theme with brand elements", {
  th <- theme_cgd()
  expect_s3_class(th, "theme")
  expect_true(attr(th, "complete"))
  expect_identical(th$legend.position, "right")
  expect_s3_class(th$plot.subtitle, "element_text")
  expect_s3_class(th$plot.caption, "element_text")
  expect_s3_class(th$strip.text, "element_text")
  expect_false(isTRUE(all.equal(as.numeric(th$panel.spacing), 0)))
})

test_that("set_theme is an alias for theme_cgd", {
  expect_identical(set_theme(), theme_cgd())
})

test_that("themed charts with facets, subtitle, and caption build cleanly", {
  p <- ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg)) +
    ggplot2::geom_point() +
    ggplot2::facet_wrap(~cyl) +
    ggplot2::labs(title = "T", subtitle = "S", caption = "C") +
    theme_cgd()
  expect_no_error(ggplot2::ggplot_build(p))
})

test_that("setup_plot and reset_plot round-trip session state", {
  old_theme <- ggplot2::theme_get()
  old_option <- getOption("ggplot2.discrete.fill")
  old_bar_fill <- find_geom("bar")$default_aes$fill

  setup_plot()
  expect_false(is.null(getOption("ggplot2.discrete.fill")))
  expect_identical(find_geom("bar")$default_aes$fill,
                   load_cgd_colors()[["light_teal"]])

  reset_plot()
  expect_identical(getOption("ggplot2.discrete.fill"), old_option)
  expect_identical(find_geom("bar")$default_aes$fill, old_bar_fill)
  expect_identical(ggplot2::theme_get(), old_theme)

  expect_message(reset_plot(), "nothing to reset")
})

test_that("cgd_fonts resolves a full role set", {
  fonts <- cgd_fonts()
  expect_named(fonts, c("title", "regular", "medium", "light"))
  expect_true(all(vapply(fonts, is.character, logical(1))))
})
