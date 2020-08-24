library(shiny)
library(mcr)
library(shinydashboard)
library(rhandsontable)
library(rmarkdown)

shinyServer(function(input, output, session) {
  
  datasetInput <- reactive({
    # Statistical results should appear here
    
  })

  #Functions to return sens, spec, and overall agreement.  These are functions b/c they will be used later multiple times
  sens <- reactive({
    round((input$TP / (input$TP + input$FN))*100, digits = 2)
  })
  spec <- reactive({
    round((input$TN / (input$TN + input$FP))*100, digits = 2)
  })
  overall <- reactive({
    round((sens()+spec())/2, digits = 2)
  })
  
  #text output for sens, spec, and overall agreement
  output$sens <- renderText({
    paste(sens(), "%", sep = "")
  })
  output$spec <- renderText({
    paste(spec(), "%", sep = "")
  })
  output$overall <- renderText({
    paste(overall(), "%", sep = "")
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
