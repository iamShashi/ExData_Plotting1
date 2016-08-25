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


######to make the plot#####
par(mfcol=c(1,1))
plot.new()
plot(epc$DateTime,epc$GlobalActivePower,type = "l",xlab ="",ylab="Global Active Power (kilowatts)" )

dev.copy(png,file="plot2.png",height=480,width=480)

dev.off()