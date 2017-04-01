# Load packages
library(dplyr)
library(tidyr)
library(rvest)
# Read WebPage
WebAwesonIcons <- read_html("http://fontawesome.io/icons/")
# Get Nodes
Nodes <- html_nodes(WebAwesonIcons, ".col-sm-4 a")
# Get list of icons
suppressWarnings(
  Icons <- data_frame(IconName = html_text(Nodes)) %>% 
    separate(col = IconName,
             sep = " ",
             into = c("1", "Example", "of", "Name", "Alias")) %>%
    filter(is.na(Alias)) %>% 
    select(Name))
# Clean work space
rm(Nodes, WebAwesonIcons)
