function(input, output, session) {
  source("app_ObserveEvents.R",local = TRUE)
  source("app_RenderPlots.R",local = TRUE)
  source("app_mcsl.R",local = TRUE)

  
  shinyFileChoose(input,'file', session=session,roots=c(wd='.'))
  
  envv=reactiveValues(y=NULL)
  envv$InfoBox_sub = "Welcome to PViST.\nStart by picking a species."
  
  envv$serObj_metaFeats = NULL
  
  output$select.file <-
    renderUI(expr = selectInput(inputId = 'file.name',
                                label = 'File Name',
                                choices = list.files(path = input$LoadInroot,
                                                    full.names = FALSE,
                                                    recursive = FALSE)))
  

 

  
  
  
}




# Define server logic required to draw a histogram
# server <- function(input, output) {
#   
#   ################################ observeEvent sections
#   source("app_ObserveEvents.R",local = TRUE)
#   
#   
#   # Plot scatter plot
#   output$scatter <- renderPlotly({
#     data <- data.frame(x = sample.int(1000, 100), y = sample.int(1000, 100))
#     plot_ly(data, x = ~ x, y = ~ y, type = "scatter", mode = "markers")
#   })
#   
#   scatterProxy <- plotlyProxy("scatter")
#   
#   # Catch plot click
#   observeEvent(event_data("plotly_click"), {
#     d <- event_data("plotly_click")
#     xrange <- c((d$x - 100), (d$x + 100))
#     yrange <- c((d$y - 100), (d$y + 100))
#     plotlyProxyInvoke(scatterProxy, "relayout", list(xaxis = list(range = xrange), yaxis = list(range = yrange)))
#   })
#   
#   
# }