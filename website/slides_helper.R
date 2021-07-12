

#' Generates the slides to show on each website
#'
#' @param associated_file the base file to use (no file extension)
#'
#' @return nothing, all output it directed to cat (not a good idea)
#' @export
print_slide_md <- function(associated_file){

  base_path <- basename(associated_file)
  fig_path <- here::here("website", "figs", base_path)
  fig_short_path <- paste0("figs/", base_path, "/")
  slides <- dir(fig_path, pattern = "*.png")

  script_file <- here::here("slides", paste0(associated_file, "_script.txt"))
  lines <- readLines(script_file)

  line_count <- 1
  for(i in 1:length(slides)){
    cat("\n## Slide ")
    cat(paste(i,"\n\n\n"))

    fig_filename <- paste0(fig_short_path, slides[i])

    cat(paste0('![](',fig_filename,')\n'))
    if(line_count <= length(lines)){
      while (lines[line_count] != ">>>") {
        cat(lines[line_count])
        cat("\n")
        line_count <- line_count + 1
      }
      line_count <- line_count + 1
    }
  }
}

#print_slide_md("basics/20_basics-data-prep")
