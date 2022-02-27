complete <- function(directory, id=1:332)
{
  ## 'directory' is a character vector of length 1 indicating the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers to be used
  
  ## Returns a data frame of the form:
  ## id nobs
  ## 1 117
  ## 2 1041
  ## ...
  ## Where 'id' is the monitor ID number and 'nobs' is the number of complete cases
  
  dataComplete=data.frame()
  for(i in seq_along(id))
  {
    dirFile<-getFileName(directory, id[i])
    dataRaw<-read.csv(dirFile)
    nComplete<-sum(complete.cases(dataRaw))
    dataComplete<-rbind(dataComplete, cbind(id[i], nComplete))
  }
  colnames(dataComplete)<-c("id", "nobs")
  dataComplete
}