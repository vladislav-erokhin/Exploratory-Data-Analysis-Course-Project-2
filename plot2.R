library(dplyr)

if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

baltimoreEmissionByYear <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarise(emission = sum(Emissions))

barplot(
    height = baltimoreEmissionByYear$emission, 
    names.arg = baltimoreEmissionByYear$year, 
    xlab = "Year",
    ylab = "Emissions (tons)",
    main = "Baltimore City Total PM2.5 Emissions by Year")

dev.copy(png,'plot2.png')
dev.off()
