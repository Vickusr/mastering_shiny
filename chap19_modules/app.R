# refactor this into a module

# We are going to use a new style of module construction that will 
# appear in shiny 1.5.0. Here we define a simple function that lets
# you use the new style in old Shiny. You can delete this code when
# shiny 1.5.0 is out.
# moduleServer <- function(id, module) {
#     callModule(module, id)
# }

library(shiny)
# ui <- fluidPage(
#     selectInput("var", "Variable", names(mtcars)),
#     numericInput("bins", "bins", 10, min = 1),
#     plotOutput("hist")
# )

#UI first ====
# histogramUI <- function(id) {
#     tagList(
#         selectInput(NS(id, "var"), "Variable", names(mtcars)),
#         numericInput(NS(id, "bins"), "bins", 10, min = 1),
#         plotOutput(NS(id, "hist"))
#     )
# }



# server <- function(input, output, session) {
#     data <- reactive(mtcars[[input$var]])
#     output$hist <- renderPlot({
#         hist(data(), breaks = input$bins, main = input$var)
#     }, res = 96)
# }

# Step 2
# server side
# ====
# histogramServer <- function(id) {
#     moduleServer(id, function(input, output, session) {
#         data <- reactive(mtcars[[input$var]])
#         output$hist <- renderPlot({
#             hist(data(), breaks = input$bins, main = input$var)
#         }, res = 96)
#     })
# }

# Updated app
# 
# Now that we have the ui and server functions, 
# it’s good practice to write a function that 
# uses them to generate an app which we can use 
# for experimentation and testing:
# =====      
    histogramApp <- function() {
        ui <- fluidPage(
            histogramUI("hist1")
        )
        server <- function(input, output, session) {
           
            print(session)
             histogramServer("hist1")
        }
        
        shinyApp(ui, server)  
    }

# Note that, like all Shiny control, you 
# need to use the same id in both UI and server, 
# otherwise the two pieces will not be connected.
# ui <- fluidPage(histogramUI('hist1'),
#                 histogramUI('hist2'))
# 
# server <- function(input,output,session){
#     histogramServer('hist1')
#     histogramServer('hist2')
# }
# Run the application 
#shinyApp(ui = ui, server = server)
    histogramApp()