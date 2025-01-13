# libs ----
pacman::p_load(knitr, plyr, ggplot2, reshape2, stringr, dplyr, likert, tidyr, readr, openxlsx, ggrepel, haven, maps, geofacet, gghighlight)

colors_okabe <- c("#0072B2", "#009E73", "#56B4E9", "#D55E00", "#E69F00", "#CC79A7")

sysfonts::font_add_google(name = 'Open Sans', family = "text") # Changed from DM Sans
showtext::showtext_auto()

# load data ----
splc00 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2000.csv")
splc01 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2001.csv") 
splc02 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2002.csv") 
splc03 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2003.csv") 
splc04 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2004.csv") 
splc05 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2005.csv") 
splc06 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2006.csv") 
splc07 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2007.csv") 
splc08 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2008.csv") 
splc09 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2009.csv") 
splc10 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2010.csv") 
splc11 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2011.csv") 
splc12 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2012.csv") 
splc13 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2013.csv") 
splc14 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2014.csv") 
splc15 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2015.csv") 
splc16 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2016.csv") 
splc17 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2017.csv") 
splc18 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2018.csv") 
splc19 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2019.csv") 
splc20 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2020.csv") 
splc21 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2021.csv") 
splc22 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2022.csv") 
splc23 <- read_csv("C:/Users/urlo2939/OneDrive - UCB-O365/Documents/GitHub/cspv/Firearm suicide - Masculinity/Data/SPLC/splc-hate-groups-2023.csv") 

splc <- bind_rows(splc00, splc01, splc02, splc03, splc04, splc05, splc06, splc07, splc08, splc09, splc10, splc11, splc12, splc13, splc14, splc15, splc16, splc17, splc18, splc19,
                  splc20, splc21, splc22, splc23) %>% 
  janitor::clean_names()

# data ----
splcxyear <- splc %>% 
  group_by(year) %>% 
  summarise(total = n())

splcxstate <- splc %>%
  group_by(year, state) %>% 
  summarise(total = n())

splcxideology <- splc %>% 
  group_by(ideology) %>% 
  summarise(total = n())

splcx <- splc %>% 
  group_by(year, state, ideology) %>% 
  summarise(total = n())

splcxstate %>% 
  ggplot(aes(x = year, y = total)) + 
  geom_area(color = "#0072B2", fill = "#E69F00", linewidth = 1, alpha = 0.7) +  
  #geom_hline(yintercept = 0.5, color = "white", linetype = "dashed", linewidth = 0.35) +
  facet_geo(~state, grid = "us_state_grid3", label = "name") +  
  scale_y_continuous(n.breaks = 5, expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_fill_manual(values = colors_okabe) +
  scale_color_manual(values = colors_okabe) +
  labs(title = "Hate and Antigovernment Extremist Groups in the United States, 2000 - 2023", x = NULL, y = NULL, color = NULL, fill = NULL, 
       caption = "Source: Southern Poverty Law Center") +
  theme_minimal() +
  theme(legend.position = "top",
        legend.text = element_text(family = "text", size = 11),
        legend.key.height = grid::unit(3, "mm"),
        legend.key.width = grid::unit(3, "mm"),
        plot.title = element_text(family = "text", face = "bold", size = 18, hjust = 0.5),
        plot.title.position = "plot",
        axis.text.y = element_text(size = 6, family = "text", color = "black", face = "bold"),
        axis.text.x = element_text(size = 6, family = "text", hjust = 0.5),
        panel.grid = element_blank(),
        panel.border = element_rect(colour = "black", fill = "transparent", linewidth = 0.25))


splcx %>% 
  ggplot(aes(x = year, y = total)) + 
  geom_area(aes(fill = ideology, color = ideology), position = position_fill(vjust = 1, reverse = T)) +  
  #geom_hline(yintercept = 0.5, color = "white", linetype = "dashed", linewidth = 0.35) +
  facet_geo(~state, grid = "us_state_grid3", label = "name") +  
  scale_y_continuous(labels = scales::percent, n.breaks = 4, expand = c(0, 0)) +
  scale_x_continuous(expand = c(0, 0)) +
  # scale_fill_manual(values = colors_okabe) +
  # scale_color_manual(values = colors_okabe) +
  labs(title = "Hate and Antigovernment Extremist Groups in the United States, 2000 - 2023", x = NULL, y = NULL, color = NULL, fill = NULL, 
       caption = "Source: Southern Poverty Law Center") +
  theme_minimal() +
  theme(legend.position = "top",
        legend.text = element_text(family = "text", size = 11),
        legend.key.height = grid::unit(3, "mm"),
        legend.key.width = grid::unit(3, "mm"),
        plot.title = element_text(family = "text", face = "bold", size = 18, hjust = 0.5),
        plot.title.position = "plot",
        axis.text.y = element_text(size = 6, family = "text", color = "black", face = "bold"),
        axis.text.x = element_text(size = 6, family = "text", hjust = 0.5),
        panel.grid = element_blank(),
        panel.border = element_rect(colour = "black", fill = "transparent", linewidth = 0.25))


























