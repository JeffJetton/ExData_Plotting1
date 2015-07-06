# Project 1 - plot3.R

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
                          
# This plot will require parsing the date/time info
data$dtm <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")




###################################
####        Create Plot        ####
###################################

png("plot3.png")  # 480x480 is the default

# Plot initial line (submeter 1)
plot(data$dtm, data$Sub_metering_1, type="l",
     xlab=NA, ylab="Energy sub metering")
# Add submeters 2 & 3
lines(data$dtm, data$Sub_metering_2, col="red")
lines(data$dtm, data$Sub_metering_3, col="blue")
# Add legend
legend("topright", legend=names(data)[7:9],
       col=c("black", "red", "blue"), lty=1)
     
dev.off()

