##########
## This is a R script to plot a graph with years of Observation on X-axis 
## Total amount of Emission (in tons) by motor vehicle related sources.
## Comparision is between Baltimore City and Los Angeles.
##
## Note: We are in the working directory where unzipped data files are available.
##########

# Load libraries required.
library(plyr)
library(ggplot2)

# Read the dataset from the file.
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get the SCC code(s) from SCC$SCC where EI.Sector has Vehicle related combusions.
Vehicle.SCC <- SCC$SCC[which(grepl("Vehicles", SCC$EI.Sector))]

# Get the Baltimore & Los Angeles subset.
PM25.BaLa <- subset(PM25, PM25$SCC %in% Vehicle.SCC & (fips=="24510" | fips == "06037"))

# Get a subset from Baltimore & Los Angeles set, with Emissions summed by "fips".
PM25.City <- ddply(PM25.BaLa, .(year, fips), summarize, Emissions.City = sum(Emissions))

# Get the City Name into a new column.
PM25.City$City <- ifelse(PM25.City$fips == "24510", "Baltimore", "Los Angeles")
  
# Graph Device to be png
png("plot6.png", height=480, width=480)

# Just plot the graph; year on x-axis and Total Emissions per year on y-axis.
qplot(year, Emissions.City, data = PM25.City, color = City, geom = "line") +
  xlab("Year of Observation") +
  ylab("Total amt. of PM2.5 Motor Vehicle Emission (in tons)") +
  ggtitle("PM2.5 Motor Vehicle Emission by Year in Blatimore & Los Angeles")

# Close the Graphic device.
dev.off()

