####
# This is a function to compute mean of "pollutant" among the given id's
#
# Input:
#   threshold is an integer vector indicating complete observations.
#   directory is the location of the CSV files under getwd().
# 
# Output:
#   a numeric vector of correlations
#
#
# Disclaimer: I've used some of the concepts/tricks from FAQ mentioned in
# https://github.com/derekfranks/practice_assignment/blob/master/Practice_Assignment.pdf
####

corr <- function(directory, threshold = 0) {
  
  
  # Let us get the list of all files in the directory.
  all_files <- list.files(directory, full.names = TRUE)
  id <- 1:332
  # Now, Get the subset files that we are interested in, only.
  # This is to optimize the memory required.
  # NOTE: ID inside the dataset in each CSV file is same as the filename itself.
  files_of_interest <- all_files[id]
  
  # Read the contents of files_of_interest, make it a single data frame.
  content_vector <- lapply(files_of_interest, read.csv)
  cont <- do.call(rbind, content_vector)
  
  #cont_NA <- complete.cases(cont)
  content <- cont[complete.cases(cont),] # Get the clean and complete data.
  
  # Create an empty matrix with length(id) rows and 2 coulmns.
  # Assign column names.
  out_len <- length(id)
  output <- matrix(0, out_len, 3)
  colnames(output) <- c("id", "nobs", "corr")
  
  i <- 1
  
  while (i <= out_len) {
    output[i, 1] <- id[i]
    tmp_cont <- content[which(content$ID == id[i]),]
    output[i, 2] <- nrow(tmp_cont)
    output[i, 3] <- cor(tmp_cont$sulfate, tmp_cont$nitrate)
    i <- i + 1
  }
  out <- as.data.frame(output)
  final <- out[which(out$nobs > threshold), ]

  final$corr  
   
}