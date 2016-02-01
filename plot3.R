library(dplyr)
library(ggplot2)

if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

baltimoreEmissionByYearAndType <- NEI %>% 
    filter(fips == "24510") %>% 
    group_by(year, type) %>%
    summarise(emission = sum(Emissions))

qplot(year, emission, data=baltimoreEmissionByYearAndType, color=type, geom ="line") + 
    ggtitle("Baltimore City PM2.5 Emmission by type and year") + 
    xlab("Year") + 
    ylab("Emissions (tons)")

dev.copy(png,'plot3.png')
dev.off()
