# --------------------------------------Funciones------------------------------------

contar_ids_repetidos <- function(data, id){
  data %>% dplyr::count({{id}}) %>% dplyr::filter(n > 1) %>% nrow()
}

armar_tabla_frecuencia <- function(data, vars){
  data %>% 
    select(all_of(vars)) %>% 
    map(table)
}

evaluar_modelo <- function(modelo, datos_test, nivel_positivo, var_respuesta) {
  predicciones <- predict(modelo, datos_test, list = FALSE, type = "prob")[,nivel_positivo]
  auc <- roc(datos_test[[var_respuesta]], predicciones) %>% auc
  return(auc)
}


