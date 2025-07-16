library(tidyverse)
library(modeldata)

data("crickets")
glimpse(crickets)
ggplot(crickets, aes(temp, rate, colour = species)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE)

model <- lm(rate ~ temp + species, data = crickets)
summary(model)

ggplot(crickets, aes(temp, rate, colour = species)) + 
  geom_point() + 
  geom_abline(aes(slope = 3.60275,
              intercept = -7.21091,
              col = "O. exclamationis")) +
  geom_abline(aes(slope = 3.60275,
              intercept = -7.21091 - 10.06529,
              col = "O. niveus"))

crickets_test <- tibble(species = c("O. exclamationis", "O. niveus"),
                        temp = c(24, 26))
predict(model, crickets_test)
