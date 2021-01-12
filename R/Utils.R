# --------------------------------------Funciones------------------------------------

contar_ids_repetidos <- function(data, id){
  data %>% dplyr::count({{id}}) %>% dplyr::filter(n > 1) %>% nrow()
}

armar_tabla_frecuencia <- function(data, vars){
  data %>% 
    select(all_of(vars)) %>% 
    map(table)
}


