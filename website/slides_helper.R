

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
  headline_file <- here::here("slides", paste0(associated_file, "_headline.txt"))
  lines <- readLines(script_file)
  headlines <- readLines(headline_file)

  cat("\n# Slide download \n\n\n")
  cat(paste0("You can download the slides in this presentation [here](pdfs/", base_path ,".pdf).\n\n"))

  cat(paste0("# Slides\n\n"))
  cat("Here, you can find the slides from the video. Under each slide you can find the script for that slide.\n\n")

  line_count <- 1
  for(i in 1:length(slides)){
    cat(headlines[i])
    #cat("\n## Slide ")
    cat(paste0(" (",i,"/",length(slides),") {.unlisted .unnumbered}\n\n\n"))



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

    cat(paste0("<br/><br/><br/>\n\n\n"))
  }
}

#print_slide_md("basics/20_basics-data-prep")
