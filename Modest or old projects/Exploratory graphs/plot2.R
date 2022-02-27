plot2<-function()
{
  library(lubridate)
  
  png("plot2.png")
  rawData<-read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses = c("character", "character", "character", "character", "character", "character", "character", "character", "character"), na.strings="?")
  rawData$Date<-dmy(rawData$Date)
  data<-subset(rawData, Date>=ymd("2007-02-01") & Date<=ymd("2007-02-02"))
  data$Date<-ymd_hms(paste(data$Date, data$Time, sep=" "))
  data$Global_active_power<-as.numeric(data$Global_active_power)
  data<-subset(data, !is.na(data$Global_active_power), )
  
  with(data, plot(Date, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
  dev.off()
}