library(shiny)


library(ggplot2)
datasets <- data(package = "ggplot2")$results[c(2, 4, 10), "Item"]

ui <- fluidPage(
    selectInput("dataset", "Dataset", choices = datasets),
    verbatimTextOutput("summary"),
    plotOutput("plot")
)

server <- function(input, output, session) {
    dataset <- reactive({
        get(input$dataset, "package:ggplot2")
    })
    output$summmry <- renderPrint({
        summary(dataset())
    })
    output$plot <- renderPlot({
        print(dataset())
        plot(dataset())
    }, res = 96)
}

# Run the application 
shinyApp(ui = ui, server = server)
