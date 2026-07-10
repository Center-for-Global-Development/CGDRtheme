test_that("load_cgd_colors returns the full named color set", {
  colors <- load_cgd_colors()
  expect_type(colors, "character")
  expect_length(colors, 13)
  expect_true(all(grepl("^#[0-9A-Fa-f]{6}$", colors)))
  expect_true(all(c("teal", "gold", "light_teal", "teal_black") %in% names(colors)))
})

test_that("load_cgd_palette returns all palettes built from brand colors", {
  palettes <- load_cgd_palette()
  expect_type(palettes, "list")
  expect_true(all(c("categorical", "sequential3", "polar2", "stoplight") %in%
                    names(palettes)))
  expect_length(palettes$categorical, 8)
  expect_true(all(unlist(palettes) %in% load_cgd_colors()))
})

test_that("cgd_palette subsets and interpolates", {
  expect_length(cgd_palette("categorical"), 8)
  expect_length(cgd_palette("categorical", 3), 3)
  expect_length(cgd_palette("sequential3", 10, type = "continuous"), 10)
})

test_that("cgd_palette fails loudly on bad input", {
  expect_error(cgd_palette("nonexistent"), "not found")
  expect_error(cgd_palette("categorical", 10), "greater than")
})
