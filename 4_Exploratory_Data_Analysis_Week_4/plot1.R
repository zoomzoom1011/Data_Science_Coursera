library("data.table")

# Read as data table
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))

#get the sum by each year
temp_NEI <- NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

#use barplot for visualization
png("plot1.png")
barplot(temp_NEI$Emissions, 
        names.arg = temp_NEI$year, 
        xlab="Year", 
        ylab="Total Emission",
        main="Total PM2.5 Emmissions by Year")
dev.off()