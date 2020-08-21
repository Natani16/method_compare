library(shiny)
library(mcr)
library(shinydashboard)
library(rhandsontable)
library(rmarkdown)

shinyServer(function(input, output, session) {
  
  datasetInput <- reactive({
    # Statistical results should appear here
  })



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
