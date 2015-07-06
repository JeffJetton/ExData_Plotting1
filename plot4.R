# Project 1 - plot4.R

###################################
####    Read and clean data    ####
###################################

# Assume that the data is in the current working directory
filepath <- "household_power_consumption.txt"

# Read in the table, starting at the first row of the
# section of data we actually need to use. Read only
# two days of data (assuming a sample every minute)
data <- read.table(filepath, sep=";", na.strings="?",
                   colClasses=c("character", "character", rep("numeric", 7)),
                   nrows=2 * 24 * 60, skip=66637)     
                            
# Since we skipped the header, we'll go back and get it
names(data) <- read.table(filepath, colClasses="character",
                          sep=";", nrows=1)
                          
# These plots will require parsing the date/time info
data$dtm <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")




###################################
####        Create Plots       ####
###################################

png("plot4.png")  # 480x480 is the default

# Set up the graphics device for a 2x2 plot
savepar <- par(mfrow=c(2,2))

# Upper-left plot
plot(data$dtm, data$Global_active_power, type="l",
     xlab=NA, ylab="Global Active Power")
     
# Upper-right plot
plot(data$dtm, data$Voltage, type="l",
     xlab="datetime", ylab="Voltage")
     
# Lower-left plot
# Plot initial line (submeter 1)
plot(data$dtm, data$Sub_metering_1, type="l",
     xlab=NA, ylab="Energy sub metering")
# Add submeters 2 & 3
lines(data$dtm, data$Sub_metering_2, col="red")
lines(data$dtm, data$Sub_metering_3, col="blue")
# Add legend
legend("topright", legend=names(data)[7:9],
       col=c("black", "red", "blue"), lty=1,
       bty="n")
       
# Lower-right plot
plot(data$dtm, data$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")
     
# Restore previous graphics configuration
par(savepar)
     
dev.off()

