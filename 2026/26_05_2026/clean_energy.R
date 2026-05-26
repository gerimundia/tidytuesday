
# Packages -----------------------------------------------------------

pacman::p_load(tidytuesdayR, dplyr, ggplot2, plotly, htmlwidgets)

# Data -----------------------------------------------------------

tuesdata <- tt_load('2026-05-26')

data <- tuesdata$energy_cleaned %>% 
  select(country_name, yr, perc_renewable_of_total_electricity_output) %>% 
  filter(is.na(perc_renewable_of_total_electricity_output)==F) %>% 
  filter(yr == 2010) %>%
  filter(country_name %in% c("Latin America and Caribbean", 
                             "Nothern America", 
                             "Europe", 
                             "Eastern Europe",
                             "Sub-Saharan Africa", 
                             "Northern Africa", 
                             "Caucasus and Central Asia", 
                             "Eastern Asia (including Japan)",
                             "South Eastern Asia",
                             "Southern Asia",
                             "Western Asia",
                             "Oceania")) %>% 
  arrange(desc(perc_renewable_of_total_electricity_output))

# Plot -----------------------------------------------------------

plot1 <- ggplot(data, aes(x=perc_renewable_of_total_electricity_output, 
               y=reorder(country_name, perc_renewable_of_total_electricity_output), 
               key=country_name,
               text=paste0(round(perc_renewable_of_total_electricity_output, 1), "%"))) +
  geom_col(fill="darkgoldenrod3") +
  xlim(c(0,60)) + 
  labs(x=NULL, y=NULL, 
       title="2010: Renewable energy percentage of total electricity output") +
  theme_minimal() +
  theme(plot.title.position="plot", 
        plot.title=element_text(size=12, color="darkgoldenrod4", face="bold"),
        axis.text.y=element_text(size=11),
        axis.text.x=element_text(size=9))

ggsave(filename="renewable_energy.jpg", 
       plot=plot1, 
       units="cm", width=13, height=10, dpi=400)

# Plotly -----------------------------------------------------------

tidytuesdayplot <-  ggplotly(plot1, tooltip="text", source="select_bar") %>% 
  layout(hoverlabel=list(font=list(size=27)))

htmlwidgets::saveWidget(tidytuesdayplot, 
                        file="tidytuesdayplot.html")
