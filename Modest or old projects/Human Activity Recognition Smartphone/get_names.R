get_names<-function(path)
{
  names <- readLines(path)
  names <- strsplit(names, " ")
  
  ## Get only the second character string (numbers are uninformative as they are the same as the vector's index)
  names <- sapply(names, function(x) {x[2]})
  
  ## Check if future column names have duplicates (and change them is so)
  if(!all(isFALSE(duplicated(names))))
  {
    featNamesDup<-unique(names[duplicated(names)])
    for (i in seq_along(featNamesDup))
    {
      featDupI<-which(names==featNamesDup[i])
      for (j in seq_along(featDupI))
      {
        names[featDupI[j]]<-paste(names[featDupI[j]], as.character(j), sep=" ")
      }
    }
  }
  names
}