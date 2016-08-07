library(shiny)
source("essai.R")

shinyServer(function(input, output) {
 # Generate a summary of the dataset
  output$summary <- renderPrint({
    N = input$nb_quipes
    oldw <- getOption("warn")
    options(warn = -1)
    matchs_par_jour(N) 
    options(warn = oldw)
  })
})
