
library(shiny)

# Define UI for application that draws a histogram
# ui <- fluidPage(
#     textInput("nm", "name"),
#     actionButton("clr", "Clear"),
#     textOutput("hi")
# )
# server <- function(input, output, session) {
#     hi <- reactive(paste0("Hi ", input$nm))
#     output$hi <- renderText(hi())
#     
#     observeEvent(input$clr, {
#         updateTextInput(session, "nm", value = "")
#     })
# }
#16.3.1 ====
# ui <- fluidPage(
#     actionButton("drink", "drink me"),
#     actionButton("eat", "eat me"),
#     textOutput("notice")
# )
# server <- function(input, output, session) {
#     notice <- reactiveVal("")
#     observeEvent(input$drink, notice("You are no longer thirsty"))
#     observeEvent(input$eat, notice("You are no longer hungry"))
#     
#     output$notice <- renderText(notice())
# }

# ui <- fluidPage(
#     actionButton("up", "up"),
#     actionButton("down", "down"),
#     textOutput("n")
# )
# server <- function(input, output, session) {
#     n <- reactiveVal(0)
#     observeEvent(input$up, n(n() + 1))
#     observeEvent(input$down, n(n() - 1))
#     
#     output$n <- renderText(n())
# }

#16.3.2 accumulating inputs
# ui <- fluidPage(
#     textInput("name", "name"),
#     actionButton("add", "add"),
#     actionButton("del", "delete"),
#     textOutput("names")
# )
# server <- function(input, output, session) {
#     names <- reactiveVal()
#     observeEvent(input$add, {
#         names(union(names(), input$name))
#         updateTextInput(session, "name", value = "")
#     })
#     observeEvent(input$del, {
#         names(setdiff(names(), input$name))
#         updateTextInput(session, "name", value = "")
#     })
#     
#     output$names <- renderText(names())
# }

#16.3.3
ui <- fluidPage(
    actionButton("start", "start"),
    actionButton("stop", "stop"),
    textOutput("n")
)
server <- function(input, output, session) {
    running <- reactiveVal(FALSE)
    observeEvent(input$start, running(TRUE))
    observeEvent(input$stop, running(FALSE))
    
    n <- reactiveVal(0)
    observe({
        if (running()) {
            n(isolate(n()) + 1)
            invalidateLater(250)
        }
    })
    output$n <- renderText(n())
}

# Run the application 
shinyApp(ui = ui, server = server)
