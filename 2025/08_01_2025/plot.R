

# Packages -----------------------------------------------------------

pacman::p_load(dplyr, ggplot2, gganimate, foreign, stringr, viridis)


# Data -----------------------------------------------------------

url <- "https://sadapmcmmm.blob.core.windows.net/strapi-uploads/assets/PT_CM_Executive_Summary_12122023_a55eea08ef.csv"

childmarriagedata <- read.csv(url)

variables <- c("REF_AREA","TIME_PERIOD","OBS_VALUE")

data <- childmarriagedata %>% 
        filter(INDICATOR == "PT_F_20-24_MRD_U18",
               AGE == "Y20T24",
               EDUCATION_LEVEL == "_T",
               EDUCATION_LEVEL == "_T",	
               WEALTH_QUINTILE == "_T",	
               RESIDENCE == "_T",	
               RELIGION == "_T",	
               ETHNICITY == "_T",	
               PROJECTION_SCENARIO == "_T",	
               CH_MARRIAGE_STATUS == "_T",
               UNIT_MEASURE == "PCNT",
               str_starts(REF_AREA, "UNICEF")) %>% 
        select(all_of(variables))

data$Area <- sub("^UNICEF_", "", data$REF_AREA)

unique(data$Area)


# Plot -----------------------------------------------------------

note <- paste("Source: The Child Marriage Data Portal.",
              "EAP: East Asia and Pacific, ECA: Europe and Central Asia, SA: South Asia,",
              "EECA: Eastern Europe and Central Asia, SSA: Sub-Saharan Africa",
              "ESA: Eastern and Southern Africa, LAC: Latin America and Caribbean",
              "MENA: Middle East and North Africa, WCA: West and Central Africa", sep="\n")

ggplot(data, aes(x=TIME_PERIOD, y=OBS_VALUE, color=Area)) + 
          geom_line(linewidth=1.5) + 
          geom_point(size=4.0) +
          scale_color_viridis(discrete = TRUE) +
           labs(x="Year", 
                y="", 
                color="",
                title="Percentage of women aged 20-24 who were in union before age 18",
                caption=note) + 
          transition_reveal(TIME_PERIOD) +
          theme_minimal() + 
          theme(axis.text.y  = element_text(size=9),
                axis.text.x  = element_text(size=10),
                axis.title = element_text(size=11, color="gray10"), 
                axis.title.x = element_text(margin = margin(t = 15, r = 0, b = 10, l = 0)),
                axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
                legend.text =  element_text(size=11, color="gray10"),
                legend.position = "right",
                legend.key.size = unit(0.8, 'cm'),
                panel.grid.minor = element_blank(),
                plot.title.position = "plot",
                plot.title = element_text(margin = margin(t = 5, r = 0, b = 10, l = 0)),
                plot.caption =  element_text(hjust=0, margin = margin(0, 0, 10, 0),
                                             size=8, color="gray20"))

anim_save("childmarriage.gif", animation = last_animation(), )


