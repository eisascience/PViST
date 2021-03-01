output$InfoBox <- renderValueBox({
  valueBox(
    value = "Info Bar", #format(Sys.time(), "%a %b %d %X %Y %Z"),
    subtitle = envv$InfoBox_sub,
    icon = icon("area-chart"),
    color = "yellow" #if (downloadRate >= input$rateThreshold) "yellow" else "aqua"
  )
})