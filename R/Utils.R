MSJ_ERROR_BIBLIOTECAS <- "Faltan bibliotecas necesarias"

# --------------------------------------Funciones------------------------------------

contar_ids_repetidos <- function(data, id){
  if(require(tidyverse) == FALSE){
    print(MSJ_ERROR_BIBLIOTECAS)
    return()
  }
  data %>% dplyr::count({{id}}) %>% dplyr::filter(n > 1) %>% nrow()
}

armar_tabla_frecuencia <- function(data, vars){
  if(require(tidyverse) == FALSE){
    print(MSJ_ERROR_BIBLIOTECAS)
    return()
  }
  
  data %>% 
    select(all_of(vars)) %>% 
    map(table)
}

graficar_curva_roc <- function(modelo, datos_test, nivel_positivo, var_respuesta, type_predict = "prob") {
  if(require(pROC) == FALSE || require(tidyverse) == FALSE){
    print(MSJ_ERROR_BIBLIOTECAS)
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

crear_df_evaluacion <- function(modelo, datos, nombre_var_respuesta, nombre_var_ids, type_predict, nivel_positivo ) {
  
  if(require(tidyverse) == FALSE){
    print(MSJ_ERROR_BIBLIOTECAS)
    return()
  }  
  
  # Hacemos la predicción
  y_predichos <- predict(modelo, datos, type = type_predict)[,nivel_positivo]
  
  # Extraemos los valores y observados
  y_obs <- datos[[nombre_var_respuesta]]
  
  # Extraemos los ids
  ids <- datos[[nombre_var_ids]]
  
  # Creamos el df y devolvemos el resultado
  df_resultado <- data.frame(ids, y_obs, y_predichos) %>% arrange(-y_predichos)
  return(df_resultado)
}

calcular_porcentaje_correctos <- function(modelo, datos, p_df, nombre_var_respuesta, nombre_var_ids, type_predict, nivel_positivo) {
  
  if(require(tidyverse) == FALSE){
    print(MSJ_ERROR_BIBLIOTECAS)
    return()
  }  
  
  # Obtenemos el df para hacer la evaluacion
  df <- crear_df_evaluacion(modelo, datos, nombre_var_respuesta, nombre_var_ids, type_predict, nivel_positivo)
  
  # Calculamos las n observaciones que vamos a usar en base a p_df.
  nro_filas_df <- nrow(df)
  nro_filas_sub <- floor(p_df * nro_filas_df)
  
  # Apartamos las primeras n observaciones y calculamos el porcentajes de correctos
  df <- df[1:nro_filas_sub,]
  p_correctos <- sum(df$y_obs == nivel_positivo) / nro_filas_sub
  
  return(round(p_correctos, 4))
  
}

evaluar_modelo_metodo_silvia <- function(modelo, datos, proporciones, nombre_var_respuesta, nombre_var_ids, type_predict = "prob", nivel_positivo = "true"){

  if(require(tidyverse) == FALSE){
    print(MSJ_ERROR_BIBLIOTECAS)
    return()
  }
    
  # Creamos el vector donde guardamos los resultados
  porcentaje_correctos <- vector(mode = "numeric", length = length(proporciones))
  
  # Iteramos para tener todos los porcentajes de correctos
  for(i in seq_along(proporciones)) {
    porcentaje_correctos[i] <- calcular_porcentaje_correctos(modelo, 
                                                             datos, 
                                                             proporciones[i], 
                                                             nombre_var_respuesta = "diagnostico_pro", 
                                                             nombre_var_ids = "id",
                                                             type_predict = type_predict,
                                                             nivel_positivo = nivel_positivo) 
  }
  
  # Hacemos el grafico de columnas
  data.frame(x = proporciones, y = porcentaje_correctos) %>% 
    ggplot(aes(x, y)) +
    geom_col(fill = "firebrick", alpha = .6) +
    geom_label(aes(label = paste(y * 100, "%")), nudge_y = .04) +
    scale_x_continuous("Proporcion", labels = label_percent(1L), breaks = proporcion) +
    scale_y_continuous("Porcentaje correctos", labels = label_percent()) +
    theme_bw()

}
