# Videos youtube: https://www.youtube.com/watch?v=z8PRU46I3NY&ab_channel=DataScienceDojo

# Mios
library(tidyverse)
library(pROC)

# Del tutorial
library(caret)
library(e1071)
library(doSNOW)
library(ipred)
library(xgboost)


titanic <- read.csv("./data/train.csv")

glimpse(titanic)

# Nos quedamos con las variables a usar
titanic <- titanic %>% 
    select(-PassengerId, -Name, -Ticket, -Cabin)

# Reemplazar blancos en embarked
table(titanic$Embarked)

titanic <- titanic %>% 
    mutate(Embarked = replace(Embarked, Embarked == "", "S"))

# Añadir tracking a los NA de age, capaz podamso usar este patrón para predecir
summary(titanic$Age)

titanic <- titanic %>% 
    mutate(missing_age = ifelse(is.na(Age), "Y", "N"))

table(titanic$missing_age)

# Vamos a  combinar las dos variables de parientes en uno
titanic <- titanic %>% 
    mutate(family_size = SibSp + Parch + 1)

ggplot(titanic, aes(family_size)) + geom_bar()

# Transformamos las variables a factores para que seane tratadas como categóricas
titanic <- titanic %>% 
    mutate(Survived = as.factor(Survived),
           Pclass = as.factor(Pclass),
           Sex = as.factor(Sex),
           Embarked = as.factor(Embarked),
           missing_age = as.factor(missing_age))

glimpse(titanic)

# Imputamos los valores faltantes de age
titanic_imputado <- dummyVars(~., titanic[,-1]) %>% 
    predict(titanic[,-1]) %>% 
    preProcess(titanic_dummy, method = "bagImpute") %>% 
    predict(titanic_dummy)

titanic <- titanic %>% 
    mutate(Age = titanic_imputado[,"Age"])

summary(titanic$Age)

# Dividir data
set.seed(54321)
indeces_train <- createDataPartition(titanic$Survived, times = 1, p = .7, list = FALSE)

titanic_train <- titanic[indeces_train,]

titanic_test <- titanic[-indeces_train,]

print("En dataset completo")
table(titanic$Survived) %>% prop.table()

print("En dataset train")
table(titanic_train$Survived) %>% prop.table()

print("En dataset test")
table(titanic_test$Survived) %>% prop.table()

# Establecemos la fomra en que se entrenara al modelo
train_control <- trainControl(method = "repeatedcv",
                              number = 10,
                              repeats = 3,
                              search = "grid")
# Esto no se bien que hace
tune_grid <- expand.grid(eta = c(.05, .075, .1),
                         nrounds = c(50, 75, 100),
                         max_depth = 6:8,
                         min_child_weight = c(2.0, 2.25, 2.5),
                         colsample_bytree = c(.3, .4, .5),
                         subsample = 1,
                         gamma = 1)

# Para correr en paralelo
cluster <- makeCluster(5, type = "SOCK")
registerDoSNOW(cluster)

# Costruimos el modelo
modelo <- train(Survived ~ .,
                data = titanic_train,
                method = "xgbTree",
                tuneGrid = tune_grid,
                trControl = train_control)

stopCluster(cluster)

modelo

# Hacemos las prediccioens y vemos la perfomance
predicciones <- predict(modelo, titanic_test)
confusionMatrix(predicciones, titanic_test$Survived)

predicciones_raw <- predict(modelo, titanic_test, type = "prob")[,"1"]
roc(titanic_test$Survived, predicciones_raw) %>% 
    auc()
