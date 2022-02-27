plot4<-function()
{
  library(lubridate)
  
  png("plot4.png")
  rawData<-read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses = c("character", "character", "character", "character", "character", "character", "character", "character", "character"), na.strings="?")
  rawData$Date<-dmy(rawData$Date)
  data<-subset(rawData, Date>=ymd("2007-02-01") & Date<=ymd("2007-02-02"))
  data$Date<-ymd_hms(paste(data$Date, data$Time, sep=" "))
  data$Global_active_power<-as.numeric(data$Global_active_power)
  data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
  data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
  data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
  data$Voltage<-as.numeric(data$Voltage)
  data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
  
  
  par(mfcol=c(2,2))
  
  with(data, plot(Date, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
  
  with(data, plot(Date, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
  lines(data$Date, data$Sub_metering_2, col="red")
  lines(data$Date, data$Sub_metering_3, col="blue")
  legend("topright", bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))
  
  with(data, plot(Date, Voltage, xlab="datetime", type="l"))
  with(data, plot(Date, Global_reactive_power, xlab="datetime", type="l"))
  
  dev.off()
}