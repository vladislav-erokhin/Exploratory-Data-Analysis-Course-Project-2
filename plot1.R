library(dplyr)

if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

emissionByYear <- NEI %>% group_by(year) %>% summarise(emission = sum(Emissions))

barplot(
    height = emissionByYear$emission/10^6, 
    names.arg = emissionByYear$year, 
    xlab = "Year",
    ylab = "Emissions (million tons)",
    main = "Total PM2.5 Emissions by Year")

dev.copy(png,'plot1.png')
dev.off()
