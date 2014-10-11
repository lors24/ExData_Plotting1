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
# subset the data to the dates that we are interested in

png(filename = "plot1.png")
par(mar = c(4.9,5,3,1))
hist(data_S$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()
