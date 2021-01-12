library(shiny)
datasetInput <- function(id, filter = NULL) {
    names <- ls("package:datasets")
    if (!is.null(filter)) {
        data <- lapply(names, get, "package:datasets")
        names <- names[vapply(data, filter, logical(1))]
    }
    
    selectInput(NS(id, "dataset"), "Pick a dataset", choices = names)
}
datasetServer <- function(id) {
    moduleServer(id, function(input, output, session) {
        reactive(get(input$dataset, "package:datasets"))
    })
}

datasetApp <- function(filter = NULL) {
    ui <- fluidPage(
        datasetInput("dataset", filter = filter),
        tableOutput("data")
    )
    server <- function(input, output, session) {
        data <- datasetServer("dataset")
        output$data <- renderTable(head(data()))
    }
    shinyApp(ui, server)
}
# datasetApp(is.data.frame)
find_vars <- function(data, filter) {
    # stopifnot(is.data.frame(data))
    # stopifnot(is.function(filter))
    names(data)[vapply(data, filter, logical(1))]
}
# 
# You might also apply this strategy to find_vars(). 
# It’s not quite as important here, but because debugging 
# Shiny apps is a little harder than debugging regular R code, 
# I think it does make sense to invest a little more 
# time in checking inputs so that you get clearer error 
# messages when something goes wrong.
# 
# find_vars <- function(data, filter) {
#     stopifnot(is.data.frame(data))
#     stopifnot(is.function(filter))
#     names(data)[vapply(data, filter, logical(1))]
# }

# This caught a couple of errors that I made while working on this chapter.

selectVarInput <- function(id) {
    selectInput(NS(id, "var"), "Variable", choices = NULL) 
}

selectVarServer <- function(id, data, filter = is.numeric) {
    moduleServer(id, function(input, output, session) {
        observeEvent(data(), {
            updateSelectInput(session, "var", choices = find_vars(data(), filter))
        })
        
        reactive(data()[[input$var]])
    })
}

selectVarApp <- function(filter = is.numeric) {
    ui <- fluidPage(
        datasetInput("data", is.data.frame),
        selectVarInput("var"),
        verbatimTextOutput("out")
    )
    server <- function(input, output, session) {
        data <- datasetServer("data")
        var <- selectVarServer("var", data, filter = filter)
        output$out <- renderPrint(var())
    }
    
    shinyApp(ui, server)
}
selectVarApp()
#datasetApp()
