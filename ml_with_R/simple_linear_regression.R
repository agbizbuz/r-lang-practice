library(tidymodels)
theme_set(theme_minimal())
set.seed(0)

# View(airquality)

# Split data
aq_split <- initial_split(airquality)
aq_train <- training(aq_split)
aq_test <- testing(aq_split)

# visualize data
ggplot(aq_train, aes(x = Wind, y = Temp)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE)

# Build a model
aq_model <- lm(Temp ~ Wind, aq_train)

names(aq_model)
aq_model$coefficients
aq_model$residuals
aq_model$fitted_values

summary(aq_model)
fitted.values(aq_model)
confint(aq_model, level = .90)

plot(aq_model)

# the broom package

tidy(aq_model)
glance(aq_model)
aq_aug <- augment(aq_model)
View(aq_aug)

# model performance

predict(aq_model, aq_test)

rms_error <- sqrt(mean((aq_test$Temp - predict(aq_model, aq_test))^2))
