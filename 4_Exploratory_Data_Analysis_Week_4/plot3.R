library("data.table")
library("ggplot2")

# Read as data table
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

#get the sum by each year
subset_NEI <- subset(NEI,fips=="24510")
temp_NEI <- subset_NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = c("year","type")]

#use ggplot for visualization
ggplot(temp_NEI, aes(year, Emissions, color = type))+ 
  geom_line()+
  xlab("year") +
  ylab("Total Emissions") +
  ggtitle("Baltimore Total PM2.5 Emmissions by Year")+
  ggsave('plot3.png')