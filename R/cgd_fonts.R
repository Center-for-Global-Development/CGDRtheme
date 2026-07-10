# Internal font resolution for CGD charts.
#
# The brand font is Sofia Pro, which is commercially licensed and cannot be
# bundled with the package. When it is not available on the machine, Poppins
# is fetched from Google Fonts into the user's font directory (a per-user
# download -- no system-level install or admin rights required). Resolution
# runs once per session and is cached.
#
# The resolved set maps font roles to registered family names:
#   title   -- plot titles, used with face = "bold"
#   regular -- axis text
#   medium  -- axis and legend titles
#   light   -- data labels, annotations, legend text; used with face = "italic"

.cgd_fonts_cache <- new.env(parent = emptyenv())

cgd_fonts <- function() {
  if (is.null(.cgd_fonts_cache$set)) {
    .cgd_fonts_cache$set <- resolve_cgd_fonts()
  }
  .cgd_fonts_cache$set
}

resolve_cgd_fonts <- function() {
  if (font_family_exists("Sofia Pro")) {
    return(font_set("Sofia Pro"))
  }

  # require_font() downloads into tempdir() by default, which would re-fetch
  # Poppins every session; keep the files in a persistent per-user cache and
  # register any previously cached copies first.
  font_dir <- tools::R_user_dir("CGDtheme", "data")
  dir.create(font_dir, recursive = TRUE, showWarnings = FALSE)
  cached <- list.files(font_dir, pattern = "\\.(ttf|otf)$", full.names = TRUE)
  if (length(cached)) {
    tryCatch(systemfonts::add_fonts(cached), error = function(e) NULL)
  }

  fetched <- tryCatch(
    systemfonts::require_font("Poppins", fallback = "sans", dir = font_dir,
                              error = FALSE),
    error = function(e) FALSE
  )
  if (isTRUE(fetched)) {
    message(
      "CGDtheme: Sofia Pro is not installed on this machine; ",
      "charts will use Poppins (from Google Fonts) instead."
    )
    return(font_set("Poppins"))
  }

  warning(
    "CGDtheme: neither Sofia Pro nor Poppins is available; ",
    "charts will use the default sans font.",
    call. = FALSE
  )
  list(title = "sans", regular = "sans", medium = "sans", light = "sans")
}

font_family_exists <- function(family) {
  family %in% systemfonts::system_fonts()$family ||
    family %in% systemfonts::registry_fonts()$family
}

font_set <- function(base) {
  list(
    title = base,
    regular = base,
    medium = font_weight_variant(base, "Medium", "medium"),
    light = font_weight_variant(base, "Light", "light")
  )
}

# Some Sofia Pro installs expose one family per weight ("Sofia Pro Medium");
# use those directly when present. Otherwise register a named variant so
# ggplot can reach weights beyond plain/bold.
font_weight_variant <- function(base, suffix, weight) {
  standalone <- paste(base, suffix)
  if (font_family_exists(standalone)) {
    return(standalone)
  }
  variant <- paste("CGDtheme", standalone)
  if (!font_family_exists(variant)) {
    tryCatch(
      systemfonts::register_variant(name = variant, family = base, weight = weight),
      error = function(e) NULL
    )
  }
  if (font_family_exists(variant)) variant else base
}
