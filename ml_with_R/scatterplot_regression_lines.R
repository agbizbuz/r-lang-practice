# Scatter plots

library(tidyverse)
library(modeldata)

View(penguins)

ggplot(penguins, aes(x = flipper_length_mm,
                     y = bill_length_mm,
                     colour = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  scale_color_brewer(palette = "Dark2") + 
  labs(x = "Flipper Length",
       y = "Bill Length",
       colour = "Species",
       title = "Penguine Measurements") + 
  theme_minimal()

  