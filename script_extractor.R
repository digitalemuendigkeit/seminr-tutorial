# This file extracts the slide comments into a txt file.

library(tidyverse)

input_files <- dir("slides", pattern = "*.Rmd", recursive = T, full.names = T)
output_files <- input_files %>% map_chr(~str_replace(., ".Rmd", "_script.txt"))

for(j in 1:length(input_files)){
  f_input <- input_files[[j]]
  fileConn <- file(output_files[[j]])
  # open input file
  con <- file(f_input, open = "r")
  line <- readLines(con)

  # setup state machien
  state <- "start"
  comments <- list()
  skippable_lines <- c("!\\[", "\\.pull")
  click_text <- ">>>"

  header <- rmarkdown::yaml_front_matter(input_files[[j]])

  comments[length(comments)+1] <- paste0("Hello and welcome to this Video: ", header$title)
  comments[length(comments)+1] <- paste0("\nThe slides in this presentation were created by: ", header$author)
  comments[length(comments)+1] <- paste0("\n", click_text, "\n")

  for (i in 1:length(line)){
    #print(paste(state, line[[i]]))
    if (state == "start" && line[[i]]=="---"){
      state <- "yaml"
      next
    }
    if (state == "yaml" && line[[i]]=="---"){
      state <- "body"
      next
    }
    if (state == "body" && stringr::str_starts(line[[i]],"```")){
      state <- "chunk"
      next
    }
    if (state == "chunk" && stringr::str_starts(line[[i]],"```")){
      state <- "body"
      next
    }
    if (state == "body" && stringr::str_starts(line[[i]],"\\?\\?\\?")){
      state <- "comment"
      next
    }
    if (state == "comment" && stringr::str_starts(line[[i]],"--")){
      state <- "body"
      comments[length(comments)+1] <- click_text
      next
    }

    if (state == "comment" && line[[i]] == "-"){
      comments[length(comments)+1] <- click_text
      next
    }


    if (state == "comment" && any(stringr::str_starts(line[[i]], skippable_lines))){
      # figure
      state <- "body"
      next
    }

    # this is relevant ----
    if (state == "comment"){
      comments[length(comments)+1] <- line[[i]]
    }
  }

  #print(comments %>% unlist())
  if(!is.null(comments %>% unlist())){
    writeLines(comments %>% unlist(), fileConn)
  }
  close(fileConn)
  close(con)
}






