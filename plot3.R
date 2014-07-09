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

data_S$fec <- strptime(paste(data_S[,1], data_S[,2], sep = ","), "%Y-%m-%d,%H:%M:%S")

png(filename = "plot3.png")
par(mar = c(3,4,2,2))
with(data_S, {
    plot(fec, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    points(fec, Sub_metering_2, type = "l", col = "red")
    points(fec, Sub_metering_3, type = "l", col = "blue")    
legend("topright", lwd = 1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.off()
