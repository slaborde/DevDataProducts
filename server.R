library(ggplot2)
library(devtools)
library(rCharts)

userData <- function(names){
      userData <- subset(data, Name == names)
}

top10 <- function(year, gender){
      top10 <- subset(data, Year == year & Sex == gender, select = c('Name','TotalBirth'))
      top10 <- top10[order(-top10$TotalBirth),]
      head(top10, 10)
}

colClasses <- c('numeric','factor','factor', 'character')
data <- read.csv('nombre_nacim_por_anio_y_sexo.csv', 
                 header = TRUE, na.strings = "NA", colClasses = colClasses,  skipNul = TRUE)

data <- subset(data, Name != '') 
data <- data.frame(Year = data$Year, Sex = data$Sex, Name = data$Name, 
                   TotalBirth = as.numeric(data$TotalBirth))

shinyServer(
      function(input, output) {
            output$name <- renderText({toupper(input$name)})
            output$tab1 <- renderText({paste('Statistics for:', input$name, sep = ' ')})
            output$tab2 <- renderText({paste('Popular Male Names in:', input$year, sep = ' ')})
            output$tab3 <- renderText({paste('Popular Female Names in:', input$year, sep = ' ')})
            output$result <- renderText({
                  dat <- userData(toupper(input$name))
                  if (nrow(dat) > 0) {
                        dat <- aggregate(data = dat, TotalBirth ~ Year + Name, sum)
                        total <- subset(dat, Year == input$year, select = c('Year','TotalBirth'))
                  }
                  paste(total$TotalBirth, toupper(input$name), 'was born in', input$year, sep = " ")})
            output$stat <- renderChart({
                  uData <- userData(toupper(input$name))
                  if (nrow(uData) > 0) {
                        uData <- aggregate(data = uData, TotalBirth ~ Year + Name, sum)
                        x <- subset(uData, Year == input$year, select = c('Year','TotalBirth'))
                  }
                  n1 <- nPlot(TotalBirth ~ Year, data = uData, group = 'Name', 
                              type = "lineChart")
                  n1$addParams(dom = 'stat', width = 600, height = 300)
                  n1
            })
            output$pieMale <- renderChart({
                  top10Male <- top10(input$year, 'Masculino')
                  n2 <- nPlot(TotalBirth ~ Name, data = top10Male, type = "pieChart")
                  n2$chart(donut = TRUE)
                  n2$addParams(width = 300, height = 450, dom = 'pieMale')
                  n2
            })
            output$pieFemale <- renderChart({
                  top10Female <- top10(input$year, 'Femenino')
                  n3 <- nPlot(TotalBirth ~ Name, data = top10Female, type = "pieChart")
                  n3$chart(donut = TRUE)
                  n3$addParams(width = 300, height = 450, dom = 'pieFemale')
                  n3
            })
      }
)