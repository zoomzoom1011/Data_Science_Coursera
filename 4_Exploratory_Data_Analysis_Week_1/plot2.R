#read data
datas <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(datas)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subset_datas<-subset(datas,datas$Date=="1/2/2007"|datas$Date =="2/2/2007")

#convert data
subset_datas$DateTime <- as.POSIXct(paste(subset_datas$Date, subset_datas$Time), format = "%d/%m/%Y %H:%M:%S")
subset_datas$Global_active_power <- as.numeric(as.character(subset_datas$Global_active_power))

#plot data
png('plot2.png', width=480,height=480)
plot(subset_datas$DateTime,subset_datas$Global_active_power, type = "l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()