### COURSERA exploratory data analysis module ###
######### assignment 1,  due 12/09/2015 #########

#### DEPENDENCIES ### - please install if not already done
library(dplyr)


### get and clean data

# download zipped file to a new folder in your working directory
if(!file.exists("./EPC")){dir.create("./EPC")}
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="./EPC/data.zip")
dateDownloaded <- date()

# unzip to your wd
unzip("./EPC/data.zip")

# read in as dataframe
df <- read.table("household_power_consumption.txt", sep=";", 
                 header=TRUE, stringsAsFactors=FALSE, na.strings = "?")

# keep only rows with the dates of interest in df
df <- df[(df$Date=="1/2/2007"|df$Date=="2/2/2007"),] #how could have done this whiole reading in to save memory?

# format data and time as R date and time values
df <- mutate(df, timepoint = paste(Date, Time, sep=" "))
df$timepoint <- strptime(df$timepoint, "%d/%m/%Y %H:%M:%S")


### plot4
par(mfrow=c(2,2), mar=c(4,4,2,1))
plot(df$timepoint, df$Global_active_power, type="n",
     ylab="Global Active Power (kilowatts)", xlab="")
lines(df$timepoint, df$Global_active_power)

plot(df$timepoint, df$Voltage, type="n", 
     xlab="datetime")
lines(df$timepoint, df$Voltage)

plot(df$timepoint, df$Sub_metering_1, type="n", 
     ylab="Energy sub metering", xlab="")
lines(df$timepoint, df$Sub_metering_1)
lines(df$timepoint, df$Sub_metering_2, col="red")
lines(df$timepoint, df$Sub_metering_3, col="blue")
legend("topright", pch="_", col=c("black","red","blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(df$timepoint, df$Global_active_power, type="n",
     xlab="datetime")
lines(df$timepoint, df$Global_active_power)

dev.copy(png, file="plot4.png", width = 480, height = 480, units = "px")
dev.off()
