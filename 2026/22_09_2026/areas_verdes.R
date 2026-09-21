# Packages -----------------------------------------------------------

pacman::p_load(tidytuesdayR, dplyr, ggplot2, scales)

# Data -----------------------------------------------------------

tuesdata <- tt_load('2026-09-22')

data <- tuesdata$urban

data <- data %>% 
  filter(sdgRegion=="Latin America and the Caribbean" & 
           (year==1990 |  year==2020) & 
           is.na(greenAreaPerCapitaM2)==F)

promedio <- data %>% 
  group_by(year, countryOrTerritoryName) %>% 
  summarise(promedio = mean(greenAreaPerCapitaM2))
  
promedio <- promedio %>% 
  filter(countryOrTerritoryName!="Latin America and the Caribbean")

promedio$countryOrTerritoryName[promedio$countryOrTerritoryName=="Venezuela (Bolivarian Republic of)"] <- "Venezuela"
promedio$countryOrTerritoryName[promedio$countryOrTerritoryName=="Bolivia (Plurinational State of)"] <- "Bolivia"
promedio$countryOrTerritoryName[promedio$countryOrTerritoryName=="Dominican Republic"] <- "Dominican Rep."

head(promedio)


# Plot -----------------------------------------------------------

ggplot(promedio, 
       aes(x=as.factor(countryOrTerritoryName), y=promedio, color=as.character(year))) +
  geom_segment(aes(xend=as.factor(countryOrTerritoryName), yend=0, ), 
               linewidth=1) +
  geom_point(size=4) +
  scale_color_manual(values = c("coral", "brown3")) +
  coord_flip() +
  labs(x=NULL, 
       y="Promedio de áreas verdes per cápita en ciudades reportadas por país (m2)",
       color=NULL) +
  ylim(0,80) +
  theme_minimal() +
  theme(axis.text = element_text(size=9), 
      axis.title.x = element_text(size=9, margin = margin(t = 10, r = 10, b = 0, l = 0)),
      legend.text = element_text(size=10))

ggsave(filename=paste0("2026/22_09_2026/", "areas_verdes.jpg"), 
       plot=last_plot(), units="cm", width=13, height=10, dpi=450)
