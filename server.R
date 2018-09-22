function(input, output) {
  plant_selected <- reactive({
    plant_rules[[input$plants]]
  })
  
  draw_plant <- reactive({
    axiom <- plant_selected()$axiom
    for (i in 1:input$depth) axiom = gsubfn(".", plant_selected()$rules, axiom)
    actions = str_extract_all(axiom, "\\d*\\+|\\d*\\-|F|L|R|\\[|\\]|\\|") %>% unlist
    
    status = data.frame(x = numeric(0),
                        y = numeric(0),
                        alfa = numeric(0))
    points = data.frame(
      x1 = 0,
      y1 = 0,
      x2 = NA,
      y2 = NA,
      alfa = 90,
      depth = 1
    )
    
    for (action in actions)
    {
      if (action == "F")
      {
        x = points[1, "x1"] + cos(points[1, "alfa"] * (pi / 180))
        y = points[1, "y1"] + sin(points[1, "alfa"] * (pi / 180))
        points[1, "x2"] = x
        points[1, "y2"] = y
        data.frame(
          x1 = x,
          y1 = y,
          x2 = NA,
          y2 = NA,
          alfa = points[1, "alfa"],
          depth = points[1, "depth"]
        ) %>% rbind(points) -> points
      }
      if (action %in% c("+", "-")) {
        alfa = points[1, "alfa"]
        points[1, "alfa"] = eval(parse(text = paste0(
          "alfa", action, input$angle
        )))
      }
      if (action == "[") {
        data.frame(x = points[1, "x1"],
                   y = points[1, "y1"],
                   alfa = points[1, "alfa"]) %>%
          rbind(status) -> status
        points[1, "depth"] = points[1, "depth"] + 1
      }
      
      if (action == "]") {
        depth = points[1, "depth"]
        points[-1,] -> points
        data.frame(
          x1 = status[1, "x"],
          y1 = status[1, "y"],
          x2 = NA,
          y2 = NA,
          alfa = status[1, "alfa"],
          depth = depth - 1
        ) %>%
          rbind(points) -> points
        status[-1,] -> status
      }
    }
    points
  })
  
  output$main_plot <- renderPlot({
    ggplot() +
      geom_segment(
        aes(
          x = x1,
          y = y1,
          xend = x2,
          yend = y2
        ),
        lineend = "round",
        colour = "#085d08",
        data = na.omit(draw_plant())
      ) +
      coord_fixed(ratio = 1) +
      theme_void()
    
  })
  
  output$axiom <- renderText({
    HTML(plant_selected()$axiom)
    
  })
  
  output$rules <- renderText({
    HTML(paste(paste(
      names(plant_selected()$rules),
      plant_selected()$rules,
      sep = " = "
    ), collapse = "<br>"))
  })
}
