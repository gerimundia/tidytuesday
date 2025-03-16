
# Packages -----------------------------------------------------------

pacman::p_load(tidytuesdayR, data.table, extrafont, ggplot2, ggimage)


# Data -----------------------------------------------------------


tuesdata <- tidytuesdayR::tt_load('2025-03-11')

pixar_films <- tuesdata$pixar_films

pixar_films <- pixar_films[c(1:24), ]

films <- pixar_films[order(-pixar_films$run_time), ]

films <- head(films, 10)

films <- data.table(films)

films$label <- films$film

films[film=="Monsters University", label:=paste("Monsters","University", sep="\n")]
films[film=="The Incredibles", label:=paste("The","Incredibles", sep="\n")]

films$anio <- year(films$release_date)

films$label2 <- paste(films$label,paste0("(",as.character(films$anio),")"), sep="\n")

films$vjust <- (c(-1, 2, -1, 1.5, -1, 2, -1, 1.5, -1, 2))

# Plot -----------------------------------------------------------

font_import()
loadfonts(device = "win")
windowsFonts() 

ggplot(films, aes(x = reorder(film, -run_time), y = run_time)) +
  geom_point(aes(color=film), size=19) +
  geom_text(aes(label = label2), vjust = films$vjust, size=4.5, family = "Comic Sans MS") +
  ylim(60,180) +
  labs(title = "10 películas de Pixar con mayor duración (hasta 2021)", 
       y="Duración de la película (minutos)", x="",
       caption="Data: {pixarfilms}") + 
  theme_minimal(base_family = "Comic Sans MS") +
  theme(text = element_text(family = "Comic Sans MS"),
    panel.background = element_rect(fill = "#fcf0d2", colour = "#fcf0d2"), 
    panel.border = element_blank(), 
    axis.line = element_blank(),
    axis.ticks.y=element_blank(),
    axis.text.x=element_blank(),
    axis.title=element_text(size = 15),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face="bold", size = 18),
    axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
    legend.position = "none",
    plot.background = element_rect(fill = "#fcf0d2", colour = "#fcf0d2"),
    plot.margin = margin(t=5, r=1, b=1, l=10),
    plot.caption = element_text(hjust = 0, vjust = 2.5, size=11))

ggsave(last_plot(), file="pixar.png")

