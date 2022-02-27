run_analysis<-function()
{
  library(dplyr)
  source("read_X_file.R")
  source("get_names.R")
  
  ### Merges the training and the test sets to create one data set
  XTest  <- read_X_file("test/X_test.txt")
  XTrain <- read_X_file("train/X_train.txt")
  dataSet <- rbind(XTest, XTrain)
  rm(XTest, XTrain)
  
  ### Labels the data set with descriptive variables names (the same used originally)
  ### And also extracts only the measurements on the mean and standard deviation for each measurement
  names(dataSet) <- get_names("features.txt")
  dataSet<-select(dataSet, contains("mean()"), contains("std()"))
  names(dataSet)<-gsub("()","",names(dataSet),fixed=TRUE)
  names(dataSet)<-gsub("-",".",names(dataSet),fixed=TRUE)
  
  ### Fetches activity data and labels, and includes them in the dataset
  YTest  <- readLines("test/Y_test.txt")
  YTrain <- readLines("train/Y_train.txt")
  Y <- as.factor(c(YTest, YTrain))
  levels(Y)<-get_names("activity_labels.txt")
  dataSet<-cbind(activity=Y,dataSet)
  rm(YTest, YTrain)
  
  ### Fetches subject numbers and includes them in the dataset
  subjectTest  <- readLines("test/subject_test.txt")
  subjectTrain <- readLines("train/subject_train.txt")
  subjects <- as.numeric(c(subjectTest, subjectTrain))
  dataSet<-cbind(subjects, dataSet)
  rm(subjectTest, subjectTrain, subjects)
  
  ### Lastly, creates an independant dataset (overallMeanSubjectActivity) with the average of each variable
  ### for each activity and each subject. That makes 6 lines per subject: 1 for each activity
  dataPerSubject<-split(dataSet, dataSet$subjects)
  dataPerActivityPerSubject<-lapply(dataPerSubject, function(x){split(x, x$activity)})
  dataPerActivityPerSubjectMean<-lapply(dataPerActivityPerSubject, function(x){lapply(x, function(y) { colMeans(mutate(y, activity=as.numeric(activity)))})})
  overallMeanSubjectActivity<-data.frame(do.call(rbind, lapply(dataPerActivityPerSubjectMean, function(x){do.call(rbind, x)})))
  rownames(overallMeanSubjectActivity)<-NULL
  overallMeanSubjectActivity[,"activity"]<-as.factor(overallMeanSubjectActivity[,"activity"])
  levels(overallMeanSubjectActivity[,"activity"])<-levels(Y)
  overallMeanSubjectActivity
 
}