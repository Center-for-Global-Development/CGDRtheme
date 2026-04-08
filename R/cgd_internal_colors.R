# Internal CGD brand colors and palettes used throughout the package.

cgd_colors_internal <- function() {
  c(
    teal = "#0B4C5B",
    gold = "#FFB52C",
    teal_gray = "#85A5AD",
    light_teal = "#006970",
    cream = "#F3F6F7",
    dark_gray = "#394649",
    teal_black = "#1A272A",
    blue = "#2D99B5",
    light_blue = "#BFDEE0",
    light_gold = "#FEE8BF",
    light_gray = "#DFE0E2",
    red = "#D15553",
    green = "#00896C"
  )
}

cgd_palettes_internal <- function() {
  colors <- cgd_colors_internal()

  list(
    categorical = c(
      colors[["light_teal"]],
      colors[["gold"]],
      colors[["blue"]],
      colors[["light_blue"]],
      colors[["light_gold"]],
      colors[["teal_gray"]],
      colors[["dark_gray"]],
      colors[["light_gray"]]
    ),
    sequential1 = c(colors[["light_teal"]]),
    sequential2 = c(colors[["light_blue"]], colors[["light_teal"]]),
    sequential3 = c(
      colors[["light_gray"]],
      colors[["light_blue"]],
      colors[["light_teal"]]
    ),
    sequential4 = c(
      colors[["light_gray"]],
      colors[["light_blue"]],
      colors[["light_teal"]],
      colors[["dark_gray"]]
    ),
    sequential8 = c(
      colors[["light_gray"]],
      colors[["teal_gray"]],
      colors[["light_blue"]],
      colors[["blue"]],
      colors[["light_teal"]],
      colors[["teal"]],
      colors[["dark_gray"]],
      colors[["teal_black"]]
    ),
    polar1 = c(colors[["light_teal"]]),
    polar2 = c(colors[["light_teal"]], colors[["gold"]]),
    polar3 = c(
      colors[["light_teal"]],
      colors[["teal_gray"]],
      colors[["gold"]]
    ),
    polar4 = c(
      colors[["light_teal"]],
      colors[["teal_gray"]],
      colors[["light_gold"]],
      colors[["gold"]]
    ),
    polar5 = c(
      colors[["light_teal"]],
      colors[["teal_gray"]],
      colors[["light_blue"]],
      colors[["light_gold"]],
      colors[["gold"]]
    ),
    stoplight = c(
      colors[["green"]],
      colors[["gold"]],
      colors[["red"]]
    )
  )
}
