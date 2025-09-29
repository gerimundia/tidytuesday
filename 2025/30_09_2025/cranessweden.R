
# Packages -----------------------------------------------------------

pacman::p_load(tidytuesdayR, ggplot2, dplyr, viridis, scales)

# Data -----------------------------------------------------------

tuesdata <- tt_load('2025-09-30')

cranes <- tuesdata$cranes
cranes$anio_mes <- format(cranes$date, "%Y-%m")

data <- cranes %>% 
  group_by(anio_mes) %>% 
  summarize(total = sum(observations, na.rm=TRUE))

data$anio <- substr(data$anio_mes, 1, 4)
data$mes <- substr(data$anio_mes, 6, 7)
data$mes_abb <- month.abb[as.numeric(data$mes)]


# Plot -----------------------------------------------------------
ggplot(data)+
  geom_tile(aes(y = anio, x = reorder(mes_abb, as.numeric(mes)), 
                fill = total), 
            color = "white", linewidth = 0.7) + 
  scale_fill_viridis(name="", 
                     option ="A", 
                     begin = 0.8, end = 0.2,
                     labels = comma_format
                     (big.mark = ",", decimal.mark = ".")) +
  scale_x_discrete(drop = FALSE) +
  labs(y="Year", x="Month", 
       title="Cranes observed monthly at Lake Hornborgasjön, Sweden") + 
  theme_minimal() +
  theme(
    axis.title = element_text(size=12, color="gray20"),
    axis.text = element_text(size=9, color="gray30"),
    axis.title.y = element_text(margin = margin(t = 0, r = 15, b = 0, l = 0)),
    axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)),
    legend.text = element_text(size=10),
    title = element_text(size=13, color="gray20", face="bold"))

ggsave(last_plot(), file="cranes.jpg")
