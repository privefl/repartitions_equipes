library(shiny)

shinyUI(fluidPage(
  
  # Application title
  headerPanel("Répartir des équipes"),
  
  # Sidebar with controls to select a dataset and specify the
  # number of observations to view
  sidebarLayout(
    sidebarPanel(
      numericInput('nb_quipes', "Nombre d'équipes", value = 7,
                   min = 4, max = 12),
      submitButton("Lancer"),
      h1(""),
      h4("Temps de calcul :"),
      h5("4-8   => < 1 sec"),
      h5("9-10  => < 1 min"),
      h5("11-12 => < 1 h")
    ),
    
    # Show a summary of the dataset and an HTML table with the 
    # requested number of observations
    mainPanel(
      verbatimTextOutput("summary")
    )
  )
))