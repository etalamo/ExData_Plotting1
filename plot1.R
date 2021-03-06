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

#PLOT 1
ds1$globalactivepower <- as.numeric(ds1$globalactivepower)
png("plot1.png", width=480, height=480)
hist(ds1$globalactivepower, col = "red", 
     xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
