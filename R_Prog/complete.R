####
# This is a function to compute a data frame with the given id's
#
# Input:
#   id is an integer vector indicating the monitor ID numbers.
#   directory is the location of the CSV files under getwd().
# 
# Output:
#   data frame of the form:
#   # id nobs
#   # 1  117
#   # 2  1041
#
#
# Disclaimer: I've used some of the concepts/tricks from FAQ mentioned in
# https://github.com/derekfranks/practice_assignment/blob/master/Practice_Assignment.pdf
####

complete <- function(directory, id = 1:332) {
  
  
  # Let us get the list of all files in the directory.
  all_files <- list.files(directory, full.names = TRUE)
  
  # Now, Get the subset files that we are interested in, only.
  # This is to optimize the memory required.
  # NOTE: ID inside the dataset in each CSV file is same as the filename itself.
  files_of_interest <- all_files[id]
  
  # Read the contents of files_of_interest, make it a single data frame.
  content_vector <- lapply(files_of_interest, read.csv)
  cont <- do.call(rbind, content_vector)
  
  cont_NA <- complete.cases(cont)
  content <- cont[cont_NA,]
  
  # Create an empty matrix with length(id) rows and 2 coulmns.
  # Assign column names.
  out_len <- length(id)
  output <- matrix(0, out_len, 2)
  colnames(output) <- c("id", "nobs")
  
  i <- 1
  
  while (i <= out_len) {
    output[i, 1] <- id[i]
    output[i, 2] <- nrow(content[which(content$ID == id[i]),])
    i <- i + 1
  }
  
  # return the output as a data frame.
  as.data.frame(output)
  
}

