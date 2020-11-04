
library(shiny)
library(ggplot2)
mtcars
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("3.2.8 exercises"),
    
    

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            h3('Number 1:'),
            textInput('name', "Name", placeholder = 'Your name'),
            
            h3('Number 2:'),
            sliderInput('dates', "Date selection",min = as.Date('2020-01-01'), value = Sys.Date(),max = as.Date('2020-12-31')),
            
            
            h3('Number 3:'),
            selectInput('test','Group Testing', 
                        choices = list('A' = list("A1","A2","A3"),
                                       'B' = list('B1','B2','B3'))),
            
            h3('Number 4:'),
            sliderInput('num_range', "Number Range", min = 0, max = 100, value = 5,step = 3, animate = TRUE)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot", 
                      click = 'plot_click', 
                      dblclick = 'plot_dblclick',
                      brush = 'plot_brush')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
       ggplot(mtcars, aes(x = mpg, y = cyl, colour = gear)) + geom_point()
    })
    
    # observeEvent(input$plot_click, {
    #     print(input$plot_click)
    # })
    
    # observeEvent(input$plot_dblclick, {
    #     print(input$plot_dblclick)
    # })
    
    observeEvent(input$plot_brush, {
        print(input$plot_brush)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
