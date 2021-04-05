server <- function(input, output, session) {
  
  
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