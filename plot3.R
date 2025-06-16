library(data.table)

# Load data
zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_file <- "household_power_consumption.zip"
data_file <- "household_power_consumption.txt"

if (!file.exists(data_file)) {
    if (!file.exists(zip_file)) {
        download.file(zip_url, destfile = zip_file, mode = "wb")
    }
    unzip(zip_file)
}

data <- fread(data_file, na.strings = "?", sep = ";")

# Filter only on necessary dates
data <- data[data$Date %in% c("1/2/2007", "2/2/2007")]

# Create a DateTime variable with Date/Time classes
data[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]


# Generate Plot 3
png(filename = "plot3.png", width = 480, height = 480)

with(data, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", xaxt = "n"))
axis.POSIXct(1, at = c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00"), format = "%a")
with(data, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(data, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1 , col = c("black", "red", "blue"))

dev.off()