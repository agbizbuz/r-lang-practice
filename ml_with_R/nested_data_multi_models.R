library(tidymodels)

glimpse(penguins)

penguis_nested <- penguins |>
  group_by(species) |>
  nest()
View(penguis_nested)
View(penguis_nested$data[[1]])

penguins_lm <- function(df) {
  lm(bill_length_mm ~ bill_depth_mm,
     data = df)
}

penguis_nested <- penguis_nested |>
  mutate(model = map(data, penguins_lm),
         model_tidy = map(model, tidy),
         model_glance = map(model, glance))
View(penguis_nested)
summary(penguis_nested$model[[1]])
View(penguis_nested$model_tidy[[1]])

penguins_t <- penguis_nested %>% 
  unnest(model_tidy)
View(penguins_t)

penguins_g <- penguis_nested %>% 
  unnest(model_glance)
View(penguins_g)

penguins_wide <- penguins_t %>% 
  pivot_wider(names_from = term,
              values_from = estimate:model_glance)
View(penguins_wide)

ggplot() +
  geom_point(data = penguins, aes(x = bill_depth_mm,
                                  y = bill_length_mm,
                                  colour = species)) + 
  geom_abline(data = penguins_wide, 
              aes(slope = estimate_bill_depth_mm,
                  intercept = `estimate_(Intercept)`,
                  colour = species))
