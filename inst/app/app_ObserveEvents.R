## ObserveEvents--------------------------------------


observeEvent(input$loadSerObj, {
  
  
  envv$path2SDA_dyn <- paste0(input$LoadInroot, "/", input$file.name)
  
  # print(envv$path2SDA_dyn)
  
  if(file.exists(envv$path2SDA_dyn)) {
    
    envv$InfoBox_sub = "Loading Seurat Obj"
    
    envv$SerObj = readRDS(envv$path2SDA_dyn)
    
    envv$InfoBox_sub = "Seurat Obj loaded in PViST"
    
    envv$SerObj$log_nFeature_Spatial  = log10(envv$SerObj$nFeature_Spatial)
    
    
    
    
    
    envv$serObj_metaFeats <-setdiff(colnames(envv$SerObj@meta.data),
                                    c("nCount_Spatial", "nFeature_Spatial",
                                      "log_nCount_Spatial", "nCount_SCT",
                                      "nFeature_SCT"))
    
   
    
    
    # print(envv$serObj_metaFeats)
    
    
    
    
    
    
  } else { 
    envv$InfoBox_sub = "Seurat Obj not found"
    
  }
})

observeEvent(envv$serObj_metaFeats, {
  if(!is.null(envv$serObj_metaFeats)){
    output$select.meta.cols <-
      renderUI(expr = selectInput(inputId = 'meta.cols',
                                  label = 'Avl. Meta',
                                  choices = envv$serObj_metaFeats))
  }
})


