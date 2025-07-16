library(tidyverse)
library(broom)
library(GGally)


performance <- read_csv("performance.csv")
View(performance)

ggpairs(performance)


# Use t-statistics to decide which columns can be thrown away

model_6 <- lm(overall_rating ~ ., data = performance)
summary(model_6)

# throw away not_overly_critical because of low t value 0.261
model_5 <- update(model_6, . ~. - not_overly_critical)
summary(model_5)

# throw away raises_for_performance because of low t value 0.470
model_4 <- update(model_5, . ~. - raises_for_performance)
summary(model_4)

# throw away no_special_privileges because of low t value -0.588
model_3 <- update(model_4, . ~. - no_special_privileges)
summary(model_3)

# use the final model to get the residual plots
perf_aug <- augment(model_3)
View(perf_aug)

ggplot(perf_aug, aes(x = .fitted, y = .resid)) +
  geom_point() + 
  geom_hline(yintercept = 0)

# compare models with AIC (Akaike Information Criterion)
model_list <- list(model_6,
                   model_5,
                   model_4,
                   model_3)
lapply(model_list, extractAIC)
