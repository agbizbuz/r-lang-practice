library(tidyverse)
set.seed(0)

?geom_qq

norms <- rnorm(200)
qplot(sample = norms)
df <- data_frame(norms)
ggplot(df, aes(sample = norms)) +
  geom_qq() + 
  geom_qq_line()

# is it right skewed as shown by above plot? yes - check with qplot hist
qplot(x = norms)

df$group <- factor(sample(1:3, 200, replace = T))
ggplot(df, aes(sample = norms, colour = group)) +
  geom_qq() + 
  geom_qq_line() + 
  facet_wrap(~group) + 
  theme_minimal() + 
  scale_color_brewer(palette = "Dark2")

# chi square distribution
chisq <- rchisq(200, 4)
df_chq <- data_frame(chisq)
ggplot(df_chq, aes(sample = chisq)) +
  geom_qq(distribution = qchisq,
          dparams = list(df = 4)) +
  geom_qq_line(distribution = qchisq,
          dparams = list(df = 4))
