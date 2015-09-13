
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

### plot 1
hist(df$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
# copy to PNG file
dev.copy(png, file="plot1.png", width = 480, height = 480, units = "px")
dev.off()
