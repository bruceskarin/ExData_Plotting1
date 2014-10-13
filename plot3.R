plot3 <- function(){
                #Read the data and format the date and time data
                powerData <- read.delim("household_power_consumption.txt", sep = ";")
                powerData$Time <- as.POSIXct(paste(powerData$Date, powerData$Time), format = "%d/%m/%Y %H:%M:%S")
                
                
                #Subset data to specified days
                startDate <- as.POSIXct("2007-02-01")
                endDate <- as.POSIXct("2007-02-03")
                sub.powerData = subset(powerData, powerData$Time >= startDate &  powerData$Time < endDate)
                
                #Convert plot data to numberic
                sub.powerData$Sub_metering_1 <- as.numeric(sub.powerData$Sub_metering_1)
                sub.powerData$Sub_metering_2 <- as.numeric(sub.powerData$Sub_metering_2)
                sub.powerData$Sub_metering_3 <- as.numeric(sub.powerData$Sub_metering_3)
                
                #Create png file
                png(filename = "graph3.png", width=480, height=480)
                
                #plot line graph of sub metering power
                plot(sub.powerData$Time, sub.powerData$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab = NA, xaxt = "n")
                points(sub.powerData$Time, sub.powerData$Sub_metering_2, type = "l", col="red")
                points(sub.powerData$Time, sub.powerData$Sub_metering_3, type = "l", col="blue")
                axis.POSIXct(1, at=seq(startDate, endDate, by="day"), format="%a")
                legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
                
                #close device
                dev.off()
}