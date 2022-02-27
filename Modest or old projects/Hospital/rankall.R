rankall <- function(outcome, num="best")
{
  ## Best just means first position in an ordered list
  if (num=="best")
  {
    num=1
  }
  
  ## Reading data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Checking that outcome is valid
  possibleOutcomes <- c("heart attack", "heart failure", "pneumonia")
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
  colnames(data) <- c("hospital", "state", outcome)
  
  ## Then ensure our data is in numerical form and split data by state (gets a list of data frames by state)
  suppressWarnings(data[,outcome]<-as.numeric(data[,outcome]))
  dataSplit <- split(data,data[,"state"])
  
  ## For each of these data frames/states, get hospital ranked "num" for this outcome
  for (i in seq_along(dataSplit))
  {
    dataState <- dataSplit[[i]][order(dataSplit[[i]][,outcome], dataSplit[[i]][,"hospital"]),]
    dataState <- dataState[complete.cases(dataState),]
    numHospital=num
    if (numHospital=="worst")
    {
      numHospital=nrow(dataState)
    }
    if (nrow(data)<numHospital)
    {
      dataState <- data.frame(cbind("hospital"=NA, "state"=names(dataSplit)[i]))
    }
    else
    {
      dataState <- data.frame(cbind("hospital"=dataState[numHospital,"hospital"], "state"=names(dataSplit)[i]))
    }
    row.names(dataState) <- names(dataSplit)[i]
    dataSplit[[i]] <- dataState
  }
  ## unsplit the list, and return a data frame
  do.call(rbind, dataSplit)
}