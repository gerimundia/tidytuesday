
# Packages -----------------------------------------------------------

pacman::p_load(tidytuesdayR, viridis, ggplot2, dplyr)

# Data -----------------------------------------------------------

tuesdata <- tt_load('2025-05-27')

monsters <- tuesdata$monsters

data <- monsters %>% 
          group_by(size) %>% 
          summarize(Intelligence = mean(int, na.rm=TRUE),
                    Strength = mean(str, na.rm=TRUE))
  
  
# Plot -----------------------------------------------------------

fondo <- "white"

data %>% 
ggplot() +
  geom_point(aes(x = Intelligence, y = Strength, color=size), size=6) +
  ylim(0,30) + 
  xlim(0,15) +
  labs(title = paste("Dungeons and Dragons Monsters: intelligence", 
                     brain, "vs strength", strong),
  y="Mean strength", x="Mean intelligence", colour="Size") + 
  scale_color_viridis_d(end=0.9) +
  theme_minimal() +
  theme(panel.background = element_rect(fill = fondo, colour = fondo),
        plot.background = element_rect(fill = fondo, colour = fondo),
        axis.title=element_text(size = 12, color="gray20"),
        plot.title = element_text(face="bold", size = 12.8, color="indianred"),
        plot.margin = margin(t=10, r=10, b=10, l=10), 
        axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
        axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)), 
        legend.box.spacing = unit(0.5, units = "cm"),
        legend.key.size = unit(0.8, units = "cm"), 
        legend.title = element_text(size = 12, color="gray20")) +
  guides(fill = guide_legend(byrow = TRUE))
  
ggsave(last_plot(), file="d_and_d.png")
