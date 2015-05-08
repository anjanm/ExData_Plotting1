## Read the file data into a data frame, set the correct format of the Date column
power <- read.csv("household_power_consumption.txt", 
                  sep = ";", 
                  na.strings = "?", 
                  stringsAsFactors = FALSE)
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

## Create a new data frame with a subset of necessary dates for the plots
plotdf <- subset(power, power$Date %in% as.Date(c('2007-02-01', '2007-02-02')))

## Combine Date and Time columns to plot outcomes for each min; convert as char
plotdf <- transform(plotdf, 
                    DateTime = as.character(paste(plotdf$Date, plotdf$Time, sep = " ")))

## Convert the new DateTime column to POSIXlt format, so R can figure out x-axis
plotdf$DateTime <- strptime(plotdf$DateTime, "%Y-%m-%d %H:%M:%S")

## Create the plot in a PNG device; close the device at the end
png(file = "plot2.png", width = 480, height = 480)

plot(plotdf$DateTime, 
     plotdf$Global_active_power, 
     type = "l",
     xlab = "", 
     ylab = "Global Active Power (kilowatts)"
)

dev.off()