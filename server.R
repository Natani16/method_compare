library(shiny)
library(mcr)
library(shinydashboard)
library(rhandsontable)
library(rmarkdown)

shinyServer(function(input, output, session) {
  
  datasetInput <- reactive({
    # Statistical results should appear here
    
  })

  
  #text output for sens, spec, and overall agreement
  output$sens <- renderText({
    paste(round((input$TP / (input$TP + input$FN))*100, digits = 2), "%", sep = "")
  })
  output$spec <- renderText({
    paste(round((input$TN / (input$TN + input$FP))*100, digits = 2), "%", sep = "")
  })
  output$overall <- renderText({
    paste(round((input$TP+input$TN)/(input$TP + input$FP + input$TN + input$FN)*100, digits = 2), "%", sep = "")
  })
  #Q value functions
  {
  #functions for Q1, 2, and 3 for sens
  sensQ1 <- reactive({
    2*input$TP + 3.84
  })
  sensQ2 <- reactive({
    1.96*sqrt(3.84+4*input$TP*input$FN/(input$TP+input$FN))
  })
  sensQ3 <- reactive({
    2*(input$TP+input$FN)+7.68
  })
  #functions for Q1, 2, and 3 for spec
  specQ1 <- reactive({
    2*input$TN + 3.84
  })
  specQ2 <- reactive({
    1.96*sqrt(3.84+4*input$TN*input$FP/(input$TN+input$FP))
  })
  specQ3 <- reactive({
    2*(input$TN+input$FP)+7.68
  })
  #overall Q1, 2, and 3 values
  overallQ1 <- reactive({
    2*(input$TN + input$TP) + 3.84
  })
  overallQ2 <- reactive({
    1.96*sqrt(3.84+4*(input$TP + input$TN)*(input$FP + input$FN)/(input$TP + input$FP + input$TN + input$FN))
  })
  overallQ3 <- reactive({
    2*(input$TP + input$FP + input$TN + input$FN)+7.68
  })
  }
  
  
  
  # text outputs for lo and hi limits
  output$sens_lo <- renderText({
    paste(round(100*((sensQ1()-sensQ2())/sensQ3()), digits = 2), "%", sep = "")
  })
  output$sens_hi <- renderText({
    paste(round(100*((sensQ1()+sensQ2())/sensQ3()), digits = 2), "%", sep = "")
  })
  output$spec_lo <- renderText({
    paste(round(100*((specQ1()-specQ2())/specQ3()), digits = 2), "%", sep = "")
  })
  output$spec_hi <- renderText({
    paste(round(100*((specQ1()+specQ2())/specQ3()), digits = 2), "%", sep = "")
  })
  output$overall_lo <- renderText({
    paste(round(100*((overallQ1()-overallQ2())/overallQ3()), digits = 2), "%", sep = "")
  })
  output$overall_hi <- renderText({
    paste(round(100*((overallQ1()+overallQ2())/overallQ3()), digits = 2), "%", sep = "")
  })
  
  
  #Calculates the totals of each row and the table
  {
  #Total positive candidate tests
  output$totposcand <- renderText({
        input$TP + input$FP
  })
  #Total negative candidate tests
  output$totnegcand <- renderText({
    input$TN + input$FN
  })
  #Total positive comparative tests
  output$totposcomp <- renderText({
    input$TP + input$FN
  })
  #Total negative comparative tests
  output$totnegcomp <- renderText({
    input$TN + input$FP
  })
  #Total tests
  output$tottest <- renderText({
    input$TP + input$FP + input$TN + input$FN
  })
  }

  output$downloadReport <- downloadHandler(
    filename = function() {
      paste(paste(input$m1,'vs.',input$m2, '@', Sys.Date()), sep = '.', switch(
        input$format, PDF = 'pdf', HTML = 'html'
      ))
    },
    content = function(file) {
      
      src <- normalizePath('report.Rmd')
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'report.Rmd')
      out <- rmarkdown::render('report.Rmd', switch(
        input$format,
        PDF = pdf_document(), HTML = html_document(), Word = word_document()
      ))
      file.rename(out, file)
      
    }
    
  )
  
})
