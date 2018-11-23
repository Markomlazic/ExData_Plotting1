# Downloading and loading data
html <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(html, destfile = "power_data.zip")
unzip("power_data.zip")
power_data <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
power_data$Date <- strptime(power_data$Date, format = "%d/%m/%Y")
red_data <- subset(power_data, Date == "2007-02-01" | Date == "2007-02-02")
red_data$time_date <- as.POSIXct(paste(red_data$Date, red_data$Time), format="%Y-%m-%d %H:%M:%S")

# Creating and saving the plot
png("plot2.png", width = 480, height = 480)
plot(data = red_data, Global_active_power ~ time_date, type = "l", ylab = "Global Active Power (kilowatts)", xlab = NA, font.lab = 2)
dev.off()
