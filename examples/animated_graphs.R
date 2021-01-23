# El tutorial es de esta página: https://www.datanovia.com/en/blog/gganimate-how-to-create-plots-with-beautiful-animation-in-r/

# Bilbiotecas
library(gganimate)
library(tidyverse)
library(gifski)


# Cargamos los datos
datos <- read.table("data/datos_eda.csv", sep = ";", dec = ".", header = TRUE)
glimpse(datos)


# Vamos a probar de hacer la proporción de personas con parkinsons según edad

# Declaramos unas variables que van a ser importantes al final
N_FRAME <-  120
HEIGHT <- 700
WIDTH <- 1000

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

animate(p, 
        render = gifski_renderer("./examples/render_edad_prop_pos.gif"), 
        nframe = N_FRAME, 
        height = HEIGHT, 
        width = WIDTH)

# TODO: Por qué tengo que usar gifski?



