
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
library(scCustFx)
library(Seurat)
library(SeuratDisk)

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


ui <- dashboardPage(
  dashboardHeader(title = "PViST"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("0. Load Object", tabName = "LoadInDash", icon = icon("dashboard"),
               badgeLabel = "underdev", badgeColor = "red"),
      menuItem("1. QC plots", tabName = "QCplots", icon = icon("wrench")),
      menuItem("2. Gene Explorer", tabName = "GeneExplorer", icon = icon("dna")),
      # menuItem("Batch removal", tabName = "BatchRemove", icon = icon("toolbox")),
      # menuItem("DGE Batch-Removed", tabName = "DGEsda", icon = icon("autoprefixer")),
      # menuItem("Save Out", tabName = "SaveOut", icon = icon("save")),
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
                            value ="Sox9"),
                  plotOutput("FeatPlot_umap", height = 500),
                  
         
                  
                  width = 10, background = "black"
                )
                
              ),
      ) #end of tabitem
      
      )
    )
  )


