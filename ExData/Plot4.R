##########
## This is a R script to plot a graph with years of Observation on X-axis 
## Total amount of Emission (in tons) by Coal combustion related sources.
##
## Note: We are in the working directory where unzipped data files are available.
##########

# Load libraries required.
library(plyr)
library(ggplot2)

# Read the data from files.
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get the SCC code(s) from SCC$SCC where EI.Sector has Coal related combusions.
Coal.SCC <- SCC$SCC[which(grepl("Coal", SCC$EI.Sector))]

# Get the subset of PM25 with specific Coal.SCC
PM25.C <- subset(PM25, PM25$SCC %in% Coal.SCC)  
  
# Graph Device to be png
png("plot4.png", height=480, width=480)

with(PM25.C, plot(unique(year), tapply(Emissions, year, sum),
                  type ="l", lwd = 2, col = "blue",
                  xlab = "Year of Observation",
                  ylab = "Coal Related Total Emissions (in tons)",
                  main = "Coal Related PM2.5 Emissions by Year"))

# Close the Graphic device.
dev.off()

