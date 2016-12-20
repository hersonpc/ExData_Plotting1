###################################################################################
###################################################################################
###################################################################################
###
### Course.: Exploratory Data Analysis - Week 1
### Author.: Herson Melo - hersonpc@gmail.com
### Date...: 20 Dec 2016
###
###################################################################################
###################################################################################
###################################################################################


###
## Plot 1
###

library(dplyr)

filename <- "household_power_consumption.txt"

if(!file.exists(filename)) {

    zipfile <- "household_power_consumption.zip"
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

    # if don't exist zip file... download it...
    if(!file.exists(zipfile)) {
        if(Sys.info()["sysname"][[1]] == "Windows") {
            download.file(url, zipfile)
        } else {
            download.file(url, zipfile, method = "curl")
        }
    }
    
    # if do exist zip file... extract it or die...
    if(!file.exists(zipfile)) {
        stop("UCI Household Power Consumption not found and cannot be downloaded!")
    } else {
        # check if files are extracted...
        unzip(zipfile)
    }        
    
}

source <- read.csv2(filename, na.strings = "?", stringsAsFactors = F)
df <- tbl_df(source)
#str(df)

#####################################################################################


df$Date <- as.Date(df$Date, format = "%d/%m/%Y")

df <- df %>% filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

df$Global_active_power <- as.numeric(df$Global_active_power)

#####################################################################################


png(filename = "plot1.png", width = 480, height = 480)

hist(x = df$Global_active_power, 
     c = "red",
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

dev.off()
