## plot2.R is to plot Global Active Power
## Using sqldf library
library(sqldf)

## Open a file connection to household_power_consumption.txt
## The household_power_consumption.txt needs to be in the same folder as this R file.
fileCon <- file("household_power_consumption.txt") 


## select data for given dates instead of reading the entire file.
dfSelected <- sqldf("select * from fileCon where (Date = '1/2/2007' or Date = '2/2/2007')", file.format = list(header = TRUE, sep = ";"))

## Close the file connection
close(fileCon)

## convert the Date and Time columns Date/Time classes.
dfSelected$Date <- as.Date(sqldf$Date, "%d/%m/%Y")

datetime <- paste(dfSelected$Date, dfSelected$Time)

## add a new column called DateTime
dfSelected$DateTime <- as.POSIXct(datetime)

## open the png device
png(filename = "plot3.png")

## plot line graph with legend

plot(dfSelected$Sub_metering_1 ~ dfSelected$DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(dfSelected$Sub_metering_2 ~ dfSelected$DateTime, type = "l", col = "Red")
lines(dfSelected$Sub_metering_3 ~ dfSelected$DateTime, type = "l", col = "Blue")

## add legend

legend("topright", col = c("black", "red", "blue"), lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


## close the device
dev.off()

