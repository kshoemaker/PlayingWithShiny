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
library(plotly)


color_options <- c("species", "island", "year", "sex")
axis_options <- c("bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Penguins!"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "color",
                        label = "Color your points by:",
                        choices = color_options  ),
            selectInput(inputId = "x",
                        label = "Variable on the X axis:",
                        choices = axis_options, 
                        selected = "bill_length_mm"),
            selectInput(inputId = "y",
                        label = "Variable on the Y axis:",
                        choices = axis_options, 
                        selected = "bill_depth_mm"  )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("PenguinPlot"), 
           plotOutput("ColorPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    # color_choice <- reactive({get(input$color)})
    my_penguins <- penguins %>% mutate(year = factor(year))
    
    output$PenguinPlot <- renderPlot({
       p <- ggplot(my_penguins, aes(x = .data[[input$x]], y = .data[[input$y]], col = .data[[input$color]])) + geom_point()
       p
    })
    output$ColorPlot <- renderPlot(({
        p2 <- ggplot(my_penguins, aes(x = .data[[input$color]], fill =.data[[input$color]] )) + geom_bar()
        p2
    }))
}

# Run the application 
shinyApp(ui = ui, server = server)
