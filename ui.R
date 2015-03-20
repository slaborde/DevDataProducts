getYears <- function() {
      ys <- list()
      for(i in 1960:2010) {
          ys <- c(ys, i)  
      }
      ys
}

#h3('X' + verbatimTextOutput("name") + 'was born in XX'),

require(rCharts)
shinyUI(
      pageWithSidebar(
            #Application title
            headerPanel("How Popular is your Name ??"),
            sidebarPanel(
                  textInput(inputId="name", label = "My name is:", value = 'MARIA'),
                  selectInput('year', 'and born in:', choices = getYears(), selected = 1980),
                  submitButton('Next')
            ),
            mainPanel(
                  helpText('For example put your name and your birth year on your left 
                            and you would see the evolution of the popularity of your name 
                            along 50 years'),
                  helpText('Note: This app is about people born between 1960 and 2010 in Montevideo Uruguay, 
                              mostly of their names are spanish names like Carlos and Julieta.'),
                  h3(textOutput('result')),
                  tabsetPanel(
                        tabPanel(textOutput('tab1'), showOutput("stat", "nvd3")), 
                        tabPanel(textOutput('tab2'), showOutput("pieMale", "nvd3")), 
                        tabPanel(textOutput('tab3'), showOutput("pieFemale", "nvd3"))
                  )
            )
      )
)