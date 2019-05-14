library("data.table")
library("ggplot2")

# Read as data table
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

## Subset coal combustion data
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("comb", SCC$SCC.Level.Four, ignore.case=TRUE)
combustioncoal <- SCC[combustion & coal, SCC]
subset_NEI <- NEI[NEI$SCC %in% combustioncoal,]
temp_NEI <- subset_NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]
temp_NEI$year <- as.character(temp_NEI$year)


#use ggplot for visualization
ggplot(temp_NEI, aes(year, Emissions))+ 
  geom_bar(stat="identity", width=0.75)+
  xlab("year") +
  ylab("Total Emissions") +
  ggtitle("Coal Combustion-related PM2.5 Emmissions by Year") +
  ggsave('plot4.png')