library(shiny)

#helpers
nextPage <- function(id, i) {
    actionButton(NS(id, paste0("go_", i, "_", i + 1)), "next")
}
prevPage <- function(id, i) {
    actionButton(NS(id, paste0("go_", i, "_", i - 1)), "prev")
}

# UI wrap
wrapPage <- function(title, page, button_left = NULL, button_right = NULL) {
    tabPanel(
        title = title, 
        fluidRow(
            column(12, page)
        ), 
        fluidRow(
            column(6, button_left),
            column(6, button_right)
        )
    )
}


