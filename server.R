server <- function(input, output, session) {
  
  # read the data for plotting
  data = read.csv("Japan earthquakes 2001 - 2018.csv")
  
  # reactive component to change data based on earthquake threshold
  strong <- reactive({
    data %>%
    filter(mag >= input$magthresh)
  })
  
  # centre of leaflet map view
  japan_lon <- 138.129731
  japan_lat <- 38.0615855
  
  # create a leafet map of the data
  output$mymap <- renderLeaflet({
    leaflet() %>%
      setView(lng = japan_lon, lat = japan_lat, zoom = 5) %>%
      addProviderTiles("Esri.WorldStreetMap") %>%
      addCircles(
        data = strong(),
        radius = sqrt(10^strong()$mag) * 2,
        color = "#126c0a",
        fillColor = "#126c0a",
        fillOpacity = 0.2,
        popup = paste0(
          "<strong>Time: </strong>", substr(strong()$time, 1, nchar(strong()$time)-1), "<br>",
          "<strong>Magnitude: </strong>", strong()$mag, "<br>",
          "<strong>Depth (km): </strong>", strong()$depth, "<br>",
          "<strong>Place: </strong>", strong()$place, "<br>"
          )
        )
    
  })
  
  #create an additional histogram at the bottom to show distribution (ie. larger earthquakes are less common)
  output$hist_mag_plot <- renderPlot({
    
    hist(strong()$mag, col='steelblue', border='white')
    
  })
}
