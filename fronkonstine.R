library(gsubfn)
library(stringr)
library(dplyr)
library(ggplot2)

#Plant 1
axiom = "F"
rules = list("F" = "FF-[-F+F+F]+[+F-F-F]")
angle = 22.5
depth = 4

#Plant 2
axiom = "X"
rules = list("X" = "F[+X][-X]FX", "F" = "FF")
angle = 25.7
depth = 7

#Plant 3
axiom = "X"
rules = list("X" = "F[+X]F[-X]+X", "F" = "FF")
angle = 20
depth = 7

#Plant 4
axiom = "X"
rules = list("X" = "F-[[X]+X]+F[+FX]-X", "F" = "FF", "L" = "LXF")
angle = 22.5
depth = 5

#Plant 5
axiom = "F"
rules = list("F" = "F[+F]F[-F]F")
angle = 25.7
depth = 5

#Plant 6
axiom = "F"
rules = list("F" = "F[+F]F[-F][F]")
angle = 20
depth = 5


for (i in 1:depth)
  axiom = gsubfn(".", rules, axiom)

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
    points[1, "alfa"] = eval(parse(text = paste0("alfa", action, angle)))
  }
  if (action == "[") {
    data.frame(x = points[1, "x1"], y = points[1, "y1"], alfa = points[1, "alfa"]) %>%
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

n    = length(actions)
x1   = numeric(n+1)
x2   = numeric(n)
y1   = numeric(n+1)
y2   = numeric(n)
alfa = numeric(n+1)
d    = numeric(n+1)
status <- c()
conditional_F  <- actions == "F"
conditional_p  <- actions == "+"
conditional_m  <- actions == "-"
conditional_ob <- actions == "["
conditional_cb <- actions == "]"

x1[1]   = 0
y1[1]   = 0
x2[1]   = NA
y2[1]   = NA
alfa[1] = 90
d[1]    = 1
for (i in 1:n)
{
  if (conditional_F[i])
  {
    x2[i]   = x1[i] + cos(alfa[i] * pi / 180)
    y2[i]   = y1[i] + sin(alfa[i] * pi / 180)
    x1[i+1]   = x2[i]
    y1[i+1]   = y2[i]
    alfa[i+1] = alfa[i]
    d[i+1] = d[i]
  }
  if (conditional_p[i]) {
    alfa[i+1] = alfa[i] + angle
    d[i+1] = d[i]
  }
  if (conditional_m[i]) {
    alfa[i+1] = alfa[i] + angle
    d[i+1] = d[i]
  }
  if (conditional_ob[i]) {
    status <- c(i, status)
    d[i] = d[i - 1] + 1
  }
  if (conditional_cb[i]) {
    j = status[1]
    x1[i] = x1[j]
    y1[i] = y1[j]
    alfa[i] = alfa[j]
    d[i] = d[i - 1] - 1
    status <- status[-1]
  }
}
points <- data.frame(x1,y1,x2,y2,alfa,depth =d)

ggplot() +
  geom_segment(
    aes(
      x = x1,
      y = y1,
      xend = x2,
      yend = y2,
      size = depth,
      color = depth
    ),
    lineend = "round",
    data = na.omit(points)
  ) +
  coord_fixed(ratio = 1) +
  scale_size_continuous(range = c(1, 0.2)) +
  scale_color_continuous(low = "#3a1f05",
                         high = "#085d08") +
  theme_void()
