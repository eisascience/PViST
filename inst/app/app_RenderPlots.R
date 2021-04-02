
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