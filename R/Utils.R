# --------------------------------------Funciones------------------------------------

contar_ids_repetidos <- function(data, id){
  data %>% dplyr::count({{id}}) %>% dplyr::filter(n > 1) %>% nrow()
}



