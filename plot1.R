plot1 <- function(){
                #Read the data and format the date and time data
                powerData <- read.delim("household_power_consumption.txt", sep = ";")
                powerData$Date <- as.Date(powerData$Date, format = "%d/%m/%Y")
                powerData$Time <- as.POSIXct(powerData$Time, format = "%H:%M:%S")
                
                #Subset data to specified days
                startDate <- as.Date("2007-02-01")
                endDate <- as.Date("2007-02-02")
                sub.powerData = subset(powerData, powerData$Date >= startDate &  powerData$Date <= endDate)
                
                sub.powerData$Gobal_active_power <- as.numeric(sub.powerData$Global_active_power)/1000
                
                #Create png file
                png(filename = "graph1.png", width=480, height=480)
                
                #plot histogram of global active power
                hist(sub.powerData$Gobal_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
                
                #close device
                dev.off()
}