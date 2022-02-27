getFileName <- function(directory, id)
{
  ## File names (without the extension) are always 3 characters wide, with 0s
  ## filling the left side if id is too short. This is a simple function to make
  ## sure we get the right path and file name whatever the id length
  
  ## 'directory' is a character vector of length 1 indicating the location of the CSV file
  
  ## 'id' is an integer vector of length 1 indicating the monitor ID number
  
  if(nchar(as.character(id))==1)
  {
    dirFile<-file.path(directory, paste("00", as.character(id), ".csv", sep=""))
  }
  else if(nchar(as.character(id))==2)
  {
    dirFile<-file.path(directory, paste("0", as.character(id), ".csv", sep=""))
  }
  else
  {
    dirFile<-file.path(directory, paste(as.character(id), ".csv", sep=""))
  }
  dirFile
}