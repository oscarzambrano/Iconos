Credenciales <- function(inputValue1, inputValue2) {

  # User Interface
  ui <- dashboardPage(
    header =  dashboardHeader(disable = T), 
    sidebar = dashboardSidebar(disable = T), 
    body = dashboardBody(
      sidebarPanel(gadgetTitleBar(title = "Credenciales", 
                                  left = NULL), 
                   radioButtons(inputId = "server",
                                label = "Servidor", 
                                choices = c("115", "130", "Ambos"), 
                                selected = "130", 
                                inline = T, 
                                width = "100%"),
                   textInput(inputId = "user", 
                             label = "Usuario:", 
                             value = "", 
                             width = "100%", 
                             placeholder = "MiUsuario"),
                   passwordInput(inputId = "password", 
                                 label = "Contraseña:", 
                                 value = "", 
                                 width = "100%", 
                                 placeholder = "Mi.contraseña"),
                  actionButton(inputId = "save", 
                               label = "Guardar", 
                               icon = icon("vcard"), 
                               width = "50%"),
                  uiOutput(outputId = "check", inline = T, align = "center"),
                  width = 3))
    
  )
  
  # Server
  server <- function(input, output, session) {
    
    output$check <- renderUI({
      icon(name = dplyr::if_else(condition = input$save != 0, true = "check", false = "question"))
    })
    
    observeEvent(input$save, {
      if (file.exists("ID.RDS")){
        ID <- readRDS("ID.RDS")
        if (input$server == "Ambos") {
          ID <- list(uid115 = input$user,
                     uid130 = input$user,
                     pdw115 = input$password,
                     pdw130 = input$password)  
        } else if (input$server == "130") {
          ID$uid130 <- input$user
          ID$pdw130 <- input$user
          
        } else {
          ID$uid115 <- input$user
          ID$pdw1150 <- input$user
        }
      } else {
        ID <- list(uid115 = input$user,
                   uid130 = input$user,
                   pdw115 = input$password,
                   pdw130 = input$password)
        
      }
      saveRDS(object = ID, file = "ID.RDS", ascii = T)
    })

    
    observeEvent(input$done, {
      returnValue <- "Listo!"
      stopApp(returnValue)
    })
  }
  
  runGadget(ui, server, viewer =  dialogViewer("Boxes", height = 800, width = 400))
}
