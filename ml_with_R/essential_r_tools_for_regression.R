library(tidyverse)
library(ISLR2)
library(broom)

college_sm <- College %>% 
  mutate(log_full = log(F.Undergrad)) %>% 
  select(Grad.Rate,
         log_full,
         Private,
         Top25perc)
model_top <- lm(Grad.Rate ~ log_full + 
                  Private + 
                  Top25perc,
                data = college_sm)
summary(model_top)


# Functions from broom ----------------------------------------------------

tidy(model_top)
model_aug <- augment(model_top)
View(model_aug)
model_glance <- glance(model_top)
View(model_glance)
