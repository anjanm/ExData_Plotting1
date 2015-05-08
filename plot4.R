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
png(file = "plot4.png", width = 480, height = 480)

## Create the 4x4 canvas
par(mfrow = c(2,2))

## First plot: topleft
plot(plotdf$DateTime, 
     plotdf$Global_active_power, 
     type = "l",
     xlab = "", 
     ylab = "Global Active Power"
)

## Second plot: topright
plot(plotdf$DateTime, 
     plotdf$Voltage, 
     type = "l",
     xlab = "datetime", 
     ylab = "Voltage"
)

## Third plot: bottomleft

    ## Create the shell first
    plot(plotdf$DateTime, 
         plotdf$Sub_metering_1, 
         type = "n",
         xlab = "", 
         ylab = "Energy sub metering"
    )
    
    ## Now add the points
    points(plotdf$DateTime, plotdf$Sub_metering_1, col = "black", type = "l")
    points(plotdf$DateTime, plotdf$Sub_metering_2, col = "red", type = "l")
    points(plotdf$DateTime, plotdf$Sub_metering_3, col = "blue", type = "l")
    
    ## Add the legend
    legend("topright", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col = c("black", "red", "blue"), 
           pch = "-")

## Fourth plot: bottomright
plot(plotdf$DateTime, 
     plotdf$Global_reactive_power, 
     type = "l",
     xlab = "datetime", 
     ylab = "Global_reactive_power"
)

dev.off()