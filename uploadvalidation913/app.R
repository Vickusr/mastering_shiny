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
    fileInput("file", NULL, accept = c(".csv", ".tsv")),
    numericInput("n", "Rows", value = 5, min = 1, step = 1),
    tableOutput("head")
)

server <- function(input, output, session) {
    data <- reactive({
        req(input$file)
        
        ext <- tools::file_ext(input$file$name)
        switch(ext,
               csv = vroom::vroom(input$file$datapath, delim = ","),
               tsv = vroom::vroom(input$file$datapath, delim = "\t"),
               validate("Invalid file; Please upload a .csv or .tsv file")
        )
    })
    
    output$head <- renderTable({
        head(data(), input$n)
    })
}
# Run the application 
shinyApp(ui = ui, server = server)
