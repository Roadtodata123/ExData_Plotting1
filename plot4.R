##
## This script produces the graph Plot 4 as specified  on
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

#Plot4   - plots the graphs and output it to png file

par(mfrow = c(2,2))
par(mar=c(4,4,2,4))

#graph1
with(mysubdata,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))

#Graph2
with(mysubdata,plot(DateTime,Voltage,type="l",xlab="datetime",ylab="Voltage"))


#graph3
with(mysubdata,plot(DateTime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
points(mysubdata$DateTime,mysubdata$Sub_metering_1, col="black", type="l")
points(mysubdata$DateTime,mysubdata$Sub_metering_2, col="red", type="l")
points(mysubdata$DateTime,mysubdata$Sub_metering_3, col="blue", type="l")
legend("topright",lty=1,col=c("black","red","blue"), legend=names(mysubdata[,7:9]), bty="n", xjust=0, cex=0.7)


#graph4
with(mysubdata,plot(DateTime,Global_reactive_power,type="l",xlab="datetime"))

dev.copy(png,file = "plot4.png",units = "px",width=500,height=500)
dev.off()

