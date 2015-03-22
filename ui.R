getYears <- function() {
      ys <- list()
      for(i in 1960:2010) {
          ys <- c(ys, i)  
      }
      ys
}

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
                  h3('Put your name and your birth year on your left 
                            and you would see the evolution of the popularity of your name 
                            along 50 years'),
                  helpText('Note: This app is about people born between 1960 and 2010 in Montevideo Uruguay, 
                              mostly of their names are spanish names like Carlos and Julieta.
                           I use the open data from the Goverment Montevideo - Uruguay 
                           municipality you can download the data from: '),
                  a(href="https://catalogodatos.gub.uy/dataset/partidas-de-registro-civil-de-montevideo", "Partidas-de-registro-civil-de-montevideo"),
                  helpText('Note For the graders: I intended to use NVD3 graphics but it seems ther is a bug
                           when changing the tab and get back to the first tab the graphic cuts off
                           couldnt solve it... you need to refresh the app from the browser.'),
                  h3(verbatimTextOutput("result")),
                  tabsetPanel(
                        tabPanel(textOutput('tab1'), showOutput("stat", "nvd3")), 
                        tabPanel(textOutput('tab2'), showOutput("pieMale", "nvd3")), 
                        tabPanel(textOutput('tab3'), showOutput("pieFemale", "nvd3"))
                  )
            )
      )
)