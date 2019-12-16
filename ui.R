#

library(shiny)
library(DT)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Vornamen")
    , shiny::textOutput('text')

    # Sidebar with a slider input for number of bins
    , sidebarLayout(
        shiny::sidebarPanel(
            shiny::checkboxGroupInput('gender', 'Geschlecht', selected = 'm', choices = c('m','f'))
            , shiny::checkboxGroupInput('letters', 'Buchstaben', selected = c('a','i','m','n'), choices = letters )
        )
        # Show a plot of the generated distribution
        , mainPanel(
            DT::DTOutput("table", height = 10000)
        )
    
)) )
