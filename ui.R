page_fillable(
  theme = bs_theme(
    version = 5,                        # Bootstrap 5
    bootswatch = NULL,                   # No prebuilt bootswatch theme, fully custom
    bg = "#f5f0e1",                      # Background color (light beige, aged paper)
    fg = "#4a3f35",                      # Foreground text color (dark brown/ink)
    primary = "#2e5631",                 # Primary color (earthy green)
    secondary = "#b69b4c",               # Secondary color (soft muted yellow)
    success = "#507d2a",                 # Success color (darker green)
    info = "#8d7b55",                    # Info color (warm brown)
    warning = "#c2a83e",                 # Warning color (golden yellow)
    danger = "#8b5742",                  # Danger color (muted reddish brown)
    
    # Set font, use a serif font to mimic herbarium labels
    base_font = font_google("Roboto Slab"), 
    heading_font = font_google("Playfair Display"),
    
    # Customize components (e.g., buttons, borders)
    input_border_color = "#8d7b55",      # Warm brown for input borders
    "input-border-radius" = "5px",       # Slightly rounded corners for inputs/buttons
    "btn-border-radius" = "10px",        # More rounded buttons
    "plot-background" = "#f5f0e1"        # Match plot background to paper-like look
  ),
  layout_columns(

# Colonne informations ----------------------------------------------------
    card(
      card_header("test"),
      card_body(
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
    ),

# Dessin ------------------------------------------------------------------


    plotOutput(outputId = "main_plot")
  ))
