#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(
    sliderInput("height", "height", min = 100, max = 500, value = 250),
    sliderInput("width", "width", min = 100, max = 500, value = 250),
    sliderInput("n", "n", min = 10, max = 100, value = 25),
    plotOutput("plot", width = 250, height = 250)
)
server <- function(input, output, session) {
    output$plot <- renderPlot(
        width = function() input$width,
        height = function() input$height,
        res = 96,
        {
            plot(rnorm(input$n), rnorm(input$n))
        }
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
