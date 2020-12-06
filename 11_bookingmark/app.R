#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- function(request) {
    fluidPage(
    sidebarLayout(
        sidebarPanel(
            sliderInput("omega", "omega", value = 1, min = -2, max = 2, step = 0.01),
            sliderInput("delta", "delta", value = 1, min = 0, max = 2, step = 0.01),
            sliderInput("damping", "damping", value = 1, min = 0.9, max = 1, step = 0.001),
            numericInput("length", "length", value = 100),
            bookmarkButton()
        ),
        mainPanel(
            plotOutput("fig")
        )
    )
)
}
server <- function(input, output, session) {
    t <- reactive(seq(0, input$length, length = input$length * 100))
    x <- reactive(sin(input$omega * t() + input$delta) * input$damping ^ t())
    y <- reactive(sin(t()) * input$damping ^ t())
    
    output$fig <- renderPlot({
        plot(x(), y(), axes = FALSE, xlab = "", ylab = "", type = "l", lwd = 2)
    }, res = 96)
    
    observe({
        reactiveValuesToList(input)
        print(input)
        session$doBookmark()
    })
    
    onBookmarked(updateQueryString)
}

# Run the application 
shinyApp(ui = ui, server = server, enableBookmarking = 'url')
