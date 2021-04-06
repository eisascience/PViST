
### render plots ========================

output$DimRedux_unsup_umap_qc <- renderPlotly({
  # print(output$serObj_metaFeats)
  Idents(envv$SerObj) = input$meta.cols
  # cowplot::plot_grid(DimPlot(envv$SerObj, reduction = "umap", label = TRUE) + theme_bw()  ,
  #                    SpatialDimPlot(envv$SerObj, stroke = 0, group.by = as.character(input$meta.cols)) ,
  #                    ncol = 2)
  # 
  
  DimPlot(envv$SerObj, reduction = "umap", label = TRUE)
})

output$spatialDimplot <- renderPlot({
  SpatialDimPlot(envv$SerObj, stroke = 0, group.by = as.character(input$meta.cols))
})


output$nCountSpatial <- renderPlot({
  Idents(envv$SerObj) = input$meta.cols
  cowplot::plot_grid(VlnPlot(envv$SerObj, features = "log_nCount_Spatial", pt.size = 0, log = TRUE) + 
                       ggtitle("log nCount (UMI) per unsup clusts"),
                     SpatialFeaturePlot(envv$SerObj, features = "log_nCount_Spatial") + 
                       theme(legend.position = "right"), ncol = 2)
  
})

output$nFeatureSpatial <- renderPlot({
  Idents(envv$SerObj) = input$meta.cols
  cowplot::plot_grid(VlnPlot(envv$SerObj, features = "log_nFeature_Spatial", pt.size = 0, log = TRUE) + 
                       ggtitle("log nFeature (genes) per unsup clusts"),
                     SpatialFeaturePlot(envv$SerObj, features = "log_nFeature_Spatial") + 
                       theme(legend.position = "right"), ncol = 2)
  
})

output$nCountSpatialVsnFeature_Spatial <- renderPlot({
  Idents(envv$SerObj) = input$meta.cols
  FeatureScatter(envv$SerObj, feature1 =  "log_nCount_Spatial", feature2 = "log_nFeature_Spatial") + 
    ggtitle("log_nCount_Spatial vs log_nFeature_Spatial")
  
})


output$FeatPlot_umap <- renderPlot({

  FeaturePlot(envv$SerObj, reduction = "umap", features = input$GeneName )

})

output$SpatialFeaturePlot_usrIn1 <- renderPlot({
  
  SpatialFeaturePlot(envv$SerObj, 
                     features = input$GeneName, 
                     ncol = 1, 
                     alpha = c(0.1, 1), 
                     max.cutoff = "q98", min.cutoff = "q02")
  
})

output$FeatDuoScatter<- renderPlot({
  Idents(envv$SerObj) = input$meta.cols
  FeatureScatter(envv$SerObj, feature1 = input$GeneName1, feature2 = input$GeneName2, plot.cor = T) + geom_smooth()
  
})




output$FeatCor <- renderPlot({
 
  cols <- colorRampPalette(c("navy", "dodgerblue",  "white", "gold", "red"))
  
  GeneSet <- input$GeneSetCor
  
  if(length(grep(",", GeneSet)) == 0){
    
    if(length(grep('"', GeneSet)) + length(grep("'", GeneSet))>0) {
      GeneSet <- unlist(strsplit(gsub("'", '', gsub('"', '', GeneSet)), " "))
    } else {
      GeneSet <- unlist(strsplit(GeneSet, " "))
    }
    
    #print(GeneSet)
  }else {
    GeneSet <- (unlist(strsplit(gsub(" ", "", gsub("'", '', gsub('"', '', GeneSet))), ",")))
    #print(GeneSet)
  }
  
  GeneSetNot <- GeneSet[!GeneSet %in% rownames(envv$SerObj)]
  
  print("length of your genes:")
  print(length(GeneSet))
  GeneSet <- GeneSet[GeneSet %in% rownames(envv$SerObj)]
  print("length of your genes in this dataset:")
  print(length(GeneSet))
  
  corM = cor(t(as.matrix(GetAssayData(envv$SerObj, slot = "data")[GeneSet,])))
  print(head(corM))

  
  pheatmap::pheatmap(corM, #cellwidth = 3, cellheight = 3,
                     #main = "monaco.label.fine \nEuc. dist WardD2 Clust",
                     #color = cols(21), show_colnames = T,
                     #clustering_distance_rows = "euclidean",
                     #clustering_distance_cols = "euclidean", #euclidean
                     #clustering_method = "ward.D2" , breaks = c(-1, -1*rev(1:9)/10,  0, 1:9/10, 1)
                     )
  

  
})
