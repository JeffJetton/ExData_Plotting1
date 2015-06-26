# Project 1 - plot1.R

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



###################################
####        Create Plot        ####
###################################

png("plot1.png")  # 480x480 is the default
hist(data$Global_active_power, col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()

