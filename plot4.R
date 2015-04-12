## plot4.R is to plot Global Active Power
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
dfSelected$Date <- as.Date(dfSelected$Date, "%d/%m/%Y")

datetime <- paste(dfSelected$Date, dfSelected$Time)

## add a new column called DateTime
dfSelected$DateTime <- as.POSIXct(datetime)

##open new device
dev.new()

## open the png device
png(filename = "plot4.png",  width=480, height=480, unit="px")

## plot graphs in 2 rows and 2 cols
par(mfrow =c(2, 2))

# 1st row 1st col
plot(dfSelected$Global_active_power ~ dfSelected$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# 1st row 2nd col
plot(dfSelected$Voltage ~ dfSelected$DateTime, type = "l", ylab = "Volatge", xlab = "datetime")

# 2nd row 1st col
plot(dfSelected$Sub_metering_1 ~ dfSelected$DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(dfSelected$Sub_metering_2 ~ dfSelected$DateTime, type = "l", col = "Red")
lines(dfSelected$Sub_metering_3 ~ dfSelected$DateTime, type = "l", col = "Blue")
## add legend
legend("topright", col = c("black", "red", "blue"), lwd = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 2nd row 2nd col
plot(dfSelected$Global_reactive_power ~ dfSelected$DateTime, type = "l", ylab = "Global_reactive_power", xlab = "datetime")


## close the device
dev.off()

