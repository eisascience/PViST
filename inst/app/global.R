.libPaths()
library(BiocManager)
options(repos = BiocManager::repositories())


library(shiny)
library(shinydashboard)
library(ggplot2)
library(data.table)
library(ggrepel)
library(viridis)
library(ggnewscale)
library(RColorBrewer)
library(grid)
library(gridExtra) 
require(dplyr)
library(ggrastr)
library(plotly)
library(bslib)


library("BiocParallel")
register(MulticoreParam(4))
