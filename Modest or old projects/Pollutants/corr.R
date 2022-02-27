corr<-function(directory, threshold=0)
{
  ## 'directory' is a character vector of length 1 indicating the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the number of completely
  ## observed observations (on all variables) required to comute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Returns a numeric vector of correlations
  
  data<-data.frame()
  dataComplete<-complete(directory)
  monitorsPassThreshold<-dataComplete[["id"]][dataComplete[["nobs"]]>threshold]
  vecCor<-vector("numeric")
 
  for(i in seq_along(monitorsPassThreshold))
  {
    dirFile<-getFileName(directory, monitorsPassThreshold[i])
    dataRaw<-read.csv(dirFile)
    completeData<-complete.cases(dataRaw)
    data<-dataRaw[completeData,]
    vecCor<-c(vecCor, cor(data[["sulfate"]], data[["nitrate"]]))
  }
  vecCor
}