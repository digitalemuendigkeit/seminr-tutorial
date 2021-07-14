# This file extracts the slide comments into a txt file.

#' Extracts the slide headlines from a Rmd file
#'
#' @param filename path of the Rmd file
#'
#' @return a vector of lines from the slide noted
#' @export
#'
extract_headlines <- function(filename){

  # open input file
  con <- file(filename, open = "r")
  line <- readLines(con)

  # setup state machien
  state <- "start"
  comments <- list()
  skippable_lines <- c("!\\[", "\\.pull")

  header <- rmarkdown::yaml_front_matter(filename)

  comments[length(comments)+1] <- paste0("## ", header$title)
  last_head <- ""

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
      #comments[length(comments)+1] <- line[[i]]
      next
    }

    if (state == "comment" && line[[i]] == "-"){
      comments[length(comments)+1] <- last_head
      next
    }


    if (state == "comment" && any(stringr::str_starts(line[[i]], skippable_lines))){
      # figure
      state <- "body"
      next
    }

    # this is headline relevant ----
    if (state == "body"){
      if(stringr::str_starts(line[[i]], "# ")){
        last_head <- paste0("#", line[[i]])
        comments[length(comments)+1] <- last_head
      }
    }
  }

  close(con)
  unlist(comments)
}




#' Extracts the slide notes from a Rmd file
#'
#' @param filename path of the Rmd file
#' @param click_text the text to insert for transitionts (default: >>>)
#'
#' @return a vector of lines from the slide noted
#' @export
#'
extract_notes <- function(filename, click_text = ">>>", fortelepromter = "FALSE"){
  # open input file
  con <- file(filename, open = "r")
  line <- readLines(con)

  # setup state machien
  state <- "start"
  comments <- list()
  skippable_lines <- c("!\\[", "\\.pull")

  header <- rmarkdown::yaml_front_matter(filename)

  if (fortelepromter){
    comments[length(comments)+1] <- paste0("Countdown: \n")
    comments[length(comments)+1] <- paste0("\n")
    comments[length(comments)+1] <- paste0("1\n\n\n\n")
    comments[length(comments)+1] <- paste0("2\n\n\n\n")
    comments[length(comments)+1] <- paste0("3\n\n\n\n")
  }

  comments[length(comments)+1] <- paste0("Hello and welcome to this Video: ", header$title, "\n")
  comments[length(comments)+1] <- paste0("The slides in this presentation were created by: ", header$author, "\n")
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

  close(con)
  unlist(comments)
}


extract_all_notes <- function(input_files, output_files, telepromter = TRUE){
  output_files <- purrr::map_chr(input_files, ~stringr::str_replace(., ".Rmd", "_script.txt"))
  # get comments
  for(j in 1:length(input_files)){
    message(paste("Extracting notes from", input_files[[j]]))
    f_input <- input_files[[j]]
    fileConn <- file(output_files[[j]])
    # open input file
    comments <- extract_notes(f_input, fortelepromter = telepromter)

    writeLines(unlist(comments), fileConn)
    close(fileConn)
  }
}

extract_all_headlines <- function(input_files) {
  headline_files <- purrr::map_chr(input_files, ~stringr::str_replace(., ".Rmd", "_headline.txt"))

    # get headlines
  for(j in 1:length(input_files)){
    message(paste("Extracting headlines from", input_files[[j]]))
    f_input <- input_files[[j]]
    fileConn <- file(headline_files[[j]])
    # open input file
    comments <- extract_headlines(f_input)

    writeLines(unlist(comments), fileConn)
    close(fileConn)
  }
}




