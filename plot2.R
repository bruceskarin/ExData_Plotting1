plot3 <- function(){
                #Read the data and format the date and time data
                powerData <- read.delim("household_power_consumption.txt", sep = ";")
                powerData$Time <- as.POSIXct(paste(powerData$Date, powerData$Time), format = "%d/%m/%Y %H:%M:%S")
                
                
                #Subset data to specified days
                startDate <- as.POSIXct("2007-02-01")
                endDate <- as.POSIXct("2007-02-03")
                sub.powerData = subset(powerData, powerData$Time >= startDate &  powerData$Time < endDate)
                
                #Convert plot data to numberic and kilowatts
                sub.powerData$Global_active_power <- as.numeric(sub.powerData$Global_active_power)/1000
                
                #Create png file
                png(filename = "graph2.png", width=480, height=480)
                
                #plot line graph of gobal active power
                plot(sub.powerData$Time, sub.powerData$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab = NA, xaxt = "n")
                axis.POSIXct(1, at=seq(startDate, endDate, by="day"), format="%a")
                
                #points(sub.powerData$Time, sub.powerData$Gobal_active_power, type = "l")
                
                #close device
                dev.off()
}