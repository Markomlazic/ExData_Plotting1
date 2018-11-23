# Downloading and loading data
html <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(html, destfile = "power_data.zip")
unzip("power_data.zip")
power_data <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
power_data$Date <- strptime(power_data$Date, format = "%d/%m/%Y")
red_data <- subset(power_data, Date == "2007-02-01" | Date == "2007-02-02")
red_data$time_date <- as.POSIXct(paste(red_data$Date, red_data$Time), format="%Y-%m-%d %H:%M:%S")

# Creating and saving the plot
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

# plot 1
plot(data = red_data, Global_active_power ~ time_date, type = "l", ylab = "Global Active Power", xlab = NA, font.lab = 2)

# plot 2
plot(data = red_data, Voltage ~ time_date, type = "l", xlab = "datetime", font.lab = 2)

# plot 3
plot(data = red_data, Sub_metering_1 ~ time_date, col = "black", type = "l", xlab = NA, ylab = NA)
lines(data = red_data, Sub_metering_2 ~ time_date, col = "red", type = "l", xlab = NA, ylab = NA)
lines(data = red_data, Sub_metering_3 ~ time_date, col = "blue", type = "l", xlab = NA, ylab = NA)
title(ylab = "Energy sub metering", font.lab = 2)
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), lwd=c(1,1,1), col=c("black", "red", "blue"), box.lwd = 0)

# plot 4
plot(data = red_data, Global_reactive_power ~ time_date, type = "l", xlab = "datetime", font.lab = 2)

dev.off()

