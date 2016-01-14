##########
## This is a R script to plot a graph with years of Observation on X-axis 
## Total amount of Emission (in tons) on Y-axis in United states.
##
## Note: We are in the working directory where unzipped data files are available.
##########


# Read the dataset from the file.
PM25 <- readRDS("summarySCC_PM25.rds")

# Graph Device to be png
png("plot1.png", height=480, width=480)

# Just plot the graph; year on x-axis and Total Emissions per year on y-axis.
with(PM25, plot(unique(year), tapply(Emissions, year, sum),
                type = "l", col = "blue", lwd = 2,
                xlab = "Year of Observation",
                ylab = "Total amt. of PM2.5 Emission (in tons)",
                main = "PM2.5 Emission by Year in United States"))

# Close the Graphic device.
dev.off()

