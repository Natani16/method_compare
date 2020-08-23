library(shiny)
library(mcr)
library(shinydashboard)
library(rhandsontable)
library(rmarkdown)

shinyServer(function(input, output, session) {
  
  datasetInput <- reactive({
    # Statistical results should appear here
    
  })
  output$specif <- reactive({
    
  })
  output$sens <- reactive({
    
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
