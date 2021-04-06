ui <- dashboardPage(
  dashboardHeader(title = "PViST"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("0. Load Object", tabName = "LoadInDash", icon = icon("dashboard"),
               badgeLabel = "underdev", badgeColor = "red"),
      menuItem("1. QC plots", tabName = "QCplots", icon = icon("wrench")),
      menuItem("2a. Gene Explorer", tabName = "GeneExplorer", icon = icon("dna")),
      menuItem("2b. Expression Correlation", tabName = "GeneExplorer", icon = icon("dna")), 
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
                            value ="SOX9"),

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