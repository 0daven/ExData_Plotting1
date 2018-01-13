##################
###FILE 4
#Reading table, renaming and subsetting
pow <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(pow) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
sub.pow <- subset(pow,Date=="1/2/2007" | Date =="2/2/2007")
#Transforming Date and Time variables
sub.pow$Date <- as.Date(sub.pow$Date, format="%d/%m/%Y")
sub.pow$Time <- strptime(sub.pow$Time, format="%H:%M:%S")
sub.pow[1:1440,"Time"] <- format(sub.pow[1:1440,"Time"],"2007-02-01 %H:%M:%S")
sub.pow[1441:2880,"Time"] <- format(sub.pow[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
#Setting plot area parameters
par(mfrow=c(2,2),mar=c(5,5,0,1),oma=c(0,0,0,0),cex=0.7)
#Creating plots
with(sub.pow,{
  plot(Time,as.numeric(as.character(Global_active_power)),type="l",xlab = "",ylab = "Global Active Power")
  plot(Time,as.numeric(as.character(Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(Time,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  lines(Time,as.numeric(as.character(Sub_metering_1)))
  lines(Time,as.numeric(as.character(Sub_metering_2)),col="red")
  lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue")
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(Time,as.numeric(as.character(Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})
## Save file and close device
#dev.copy(png,"plot4.png", width=480, height=480)
#dev.off()
