# This script retrieves data from a zip file, then creates a histogram.

plot1 <- function() {
    
    # Check if data exists, if not, download and unzip
    setwd("~/R/ExpDataAnalysis/ExData_Plotting1/ExData_Plotting1")
    if(!file.exists("household_power_consumption.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",file.path(getwd(),"household_power_consumption.zip"))
        unzip(zipfile="household_power_consumption.zip")
    }
    
    # Read data and subset only the data from 2007-02-01 and 2007-02-02
    powerconsumption <- read.table("household_power_consumption.txt",sep=";",na.strings="?",header=TRUE)
    colnames(powerconsumption) <- c("Date","Time","GlobalActivePower","GlobalReactivePower","Voltage","GlobalIntensity","SubMetering1","SubMetering2","SubMetering3")
    powerconsumptionsubset <- subset(powerconsumption,Date %in% c("1/2/2007","2/2/2007"))
    
    # Format dates
    powerconsumptionsubset$Date <- as.Date(powerconsumptionsubset$Date,format="%d/%m/%Y")
    
    # Plot first chart as a histogram and save as a PNG file
    hist(as.double(powerconsumptionsubset$GlobalActivePower), main="Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
    dev.copy(png,file="plot1.png",height=480,width=480)
    dev.off()
}
