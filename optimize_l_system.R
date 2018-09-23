# Optionmisation du code grâce à :
# https://www.r-bloggers.com/strategies-to-speedup-r-code/

library(gsubfn)
library(stringr)
library(dplyr)
library(ggplot2)

axiom = "F"
rules = list("F" = "F[+F]F[-F][F]")
angle = 20
depth = 5


for (i in 1:depth)
  axiom = gsubfn(".", rules, axiom)

actions = str_extract_all(axiom, "\\d*\\+|\\d*\\-|F|L|R|\\[|\\]|\\|") %>% unlist

# Vectorise and pre-allocate data structures
n  = length(actions)
x1 = numeric(n)
y1 = numeric(n)
x2 = numeric(n)
y2 = numeric(n)
a  = numeric(n)
d  = numeric(n)
status = c()

# Take statements that check for conditions (if statements) outside the loop
is_F            <- actions == "F"
is_plus         <- actions == "+"
is_moins        <- actions == "-"
is_open_bracet  <- actions == "["
is_close_bracet <- actions == "]"

# Initialisation
a[1]  = 90
d[1]  = 1
x1[1] = 0
y1[1] = 0
x2[1] = x1[1] + cos(a[1] * (pi / 180))
y2[1] = y1[1] + sin(a[1] * (pi / 180))

# Loop
for (i in 2:n) {
  if (is_F[i]) {
    a[i]  = a[i - 1]
    d[i]  = d[i - 1]
    x1[i] = x2[i - 1]
    y1[i] = y2[i - 1]
    x2[i] = x1[i] + cos(a[i] * (pi / 180))
    y2[i] = y1[i] + sin(a[i] * (pi / 180))
  }
  if (is_plus[i]) {
    a[i]  = a[i - 1] + angle
    d[i]  = d[i - 1]
    x1[i] = x1[i - 1]
    y1[i] = y1[i - 1]
    x2[i] = x2[i - 1]
    y2[i] = y2[i - 1]
  }
  if (is_moins[i]) {
    a[i]  = a[i - 1] - angle
    d[i]  = d[i - 1]
    x1[i] = x1[i - 1]
    y1[i] = y1[i - 1]
    x2[i] = x2[i - 1]
    y2[i] = y2[i - 1]
  }
  if (is_open_bracet[i]) {
    status <- c(i, status)
    a[i]  = a[i - 1]
    d[i]  = d[i - 1] + 1
    x1[i] = x1[i - 1]
    y1[i] = y1[i - 1]
    x2[i] = x2[i - 1]
    y2[i] = y2[i - 1]
  }
  if (is_close_bracet[i]) {
    j <- status[1]
    a[i]  = a[j]
    d[i]  = d[i - 1] - 1
    x1[i] = x1[j]
    y1[i] = y1[j]
    x2[i] = x2[j]
    y2[i] = y2[j]
    status <- status[-1]
  }
}

points2 <- data.frame(actions, x1, y1, x2, y2, alfa = a, depth = d)
points2 <- points2[which(points2$actions == "F"), ]
