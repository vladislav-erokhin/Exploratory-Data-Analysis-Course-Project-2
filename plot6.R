library(dplyr)
library(ggplot2)

if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

motorVehicleSCC <- SCC %>% 
    filter(grepl("Vehicle" , SCC.Level.Two)) %>%
    select(SCC)

motorVehicleEmission <- NEI %>%  
    filter(fips == "24510" | fips == "06037", SCC %in% motorVehicleSCC$SCC) %>% 
    mutate(fipsName = ifelse(fips == "24510", "Baltimore City", ifelse(fips == "06037", "Los Angeles County", "Other"))) %>%
    group_by(year, fipsName) %>%
    summarise(emission = sum(Emissions))

ggplot(motorVehicleEmission, aes(x = factor(year), y = emission, fill = fipsName)) + 
    geom_bar(stat = "identity", position=position_dodge()) + 
    ggtitle("Baltimore City vs Los Angeles County Motor Vehicle Emissions") +
    xlab("Year") + 
    ylab("Emissions (tons)")


dev.copy(png,'plot6.png')
dev.off()
