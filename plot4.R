dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataset_url, "household_power_consumption.zip")
unzip("household_power_consumption.zip", exdir="household_power_consumption")

dat <- read.table("household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
dat_sub <- subset(dat, dat$Date=="2007-02-01" | dat$Date=="2007-02-02")
dat_sub$datetime <- paste(dat_sub$Date, dat_sub$Time)
dat_sub$datetime <- strptime(dat_sub$datetime, "%Y-%m-%d %H:%M:%S")


par(mfcol = c(2, 2),cex=.5)

plot(dat_sub$datetime, dat_sub$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

plot(dat_sub$datetime, dat_sub$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
with(dat_sub,{
        lines(datetime,Sub_metering_1)
        lines(datetime,Sub_metering_2,col="red")
        lines(datetime,Sub_metering_3,col="blue")
})
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"), cex=.8)

plot(dat_sub$datetime, dat_sub$Voltage, type="l", ylab="Voltage", xlab="datetime")

plot(dat_sub$datetime, dat_sub$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.copy(png, width = 480, height = 480, file = "plot4.png")
dev.off()