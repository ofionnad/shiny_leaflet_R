ui <- fluidPage(
  #create map space
  leafletOutput("mymap") %>% wellPanel(),
  
  #create slider input
  sliderInput("magthresh", "Magnitude Threshold", min=3, max=9, value=6.1, step=0.1) %>% wellPanel(),
   
  # histogram space
  plotOutput("hist_mag_plot")
  )