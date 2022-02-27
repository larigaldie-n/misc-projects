best<-function(state, outcome)
{
  ## Reading data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Checking that state and outcome are valid
  possibleOutcomes <- c("heart attack", "heart failure", "pneumonia")
  if (!is.character(state) || !(state %in% data$State))
  {
    stop("invalid state")
  }
  if (!is.character(outcome) || !(outcome %in% possibleOutcomes))
  {
    stop("invalid outcome")
  }
  
  ## Clean the data for future usage
  ## First get the column necessary for the outcome we are interested (along with hospital name and state)
  if (outcome=="heart attack") outcomeColumn=11
  else if (outcome=="heart failure") outcomeColumn=17
  else outcomeColumn=23
  data <- data[,c(2,7,outcomeColumn)]
  colnames(data) <- c("Hospital.Name", "State", outcome)
  
  ## Then only keep data from the state we're interested in, and ensure our data is in numerical form
  data <- data[data[,"State"]==state,]
  suppressWarnings(data[,outcome]<-as.numeric(data[,outcome]))
  
  ## Check if we have the necessary info and return the first hospital when ordered by rank, then hospital name
  if(all(is.na(data[,outcome])))
  {
    stop("Hospitals in this state have no data for this outcome")
  }
  else
  {
    data <- data[order(data[,outcome], data[,"Hospital.Name"]),]
    data[1, "Hospital.Name"]
  }
}