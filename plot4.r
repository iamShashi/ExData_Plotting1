######to make the data tidy#####

f <- "hpc.zip" 

#to check for the original dataset and download it
if (!file.exists(f)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, f,method = 'libcurl')
}  

#to extract the dataset
if (!file.exists("hpc")) { 
  unzip(f) 
}


epc<-read.table("household_power_consumption.txt",skip=grep("31/1/2007;23:59:00",readLines(con<-file("household_power_consumption.txt"))),nrows = 2880,sep = ";",na.strings = "?",stringsAsFactors = FALSE)


colnames(epc) <- c("Date", "Time","GlobalActivePower","GlobalReactivePower","Voltage","GlobalIntensity","SubMetering1","SubMetering2","SubMetering3")


epc$Date<-as.Date(epc$Date,"%d/%m/%Y")

epcNew <- paste(as.Date(epc$Date), epc$Time)
epc$DateTime <- as.POSIXct(epcNew)
rm(epcNew)


######to make the plots#####


par(mfcol=c(1,1))
plot.new()

par(mfcol = c(2,2))

plot(epc$DateTime,epc$GlobalActivePower,type = "l",xlab ="",ylab="Global Active Power" )


plot(epc$DateTime,epc$SubMetering1,type = "n",xlab="",ylab="Energy sub metering")

points(epc$DateTime,epc$SubMetering1,type = "l")

points(epc$DateTime,epc$SubMetering2,type = "l",col="red")

points(epc$DateTime,epc$SubMetering3,type = "l",col="blue")

legend("topright",lty=1,col = c("black","red","blue"),legend = c("Sub metering 1","Sub metering 2","Sub metering 3"),pt.cex=1,cex=0.85,bty="n")


plot(epc$DateTime,epc$Voltage,xlab="datetime",ylab="Voltage",type="l")


plot(epc$DateTime,epc$GlobalReactivePower,xlab="datetime",ylab="Global reactive power",type="l")

dev.copy(png,file="plot4.png",height=480,width=480)

dev.off()