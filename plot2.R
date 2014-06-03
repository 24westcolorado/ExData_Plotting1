#------------------------------------------------------------------------------
#
# Plot 2 file
#
#------------------------------------------------------------------------------
# 1.  Load the data,
# 2.  Construct Plot 2, 
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
# Extract the global active power data and the dates

colnames(dat2)
timvec    <- strptime(dat2$Time,"%H:%M:%S")
timnum    <- as.numeric(format(dat2$Date,"%d")) +
  as.numeric(format(timvec,"%H"))/24 + 
  as.numeric(format(timvec,"%M"))/60/24 + 
  as.numeric(format(timvec,"%S"))/60/60/24

yvec    <- dat2$Global_active_power
yvec2   <- as.numeric(levels(yvec))[yvec]


#------------------------------------------------------------------------------
# Prepare the png file with dimension 480 pixels by 480 pixels

png(filename = "plot2.png",
    width = 480, height = 480,units = "px")

#------------------------------------------------------------------------------
# Make the histogram plot using the base package

plot(timnum,yvec2,
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     main = "",
     xaxt = "n")
axis(1,at = c(1,2,3), labels = c("Thur","Fri","Sat"))

#------------------------------------------------------------------------------
# Save the plot to a png file

dev.off()

