# Pick al slides and create PDFS
# Extract PDF Pages and PNGS
# Extract matching script
# Generat Website pages

# where?

src_path <- here::here("slides")
fig_out_path <- here::here("website", "figs")
files <- dir(src_path, pattern = "*.html", recursive = T, full.names = T)
rmd_files <- dir(src_path, pattern = "*.Rmd", recursive = T, full.names = T)

for(i in 1:length(rmd_files)){
  message(paste0("Preparing RMD:", rmd_files[i]))
  rmarkdown::render(rmd_files[i])
}




for (i in 1:length(files)){

# which file?
  fname <- files[i]
  src_file <- fname
  message(paste0("Rendering file: ", basename(src_file)))

  # create pdf
  pdf_file <- paste0(stringr::str_replace(fname, "html", "pdf"))
  pagedown::chrome_print(src_file,output=pdf_file)

  info <- pdftools::pdf_info(pdf_file)

  target_dir <- paste0(fig_out_path, "/", xfun::sans_ext(basename(fname)))
  if(!dir.exists(target_dir)){
    dir.create(target_dir)
  }
  png_names <- paste0(target_dir,"/slide_",sprintf("%02d", 1:info$pages), ".png")
  pdftools::pdf_convert(pdf_file, filenames = png_names, antialias = TRUE, dpi = 150)
}



# Finally, render the site
rmarkdown::render_site("website")
