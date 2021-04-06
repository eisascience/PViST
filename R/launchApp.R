#' Launch PViST
#' @title Launch PViST
#' @description Launch PViST
#' @keywords PViST
#' @export
#' @return Shiny application.
#' @import shiny
#' @import shinydashboard
#' @import shinyWidgets
#' @import shinyFiles
#' @import ggplot2
#' @import plotly
#' @import data.table
#' @import ggrepel
#' @import viridis
#' @import ggnewscale
#' @import grid
#' @import gridExtra
#' @import stringr
#' @import viridis
#' @import RColorBrewer
#' @import BiocParallel
#' @import clusterProfiler
#' @import AnnotationHub
#' @import ggpubr
#' @import ggrastr
#' @import dplyr

#' 
launchPViST <- function(...) {
  ## runApp() does not work w shiny-server
  shinyAppDir(appDir = system.file("app", package = "PViST"))
  
}