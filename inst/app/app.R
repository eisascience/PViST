
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
library(scCustFx)
library(Seurat)
library(SeuratDisk)
library(bslib)




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
system.file()
source("app_gui.R",local = TRUE)
source("app_server.R",local = TRUE)






#######################





shinyApp(ui, server)