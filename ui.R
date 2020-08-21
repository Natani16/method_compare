library(shiny)
library(mcr)
library(shinydashboard)
library(rhandsontable)
library(rmarkdown)

dashboardPage(
  dashboardHeader(title = "Binary Classification"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Information", tabName = "info", 
               icon = icon("info", "fa-lg")
               ),
      menuItem("Data", tabName = "data", 
               icon = icon("table", "fa-lg")
               ),
      menuItem("Sens and Spec", tabName = "test",
               icon = icon("calculator", "fa-lg")),
      menuItem("Download", tabName = "download",
               icon = icon("download", "fa-lg")
               )
    )
  ),
  dashboardBody(
    tabItems(
      #info
      {tabItem(tabName = "info",
              # Need to write this part providing explanation what this website is used for...
              h4('References and packages:'),
              h5("1. R: A language and environment for statistical computing. 
                 R Foundation for Statistical Computing, Vienna, Austria.",
                  a('https://www.R-project.org',
                  href = "https://www.R-project.org")),
              h5("2. shiny: Web Application Framework for R.",
                 a("http://CRAN.R-project.org/package=shiny", 
                  href = "http://CRAN.R-project.org/package=shiny")),
              h5("3. shinydashboard: Create Dashboards with 'Shiny'.",
                 a('http://rstudio.github.io/shinydashboard',
                  href = "http://rstudio.github.io/shinydashboard")),
              h5("4. pander: An R Pandoc Writer.",
                 a('http://rapporter.github.io/pander',
                  href = "http://rapporter.github.io/pander")),
              h5("5. rmarkdown: Dynamic Documents for R.",
                 a('http://rmarkdown.rstudio.com',
                 href = "http://rmarkdown.rstudio.com")),
              br(),
              h4('For any questions or concerns please contact:', 
                 a("Burak Bahar, MD", href = "mailto:burakbaharmd@gmail.com"))
              )},
      tabItem(tabName = "data",

              # You should turn this part to a 2x2 table instead of 4 rows

              box(title = "Enter Data", status = 'info',
                  h4("Comparative method:"),
                  numericInput(inputId = "pos_tests_met", label = "Enter the number of positive tests from the comparitive method:", value = NA),
                  numericInput(inputId = "neg_tests_met", label = "Enter the number of negative tests from the comparative method:", value = NA),
                  h4("Method being tested:"),
                  numericInput(inputId = "pos_tests_test", label = "Enter the number of positive tests from the method being tested:", value = NA),
                  numericInput(inputId = "neg_tests_test", label = "Enter the number of negative tests from the method being tested:", value = NA),
                  
                  ),


      ),
      

      tabItem(tabName = "test",
                box(title = "Output",h4("Test to see if tab shows"), verbatimTextOutput("sensitivity"))
                
              
              
      ),
      tabItem(tabName = "download",
              box(title = "Download Report", status = 'info',
              radioButtons('format', h5('Document format'), 
                           c('PDF', 'HTML'),
                           inline = TRUE),
              downloadButton('downloadReport')
              )
          )
      )
    )
  )
