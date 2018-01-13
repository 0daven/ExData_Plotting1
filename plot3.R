##################
###FILE 3
#Reading table, renaming and subsetting
pow <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(pow) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
sub.pow <- subset(pow,Date=="1/2/2007" | Date =="2/2/2007")
#Transforming Date and Time variables
sub.pow$Date <- as.Date(sub.pow$Date, format="%d/%m/%Y")
sub.pow$Time <- strptime(sub.pow$Time, format="%H:%M:%S")
sub.pow[1:1440,"Time"] <- format(sub.pow[1:1440,"Time"],"2007-02-01 %H:%M:%S")
sub.pow[1441:2880,"Time"] <- format(sub.pow[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
#Creating plot
with(sub.pow,{
  plot(Time,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  lines(Time,as.numeric(as.character(Sub_metering_1)))
  lines(Time,as.numeric(as.character(Sub_metering_2)),col="red")
  lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue")})
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#Addin title
title(main="Energy sub-metering")
## Save file and close device
#dev.copy(png,"plot3.png", width=480, height=480)
#dev.off()
