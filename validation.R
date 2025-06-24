#IMPORT LIBRARY
library(ggplot2)
library(dplyr)
library(readr)

#Import data
credit_scoring <- read.csv("D:/WORK/REMOTE/ds-takehome/data/credit_scoring.csv")
data_credit_copy = credit_scoring

#Membuat model regresi logistik
library(glmtoolbox)
model <- glm(default ~ age + monthly_income + loan_amount + previous_defaults + credit_score, data = credit_scoring, family = binomial())
summary(model)

#uji godness of fit --> hosmer-lemeshow
hosmer_result <- hltest(model) #default g=10
# p-value > 0.72574 : artinya model


# prob calib with bins 10
data_credit_copy$yhat_prob <- predict(model, type = "response")
data_credit_copy$group <- ntile(data_credit_copy$yhat_prob, 10)

calib_data <- data_credit_copy %>%
  group_by(group) %>%
  summarise(actual = mean(default), predicted = mean(yhat_prob))

# Plot Probability Calibration
plot_calib <- ggplot(calib_data, aes(x = predicted, y = actual)) +
  geom_line(color = "blue") +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "green") +
  labs(title = "Calibration Curve", x = "Avg Predicted Probability", y = "Avg Actual Default Rate") +
  theme_minimal()

ggsave("calibration_curve.png", plot = plot_calib, width = 6, height = 4)
