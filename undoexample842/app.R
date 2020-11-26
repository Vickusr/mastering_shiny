
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    textAreaInput("message", 
                  label = NULL, 
                  placeholder = "What's happening?",
                  rows = 3
    ),
    actionButton("tweet", "Tweet")
)

# Define server logic required to draw a histogram
runLater <- function(action, seconds = 3) {
    observeEvent(
        invalidateLater(seconds * 1000), action, 
        ignoreInit = TRUE, 
        once = TRUE, 
        ignoreNULL = FALSE,
        autoDestroy = FALSE
    )
}

server <- function(input, output, session) {
    waiting <- NULL
    last_message <- NULL
    
    observeEvent(input$tweet, {
        notification <- glue::glue("Tweeted '{input$message}'")
        last_message <<- input$message
        updateTextAreaInput(session, "message", value = "")
        
        showNotification(
            notification,
            action = actionButton("undo", "Undo?"),
            duration = NULL,
            closeButton = FALSE,
            id = "tweeted",
            type = "warning"
        )
        
        waiting <<- runLater({
            cat("Actually sending tweet...\n")
            removeNotification("tweeted")
        })
    })
    
    observeEvent(input$undo, {
        waiting$destroy()
        showNotification("Tweet retracted", id = "tweeted")
        updateTextAreaInput(session, "message", value = last_message)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
