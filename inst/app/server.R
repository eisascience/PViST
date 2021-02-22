function(input, output, session) {
  shinyFileChoose(input,'file', session=session,roots=c(wd='.'))
  
  envv=reactiveValues(y=NULL)
  envv$InfoBox_sub = "Welcome to PViST.\nStart by picking a species."
  
  
  output$select.folder <-
    renderUI(expr = selectInput(inputId = 'folder.name',
                                label = 'Folder Name',
                                choices = list.dirs(path = input$LoadInroot,
                                                    full.names = FALSE,
                                                    recursive = FALSE)))
  
  
  
  
  ## Main tab--------------------------------------
  
  
  output$InfoBox <- renderValueBox({
    valueBox(
      value = "Info Bar", #format(Sys.time(), "%a %b %d %X %Y %Z"),
      subtitle = envv$InfoBox_sub,
      icon = icon("area-chart"),
      color = "yellow" #if (downloadRate >= input$rateThreshold) "yellow" else "aqua"
    )
  })
  
  
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