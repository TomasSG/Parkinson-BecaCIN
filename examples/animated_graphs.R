# Fuentes de información:
#   https://www.datanovia.com/en/blog/gganimate-how-to-create-plots-with-beautiful-animation-in-r/
#   https://gganimate.com/articles/gganimate.html
#   https://anderfernandez.com/blog/como-crear-animaciones-en-r-con-gganimate/

# Bilbiotecas
library(gganimate)
library(tidyverse)
library(gifski)
library(scales)

# Cargamos los datos
datos <- read.table("data/datos_eda.csv", sep = ";", dec = ".", header = TRUE)
glimpse(datos)

# Variables globales
PATH_SUB_DIRECTORIO <- "./examples/"

# Vamos a probar de hacer la proporción de personas con parkinsons según edad
# Preparamos los datos
prop_positivos_por_edad <- datos %>% 
  mutate(diagnostico_pro = ifelse(diagnostico_pro == "true", 1, 0)) %>% 
  group_by(edad) %>% 
  summarise(prop_pos = sum(diagnostico_pro) / n()) 

# Hacemos el gráfico estático
grafico <- ggplot(prop_positivos_por_edad, aes(edad, prop_pos)) + 
  geom_point(color = "firebrick") +
  geom_line(color = "firebrick") +
  xlab("Edad") +
  ylab("Proporción de positivos") +
  ggtitle("Relación positiva entre edad y la proproción de positivos", 
          "Al aumentar la edad se tiene una tendencia de tener mayor proporción de positivos") +
  theme_bw()

# Lo hacemos dinámico
animacion <- grafico + transition_reveal(edad)

animacion

anim_save(paste(PATH_SUB_DIRECTORIO, "render_edad_prop_pos.gif"))


# TODO: Por qué tengo que usar gifski? 
# Usa gisfki por defecto para unir todos los png en un gift. Si no lo tuvieramos instalado
# Devolvería todas las imágnes por separado en lugar de un gift.

# Voy a tratar de hacer un gráfico que cambie según los valores de un factor.
# Se me ocurrio ver como cambia la proporción de hombres y mujeres según la facilidad de usar el 
# celular

# Preparamos los datos
datos <- datos %>% 
  mutate(facilidad_celular = factor(facilidad_celular)) %>% 
  mutate(facilidad_celular = fct_relevel(facilidad_celular, 
                                         c("Very easy", 
                                           "Easy", 
                                           "Neither easy nor difficult", 
                                           "Difficult", 
                                           "Very Difficult")),
         diagnostico_pro = fct_recode(diagnostico_pro,
                                      "Negativo" = "false",
                                      "Positivo" = "true")) %>% 
  filter(!is.na(facilidad_celular)) %>% 
  filter(genero %in% c("Female", "Male"))

# Construimos le gráfico estático
grafico <- datos %>% 
  ggplot(aes(genero, stat(prop), group = diagnostico_pro, fill = diagnostico_pro)) +
  geom_bar(position = "dodge", alpha = .6) +
  xlab("Genero") +
  ylab("") +
  theme_bw() +
  scale_fill_brewer(palette = "Set1") +
  scale_y_continuous(labels = label_percent(1)) +
  theme(legend.position = "none", 
        legend.title = element_blank(),
        plot.title = element_text(face = "bold", size = 20),
        plot.subtitle =  element_text(face = "bold", size = 15)) +
  facet_grid(~ diagnostico_pro)

grafico

# Lo animamos
animacion <- grafico + 
  ggtitle("Hay mayor cantidad de hombres en \nambos grupos",
          "Nivel actual: {closest_state}") +
  transition_states(facilidad_celular, state_length = 2) 

animacion

anim_save(paste(PATH_SUB_DIRECTORIO, "genero_diagnostico_celular.gif"))

# Vamos a hacer un gráfico utilizando las fechas

# Modificando los datos
datos <- datos %>% 
  mutate(dif_comienzo_medicacion = anio_diagnostico - anio_comienzo_med,
         dif_comienzo_sintomas = anio_diagnostico - anio_comienzo_sintomas)


# Armamos el gráfico estático
datos %>% 
  filter(!is.na(anio_diagnostico)) %>% 
  ggplot(aes(d1, d2)) +
  geom_point() +
  transition_time(anio_diagnostico)



