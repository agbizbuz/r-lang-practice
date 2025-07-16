library(tidyverse)
?diamonds

# subset by row with filter()

diamonds_sm <- filter(diamonds, cut == "Ideal")
diamonds_sm <- filter(diamonds, price > 10000)
view(diamonds_sm)

diamonds_sm <- filter(diamonds, 
                      cut == "Ideal",
                      price > 10000)
view(diamonds_sm)

diamonds_sm <- filter(diamonds, 
                      cut == "Ideal" |
                      price > 10000)

# missing values
# diamonds_nocut = filter(diamonds, is.na(cut))
# view(diamonds_nocut)

# subset by columns with select
diamonds_sm <- select(diamonds, color, cut)
diamonds_sm <- select(diamonds, 1:4)
diamonds_sm <- select(diamonds, starts_with("c"))
diamonds_sm <- select(diamonds, -price)
diamonds_sm <- diamonds %>% 
  select(-price)

# reorder rows with arrange
diamonds_arr <- diamonds %>% 
  arrange(color)
diamonds_arr <- diamonds %>% 
  arrange(color, carat)
diamonds_arr <- diamonds %>% 
  arrange(desc(carat))
view(diamonds_arr)
glimpse(diamonds)

# add modify columns with mutate()
diamonds_new <- diamonds %>% 
  mutate(mass_g = .20 * carat)
glimpse(diamonds_new)

diamonds_new <- diamonds %>% 
  mutate(mass_g = .20 * carat,
         price_per_carat = price / carat)
glimpse(diamonds_new)

diamonds_new <- diamonds %>% 
  mutate(mass_g = .20 * carat,
         price_per_carat = price / carat,
          cut = tolower(cut))
glimpse(diamonds_new)

diamonds_new <- diamonds %>% 
  mutate(mass_g = .20 * carat,
         price_per_carat = price / carat,
          cut = tolower(cut),
         is_expensive = price > 10000)
glimpse(diamonds_new)

# grouped summaries with group_by and summarize ---------------------------

diamonds %>% 
  group_by(cut) %>% 
  summarise(avg_price = mean(price),
            sd_price = sd(price))

diamonds %>% 
  group_by(cut,
           color) %>% 
  summarise(avg_price = mean(price),
            sd_price = sd(price),
            count = n())

diamonds %>% 
  group_by(expensive = price > 10000) %>% 
  summarise(avg_price = mean(price),
            sd_price = sd(price),
            count = n())
