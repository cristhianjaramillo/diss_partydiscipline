#####EVALUATION OF MODEL#######

library(betareg)
library(MASS)
library(xtable)
library(officer)
library(rvg)
library(kableExtra)
library(flextable)
library(car)
library(sandwich)
library(gridExtra)
library(caret)

# Calculate AIC and BIC for each model

aic_values <- AIC(beta_model8, beta_model1, beta_model2, beta_model3, beta_model4,
                  beta_model5, beta_model6, beta_model7)

bic_values <- BIC(beta_model8, beta_model1, beta_model2, beta_model3, beta_model4,
                  beta_model5, beta_model6, beta_model7)

# Processing the data to make a table

aic_values$model <- rownames(aic_values) 
rownames(aic_values) <- NULL

aic_values <- aic_values[,c(3,1,2)]

aic_values <- aic_values %>% mutate(model = dplyr::recode(model,
                            `beta_model8` = "Model 8 (full model)",
                            `beta_model1` = "Model 1",
                            `beta_model2` = "Model 2",
                            `beta_model3` = "Model 3",
                            `beta_model4` = "Model 4",
                            `beta_model5` = "Model 5",
                            `beta_model6` = "Model 6",
                            `beta_model7` = "Model 7"))

bic_values$model <- rownames(bic_values) 
rownames(bic_values) <- NULL

bic_values <- bic_values[,c(3,1,2)]

bic_values <- bic_values %>% mutate(model = dplyr::recode(model,
                             `beta_model8` = "Model 8 (full model)",
                             `beta_model1` = "Model 1",
                             `beta_model2` = "Model 2",
                             `beta_model3` = "Model 3",
                             `beta_model4` = "Model 4",
                             `beta_model5` = "Model 5",
                             `beta_model6` = "Model 6",
                             `beta_model7` = "Model 7"))


aic_values$BIC <- bic_values$BIC

aic_values$df <- NULL

colnames(aic_values)[1] ="Model"

final_table <- aic_values

# This is the final table with AIC and BIC values

final_table

#### Further evaluation for model 8 ####

# Calculating residuals
residuals <- residuals(beta_model8)

# Residuals vs. Fitted plot
plot1 <- plot(predict(beta_model8, type = "response"), residuals,
     xlab = "Fitted Values", ylab = "Residuals",
     main = "Residuals vs. Fitted")

# Normal Q-Q plot of residuals

plot2 <- qqnorm(residuals)
qqline(residuals)

# Calculate the standardized residuals
bread <- bread(beta_model8)
std_residuals <- residuals(beta_model8) / sqrt(diag(bread))

# Scale-Location plot
plot3 <- plot(predict(beta_model8, type = "response"), sqrt(abs(std_residuals)),
     xlab = "Fitted Values", ylab = "Square Root of Standardized Residuals",
     main = "Scale-Location Plot")

# Create a layout for the combined plot
layout_matrix <- matrix(c(1, 2, 3), nrow = 1)

# Set up the layout
layout(layout_matrix)

# Plot the individual plots in the specified layout
plot1
plot2
plot3

# Reset the layout
layout(1)

# Creating indices for cross-validation
set.seed(123)  # For reproducibility
folds <- createFolds(base_b$party_discipline_adjusted, k = 10)  # 10-fold cross-validation

# Looping for cross-validation

# An empty vector to store cross-validated predictions
cv_predictions <- rep(NA, nrow(base_b))

for (i in seq_along(folds)) {
  # Training and testing datasets
  train_indices <- unlist(folds[-i])
  test_indices <- folds[[i]]
  
  train_data <- base_b[train_indices, ]
  test_data <- base_b[test_indices, ]
  
  # Fit beta regression model on the training data
  model <- betareg(party_discipline_adjusted ~ party_affiliation + gender + re_elected +
                     role + pol_experience_std + age_std + prop_votes_std + rule,
                   data = train_data)
  
  # Predict on the testing data
  cv_predictions[test_indices] <- predict(model, newdata = test_data, type = "response")
}

# Calculate cross-validated MSE
cv_mse <- mean((cv_predictions - base_b$party_discipline_adjusted)^2)

summary(base_b$party_discipline_adjusted)
