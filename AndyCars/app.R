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

my_cars <- rownames_to_column(mtcars, var = "cars")
car_choices <- my_cars$cars
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Car Info"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("chosen_cars",
                        label = "What cars are you interested in?",
                        choices = car_choices,
                        multiple = T )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           tableOutput("car_info")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$car_info <- renderTable({
        table <- my_cars %>% filter(cars %in% input$chosen_cars) %>% select(cars, mpg, hp, qsec)
        table
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
