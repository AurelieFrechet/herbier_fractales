theme_herbarium <- function() {
  theme_minimal(base_family = "serif", base_size = 15) +
    theme(
      # Background color
      plot.background  = element_rect(fill = "#f5f0e1", color = NA), # Light beige paper color
      panel.background = element_rect(fill = "#f5f0e1", color = NA), 
      
      # Remove grid lines
      panel.grid.major = element_line(color = "transparent"), # No grid lines
      panel.grid.minor = element_line(color = "transparent"),
      
      # Remove axis titles and ticks
      axis.title = element_blank(), # No axis titles
      axis.text  = element_blank(),  # No axis text
      axis.ticks = element_blank(), # No axis ticks
      axis.line  = element_blank(),  # No axis lines
      
      # Plot title styling
      plot.title = element_text(
        color = "#4a3f35", 
        size = 18, 
        hjust = 0.5, # Center title
        face = "italic", # Italic title
        margin = margin(b = 10) # Add margin for spacing
      ),
      
      # Plot margins
      plot.margin = margin(20, 20, 20, 20),
      
      # Panel border to look like a frame
      panel.border = element_rect(color = "#4a3f35", fill = NA, linewidth = 3), # Thicker border for frame effect
      plot.caption = element_text(color = "#4a3f35", hjust = 1, size = 10)
    )
}



