library(shiny)

shinyUI(fluidPage(
  
  # Application title
  headerPanel("Répartir des équipes"),
  
  # Sidebar with controls to select a dataset and specify the
  # number of observations to view
  sidebarLayout(
    sidebarPanel(
      numericInput('nb_quipes', "Choisis le nombre d'équipes", value = 7,
                   min = 3),
      
      selectInput('formatOutput', 
                  label = "Choisis le format de sortie",
                  choices = c("Matrice", "Texte"),
                  selected = "Texte")
      
    ),
    
    # Show a summary of the dataset and an HTML table with the 
    # requested number of observations
    mainPanel(
      verbatimTextOutput("summary")
    )
  )
))