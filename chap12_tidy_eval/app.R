#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
    selectInput("vars_g", "Group by", names(mtcars), multiple = TRUE),
    selectInput("vars_s", "Summarise", names(mtcars), multiple = TRUE),
    tableOutput("data")
)

server <- function(input, output, session) {
    output$data <- renderTable({
        mtcars %>% 
            group_by(across(all_of(input$vars_g))) %>% 
            summarise(across(all_of(input$vars_s), mean), n = n())
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
