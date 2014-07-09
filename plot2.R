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

png(filename = "plot2.png")
par(mar = c(4,5,2,2))
plot(data_S$fec, data_S$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = " ")
dev.off()
