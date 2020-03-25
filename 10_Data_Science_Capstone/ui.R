
library(shiny)

shinyUI(fluidPage(titlePanel("Data Science Capstone: Next Word Predicton"),

  navbarPage(
             tabPanel("Home",
                      HTML("<strong>Author: Zoom</strong>"),
                      img(src = "https://avatars2.githubusercontent.com/u/35773236?s=400&u=6a92f02cb1f0141d7b678799de250fbf4bf12b5d&v=4", width = 80, height = 80),
                      br(),
                      HTML("<strong>Date: Mar 26, 2020</strong>"),
                      br(),
                      sidebarLayout(
                        sidebarPanel(
                          hr(),
                          hr(),
                          hr(),
                          textInput("inputText", "Enter your word/phrase:",value = ""),
                          hr(),
                          hr(),
                          hr(),
                          
                        ),
                        mainPanel(
                          h2("Word Predicton Result"),
                          h6("Using NLP techquies to predcit next word"),
                          h6("It takes some time to load the database for the first time"),
                          strong("Your input"),
                          verbatimTextOutput("inputWords"),
                          hr(),
                          strong("Next word may be"),
                          strong(code(textOutput("NextWord"))),
                          hr(),
                          h6("Powered by: Swiftkey, JHU, Coursera"),
                          hr(),
                          img(src = "https://secure.webtoolhub.com/static/resources/icons/set181/f225233e.png", width = 80, height = 80),
                          img(src = "https://brand.jhu.edu/assets/uploads/sites/5/2014/06/university.logo_.small_.horizontal.blue_.jpg", width = 180, height = 80),
                          img(src = "https://www.thegeniusworks.com/wp-content/uploads/2015/10/coursera-logo.png", width = 80, height = 80)
                        )
    )
  )
)
)
)

