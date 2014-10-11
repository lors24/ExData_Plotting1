#Read libraries
library(lubridate)

fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(fileUrl, temp, method = "curl")
data <- read.table(unz(temp, "household_power_consumption.txt"), 
                   sep = ";", header = T, na.strings = "?",
                   colClasses = c("character", "character", "numeric", "numeric",
                                  "numeric", "numeric", "numeric", "numeric",
                                  "numeric"))
unlink(temp)

data$Date <- dmy(data$Date)
data_S <- subset(data, data$Date == dmy("01-02-2007") | data$Date == dmy("02-02-2007"))
rownames(data_S) <- NULL
data_S$fec <- strptime(paste(data_S[,1], data_S[,2], sep = ","), "%Y-%m-%d,%H:%M:%S")
data_S$Date <- NULL
data_S$Time <- NUL

png(filename = "plot4.png")
par(mfrow = c(2,2), mar = c(4,4,2,1), oma= c(0,0,2,0))
with(data_S, {
    plot(fec, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
    plot(fec, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
    plot(fec, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    points(data_S$fec, data_S$Sub_metering_2, type = "l", col = "red")
    points(data_S$fec, data_S$Sub_metering_3, type = "l", col = "blue")    
    legend("topright", lwd = 3, col = c("black","red", "blue"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(fec, Global_reactive_power, xlab = "datetime", type = "l")
})
dev.off()
