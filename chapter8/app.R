
library(shiny)
library(shinyFeedback)

# 8.1.1
# ui <- fluidPage(
#     shinyFeedback::useShinyFeedback(),
#     numericInput("n", "n", value = 10),
#     textOutput("half")
# )
# 
# # Define server logic required to draw a histogram
# server <- function(input, output, session) {
#     observeEvent(input$n,
#                  shinyFeedback::feedbackWarning(
#                      "n", 
#                      input$n %% 2 != 0,
#                      "Please select an even number"
#                  )  
#     )
#     output$half <- renderText(input$n / 2)
# }
# 
# # Run the application 
# shinyApp(ui = ui, server = server)

#8.1.3
# ui <- fluidPage(
#     shinyFeedback::useShinyFeedback(),
#     textInput("dataset", "Dataset name"), 
#     tableOutput("data")
# )
# 
# server <- function(input, output, session) {
#     data <- reactive({
#         req(input$dataset)
#         
#         exists <- exists(input$dataset, "package:datasets")
#         shinyFeedback::feedbackDanger("dataset", !exists, "Unknown dataset")
#         #req(exists, cancelOutput = TRUE)
#         req(exists)
#         get(input$dataset, "package:datasets")
#     })
#     
#     output$data <- renderTable({
#         head(data())
#     })
# }

#8.1.4
# ui <- fluidPage(
#     numericInput("x", "x", value = 0),
#     selectInput("trans", "transformation", 
#                 choices = c("square", "log", "square-root")
#     ),
#     textOutput("out")
# )
# 
# server <- function(input, output, server) {
#     output$out <- renderText({
#         if (input$x < 0 && input$trans %in% c("log", "square-root")) {
#             validate("x can not be negative for this transformation")
#         }
#         
#         switch(input$trans,
#                square = input$x ^ 2,
#                "square-root" = sqrt(input$x),
#                log = log(input$x)
#         )
#     })
# }

# 8.2.3
# ui <- fluidPage(
#     tableOutput("data")
# )
# 
# server <- function(input, output, session) {
#     notify <- function(msg, id = NULL) {
#         showNotification(msg, id = id, duration = NULL, closeButton = FALSE)
#     }
#     
#     data <- reactive({ 
#         id <- notify("Reading data...")
#         on.exit(removeNotification(id), add = TRUE)
#         Sys.sleep(1)
#         
#         notify("Reticulating splines...", id = id)
#         Sys.sleep(1)
#         
#         notify("Herding llamas...", id = id)
#         Sys.sleep(1)
#         
#         notify("Orthogonalizing matrices...", id = id)
#         Sys.sleep(1)
#         
#         mtcars
#     })
#     
#     output$data <- renderTable(head(data()))
# }

#8.3.1 - progress bar
# ui <- fluidPage(
#     numericInput("steps", "How many steps?", 10),
#     actionButton("go", "go"),
#     textOutput("result")
# )
# 
# server <- function(input, output, session) {
#     data <- reactive({
#         req(input$go)
#         
#         progress <- Progress$new(max = input$steps)
#         on.exit(progress$close())
#         
#         progress$set(message = "Computing random number")
#         for (i in seq_len(input$steps)) {
#             Sys.sleep(0.5)
#             progress$inc(1)
#         }
#         runif(1)
#     })
#     
#     output$result <- renderText(round(data(), 2))
# }

#8.3.2 - waiter
# ui <- fluidPage(
#     waiter::use_waitress(),
#     numericInput("steps", "How many steps?", 10),
#     actionButton("go", "go"),
#     textOutput("result")
# )
# server <- function(input, output, session) {
#     data <- reactive({
#         req(input$go)
#         #waitress <- waiter::Waitress$new(max = input$steps, theme = 'overlay-percent')
#         waitress <- waiter::Waitress$new(selector = "#steps", theme = 'overlay-percent')
#         
#         on.exit(waitress$close())
#         
#         for (i in seq_len(input$steps)) {
#             Sys.sleep(0.5)
#             waitress$inc(1)
#         }
#         
#         runif(1)
#     })
#     
#     output$result <- renderText(round(data(), 2))
# }

#8.3.3
# ui <- fluidPage(
#     waiter::use_waiter(),
#     actionButton("go", "go"),
#     textOutput("result")
# )
# 
# server <- function(input, output, session) {
#     data <- reactive({
#         req(input$go)
#         waiter <- waiter::Waiter$new()
#         waiter$show()
#         on.exit(waiter$hide())
#         
#         Sys.sleep(sample(5, 1))
#         runif(1)
#     })
#     output$result <- renderText(round(data(), 2))
# }

#example 2
# ui <- fluidPage(
#     waiter::use_waiter(),
#     actionButton("go", "go"),
#     plotOutput("plot"),
# )
# 
# server <- function(input, output, session) {
#     data <- reactive({
#         req(input$go)
#         waiter::Waiter$new(id = "plot")$show()
#         
#         Sys.sleep(3)
#         data.frame(x = runif(50), y = runif(50))
#     })
#     
#     output$plot <- renderPlot(plot(data()), res = 96)
# }
# 

# example 3 - cssloaders
library(shinycssloaders)

ui <- fluidPage(
    actionButton("go", "go"),
    withSpinner(plotOutput("plot")),
)
server <- function(input, output, session) {
    data <- reactive({
        req(input$go)
        Sys.sleep(3)
        data.frame(x = runif(50), y = runif(50))
    })
    
    output$plot <- renderPlot(plot(data()), res = 96)
}


shinyApp(ui = ui, server = server)

