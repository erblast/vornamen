
library(shiny)
library(tidyverse)
library(DT)

files = dir('./data/vornamen', '.csv$', full.names = T) 


df = tibble( files = files) %>%
    mutate( data = map(files, read_csv) ) %>%
    unnest(data) %>%
    group_by(vorname, geschlecht ) %>%
    summarise( anzahl = sum(anzahl) ) %>%
    mutate( set = str_to_lower(vorname)
            , set = str_split(set, '')
            , set = map(set, sort)
            , set = map(set, unique)
            , set = map_chr( set, paste, collapse = '')
            )


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$table <- DT::renderDataTable({
        
        
        withProgress( message = 'setting filter',{
            set_input = input$letters %>%
                unique() %>%
                sort() %>%
                paste( collapse = '.*')
            
            df %>%
                filter( str_detect(set, set_input), geschlecht %in% input$gender  ) %>%
                arrange(desc(anzahl)) %>%
                select(-set) %>%
                DT::datatable(  options = list(pageLength = nrow(.) ) )
        })
    })
    
    output$text = renderText( 'Searches all German forenames from Cologne of the last years' )

})
