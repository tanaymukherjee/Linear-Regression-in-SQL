# Python Notebook - Clone of Linear Regression in SQL

library(dplyr)
datasets

linear_time_model <- lm(south ~ time_c, data = datasets[[3]])
linear_time_model
datasets[[2]]

summary(linear_time_model)
datasets[[4]]

time_seasonality_model_df <- datasets[[1]] %>%
  mutate(month_contr = factor(month))
contrasts(time_seasonality_model_df$month_contr) <- contr.helmert(12)
contrasts(time_seasonality_model_df$month_contr)

time_seasonality_model_contr_2 <- lm(south ~ time_c + month_contr,
                            data = filter(time_seasonality_model_df, year <= 2013))
time_seasonality_model_contr_2
datasets[[5]]

model.matrix(time_seasonality_model_contr_2) %>%
  cor()

