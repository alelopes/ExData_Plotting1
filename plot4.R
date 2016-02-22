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










par(mfrow=c(2,2))

plot(betweenDates$fullDate,betweenDates$Global_active_power,type = 'l',xlab = "", ylab = "Global Active Power")


with(betweenDates,plot(fullDate,Voltage,type = 'l' ,ylab = "Voltage"))

plot_colors <- c("black","red","blue")

plot(betweenDates$fullDate,betweenDates$Sub_metering_1,col=plot_colors[1],type = 'l', xlab = "", ylab = "Energy Sub Metering")

legend("topright",c("Sub_metering_1   ","Sub_metering_2   ","Sub_metering_3   "), lty = 1, col = plot_colors,cex = 0.8)

lines(betweenDates$fullDate,betweenDates$Sub_metering_2, 
      col=plot_colors[2],type = 'l')


lines(betweenDates$fullDate,betweenDates$Sub_metering_3, 
      col=plot_colors[3], type = 'l')


with(betweenDates,plot(fullDate,Global_reactive_power,type = 'l',xlab = "fullDate", ylab = "Global Active Power"))

dev.copy(png,'plot4.png')
dev.off()

