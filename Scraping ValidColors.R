# Load packages
library(dplyr)
library(tidyr)
library(rvest)
# Read WebPage
ValidColors <- read_html("https://www.rdocumentation.org/packages/shinydashboard/versions/0.5.3/topics/validColors")
# Get Nodes
Nodes <- html_nodes(ValidColors, "code")
# Get list of icons
Colors <- data_frame(Color = html_text(Nodes))
# Clean work space
rm(Nodes, ValidColors)
