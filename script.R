setwd("/Users/loredp/Documents/Coursera/ExploratoryAnalysis/Project1")
dir()

library(lubridate)

data <- read.table("./household_power_consumption.txt", 
                   sep = ";", header = T, na.strings = "?",
                   colClasses = c("character", "character", "numeric", "numeric",
                                  "numeric", "numeric", "numeric", "numeric",
                                  "numeric"))

data$Date <- dmy(data$Date)
data_S <- subset(data, data$Date == dmy("01-02-2007") | data$Date == dmy("02-02-2007"))

png(filename = "plot1.png")
par(mar = c(5,5,3,1))
hist(data_S$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()
data_S$Time

data_S$fec <- strptime(paste(data_S[,1], data_S[,2], sep = ","), "%Y-%m-%d,%H:%M:%S")
    
png(filename = "plot2.png")
par(mar = c(3,5,2,1))
plot(data_S$fec, data_S$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = " ")
dev.off()

with(data_S, plot(data_S$fec, data_S$Sub_metering_1, type = "l"))
points(data_S$fec, data_S$Sub_metering_2, type = "l", col = "red")
points(data_S$fec, data_S$Sub_metering_3, type = "l", col = "blue")    


