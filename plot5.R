library(dplyr)
library(ggplot2)

if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

motorVehicleSCC <- SCC %>% 
    filter(grepl("Vehicle" , SCC.Level.Two)) %>%
    select(SCC)

baltimoreMotorVehicleEmission <- NEI %>%  
    filter(fips == "24510", SCC %in% motorVehicleSCC$SCC) %>% 
    group_by(year) %>%
    summarise(emission = sum(Emissions))

ggplot(baltimoreMotorVehicleEmission, aes(x = factor(year), y = emission)) + 
    geom_bar(stat = "identity") + 
    ggtitle("Baltimore City Emissions from motor vehicle (SCC.Level.Two contais Vehicle)") +
    xlab("Year") + 
    ylab("Emissions (tons)")

dev.copy(png,'plot5.png')
dev.off()
