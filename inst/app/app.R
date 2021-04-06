
.libPaths()
library(BiocManager)
options(repos = BiocManager::repositories())


library(shiny)
library(shinydashboard)
library(shinyFiles)
library(ggplot2)
library(plotly)
library(data.table)
library(ggrepel)
library(viridis)
library(ggnewscale)
library(RColorBrewer)
library(grid)
library(gridExtra) 
require(dplyr)
library(ggrastr)
library(ggpubr)
library(BiocParallel)
library(Seurat)
library(SeuratDisk)
library(bslib)
library(CellMembrane)
library(scCustFx)




register(MulticoreParam(4))
# LocalRun=T


if (Sys.getenv("SCRATCH_DIR") != "") {
  init.path = paste0(Sys.getenv("SCRATCH_DIR"), "/data")
}  else {
  if(Sys.getenv()[["LOGNAME"]]=="fem") {
    init.path = 
      "/Volumes/Maggie/Work/OHSU/Conrad/R/SpatialOmics/MammalianSpermatogenesis/data/SeuratObjects" 
  } else {
    init.path = getwd()
  }
}


#######################

source("app_gui.R",local = TRUE)
source("app_server.R",local = TRUE)

ui <- dashboardPage(
  dashboardHeader(title = "PViST"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("0. Load Object", tabName = "LoadInDash", icon = icon("dashboard"),
               badgeLabel = "underdev", badgeColor = "red"),
      menuItem("1. QC plots", tabName = "QCplots", icon = icon("wrench")),
      menuItem("2a. Gene Explorer", tabName = "GeneExplorer", icon = icon("dna")),
      menuItem("2b. Expression Correlation", tabName = "GeneCor", icon = icon("dna")), 
      menuItem("3. Dim. Reduction", tabName = "DimRedux", icon = icon("dna")),
      menuItem("4. Unsup. Clustering", tabName = "UnsupClus", icon = icon("dna")),
      menuItem("5. Differential Expression", tabName = "DiffExpr", icon = icon("dna")),
      menuItem("6. Spatial Variation", tabName = "SpatialVar", icon = icon("dna")),
      menuItem("7. Spatial Colocalization", tabName = "SpatialVar", icon = icon("dna")),
      menuItem("Conrad Lab", icon = icon("file-code-o"), 
               href = "https://conradlab.org"),
      menuItem("@eisamahyari", icon = icon("heart"), 
               href = "https://eisascience.github.io")
    )
  ),
  dashboardBody(
    tags$head(
      tags$style(HTML("
          .content-wrapper {
          background-color: black !important;
          }
          .main-sidebar {
          background-color: black !important;
          }
          .multicol .shiny-options-group{
          -webkit-column-count: 5; /* Chrome, Safari, Opera */
          -moz-column-count: 5;    /* Firefox */
          column-count: 5;
          -moz-column-fill: balanced;
          -column-fill: balanced;
          }
          .checkbox{
          margin-top: 0px !important;
          -webkit-margin-after: 0px !important; 
          }
                      "))),
    tabItems(
      
      tabItem(tabName = "LoadInDash",
              h2("Platform for exploration, analysis, & Visualization of Spatial Transcriptomes (PViST)"),
              fluidRow(
                valueBoxOutput("InfoBox", width = 6),
                
                box(title = "SpeciesSelect", status = "primary", 
                    solidHeader = TRUE,collapsible = TRUE,
                    selectInput(inputId = 'species',
                                label = 'Species',
                                choices =  c('human', 'mouse', 'rhesus'),
                                selected = , multiple = F),
                    width = 3, background = "red"
                ),
                
                box(textInput("LoadInroot", "Path to folders. Expects a processed seurat in the new hd5 format.", 
                              value =init.path),
                    uiOutput("select.file"),
                    actionButton("loadSerObj", "0. Load Seurat Obj"),
                    width = 10
                ),
                
              ),
      ), #end of tabitem
      
      
      
      tabItem(tabName = "QCplots",
              h2("QA QC plots"),
              fluidRow(
                box(
                  title = "transcript and umi counts:", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  uiOutput("select.meta.cols"),
                  plotlyOutput("DimRedux_unsup_umap_qc", height = 500),
                  plotOutput("spatialDimplot", height = 500),
                  plotOutput("nCountSpatial", height = 500),
                  plotOutput("nFeatureSpatial", height = 500), 
                  plotOutput("nCountSpatialVsnFeature_Spatial", height = 500), 
                  
                  
                  width = 10, background = "black"
                )
                
              ),
      ), #end of tabitem
      
      tabItem(tabName = "GeneExplorer",
              h2("Gene Explorer"),
              fluidRow(
                box(
                  title = "Normalized gene expression", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  textInput("GeneName", "Gene name (capitalization matters)", 
                            value ="PRM1"),
                  
                  width = 10, background = "black"
                ),
                box(
                  title = "Normalized gene expression", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  plotOutput("FeatPlot_umap", height = 500),
                  
                  width = 10, background = "black"
                ),
                box(
                  title = "Normalized gene expression", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  plotOutput("SpatialFeaturePlot_usrIn1", height = 500),
                  
                  width = 10, background = "black"
                )
                
              ),
      ), #end of tabitem
      
      tabItem(tabName = "GeneCor",
              h2("Gene Correlation"),
              fluidRow(
                box(
                  title = "2 genes", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  textInput("GeneName1", "Gene name (capitalization matters)", 
                            value ="PRM1"),
                  textInput("GeneName2", "Gene name (capitalization matters)", 
                            value ="PRM2"),
                  plotOutput("FeatDuoScatter", height = 500),
                  
                  width = 10, background = "black"
                ),
                box(
                  title = "More than 2 genes ", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  textInput("GeneSetCor", "A set of genes", "'PRM1', 'SPATA42', 'SPRR4', 'NUPR2', 'HBZ', 'DYNLL2'"),
                  plotOutput("FeatCor", height = 500),
                  
                  width = 10, background = "black"
                )
              ),
      ), #end of tabitem
      
      tabItem(tabName = "DimRedux",
              h2("Gene Explorer"),
              fluidRow(
                box(
                  title = "Dimentionality reduction (supervised and unsupervised)", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  #need to add clustering here
                  
                  
                  
                  width = 10, background = "black"
                )
                
              ),
      ), #end of tabitem
      
      tabItem(tabName = "UnsupClus",
              h2("Unsupervised Cluster on Dim Redux"),
              fluidRow(
                box(
                  title = "Unsup. Clustering", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  
                  
                  
                  width = 10, background = "black"
                )
                
              ),
      ), #end of tabitem
      
      tabItem(tabName = "DiffExpr",
              h2("Differential Expression on Prev. Def. Clust"),
              fluidRow(
                box(
                  title = "DE", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  
                  
                  
                  width = 10, background = "black"
                )
                
              ),
      ), #end of tabitem
      
      tabItem(tabName = "SpatialVar",
              h2("Spatial Varaition"),
              fluidRow(
                box(
                  title = "Spatial Variation", status = "primary", solidHeader = TRUE,
                  collapsible = TRUE,
                  
                  
                  
                  width = 10, background = "black"
                )
                
              ),
      ) #end of tabitem
      
    )
  )
)

server <- function(input, output, session) {
  
  
  source("app_ObserveEvents.R",local = TRUE)
  source("app_RenderPlots.R",local = TRUE)
  source("app_mcsl.R",local = TRUE)
  source("app_Reactive.R",local = TRUE)
  
  
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





#######################





shinyApp(ui, server)