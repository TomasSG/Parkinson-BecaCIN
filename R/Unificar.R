library(tidyverse)

#--------------------------- Funciones --------------------------- 

contar_nas <- function(vector) sum(is.na(vector))

#--------------------------- Cosas --------------------------- 

datos <- read.csv2("./data/datos_eda.csv")

# Limpio Id 
datos <- datos %>% select(-id)

# Cantidad de variables y muestras
paste("Variables:", ncol(datos))
paste("Observaciones:", nrow(datos))

# Todas las variables
names(datos)

# Vemos la cantidas de NAs
datos %>% map_int(contar_nas)

# Recategorización de variables cuali
# Dividir educ en Posgraduate - College - Highschool
datos <- datos %>% 
  mutate(educ_baleanceado = fct_collapse(educ,
                             "Postgraduate" = c("Doctoral Degree", "Masters Degree"),
                             "College" = c("2-year college degree", "4-year college degree", "Some graduate school"),
                             "HighSchool" = c("High School Diploma/GED", "Some college", "Some high school")))

# Emplemos lo agrupamos en Working - Not Working
datos <- datos %>% 
  mutate(empleo_baleanceado = fct_collapse(empleo, 
                               "Working" = c("A homemaker", "Employment for wages", "Self-employed"),
                               "Not Working" = c("A student", "Out of work", "Retired", "Unable to work" )))

# Genero sacamos la observacion con Prefer not to answer
datos <- datos %>% 
  filter(genero != "Prefer not to answer")

# Estado marital lo convertimos en Married - Not Married
datos <- datos %>% 
  mutate(estado_marital_baleanceado = fct_collapse(estado_marital,
                                       "Married" = c("Married or domestic partnership"),
                                       "Not Married" = c("Divorced", "Other", "Separated", "Single never married", "Widowed")))

# Para facilidad celular lo convertimos en Easy - Not Easy
datos <- datos %>% 
  mutate(facilidad_celular_baleanceado = fct_collapse(facilidad_celular,
                                          "Not Easy" = c("Difficult", "Neither easy nor difficult", "Very Difficult"),
                                          "Easy" = c("Easy", "Very easy")))










