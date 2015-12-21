####
# This is a function to find best hospital in a state.
#
# Input:
#   State name in 2 letter abbr.
#   disease/medical condition. i.e "heart attack"/"heart failure"/"pneumonia"
# 
# Output:
#   a character vector of best hospital.
####

best <- function(state, input) {
  
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
  
  # Get the state specific outcome subset, omitting incomplete observations.
  outcome.state <- na.omit(subset(outcome, outcome$State == state, select = c(2,condition.index)))
  
  # Convert the condition.index column to numeric.
  outcome.state[,2] <- suppressWarnings(as.numeric(outcome.state[,2]))
  
  # Compute the minimum condition rate in condition.index from outcome.state.
  min.cond <- min(outcome.state[,2], na.rm = TRUE)
  
  Hospital.Name <- outcome.state[which(outcome.state[,2] == min.cond),1]
  sort(Hospital.Name)[1]
}