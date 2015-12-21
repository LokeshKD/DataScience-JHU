####
# This is a function to find best hospital in all states.
#
# Input:
#   state: State name in 2 letter abbr.
#   input: disease/medical condition. i.e "heart attack"/"heart failure"/"pneumonia"
#   num:   "best"/"worst"/numeric value indicating the nth best rank.
# 
# Output:
#   a data frame of hospitals and their states.
####

rankall <- function(input, num = "best") {
  
  # Read the data from file.
  outcome <- read.csv("./assignment_3/outcome-of-care-measures.csv", colClasses = "character")
  
  # Vectorize possible states and conditions.
  possible.conditions <- c("heart attack", "heart failure", "pneumonia")
  possible.states <- unique(outcome[,7])
  
  # Check for the validity of condition
  if(0 == length(possible.conditions[possible.conditions == input])) {
    stop("invalid outcome")
  } 
  
  # Initialize condition index based on "input".
  condition.index <- which(possible.conditions == input)
  
  # Compute the actual index mapping to outcome.
  if (condition.index == 1) {
    condition.index <- 11 # Column index for "heart attack" in outcome data frame.
  } else if (condition.index == 2) {
    condition.index <- 17 # Column index for "heart failure" in outcome data frame.
  } else if (condition.index == 3) {
    condition.index <- 23 # Column index for "pneumonia" in outcome data frame.
  } else {
    stop("invalid outcome index")
  }
  
  # Create an empty martix with 2 columns and rows equal to no of states.
  final.martix <- matrix("",length(possible.states),3)
  colnames(final.martix) <- c("hospital", "state", "rate")
  
  final.index <- 1
  
  # Loop through all states, fill the final.martix.
  while (final.index <= length(possible.states)) {
    
    # Get the state specific outcome subset, sorted based on Rate and hospital name.
    good.out <- subset(outcome, outcome$State == possible.states[final.index], 
                       select = c(2, 7, condition.index))
    
    good.out[,3] <- suppressWarnings(as.numeric(good.out[,3]))
    # Sort based on rate in 3rd column and hospital.name in 1st column.
    good.sorted <- good.out[order(good.out[,3], good.out[,1]),]
  
    good.index <- 0
    if (num == "best") {
      good.index <- 1
    } else if (num == "worst") {
      good.index <- nrow(good.sorted) 
    } else {
      good.index <- as.numeric(num)
    }
    
    # Fill the matrix with desired elements.
    final.martix[final.index,1] <- good.sorted[good.index,1]
    final.martix[final.index,2] <- possible.states[final.index]
    final.martix[final.index,3] <- good.sorted[good.index,3]
    
    final.index <- final.index + 1 # increment the counter.
    
  } # End of while loop.
  
  # Assign rownames, convert it to data.frame and return the subset of interest.
  # Sorted based on rate and hospital.name
  rownames(final.martix) <- final.martix[,2]
  final.frame <- as.data.frame(final.martix[order(final.martix[,2]),])
  subset(final.frame, select = c(1:2))
  
}