
# Books ====
# https://r4ds.had.co.nz/
# https://adv-r.hadley.nz/
# https://r-pkgs.org/
#   
# Shiny Extentions
# https://github.com/nanxstats/awesome-shiny-extensions

# Deployment:
# https://rstudio.com/resources/rstudioconf-2019/shiny-in-production-principles-practices-and-tools/
# https://shiny.rstudio.com/articles/#deployment
#   

# other things to look into
# bookdown, blogdown
# netifly
# Github Actions


install.packages(c(
  "gapminder", "ggforce", "globals", "openintro", "shiny", 
  "shinycssloaders", "shinyFeedback", "shinythemes", "testthat", 
  "thematic", "tidyverse", "vroom", "waiter", "xml2", "zeallot" 
))

# CSS bootstrap classes
actionButton("click", "Click me!", class = "btn-danger")
actionButton("drink", "Drink me!", class = "btn-lg btn-success")
actionButton("drink", "Drink me!", icon = icon("cocktail"))


# render function
# Note that the {} are not required in render functions, 
# unless you need to run multiple lines of code.


# renderText() combines the result into a single string.
# renderPrint() prints the result.

# Data table refences
# https://datatables.net/reference/option/
# https://shiny.rstudio.com/reference/shiny/latest/renderDataTable.html

# THEMES
# https://dreamrs.github.io/fresh/





