library(dplyr)

if (!"lubridate" %in% rownames(installed.packages())){
  install.packages('lubridate')
}

library(lubridate)


fullData<-read.table(file='household_power_consumption.txt',sep = ';',stringsAsFactors = FALSE,header = TRUE)

getOneDateFormat<-function(fullData){
  arrive<-dmy(fullData$Date) + hms(fullData$Time)
  
  return(arrive)
  
}
par(mfrow=c(1,1))

fullData$fullDate<-getOneDateFormat(fullData)

fullData$Global_active_power<-as.numeric(fullData$Global_active_power)

fullData$Global_reactive_power<-as.numeric(fullData$Global_reactive_power)


fullData$Voltage<-as.numeric(fullData$Voltage)

fullData$Global_intensity<-as.numeric(fullData$Global_intensity)

fullData$Sub_metering_1<-as.numeric(fullData$Sub_metering_1)

fullData$Sub_metering_2<-as.numeric(fullData$Sub_metering_2)

fullData$Sub_metering_3<-as.numeric(fullData$Sub_metering_3)

date1<-as.POSIXct(as.Date("2007-02-01 00:00:00"),tz = "BRT")
date2<- as.POSIXct(as.Date("2007-02-03 00:00:00"), tz= "BRT")

betweenDates<-filter(fullData,fullDate>=date1,fullDate<date2)
dim(betweenDates)


plot(betweenDates$fullDate,betweenDates$Global_active_power,type = 'l',xlab = "", ylab = "Global Active Power (Kilowats)")


dev.copy(png,'plot2.png')
dev.off()
