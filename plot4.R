# This script retrieves data from a zip file, then creates a four-pack of charts.

plot4 <- function() {

    # Check if data exists, if not, download and unzip
    setwd("~/R/ExpDataAnalysis/ExData_Plotting1/ExData_Plotting1")
    if(!file.exists("household_power_consumption.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",file.path(getwd(),"household_power_consumption.zip"))
        unzip(zipfile = "household_power_consumption.zip")
    }
    
    # Read data and subset only the data from 2007-02-01 and 2007-02-02
    powerconsumption <- read.table("household_power_consumption.txt",sep=";",na.strings="?",header=TRUE)
    colnames(powerconsumption) <- c("Date","Time","GlobalActivePower","GlobalReactivePower","Voltage","GlobalIntensity","SubMetering1","SubMetering2","SubMetering3")
    powerconsumptionsubset <- subset(powerconsumption,Date %in% c("1/2/2007","2/2/2007"))
    
    # Format dates and create new column Datetime
    powerconsumptionsubset$Date <- as.Date(powerconsumptionsubset$Date,format="%d/%m/%Y")
    datetime <- paste(as.Date(powerconsumptionsubset$Date), powerconsumptionsubset$Time)
    powerconsumptionsubset$Datetime <- as.POSIXct(datetime)

    # Plot fourth chart, which is really a set of four plots
    par(mfrow=c(2,2))
    plot(powerconsumptionsubset$GlobalActivePower~powerconsumptionsubset$Datetime,type="l",ylab="Global Active Power",xlab="")
    plot(powerconsumptionsubset$Voltage~powerconsumptionsubset$Datetime,type="l",ylab="Voltage",xlab="datetime")
    plot(powerconsumptionsubset$SubMetering1~powerconsumptionsubset$Datetime, type="l",ylab="Energy sub metering", xlab="")
    lines(powerconsumptionsubset$SubMetering2~powerconsumptionsubset$Datetime,col='Red')
    lines(powerconsumptionsubset$SubMetering3~powerconsumptionsubset$Datetime,col='Blue')
    legend("topright",col=c("black","red","blue"),lty=1,lwd=2,bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    plot(powerconsumptionsubset$GlobalReactivePower~powerconsumptionsubset$Datetime,type="l",ylab="Global_reactive_power",xlab="datetime")
    dev.copy(png,file="plot4.png",height=480,width=480)
    dev.off()
}
