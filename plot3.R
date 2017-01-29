#Load the file and the dataset
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
ds <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header=TRUE, stringsAsFactors=FALSE, dec=".")
unlink(temp)
rm(temp)

#Clean column names
names(ds) <- gsub("_","",names(ds))
names(ds) <- tolower(names(ds))

#Convert date field to date
ds <- transform(ds, date = as.character(date))
ds <- transform(ds, date = as.Date(date, "%d/%m/%Y"))

#Subset dates to release memory usage
ds1 <- subset(ds, (ds$date >= "2007-02-01") & (ds$date <= "2007-02-02"))
rm(ds)

#PLOT 3
datetime <- paste(as.Date(ds1$date), ds1$time)
ds1$datetime <- as.POSIXct(datetime)


png("plot3.png", width=480, height=480)
plot(ds1$datetime, ds1$submetering1, type="l", xlab="",ylab="Energy sub metering")
lines(ds1$datetime, ds1$submetering2, col="red")
lines(ds1$datetime, ds1$submetering3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, cex=0.8, col=c("black", "red", "blue"),
       inset=0.07, bty="n")
dev.off()