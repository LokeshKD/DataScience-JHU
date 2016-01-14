##########
## This is a R script to plot a graph with years of Observation on X-axis 
## Total amount of Emission (in tons) by motor vehicle related sources.
##
## Note: We are in the working directory where unzipped data files are available.
##########

# Read the dataset from the file.
PM25 <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get the Baltimore subset.
PM25.B <- subset(PM25, fips=="24510")

# Get the SCC code(s) from SCC$SCC where EI.Sector has Vehicle related combusions.
Vehicle.SCC <- SCC$SCC[which(grepl("Vehicles", SCC$EI.Sector))]

# Get a subset from Baltimore set, with specific Vehicle.SCC.
PM25.B.sub <- subset(PM25.B, PM25.B$SCC %in% Vehicle.SCC)
  
# Graph Device to be png
png("plot5.png", height=480, width=480)

with(PM25.B.sub, plot(unique(year), tapply(Emissions, year, sum),
                      type ="l", lwd = 2, col = "blue",
                      xlab = "Year of Observation",
                      ylab = "Vehicle Related Total Emissions (in tons)",
                      main = "Vehicle Related PM2.5 Emissions by Year in Baltimore"))

# Close the Graphic device.
dev.off()

