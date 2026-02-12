
# Packages -----------------------------------------------------------

pacman::p_load(tidytuesdayR, ggplot2)

# Data -----------------------------------------------------------

tuesdata <- tt_load('2026-02-10')

schedule <- tuesdata$schedule

# Discipline
schedule$discipline <- ifelse(schedule$discipline_name %in% 
                                c("Alpine Skiing", "Ski Jumping",
                                  "Cross-Country Skiing", "Freestyle Skiing", 
                                  "Nordic Combined", "", 
                                  "Ski Mountaineering"), "Skiing",
                          ifelse(schedule$discipline_name %in% 
                                   c("Figure Skating", "Speed Skating",
                                     "Short Track Speed Skating"), 
                                 "Skating", 
                                 ifelse(schedule$discipline_name %in% 
                                          c("Curling"), 
                                        "Curling",      
                                        ifelse(schedule$discipline_name %in% 
                                                 c("Snowboard"), 
                                               "Snowboard", 
                                               "Other")
                                        )))


table(schedule$discipline, useNA = "ifany")


# Plot -----------------------------------------------------------

ggplot(schedule) + 
  geom_bar(aes(y = discipline, fill=discipline)) + 
  labs(x = "Número de eventos", y = "",
       title = "Juegos Olímpicos de Invierno 2026: Número de eventos por disciplina") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text = element_text(size = 10),
        axis.title = element_text(size = 12, color="gray20"), 
        axis.title.x = element_text(margin = margin(t = 10, r = 0, b = 0, l = 0)))

ggsave(filename="olympics.jpg", 
       plot=last_plot(), 
       units="in", width = 7, height = 3.8)
