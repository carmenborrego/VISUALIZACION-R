library(ggplot2)
mpg
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar()+theme_minimal()

ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "stack")+theme_minimal()

#ahora se hace una grafica agrupada 
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "dodge")
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = position_dodge(preserve = "single"))

#Grafica de barras segmentada
#sirve para comparar el porcentaje de una categoria 
#en una variable atraves de cada nivel de otra variable 
# bar plot, with each bar representing 100%
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "fill") +
  labs(y = "Proportion")

library(scales)
ggplot(mpg, 
       aes(x = factor(class,
                      levels = c("2seater", "subcompact", 
                                 "compact", "midsize", 
                                 "minivan", "suv", "pickup")),
           fill = factor(drv, 
                         levels = c("f", "r", "4"),
                         labels = c("front-wheel", 
                                    "rear-wheel", 
                                    "4-wheel")))) + 
  geom_bar(position = "fill") +
  scale_y_continuous(breaks = seq(0, 1, .2), 
                     label = percent) +
  scale_fill_brewer(palette = "Set2") +
  labs(y = "Percent", 
       fill="Drive Train",
       x = "Class",
       title = "Automobile Drive by Class") +
  theme_minimal()

#ahora se le agregan etiquetas con porcentajes a cada segmento 
#primero se crea un summary dataset necesario para las etiquetas 
library(dplyr)
plotdata <- mpg %>%
  group_by(class, drv) %>%
  summarize(n = n()) %>% 
  mutate(pct = n/sum(n),
         lbl = scales::percent(pct))
plotdata

ggplot(plotdata, 
       aes(x = factor(class,
                      levels = c("2seater", "subcompact", 
                                 "compact", "midsize", 
                                 "minivan", "suv", "pickup")),
           y = pct,
           fill = factor(drv, 
                         levels = c("f", "r", "4"),
                         labels = c("front-wheel", 
                                    "rear-wheel", 
                                    "4-wheel")))) + 
  geom_bar(stat = "identity",
           position = "fill") +
  scale_y_continuous(breaks = seq(0, 1, .2), 
                     label = percent) +
  geom_text(aes(label = lbl), 
            size = 3, 
            position = position_stack(vjust = 0.5)) +
  scale_fill_brewer(palette = "Set2") +
  labs(y = "Percent", 
       fill="Drive Train",
       x = "Class",
       title = "Automobile Drive by Class") +
  theme_minimal()








