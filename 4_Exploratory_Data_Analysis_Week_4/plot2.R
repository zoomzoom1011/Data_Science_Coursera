library("data.table")

# Read as data table
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

#get the sum by each year
subset_NEI <- subset(NEI,fips=="24510")
temp_NEI <- subset_NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

#use barplot for visualization
png("plot2.png")
barplot(temp_NEI$Emissions, 
        names.arg = temp_NEI$year, 
        xlab="Year", 
        ylab="Total Emission",
        main="Baltimore Total PM2.5 Emmissions by Year")
dev.off()