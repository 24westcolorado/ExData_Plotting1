#------------------------------------------------------------------------------
#
# Plot 4 file
#
#------------------------------------------------------------------------------
# 1.  Load the data,
# 2.  Construct Plot 4, 
# 3.  Save it to a png file. 
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# 1.  Load the data and reduce the dataset to only the dates from 2007-02-01 to
#     2007-02-02

data      <- read.table("household_power_consumption.txt",header=TRUE,sep = ";")

# Convert the data from day/month/year to data object
data$Date <- strptime(data$Date,"%d/%m/%Y")
data$Date <- as.Date(data$Date)

# Reduce to the dates of interest
lwr_date  <- as.Date("2007-02-01")  # Set the lower data endpoint
upr_date  <- as.Date("2007-02-02")  # Set the upper data endpoint
dat2      <- data[
  (data$Date >= lwr_date) & 
    (data$Date <= upr_date),]

#------------------------------------------------------------------------------
# Extract all the data 

colnames(dat2)
timvec    <- strptime(dat2$Time,"%H:%M:%S")
timnum    <- as.numeric(format(dat2$Date,"%d")) +
  as.numeric(format(timvec,"%H"))/24 + 
  as.numeric(format(timvec,"%M"))/60/24 + 
  as.numeric(format(timvec,"%S"))/60/60/24

glpwr   <- dat2$Global_active_power
glpwr   <- as.numeric(levels(glpwr))[glpwr]

yvec1   <- dat2$Sub_metering_1
yvec1   <- as.numeric(levels(yvec1))[yvec1]

yvec2   <- dat2$Sub_metering_2
yvec2   <- as.numeric(levels(yvec2))[yvec2]

yvec3   <- dat2$Sub_metering_3

voltvec <- dat2$Voltage
voltvec <- as.numeric(levels(voltvec))[voltvec]

reactvc <- dat2$Global_reactive_power
reactvc <- as.numeric(levels(reactvc))[reactvc]

#------------------------------------------------------------------------------
# Prepare the png file with dimension 480 pixels by 480 pixels

png(filename = "plot4.png",
    width = 480, height = 480,units = "px")

#------------------------------------------------------------------------------
#
# Make the plot using the base package
#
#------------------------------------------------------------------------------
par(mfcol = c(2,2))

#------------------------------------------------------------------------------
# Top left plot

plot(timnum,glpwr,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     main = "",
     xaxt = "n")
axis(1,at = c(1,2,3), labels = c("Thur","Fri","Sat"))

#------------------------------------------------------------------------------
# Bottom left plot

plot(timnum,yvec1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "",
     col  = "black", 
     main = "",
     xaxt = "n")
lines(timnum,yvec2,col = "red")
lines(timnum,yvec3,col = "blue")
axis(1,at = c(1,2,3), labels = c("Thur","Fri","Sat"))
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1)

#------------------------------------------------------------------------------
# Top right plot

plot(timnum,voltvec,
     type = "l",
     ylab = "Voltage",
     xlab = "",
     main = "",
     xaxt = "n")
axis(1,at = c(1,2,3), labels = c("Thur","Fri","Sat"))

#------------------------------------------------------------------------------
# Bottom right plot

plot(timnum,reactvc,
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "",
     main = "",
     xaxt = "n")
axis(1,at = c(1,2,3), labels = c("Thur","Fri","Sat"))

#------------------------------------------------------------------------------
# Save the plot to a png file

dev.off()

