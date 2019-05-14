library("data.table")
library("ggplot2")

# Read as data table
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

## Subset vehicle data
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles, SCC]
subset_NEI <- NEI[NEI$SCC %in% vehiclesSCC,]
subset_NEI1 <- subset(subset_NEI,fips==c("24510","06037"))
temp_NEI <- subset_NEI1[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = c("year","fips")]
temp_NEI$County[which(temp_NEI$fips == "24510")] <- "Baltimore City, MD"
temp_NEI$County[which(temp_NEI$fips == "06037")] <- "Los Angeles County, CA"

#use ggplot for visualization
ggplot(temp_NEI, aes(year, Emissions, color = County))+ 
  geom_line() +
  xlab("year") +
  ylab("Total Emissions") +
  ggtitle("Total Vehicle PM2.5 Emmissions by Year") +
  ggsave('plot6.png')