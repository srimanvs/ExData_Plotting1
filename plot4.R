# Download, unzip and read data into table by name "data"

data <- read.table('household_power_consumption.txt', sep=';', header=T,
                   colClasses = c('character', 'character', 'numeric',
                                  'numeric', 'numeric', 'numeric',
                                  'numeric', 'numeric', 'numeric'),
                   na.strings='?')
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data <- subset(data, as.Date(DateTime) >= as.Date("2007-02-01") & 
                    as.Date(DateTime) <= as.Date("2007-02-02"))

png("plot4.png", height=480, width=480)

par(mfrow=c(2,2))

# Global Active Power Plot
plot(data$DateTime, data$Global_active_power, xlab="", pch=NA, 
     ylab="Global Active Power")
lines(data$DateTime, data$Global_active_power)

# Voltage Plot
plot(data$DateTime, data$Voltage, pch=NA, xlab="datetime", ylab="Voltage")
lines(data$DateTime, data$Voltage)

# Sub Metering Plot
plot(data$DateTime, data$Sub_metering_1, pch=NA, xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_1)
lines(data$DateTime, data$Sub_metering_2, col='red')
lines(data$DateTime, data$Sub_metering_3, col='blue')
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), col = c('black', 'red', 'blue'), bty = 'n')

# Global Reactive Power Plot
with(data, plot(DateTime, Global_reactive_power, pch=NA, xlab='datetime'))
with(data, lines(DateTime, Global_reactive_power))

dev.off()
