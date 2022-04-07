# Goal: Use the demo to make a plot of the penguins with selectInput for coloring the points


# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

## easier one first
year_options <- unique(penguins$year)
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Penguins!"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "year",
                        label = "Which year of penguins?",
                        choices = year_options   )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("PenguinPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$PenguinPlot <- renderPlot({
        subset_penguins <- penguins %>% filter(year == input$year)
       p <- ggplot(subset_penguins, aes(x = body_mass_g, y = flipper_length_mm)) + geom_point()
       p
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
