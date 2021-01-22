# El tutorial es de esta página: https://www.datanovia.com/en/blog/gganimate-how-to-create-plots-with-beautiful-animation-in-r/

# Bilbiotecas
library(gganimate)
library(tidyverse)


# Cargamos los datos
datos <- read.table("data/datos_eda.csv", sep = ";", dec = ".", header = TRUE)
glimpse(datos)


# Vamos a probar de hacer la proporción de personas con parkinsons según edad

# Preparamos los datos
prop_positivos_por_edad <- datos %>% 
  mutate(diagnostico_pro = ifelse(diagnostico_pro == "true", 1, 0)) %>% 
  group_by(edad) %>% 
  summarise(prop_pos = sum(diagnostico_pro) / n()) 

# Hacemos el gráfico estático
g <- ggplot(prop_positivos_por_edad, aes(edad, prop_pos)) + 
  geom_point() +
  geom_line() +
  xlab("Edad") +
  ylab("Proporción de positivos") +
  ggtitle("Relación postiiva entre edad y la proproción de positivos", 
          "Al aumentar la edad se tiene una tendencia de tener mayor proporción de positivos") +
  theme_minimal()

# Lo hacemos dinámico
g + transition_reveal(edad)




