##
## This script produces the graph Plot 2 as specified  on
## Coursera Exploratory Data Analysis assignment 1
## It is assumed that the required data is already 
##  downloaded onto the R working directory.  
##
## first part of this script is to read and prepare the data in 
## the condition that is acceptable for plotting the graph.
##
## The second part is to plot the graphs
##


## readd the data
mydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors=FALSE,skip=66240, nrows=5760, na.strings="?")


## add column headings
names(mydata) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")


## add DateTime column
mydata$DateTime <- strptime(paste(mydata$Date,mydata$Time), "%d/%m/%Y %H:%M:%S")

## extract only hte require set of data
mysubdata <- subset(mydata, Date == "2/2/2007" | Date =="1/2/2007")


## formating the Date
mysubdata$Date <- strptime(mysubdata$Date, format="%d/%m/%y")


library(datasets)

#plot2 - plot the graph and output the graph to png file
with(mysubdata,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
dev.copy(png,file = "plot2.png",units = "px",width=480,height=480)
dev.off()

