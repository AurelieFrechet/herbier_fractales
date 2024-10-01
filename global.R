library(gsubfn)
library(stringr)
library(dplyr)
library(ggplot2)
library(bslib)

plant_rules = list(
  "Plant 1" =
    list(
      axiom = "F",
      rules = list("F" = "FF-[-F+F+F]+[+F-F-F]"),
      angle = 22.5,
      depth = 4
    ),
  
  "Plant 2" =
    list(
      axiom = "X",
      rules = list("X" = "F[+X][-X]FX", "F" = "FF"),
      angle = 25.7,
      depth = 7
    ),
  
  "Plant 3" =
    list(
      axiom = "X",
      rules = list("X" = "F[+X]F[-X]+X", "F" = "FF"),
      angle = 20,
      depth = 7
    ),
  
  "Plant 4" =
    list(
      axiom = "X",
      rules = list("X" = "F-[[X]+X]+F[+FX]-X", "F" = "FF"),
      angle = 22.5,
      depth = 5
    ),
  
  "Plant 5" =
    list(
      axiom = "F",
      rules = list("F" = "F[+F]F[-F]F"),
      angle = 25.7,
      depth = 5
    ),
  
  "Plant 6" =
    list(
      axiom = "F",
      rules = list("F" = "F[+F]F[-F][F]"),
      angle = 20,
      depth = 5
    )
)