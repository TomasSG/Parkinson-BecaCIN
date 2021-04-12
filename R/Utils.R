# --------------------------------------Funciones------------------------------------

contar_ids_repetidos <- function(data, id){
  if(require(tidyverse) == FALSE){
    return()
  }
  data %>% dplyr::count({{id}}) %>% dplyr::filter(n > 1) %>% nrow()
}

armar_tabla_frecuencia <- function(data, vars){
  if(require(tidyverse) == FALSE){
    return()
  }
  
  data %>% 
    select(all_of(vars)) %>% 
    map(table)
}

graficar_curva_roc <- function(modelo, datos_test, nivel_positivo, var_respuesta, type_predict = "prob") {
  if(require(pROC) == FALSE || require(tidyverse) == FALSE){
    return()
  }
  
  # Primero obtenemos las probabilidades predichas
  predicciones <- predict(modelo, datos_test, type = type_predict)[,nivel_positivo]
  
  # Calculamos la sensitivity y especificity para cada valor de corte posible
  objeto_roc <- roc(datos_test[[var_respuesta]], predicciones)
  
  # Calculamos el AUROC
  auroc <- auc(objeto_roc)
  
  # Graficamos la curva ROC
  data.frame(Sensitivity = objeto_roc$sensitivities,
             Specificity = objeto_roc$specificities)  %>% 
    ggplot(aes(1 - Specificity, Sensitivity)) +
    geom_line() + 
    ggtitle("Curva ROC", paste("AUROC:", round(auroc, 4)))
}

crear_df_evaluacion <- function(modelo, 
                                datos, 
                                nombre_var_respuesta, 
                                ids, 
                                type_predict = "prob", 
                                nivel_positivo = "true") {
  
  if(require(tidyverse) == FALSE){
    return()
  }
  
  y_predichos <- predict(modelo, datos, type = type_predict)[,nivel_positivo]
  
  y_obs <- datos[[nombre_var_respuesta]]
  
  df_resultado <- data.frame(ids, y_obs, y_predichos) %>% arrange(y_predichos)
  
  return(df_resultado)
}
