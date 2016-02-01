library(dplyr)
library(ggplot2)

if(!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

coalCombustionSCC <- SCC %>% 
    filter(grepl("Combustion" , SCC.Level.One), grepl("Coal" , EI.Sector)) %>%
    select(SCC)

coalCombustionEmissionByYearAndType <- NEI %>% 
    filter(SCC %in% coalCombustionSCC$SCC) %>% 
    group_by(year, type) %>%
    summarise(emission = sum(Emissions))

ggplot(coalCombustionEmissionByYearAndType, aes(x = factor(year), y = emission, fill = type)) + 
    geom_bar(stat = "identity") + 
    ggtitle("U.S. Coal Combustion-Related Emissions: 1999-2008") +
    xlab("Year") + 
    ylab("Emissions (tons)")

dev.copy(png,'plot4.png')
dev.off()
