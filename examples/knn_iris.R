# -------------------------- BIBLIOTECAS --------------------------  
library(tidyverse)
library(caret)
library(pROC)

source("./R/Utils.R")

# -------------------------- FUNCIONES --------------------------  

calcular_medidas <- function(matriz_confusion, cant_decimales = 4){
  
  cantidad_clases <- ncol(matriz_confusion)
  matriz_resultados <- matrix(nrow = cantidad_clases, ncol = 3)
  
  row.names(matriz_resultados) <- row.names(matriz_confusion)
  colnames(matriz_resultados) <- c("Sensitiviy", "Specificity", "Precision")
  
  for(i in 1:cantidad_clases) {
    
    tp <- matriz_confusion[i, i]
    fp <- sum(matriz_confusion[i,]) - tp
    fn <- sum(matriz_confusion[,i]) - tp
    tn <- sum(matriz_confusion[-i,]) - fn
    
    matriz_resultados[i,1] <- round(tp / (tp + fn), digits = cant_decimales)
    matriz_resultados[i,2] <- round(tn / (tn + fp), digits = cant_decimales)
    matriz_resultados[i,3] <- round(tp / (tp + fp), digits = cant_decimales)
  }
  return(matriz_resultados)
}

# -------------------------- CONSTANTES Y OTROS --------------------------  
# Para CARET
SEED <- 12345
PORCENTAJE_TRAIN <- 0.7
NUMBER_FOLDS <- 10

# GRID
ESPACIADO_GRID <- 0.1

# PATH DATOS
PAHT_GRAFICO_OUT <- "./examples/decision_boundary_knn.jpg"

# GRAFICOS
UNIDADES_GRAFICOS <- "cm" 
ANCHO_GRAFICO <- 15
ALTO_GRAFICO <- 30
# -------------------------- CARGAR DATOS --------------------------  
data("iris")

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


matriz_confusion_casera <- table(predict = predicciones, real = df_iris_test$Species)
matriz_confusion_casera

calcular_medidas(matriz_confusion_casera)

multiclass.roc(as.numeric(predicciones), as.numeric(df_iris_test$Species))

# Realizamos el gráfico para ver cómo delimita las zonas

# Primero vamos generar una grilla donde los valores esten igualmente espaciados
pl_grid <- seq(min(df_iris$Petal.Length), max(df_iris$Petal.Length), ESPACIADO_GRID)
pw_grid <- seq(min(df_iris$Petal.Width), max(df_iris$Petal.Width), ESPACIADO_GRID)

# Armamos la grid
grid <- expand.grid(Petal.Length = pl_grid,
                    Petal.Width = pw_grid)


# Hacemos las predicciones
predicciones_grid_clases <- predict(knn_iris_simple, grid)

# Armamos un df para hacer el gráfico del contorno
df_grid <- data.frame(x = grid$Petal.Length, 
                      y =grid$Petal.Width,
                      c = predicciones_grid_clases)

# Armamos un df para las predicciones del df completo
predicciones_test <- predict(knn_iris_simple, df_iris_test[, c("Petal.Length", "Petal.Width", "Species")])

df_test <- data.frame(x = df_iris_test$Petal.Length, 
                     y = df_iris_test$Petal.Width, 
                     c = predicciones_test)


# Hacemos un gráfico
ggplot(df_grid, aes(x, y))  +
  geom_contour(aes(z = as.numeric(c)), size = 1, bins = length(levels(df_grid$c)), linetype = "longdash", color = "black") +
  geom_point(aes(color = c), size = .8) +
  geom_point(data = df_test, aes(x, y, color = c), size = 5, shape = 19) +
  theme_bw() + 
  theme(legend.position = "none")

ggsave(PAHT_GRAFICO_OUT, units = UNIDADES_GRAFICOS, width = ANCHO_GRAFICO, height = ALTO_GRAFICO)
