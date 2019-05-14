library("data.table")
library("ggplot2")

# Read as data table
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

## Subset vehicle data
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles, SCC]
subset_NEI <- NEI[NEI$SCC %in% vehiclesSCC,]
subset_NEI <- subset(subset_NEI,fips=="24510")
temp_NEI <- subset_NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]
temp_NEI$year <- as.character(temp_NEI$year)

#use ggplot for visualization
ggplot(temp_NEI, aes(year, Emissions))+ 
  geom_bar(stat="identity", width=0.75)+
  xlab("year") +
  ylab("Total Emissions") +
  ggtitle("Total Vehicle PM2.5 Emmissions by Year") +
  ggsave('plot5.png')