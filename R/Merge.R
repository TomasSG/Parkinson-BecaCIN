library(tidyverse)
library(readxl)

source("./R/Utils.R")

# Constantes, variables globales y otros

PATH_BD_ACTOADA <- "./data/bd_acotada.xlsx"
PATH_BD_COMPLETA <- "./data/bd_completa.xlsx"
PATH_BD_SALIDA <- "./data/bd_final.csv"

SEPARADOR_REGISTROS <- ";" 
SEPARADOR_DECIMAL <- "."

variables_bd_acotada <- c("ROW_ID", "d1", "d2", "d3", "d4", "d5")
variables_bd_completa <- c("ROW_ID2", 
                           "age", 
                           "are-caretaker", 
                           "deep-brain-stimulation",
                           "diagnosis-year", 
                           "education", 
                           "employment", 
                           "gender", 
                           "healthcare-provider",
                           "maritalStatus", 
                           "medication-start-year", 
                           "onset-year",
                           "packs-per-day",
                           "smartphone", 
                           "smoked", 
                           "surgery", 
                           "video-usage",
                           "years-smoking",
                           "professional-diagnosis",
                           "medTimepoint",
                           "F0semitoneFrom27#5Hz_sma3nz_amean", 
                           "F0semitoneFrom27#5Hz_sma3nz_stddevNorm", 
                           "F0semitoneFrom27#5Hz_sma3nz_percentile20#0", 
                           "F0semitoneFrom27#5Hz_sma3nz_percentile50#0", 
                           "F0semitoneFrom27#5Hz_sma3nz_percentile80#0", 
                           "F0semitoneFrom27#5Hz_sma3nz_pctlrange0-2", 
                           "F0semitoneFrom27#5Hz_sma3nz_meanRisingSlope", 
                           "F0semitoneFrom27#5Hz_sma3nz_stddevRisingSlope", 
                           "F0semitoneFrom27#5Hz_sma3nz_meanFallingSlope", 
                           "F0semitoneFrom27#5Hz_sma3nz_stddevFallingSlope", 
                           "jitterLocal_sma3nz_amean", 
                           "jitterLocal_sma3nz_stddevNorm", 
                           "shimmerLocaldB_sma3nz_amean", 
                           "shimmerLocaldB_sma3nz_stddevNorm")

# Código hacer join entre las tablas
datos_izq <- read_excel(PATH_BD_ACTOADA) %>% 
  select(all_of(variables_bd_acotada))

datos_der <- read_excel(PATH_BD_COMPLETA) %>% 
  select(all_of(variables_bd_completa)) %>% 
  rename(ROW_ID = ROW_ID2)

# Validamos ids_repetidos
contar_ids_repetidos(datos_izq, ROW_ID)
contar_ids_repetidos(datos_der, ROW_ID)

# Observamos los duplicados
row_id_duplicado <- datos_der %>% 
  count(ROW_ID) %>% 
  filter(n > 1) %>% 
  select(ROW_ID)

datos_der %>% 
  filter(ROW_ID %in% row_id_duplicado$ROW_ID) %>% 
  arrange(ROW_ID)

# Borramos los duplicados
datos_der <- datos_der %>% distinct(ROW_ID, .keep_all = TRUE)

contar_ids_repetidos(datos_der, ROW_ID)

# Hacemos un left join
datos_crudos <- left_join(datos_izq, datos_der, by = "ROW_ID")

# Les cambiamos el nombre
datos_final <- datos_crudos %>%
  rename(id = ROW_ID,
         edad = age,
         es_cuidador = `are-caretaker`,
         dbs = `deep-brain-stimulation`,
         anio_diagnostico = `diagnosis-year`,
         educ = education,
         empleo = employment,
         genero = gender,
         tipo_medico = `healthcare-provider`,
         estado_marital = maritalStatus,
         anio_comienzo_med = `medication-start-year`,
         anio_comienzo_sintomas = `onset-year`,
         paquetes_por_dia = `packs-per-day`,
         facilidad_celular = smartphone,
         fumo = smoked,
         cirugia = surgery,
         videollamada = `video-usage`,
         anios_fumo = `years-smoking`,
         diagnostico_pro = `professional-diagnosis`,
         punto_medicacion = medTimepoint)

# Reemplzamos los NULL por NA
datos_final[datos_final == "NULL"] <- NA

# Por último guardamos los datos para utilizarlos en el futuro
write.table(datos_final, PATH_BD_SALIDA, sep = SEPARADOR_REGISTROS, dec = SEPARADOR_DECIMAL)


