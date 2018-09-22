fluidPage(
  tags$style(
    HTML(
      "
      .draggable {
      background-color: #fff;
      background-image:linear-gradient(#eee .1em, transparent .1em);
      background-size: 100% 1.2em;
      border-width:5px;
      border-style:double;
      border-color:#08335d;
      border-radius:10px;
      padding : 20px;
      opacity : 0.9;
      }
      
      "
      )
      ),
  plotOutput(outputId = "main_plot"),
  absolutePanel(
    bottom = 20,
    right = 20,
    width = 600,
    height = 500,
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
      max = 90,
      step = 0.1,
      value = plant_rules[[names(plant_rules)[1]]]$angle
      
    ),
    
    sliderInput(
      inputId = "depth",
      label = "Depth",
      min = 1,
      max = 10,
      step = 1,
      value = plant_rules[[names(plant_rules)[1]]]$depth
    )
    
  )
      )
