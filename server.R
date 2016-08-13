library(shiny)
#source("essai.R")
source("new_solution.R")

shinyServer(function(input, output) {
 # Generate a summary of the dataset
  output$summary <- renderPrint({
    N <- input$nb_quipes
    to.print <- ifelse(input$formatOutput == "Texte", TRUE, FALSE)
    oldw <- getOption("warn")
    options(warn = -1)
    Repart(N, to.print) #matchs_par_jour(N) 
    options(warn = oldw)
  })
})
