####
# This is a function to compute mean of "pollutant" among the given id's
#
# Input:
#   pollutant could be either of sulphate/nitrate.
#   id is an integer vector indicating the monitor ID numbers.
#   directory is the location of the CSV files under getwd().
# 
# Output:
#   mean of "pollutant" among the observations represented by "id"
#
#
# Disclaimer: I've used some of the concepts/tricks from FAQ mentioned in
# https://github.com/derekfranks/practice_assignment/blob/master/Practice_Assignment.pdf
####


pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  
  # Let us get the list of all files in the directory.
  all_files <- list.files(directory, full.names = TRUE)
  
  # Now, Get the subset files that we are interested in, only.
  # This is to optimize the memory required.
  # NOTE: ID inside the dataset in each CSV file is same as the filename itself.
  files_of_interest <- all_files[id]
  
  # Read the contents of files_of_interest
  content_vector <- lapply(files_of_interest, read.csv)
  
  content <- do.call(rbind, content_vector)
   
  #Return the mean of the "pollutant"
  mean(content[,pollutant], na.rm = TRUE)
  
}