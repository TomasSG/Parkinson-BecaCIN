# -------------------------- BIBLIOTECAS --------------------------  
library(tidyverse)
library(caret)
library(pROC)

source("./R/Utils.R")

# -------------------------- CONSTANTES Y OTROS --------------------------  
# Para cargar archivos
PATH_DATOS_IN <- "iris"

# Para CARET
SEED <- 12345
PORCENTAJE_TRAIN <- 0.7
NUMBER_FOLDS <- 10

# -------------------------- CARGAR DATOS --------------------------  
data(PATH_DATOS_IN)

df_iris <- iris

# -------------------------- MANIPULACIÓN DATOS --------------------------  
glimpse(df_iris)

# Los datos están en el formato correcto así que no vamos a modificar nada.

#  -------------------------- KNN --------------------------  

# Hacemos un par de gráficos a ver si hay clara diferenciación siguiendo un par de variables.

ggplot(df_iris, aes(Sepal.Length, Sepal.Width, color = Species, shape = Species)) +
  geom_point()

ggplot(df_iris, aes(Petal.Length, Petal.Width, color = Species, shape = Species)) +
  geom_point()


# Armamos un knn con solo dos variables.
set.seed(SEED)
indices_train <- createDataPartition(df_iris$Species, p = PORCENTAJE_TRAIN, list = FALSE) %>% as.vector()
df_iris_train <- df_iris[indices_train, c("Petal.Length", "Petal.Width", "Species")]
df_iris_test <- df_iris[-indices_train, c("Petal.Length", "Petal.Width", "Species")]

grid <- expand.grid(k = 1:15)
train_control <- trainControl(method = "cv", number = NUMBER_FOLDS)

knn_iris_simple <- train(Species ~ .,
                         df_iris_train, 
                         method = "knn", 
                         preProcess = "range",
                         tuneGrid = grid,
                         trControl = train_control)

knn_iris_simple
plot(knn_iris_simple)


# Evaluamos su poder predictivo
predicciones <- predict(knn_iris_simple, df_iris_test) 
confusionMatrix(predicciones, df_iris_test$Species)


#matriz_confusion_casera <- table(predict = predicciones, real = df_iris_test$Species)
#precision <- 

# Realizamos el gráfico para ver cómo delimita las zonas

# Primero vamos generar una grilla donde los valores esten igualmente espaciados
pl_grid <- seq(min(df_iris$Petal.Length), max(df_iris$Petal.Length), 0.1)
pw_grid <- seq(min(df_iris$Petal.Width), max(df_iris$Petal.Width), 0.1)

# Armamos la grid
grid <- expand.grid(Petal.Length = pl_grid,
                    Petal.Width = pw_grid)


# Hacemos las predicciones
predicciones_grid <- predict(knn_iris_simple, grid)

# Armamos un df para hacer el gráfico
df_grid <- data.frame(x = grid$Petal.Length, 
                      y =grid$Petal.Width,
                      z = predicciones_grid)

# Armamos un df para las predicciones del df completo
predicciones_completo <- predict(knn_iris_simple, df_iris[, c("Petal.Length", "Petal.Width", "Species")])

df_completo <- data.frame(x = df_iris$Petal.Length, 
                     y = df_iris$Petal.Width, 
                     z = predicciones_completo)


# Hacemos un gráfico
ggplot(df_grid, aes(x, y, z = as.integer(z)))  +
  geom_contour(bins = 3, size = 1, colour = "black", linetype = 2) +
  geom_point(aes(color = z), size = 0.05) +
  geom_point(data = df_completo, aes(x, y, color = z), size = 2, shape = 19) +
  theme_bw()
