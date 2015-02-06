dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataset_url, "household_power_consumption.zip")
unzip("household_power_consumption.zip", exdir="household_power_consumption")

dat <- read.table("household_power_consumption/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)

dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
dat_sub <- subset(dat, dat$Date=="2007-02-01" | dat$Date=="2007-02-02")
dat_sub$datetime <- paste(dat_sub$Date, dat_sub$Time)
dat_sub$datetime <- strptime(dat_sub$datetime, "%Y-%m-%d %H:%M:%S")

dat_sub$Global_active_power <- as.numeric(dat_sub$Global_active_power)

hist(dat_sub$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red",bty="n")
dev.copy(png, width = 480, height = 480, file = "plot1.png")
dev.off()