library(dplyr)
library(tidyr)
library(rvest)
WebAwesonIcons <- read_html("http://fontawesome.io/icons/")
Nodes <- html_nodes(WebAwesonIcons, ".col-sm-4 a")
Icons <- data_frame(IconName = html_text(Nodes)) %>% 
  separate(col = IconName, 
           sep = " ", 
           into = c("1", "Example", "of", "Name", "Alias")) %>% 
  filter(is.na(Alias)) %>% 
  select(Name)
saveRDS(object = Icons, file = "Icons.RDS")
