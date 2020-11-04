asd <- datos_it1 %>% 
  mutate(valor = abs(d2))

asd <- asd %>% 
  mutate(divisor = ifelse(valor < 10, 1, ifelse(valor < 100, 10, ifelse(valor < 1000, 100, 1000)))) %>% 
  mutate(pd = floor(valor / divisor))

asd <- subset(asd, pd != 0)

ggplot(asd, aes(x = pd, y = ..count.. / sum(..count..))) +
  geom_bar() +
  scale_x_continuous(breaks = seq(1, 10, 1)) +
  scale_y_continuous(labels = label_percent(2), breaks = seq(0, .4, .1)) +
  ylab("")
