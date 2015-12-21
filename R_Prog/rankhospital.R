####
# This is a function to find best hospital in a state.
#
# Input:
#   state: State name in 2 letter abbr.
#   input: disease/medical condition. i.e "heart attack"/"heart failure"/"pneumonia"
#   num:   "best"/"worst"/numeric value indicating the nth best rank.
# 
# Output:
#   a character vector of best hospital. NA if out of bounds.
####

rankhospital <- function(state, input, num = "best") {
  
  # Read the data from file.
  outcome <- read.csv("./assignment_3/outcome-of-care-measures.csv", colClasses = "character")
  
  # Vectorize possible states and conditions.
  possible.conditions <- c("heart attack", "heart failure", "pneumonia")
  possible.states <- unique(outcome[,7])
  
  # Check for the validity of condition
  if(0 == length(possible.conditions[possible.conditions == input])) {
    stop("invalid outcome")
  } 
  
  # Check for validity of State.
  if(0 == length(possible.states[possible.states == state])) {
    stop("invalid state")
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
  
  # Get the state specific outcome subset.
  good.out <- na.omit(subset(outcome, outcome$State == state, 
                                  select = c(2, condition.index)))
  
  
  good.out[,2] <- suppressWarnings(as.numeric(good.out[,2]))
  colnames(good.out) <- c("Hospital.Name", "Rate")
   
  good.sorted <- na.omit(good.out[order(good.out$Rate, good.out$Hospital.Name),])
  
  good.index <- 0
  if (num == "best") {
    good.index <- 1
  } else if (num == "worst") {
    good.index <- nrow(good.sorted)
  } else {
    good.index <- as.numeric(num)
  }
  
  good.sorted[good.index, 1]
}