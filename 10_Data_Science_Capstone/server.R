
suppressPackageStartupMessages(
  library(shiny)
)


source("Predict_Word.R")

shinyServer(function(input, output) {
  output$NextWord <- renderPrint({
    result <- predictWord(input$inputText)
    result
  });
  output$inputWords <- renderText({
    input$inputText});
}
)
