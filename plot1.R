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


# Generate Plot 1
png(filename = "plot1.png", width = 480, height = 480)

hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
title(main = "Global Active Power")

dev.off()