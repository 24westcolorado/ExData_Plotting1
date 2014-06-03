#------------------------------------------------------------------------------
#
# Plot 1 file
#
#------------------------------------------------------------------------------
# 1.  Load the data,
# 2.  Construct Plot 1, 
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
# Extract the global active power data

colnames(dat2)
xvec  <- dat2$Global_active_power
xvec2 <- as.numeric(levels(xvec))[xvec]


#------------------------------------------------------------------------------
# Prepare the png file with dimension 480 pixels by 480 pixels

png(filename = "plot1.png",
    width = 480, height = 480,units = "px")

#------------------------------------------------------------------------------
# Make the histogram plot using the base package

hist(xvec2,breaks = 17, 
     xlab = "Global Active Power (kilowatts)",
     col = "red",
     main = "Global Active Power")

#------------------------------------------------------------------------------
# Save the plot to a png file

dev.off()

