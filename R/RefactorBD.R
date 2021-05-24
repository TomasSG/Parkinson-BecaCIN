# Vamos a hacer un refactor de las variables categóricas

library(tidyverse)

PATH_DATOS_IN <- "./data/bd_final.csv"
PATH_DATOS_OUT <- "./data/bd_final_refactor.csv"


leer_archivo <- function(path){
  df <- read.table(path, header = TRUE, sep = ";", dec = ".")
  return(df)
}

escribir_archivo <- function(df, path){
  write.table(df, path, sep = ";", dec = ".")
}

df_ini <- leer_archivo(PATH_DATOS_IN)

glimpse(df_ini)

# Cambiamos para que trate a los char como factor
df_fct <- df_ini %>% 
  map_df(~ if(is.character(.x)) { as.factor(.x)} else {.x})

glimpse(df_fct)

# ¿Cómo están distribuidos las categóricas?
df_fct %>% 
  select(where(is.factor)) %>% 
  walk(~ print(table(.x)))

# Reorganizamos las categóricas para que tengan una distribución más equitativa.

# Dividir educ en Posgraduate - College - Highschool
df_fct <- df_fct %>% 
  mutate(educ = fct_collapse(educ,
                             "Postgraduate" = c("Doctoral Degree", "Masters Degree"),
                             "College" = c("2-year college degree", "4-year college degree", "Some graduate school"),
                             "HighSchool" = c("High School Diploma/GED", "Some college", "Some high school")))

# Emplemos lo agrupamos en Working - Not Working
df_fct <- df_fct %>% 
  mutate(empleo = fct_collapse(empleo, 
                               "Working" = c("A homemaker", "Employment for wages", "Self-employed"),
                               "Not Working" = c("A student", "Out of work", "Retired", "Unable to work" )))

# Estado marital lo convertimos en Married - Not Married
df_fct <- df_fct %>% 
  mutate(estado_marital = fct_collapse(estado_marital,
                                       "Married" = c("Married or domestic partnership"),
                                       "Not Married" = c("Divorced", "Other", "Separated", "Single never married", "Widowed")))

# Para facilidad celular lo convertimos en Easy - Not Easy
df_fct <- df_fct %>% 
  mutate(facilidad_celular = fct_collapse(facilidad_celular,
                                          "Not Easy" = c("Difficult", "Neither easy nor difficult", "Very Difficult"),
                                          "Easy" = c("Easy", "Very easy")))

# Observamos como se distribuyen los datos ahora.
df_fct %>% 
  select(where(is.factor)) %>% 
  walk(~ print(table(.x)))

# Guardamos los datos
escribir_archivo(df_fct, PATH_DATOS_OUT)
