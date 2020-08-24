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
      menuItem("Data", tabName = "data_input", 
               icon = icon("table", "fa-lg")
               ),
      menuItem("Sens and Spec", tabName = "sensandspec",
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
      tabItem(tabName = "data_input",

              box(title = "Contingency Calculator", width= 10, status = 'info',
                  
                  #Row 1 houses 'comparative method' text
                  fluidRow(
                    column(width = 6, offset = 3, h4(tags$strong("Comparitive method")))
                  ),
                  #Row 2 houses 'candidate method', 'pos'., 'neg'., and 'tot.'
                  fluidRow(
                    column(3, h4(tags$strong(("Candidate Method")))),
                    column(3, h4("Positive")),
                    column(3, h4("Negative")),
                    column(3, h4(tags$em("Total")))),
                  #Row 3
                  fluidRow(
                    column(3, h4("Positive")),
                    column(3, numericInput(inputId = "TP", label = NULL, value = NULL)),
                    column(3, numericInput(inputId = "FP", label = NULL, value = NULL)),
                    column(3, textOutput("totposcand"))),
                  #Row 4
                  fluidRow(
                    column(3, h4("Negative")),
                    column(3, numericInput(inputId = "FN", label = NULL, value = NULL)),
                    column(3, numericInput(inputId = "TN", label = NULL, value = NULL)),
                    column(3, textOutput("totnegcand"))),
                  #Row 5
                  fluidRow(
                    column(3, h4(tags$em("Total"))),
                    column(3, textOutput("totposcomp")),
                    column(3, textOutput("totnegcomp")),
                    column(3, textOutput("tottest")))
                  )
      ),
      tabItem(tabName = "sensandspec",
                box(title = "Output", width= 10,
                  #Row 1
                  fluidRow(
                    column(width = 2, offset = 5, h4("Percent")),
                    column(width = 2, h4("Lo Limit")),
                    column(width = 2, h4("Hi Limit"))
                  ),
                  #Row 2
                  fluidRow(
                    column(width = 5, h4("Positive agreement/Sensitivity")),
                    column(width = 2, verbatimTextOutput("sens"))
                    #column(width = 3, h4("Lo Limit")),
                    #column(width = 3, h4("Hi Limit"))
                  ),
                  #Row 3
                  fluidRow(
                    column(width = 5, h4("Negative agreement/Specificity")),
                    column(width = 2, verbatimTextOutput("spec"))
                    #column(width = 3, h4("Lo Limit")),
                    #column(width = 3, h4("Hi Limit"))
                  ),
                  #Row 4
                  fluidRow(
                    column(width = 5, h4("Overall agreement")),
                    column(width = 2, verbatimTextOutput("overall"))
                    #column(width = 3, h4("Lo Limit")),
                    #column(width = 3, h4("Hi Limit"))
                  )
                )
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
