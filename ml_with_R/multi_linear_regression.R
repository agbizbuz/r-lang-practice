library(tidyverse)
library(GGally)
library(broom)

# simulated data

set.seed(2)
x1 <- runif(60, 100, 300)
x2 <- runif(60, 20,120)
y <- 20 + 4*x1 - 3*x2 + rnorm(60, 0, 40)

df <- tibble(x1, x2, y)

new_x1 <- seq(from = 120,
              to = 300,
              length.out = 20)
new_x2 <- runif(20, 30, 110)
new_data <- tibble(x1 = new_x1,
                   x2 = new_x2)
df
ggpairs(df)

model <- lm(y ~ x1 + x2, data = df)
summary(model)
plot(model)

fitted_vals <- predict(model, new_data)
new_data$pred <- fitted_vals
new_data
