##########
## This is a R script to plot a graph with years of Observation on X-axis 
## Total amount of Emission (in tons) by motor vehicle related sources.
##
## Note: We are in the working directory where unzipped data files are available.
##########

# Load libraries required.
library(plyr)
library(ggplot2)

# Read the dataset from the file.
PM25 <- readRDS("summarySCC_PM25.rds")

# Get the Baltimore subset.
PM25.B <- subset(PM25, fips=="24510")

# Get a subset from Baltimore set, with Emissions summed by "type".
PM25.B.sub <- ddply(PM25.B, .(year, type), summarize, Emissions.Type = sum(Emissions))
  
# Graph Device to be png
png("plot3.png", height=480, width=480)

# Just plot the graph; year on x-axis and Total Emissions per year on y-axis.
qplot(year, Emissions.Type, data = PM25.B.sub, color = type, geom = "line") +
  xlab("Year of Observation") +
  ylab("Total amt. of PM2.5 Emission per Type (in tons)") +
  ggtitle("PM2.5 Emission per Type by Year in Blatimore City")

# Close the Graphic device.
dev.off()

