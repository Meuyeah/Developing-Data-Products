library(shiny)

shinyServer(function(input, output) {
    mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
    model <- lm(hp ~ mpgsp + mpg, data = mtcars)
    
    
    modelpred <- reactive({
        mpgInput <- input$sliderMPG
        predict(model, newdata = 
                    data.frame(mpg = mpgInput,
                               mpgsp = ifelse(mpgInput - 20 > 0,
                                              mpgInput - 20, 0)))
    })
    
    output$plot1 <- renderPlot({
        mpgInput <- input$sliderMPG
        
        plot(mtcars$mpg, mtcars$hp, xlab = "MPG", 
             ylab = "HP", bty = "n", pch = 16,
             xlim = c(10, 35), ylim = c(50, 350))
        if(input$showModel){
            modellines <- predict(model, newdata = data.frame(
                mpg = 10:35, mpgsp = ifelse(10:35 - 20 > 0, 10:35 - 20, 0)
            ))
            lines(10:35, modellines, col = "blue", lwd = 4)
        }
        legend(25, 250,  "Model Prediction", pch = 16, 
               col =  "blue", bty = "n", cex = 1.2)
        points(mpgInput, modelpred(), col = "blue", pch = 16, cex = 2)
    })
    
    
    output$pred <- renderText({
        modelpred()
    })
})
