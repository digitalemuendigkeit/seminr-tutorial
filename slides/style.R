# this contains the xaringang styler information

library(xaringanthemer)
#warning(paste0("Rendering for video?",params$videoSlides))

darkgreen <- "#002901"
rwthblue <- "#C7DDF2"
base_color <- rwthblue
white_color <- "#F0F0F0"
link_color <- rwthblue

bkg <- darkgreen

if(!params$videoSlides) {
  bkg <-  "#000000"
}

style_mono_dark(
  base_color = rwthblue,
  background_color = bkg,

  title_slide_background_color = bkg,
  text_color = white_color,
  header_color = rwthblue,
  #background_image = bkg,
  text_bold_color = rwthblue,
  text_slide_number_color = rwthblue,
  padding = "16px 64px 16px 64px",
  code_highlight_color = "rgba(255,255,0,0.5)",
  code_inline_color = rwthblue,
  code_inline_font_size = "1em",
  inverse_background_color = darkgreen,
  inverse_text_color = white_color,
  inverse_text_shadow = FALSE,
  inverse_header_color = white_color,
  inverse_link_color = link_color,
  title_slide_text_color = white_color,
  footnote_color = NULL,
  footnote_font_size = "0.9em",
  footnote_position_bottom = "60px",
  left_column_subtle_color = apply_alpha(base_color, 0.6),
  left_column_selected_color = base_color,
  blockquote_left_border_color = apply_alpha(base_color, 0.5),
  table_border_color = "#666",
  table_row_border_color = "#ddd",
  table_row_even_background_color = darken_color(base_color, 0.8),
  base_font_size = "26px",
  text_font_size = "1rem",
  header_h1_font_size = "2.25rem",
  header_h2_font_size = "1.75rem",
  header_h3_font_size = "1.25rem",
  header_background_auto = FALSE,
  header_background_color = rwthblue,
  header_background_text_color = darkgreen,
  header_background_padding = NULL,
  header_background_content_padding_top = "7rem",
  header_background_ignore_classes = c("normal", "inverse", "title", "middle", "bottom"),
  text_slide_number_font_size = "0.75em",
  text_font_family = xaringanthemer_font_default("text_font_family"),
  text_font_weight = xaringanthemer_font_default("text_font_weight"),
  text_font_url = xaringanthemer_font_default("text_font_url"),
  text_font_family_fallback = xaringanthemer_font_default("text_font_family_fallback"),
  text_font_base = "sans-serif",
  header_font_family = xaringanthemer_font_default("header_font_family"),
  header_font_weight = xaringanthemer_font_default("header_font_weight"),
  header_font_family_fallback = "Georgia, serif",
  header_font_url = xaringanthemer_font_default("header_font_url"),
  code_font_family = xaringanthemer_font_default("code_font_family"),
  code_font_size = "0.9rem",
  code_font_url = xaringanthemer_font_default("code_font_url"),
  code_font_family_fallback = xaringanthemer_font_default("code_font_family_fallback"),

  header_font_google = google_font("Fira Sans"),
  text_font_google   = google_font("Fira Sans", "300", "300i"),
  code_font_google   = google_font("Fira Mono")
)

thm <- seminr_theme_dark()
thm$plot.bgcolor <- "transparent"
seminr_theme_set(thm)


our_blue <- "#004488"
our_red <- "#994455"
