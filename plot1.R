## Read the file data into a data frame, set the correct format of the Date column
power <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?", stringsAsFactors = FALSE)
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

## Create a new data frame with a subset of necessary dates for the plots
plotdf <- subset(power, power$Date %in% as.Date(c('2007-02-01', '2007-02-02')))

## Create the plot in a PNG device; close the device at the end
png(file = "plot1.png", width = 480, height = 480)

hist(plotdf$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     col = "red", 
     main = "Global Active Power")

dev.off()