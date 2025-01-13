# The following script uses data from the Southern Poverty Law Center (SPLC) Hate Map (https://www.splcenter.org/hate-map). 

# Load the libraries, color palettes and font ----
pacman::p_load(knitr, plyr, ggplot2, reshape2, stringr, dplyr, likert, tidyr, readr, openxlsx, ggrepel, haven, maps, geofacet, RColorBrewer)

colors_okabe <- c("#0072B2", "#009E73", "#56B4E9", "#D55E00", "#E69F00", "#CC79A7") # I use the Okabe Ito colors since they're color-blind friendly.

palette_brewer <- colorRampPalette(brewer.pal(12, "Paired"))(21)

sysfonts::font_add_google(name = 'Open Sans', family = "text") # I use the Open Sans font for all the text in the figures.
showtext::showtext_auto()

# Here, we load the downloaded data from SPLC and saved in the folder ----
splc00 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2000.csv")
splc01 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2001.csv") 
splc02 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2002.csv") 
splc03 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2003.csv") 
splc04 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2004.csv") 
splc05 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2005.csv") 
splc06 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2006.csv") 
splc07 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2007.csv") 
splc08 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2008.csv") 
splc09 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2009.csv") 
splc10 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2010.csv") 
splc11 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2011.csv") 
splc12 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2012.csv") 
splc13 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2013.csv") 
splc14 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2014.csv") 
splc15 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2015.csv") 
splc16 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2016.csv") 
splc17 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2017.csv") 
splc18 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2018.csv") 
splc19 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2019.csv") 
splc20 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2020.csv") 
splc21 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2021.csv") 
splc22 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2022.csv") 
splc23 <- read_csv("~/GitHub/SPLC/data/splc-hate-groups-2023.csv") 

# Combine the individual data frames in a single data frame and use janitor::clean_name() to change to lower case the variable names.
splc <- bind_rows(splc00, splc01, splc02, splc03, splc04, splc05, splc06, splc07, splc08, splc09, splc10, splc11, splc12, splc13, splc14, splc15, splc16, splc17, splc18, splc19,
                  splc20, splc21, splc22, splc23) %>% 
  janitor::clean_names()

# Aggregate data
glimpse(splc)
str(splc)

# Create two aggregate data frames, the first one shows the number of hate and antigovernment groups by year and state. The second data frame shows the number by year, state and ideology ----
splcxstate <- splc %>%
  group_by(year, state) %>% 
  summarise(total = n())

# write.csv(x = splcxstate, file = "~/GitHub/SPLC/data/SPLC_data_year_state.csv", row.names = F)

splcx <- splc %>% 
  group_by(year, state, ideology) %>% 
  summarise(total = n())

# write.csv(x = splcx, file = "~/GitHub/SPLC/data/SPLC_data_year_state_ideology.csv", row.names = F)

# Plotting the data ----
# Using ggplot2 to visualize the number of hate and antigovernment extremist groups in the US by year and state. 
splcxstate %>% 
  ggplot(aes(x = year, y = total)) + 
  geom_col(color = "#0072B2", fill = "#0072B2") +  
  facet_geo(~state, grid = "us_state_grid3", label = "name") +  
  scale_y_continuous(n.breaks = 5, expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_fill_manual(values = colors_okabe) +
  scale_color_manual(values = colors_okabe) +
  labs(title = "Number of Hate and Antigovernment Extremist Groups in the United States, 2000 - 2023", x = NULL, y = NULL, color = NULL, fill = NULL, 
       caption = "\nSource: Southern Poverty Law Center") +
  theme_minimal() +
  theme(legend.position = "top",
        legend.text = element_text(family = "text", size = 11),
        legend.key.height = grid::unit(3, "mm"),
        legend.key.width = grid::unit(3, "mm"),
        plot.title = element_text(family = "text", face = "bold", size = 18, hjust = 0.5),
        plot.title.position = "plot",
        plot.caption = element_text(family = "text", size = 8, hjust = 0),
        plot.caption.position = "plot",
        axis.text.y = element_text(size = 6, family = "text", color = "black", face = "bold"),
        axis.text.x = element_text(size = 6, family = "text", hjust = 0.5),
        panel.grid = element_blank(),
        panel.border = element_rect(colour = "black", fill = "transparent", linewidth = 0.25))

# Save the plot in the folder as .svg
ggsave(plot = last_plot(), filename = "~/GitHub/SPLC/figures/splc_year_state.svg", device = svg, width = 15, height = 11, units = "in")

# Using ggplot2 to visualize the number of hate and antigovernment extremist groups in the US by year, state, and ideology. 
splcx %>% 
  filter(!is.na(ideology)) %>% 
  ggplot(aes(x = year, y = total)) + 
  geom_col(aes(fill = ideology, color = ideology), position = position_stack(vjust = 1, reverse = T)) +  
  facet_geo(~state, grid = "us_state_grid3", label = "name") +  
  scale_y_continuous(n.breaks = 4, expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_fill_manual(values = palette_brewer) +
  scale_color_manual(values = palette_brewer) +
  guides(fill = guide_legend(ncol = 1)) +
  labs(title = "Number of Hate and Antigovernment Extremist Groups in the United States, 2000 - 2023", x = NULL, y = NULL, color = NULL, fill = NULL, 
       caption = "\nSource: Southern Poverty Law Center") +
  theme_minimal() +
  theme(legend.position = c(0.93, 0.18), legend.direction = "vertical",
        legend.text = element_text(family = "text", size = 10),
        legend.key.height = grid::unit(3, "mm"),
        legend.key.width = grid::unit(3, "mm"),
        plot.title = element_text(family = "text", face = "bold", size = 18, hjust = 0.5),
        plot.title.position = "plot",
        plot.caption = element_text(family = "text", size = 8, hjust = 0),
        plot.caption.position = "plot",
        axis.text.y = element_text(size = 6, family = "text", color = "black", face = "bold"),
        axis.text.x = element_text(size = 6, family = "text", hjust = 0.5),
        panel.grid = element_blank(),
        panel.border = element_rect(colour = "black", fill = "transparent", linewidth = 0.25))

# Save the plot in the folder as .svg
ggsave(plot = last_plot(), filename = "~/GitHub/SPLC/figures/splc_year_state_ideology.svg", device = svg, width = 17, height = 12, units = "in")

















