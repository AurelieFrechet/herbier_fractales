function(input, output) {
  plant_selected <- reactive({
    plant_rules[[input$plants]]
  })
  
  draw_plant <- reactive({
    draw_L_system(axiom = plant_selected()$axiom,
                  rules = plant_selected()$rules,
                  angle = input$angle,
                  depth = input$depth)
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
