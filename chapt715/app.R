
library(shiny)
library(ggplot2)
ui <- fluidPage(
    plotOutput("plot", brush = "plot_brush"),
    tableOutput("data")
)
server <- function(input, output, session) {
    selected <- reactiveVal(rep(TRUE, nrow(mtcars)))
    #selected()
    observeEvent(input$plot_brush, {
        #req(input$plot_brush)
        brushed <- brushedPoints(mtcars, input$plot_brush, allRows = TRUE)$selected_
        #print("brused")
        #print(brushed)
        
       # print("selected")
      #  print(selected(ifelse(brushed, !selected(), selected())))
        selected(ifelse(brushed, !selected(), selected()))
    })
    
    output$plot <- renderPlot({
        mtcars$sel <- selected()
        ggplot(mtcars, aes(wt, mpg)) + 
            geom_point(aes(colour = sel)) +
            scale_colour_discrete(limits = c("TRUE", "FALSE"))
    }, res = 96)
    
}
# Run the application 
shinyApp(ui = ui, server = server)
