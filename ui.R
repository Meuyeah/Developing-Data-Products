
library(shiny)
shinyUI(fluidPage(
    titlePanel("Horsepower prediction from MPG"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value = 10),
            checkboxInput("showModel", "Model ", value = TRUE)
        ),
        mainPanel(
            plotOutput("plot1"),
            h3("Predicted Horsepower from Model:"),
            textOutput("pred")
        )
    )
))