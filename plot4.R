plot4 <- function(){
                #Read the data and format the date and time data
                powerData <- read.delim("household_power_consumption.txt", sep = ";")
                powerData$Time <- as.POSIXct(paste(powerData$Date, powerData$Time), format = "%d/%m/%Y %H:%M:%S")
                
                
                #Subset data to specified days
                startDate <- as.POSIXct("2007-02-01")
                endDate <- as.POSIXct("2007-02-03")
                sub.powerData = subset(powerData, powerData$Time >= startDate &  powerData$Time < endDate)
                
                #Convert plot data to numberic
                sub.powerData$Global_active_power <- as.numeric(sub.powerData$Global_active_power)/1000
                sub.powerData$Voltage <- as.numeric(sub.powerData$Voltage)
                sub.powerData$Sub_metering_1 <- as.numeric(sub.powerData$Sub_metering_1)
                sub.powerData$Sub_metering_2 <- as.numeric(sub.powerData$Sub_metering_2)
                sub.powerData$Sub_metering_3 <- as.numeric(sub.powerData$Sub_metering_3)
                sub.powerData$Global_reactive_power <- as.numeric(sub.powerData$Global_reactive_power)/1000
                
                #Create png file
                png(filename = "graph4.png", width=480, height=480)
                
                #set multifunction plotting
                par(mfrow = c(2, 2))
                
                #plot line graph of gobal active power
                plot(sub.powerData$Time, sub.powerData$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab = NA, xaxt = "n")
                axis.POSIXct(1, at=seq(startDate, endDate, by="day"), format="%a")
                
                #plot voltage
                plot(sub.powerData$Time, sub.powerData$Voltage, type = "l", ylab="Voltage", xlab = "datetime", xaxt = "n")
                axis.POSIXct(1, at=seq(startDate, endDate, by="day"), format="%a")
                
                #plot line graph of sub metering power
                plot(sub.powerData$Time, sub.powerData$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab = NA, xaxt = "n")
                points(sub.powerData$Time, sub.powerData$Sub_metering_2, type = "l", col="red")
                points(sub.powerData$Time, sub.powerData$Sub_metering_3, type = "l", col="blue")
                axis.POSIXct(1, at=seq(startDate, endDate, by="day"), format="%a")
                legend("topright", lwd = 1, col = c("black", "red", "blue"), bty="n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
                
                #plot global reactive power
                plot(sub.powerData$Time, sub.powerData$Global_reactive_power, type = "l", ylab="Global Reactive Power (kilowatts)", xlab = "datetime", xaxt = "n")
                axis.POSIXct(1, at=seq(startDate, endDate, by="day"), format="%a")
                
                #close device
                dev.off()
}