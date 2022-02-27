## Function that gets an X file (test or training) and returns a dataframe


read_X_file <- function(path)
{
  X<-readLines(path)
  X<-strsplit(X, " ")
  X<-lapply(X, as.numeric)
  
  ## This works correctly, but for some reason sapply returns the transpose of the matrix I want
  ## So I just transpose it to get the right one, and then make it a dataframe
  X<-data.frame(t(sapply(X, function(x){x[!is.na(x)]})))
  
  X
}