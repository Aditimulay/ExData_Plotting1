## plot1.R is to plot Global Active Power
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
png(filename = "plot1.png")

## plot histogram
hist(dfSelected$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")

## close the device
dev.off()

