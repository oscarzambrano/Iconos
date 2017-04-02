# Load packages   
library(shiny)
library(shinydashboard)
library(miniUI)

IconsGadget <- function(inputValue1, inputValue2) {
  # Scraping data 
  source('~/Iconos/Scraping Awesome Icons.R', echo = FALSE)
  source('~/Iconos/Scraping ValidColors.R', echo = FALSE)
  
  # User Interface
  ui <- dashboardPage(
    header =  dashboardHeader(disable = T), 
    sidebar = dashboardSidebar(disable = T), 
    body = dashboardBody(
      sidebarPanel(gadgetTitleBar(title = "Value & Info Boxes", 
                                  left = NULL), 
                   selectInput(inputId = "Icon", 
                               label = "Icon", 
                               choices = Icons$Name, 
                               selected = "check", 
                               multiple = F, 
                               width = "100%"),
                   selectInput(inputId = "Color", 
                               label = "Color",
                               choices = Colors$Color,
                               selected = "aqua", 
                               multiple = F,
                               width = "100%"),
                   textInput(inputId = "Title", 
                             label = "Title", 
                             value = "Title", 
                             width = "100%", 
                             placeholder = "Titulo"),
                   textInput(inputId = "Value", 
                             label = "Value",
                             value = "Value",
                             width = "100%",
                             placeholder = "Valor"),
                   textInput(inputId = "SubTitle",
                             label = "SubTitle", 
                             value = "SubTitle",
                             width = "100%",
                             placeholder = "SubTitulo"),
                   infoBoxOutput(outputId = "InfoBox", 
                                 width = "100%"),
                   valueBoxOutput(outputId = "ValueBox", 
                                  width = "50%"),
                   width = 3))
    
    )
  
  # Server
  server <- function(input, output, session) {
    
    output$InfoBox <- renderInfoBox({
      infoBox(value = ifelse(test = input$Value == "Value", 
                             yes = input$Icon,
                             no = input$Value), 
              title = input$Title,
              subtitle = input$SubTitle,  
              color = input$Color, 
              width = "100%",
              icon = icon(input$Icon))
    })
    
    output$ValueBox <- renderValueBox({
      valueBox(value = ifelse(test = input$Value == "Value", 
                              yes = input$Icon,
                              no = input$Value), 
               subtitle = input$Title, 
               color = input$Color, 
               width = "50%",
               icon = icon(input$Icon))
    })
    
   observeEvent(input$done, {
      returnValue <- "Bye bye"
      stopApp(returnValue)
    })
  }
  
  runGadget(ui, server, viewer =  dialogViewer("Boxes", height = 800, width = 400))
}
