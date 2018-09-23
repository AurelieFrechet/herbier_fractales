fluidPage(
  includeCSS("www/styles.css"),
  plotOutput(outputId = "main_plot"),
  absolutePanel(
    bottom = 20,
    right = 20,
    width = 400,
    height = 300,
    draggable = TRUE,
    selectInput(
      inputId = "plants",
      label = "Plants",
      choices = names(plant_rules),
      selected = names(plant_rules)[1]
      
    ),
    htmlOutput("axiom"),
    htmlOutput("rules"),
    sliderInput(
      inputId = "angle",
      label = "Angle",
      min = 0,
      max = 45,
      step = 0.1,
      value = plant_rules[[names(plant_rules)[1]]]$angle,
      ticks = FALSE,
      post = "°"
      
    ),
    
    sliderInput(
      inputId = "depth",
      label = "Depth",
      min = 1,
      max = 7,
      step = 1,
      value = plant_rules[[names(plant_rules)[1]]]$depth,
      ticks = FALSE
    )
    
  )
      )
