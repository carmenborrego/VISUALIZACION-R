# load the data
url <- "https://tinyurl.com/mtktm8e5"
insurance <- read.csv(url)
#luego se indica si el paciente es obeso o no 
#obesidad se define como indice de masa corporal igual o mayor a 30
#se crea la variable de obesidad
#la siguiente linea de codigo indica si el paciente es 
#obeso o no de acuerdo con el criterio anterior 
#y agrega la variable binaria obeso o no obeso 
#al conjunto de datos
insurance$obese <- ifelse(insurance$bmi >= 30, 
                          "obese", "not obese")

#ahora se aplica la función ggplot 
#primero se llama al conjunto de datos
#se va a comenzar con la relación entre 
#edad y gasto en salud 
# specify dataset and mapping
library(ggplot2)
ggplot(data = insurance,
       mapping = aes(x = age, y = expenses))
#lo anterior solamente plotea el fondo del gráfico y la escala 
#con geoms_ se indican los objetos geométricos pueden ser 
#puntos, lineas, barras, etc. 
#con geom_point se crea un scatter plot o diagrama de dispr
#en ggplot las funciones se agregan a otras con el signo de + 
ggplot(data = insurance,
       mapping = aes(x = age, y = expenses))+
  geom_point()
#geom_ acepta opciones de color, size, y alpha
#estos controlan el color de los puntos, 
#el tamaño la transparencia que va de cero a 1 (completamente opaco)
#agregar un grado de transparencia permite visualizar puntos sobrepuestos
# make points blue, larger, and semi-transparent
ggplot(data = insurance,
       mapping = aes(x = age, y = expenses)) +
  geom_point(color = "cornflowerblue",
             alpha = .7,
             size = 2)
#ahora se agrega una linea que ajuste bien a los datos 
#las opciones son el tipo de linea lineal, cuadratica, no parametrica 
#el grueso de la linea, el color de la linea 
#y la presencia o ausencia de los intervalos de confianza 
#aquí se pide un metodo lineal con method=lm
ggplot(data = insurance,
       mapping = aes(x = age, y = expenses)) +
  geom_point(color = "cornflowerblue",
             alpha = .5,
             size = 2) +
  geom_smooth(method = "lm")

#agrupando 
#en este caso se agrupa por si fuman o no 
#las variables también pueden ser mapeadas por color 
#figura, tamaño y transparencia 
#esto permite que las categorias puedan quedar superpuestas 

ggplot(data = insurance,
       mapping = aes(x = age, 
                     y = expenses,
                     color = smoker)) +
  geom_point(alpha = .5,
             size = 2) +
  geom_smooth(method = "lm", 
              se = FALSE, 
              size = 1.5)

#la opción de color=smoke en la funcion aes porque se esta 
#mapeando una variable ne un aestetic 
#la opción geom_smooth con la opcion (se=FALSE)
#impide que se imrimanlos intervalos de confianza 

#escalas 
#las escalas controlan como las variables son mapeada sen el grafico 

ggplot(data = insurance,
       mapping = aes(x = age, 
                     y = expenses,
                     color = smoker)) +
  geom_point(alpha = .5,
             size = 2) +
  geom_smooth(method = "lm", 
              se = FALSE, 
              size = 1.5) +
  scale_x_continuous(breaks = seq(0, 70, 10)) +
  scale_y_continuous(breaks = seq(0, 60000, 20000),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", 
                                "cornflowerblue"))

#FACETS 
#facets reproduce una gráfica para cada nivel de una variable 
#determinada o pares de variables 
#en este caso facets se define como los dos niveles de 
#de la variable obeso o no obeso 
ggplot(data = insurance,
       mapping = aes(x = age, 
                     y = expenses,
                     color = smoker)) +
  geom_point(alpha = .5) +
  geom_smooth(method = "lm", 
              se = FALSE) +
  scale_x_continuous(breaks = seq(0, 70, 10)) +
  scale_y_continuous(breaks = seq(0, 60000, 20000),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", 
                                "cornflowerblue")) +
  facet_wrap(~obese)
#esta visualización permite ver simultaneamente la relaicón 
#entre edad, si fuma o no, obesidad y gasto en m+edicos 

#LABELS 
#los labels permiten interpetar mejor las gráficas 
#la función labels provee etiquetas personalizadas 
#para los ejes y leyendas 
#también se puedne agregar titulo personalizado, subtitulo 
#y caption 

ggplot(data = insurance,
       mapping = aes(x = age, 
                     y = expenses,
                     color = smoker)) +
  geom_point(alpha = .5) +
  geom_smooth(method = "lm", 
              se = FALSE) +
  scale_x_continuous(breaks = seq(0, 70, 10)) +
  scale_y_continuous(breaks = seq(0, 60000, 20000),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", 
                                "cornflowerblue")) +
  facet_wrap(~obese) +
  labs(title = "Relationship between patient demographics and medical costs",
       subtitle = "US Census Bureau 2013",
       caption = "source: http://mosaic-web.org/",
       x = " Age (years)",
       y = "Annual expenses",
       color = "Smoker?")

#Themes 
#estas funciones controlan los colores de fondo 
#fuentes y si lleva grid o no 
#dónde se presenta la leyenda 
#y otras cosas no relacionadas con los datos 
ggplot(data = insurance,
       mapping = aes(x = age, 
                     y = expenses,
                     color = smoker)) +
  geom_point(alpha = .5) +
  geom_smooth(method = "lm", 
              se = FALSE) +
  scale_x_continuous(breaks = seq(0, 70, 10)) +
  scale_y_continuous(breaks = seq(0, 60000, 20000),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", 
                                "cornflowerblue")) +
  facet_wrap(~obese) +
  labs(title = "Relationship between age and medical expenses",
       subtitle = "US Census Data 2013",
       caption = "source: https://github.com/dataspelunking/MLwR",
       x = " Age (years)",
       y = "Medical Expenses",
       color = "Smoker?") +
  theme_minimal()


#PLACING 
ggplot(insurance,
       aes(x = age, 
           y = expenses,
           color = smoker)) +
  geom_point(alpha = .5,
             size = 2) +
  geom_smooth(method = "lm",
              se = FALSE, 
              size = 1.5)
#en el ejemplo anterior las opciones data y mapping 
#se agregaron a la función ggplot 
#ahora se van a aplicar 
#para cada funcion geom_ 
#en este caso solamente se se aplican a esa geom especifica

#como el mapping de la variable smoker aparece en la funcion 
#ggplot se aplica al geom_point y a geom_smooth
#el color del punto indica si la persona fuma o no 
ggplot(insurance,
       aes(x = age, 
           y = expenses)) +
  geom_point(aes(color = smoker),
             alpha = .5,
             size = 2) +
  geom_smooth(method = "lm",
              se = FALSE, 
              size = 1.5)


#GRAFICAS COMO OBJETOS 
myplot <- ggplot(data = insurance,
                 aes(x = age, y = expenses)) +
  geom_point()
myplot
myplot <- myplot + geom_point(size = 2, color = "blue")
myplot
#al objeto se le pueden agregar otras caracteristicas 
myplot + geom_smooth(method = "lm") +
  labs(title = "Mildly interesting graph")
myplot + theme_bw()


#GRAFICOS PARA DATOS UNIVARIADOS 
library(mosaicData)
install.packages("mosaicData")
data(Marriage, package="mosaicData")
ggplot(Marriage, aes(x = race)) + 
  geom_bar()
#se modifica el relleno de las barras y sus bordes 
#las etiquetas y el titulo 
#se utiliza fill para hacer esto 
ggplot(Marriage, aes(x=race)) + 
  geom_bar(fill = "cornflowerblue", 
           color="black") +
  labs(x = "Race", 
       y = "Frequency", 
       title = "Participants by race")

#PORCENTAJES 
#se plotean los porcentajes de la distribución 

ggplot(Marriage, 
       aes(x = race, y = after_stat(count/sum(count)))) + 
  geom_bar() +
  labs(x = "Race", 
       y = "Percent", 
       title  = "Participants by race") +
  scale_y_continuous(labels = scales::percent)
#se utilizó el paquete scales para agregar los % 
#al eje de las y 


#Clasificación 
#se llama a la libreria dplyr 
library(dplyr)
plotdata <- Marriage %>%
  count(race)
#este nuevo conjunto de datos  se utilzia para una grafica 
ggplot(plotdata, 
       aes(x = reorder(race, n), y = n)) + 
  geom_bar(stat="identity") +
  labs(x = "Race", 
       y = "Frequency", 
       title  = "Participants by race")
#las varras se acomodan en orden ascendente 
#para acomodarlas en orden descendente se utiliza (race, -n)
ggplot(plotdata, 
       aes(x = reorder(race, -n), y = n)) + 
  geom_bar(stat="identity") +
  labs(x = "Race", 
       y = "Frequency", 
       title  = "Participants by race")


#PARA ETIQUETAR CADA BARRA SE HACE LO SIGUIENTE
#con geom_text
#vjust conrola la justificacion vertical 
ggplot(plotdata, 
       aes(x = race, y = n)) + 
  geom_bar(stat="identity") +
  geom_text(aes(label = n), vjust=-0.5) +
  labs(x = "Race", 
       y = "Frequency", 
       title  = "Participants by race")

library(dplyr)
library(scales)
plotdata <- Marriage %>%
  count(race) %>%
  mutate(pct = n / sum(n),
         pctlabel = paste0(round(pct*100), "%"))

# plot the bars as percentages, 
# in decending order with bar labels
library(dplyr)
library(scales)
plotdata <- Marriage %>%
  count(race) %>%
  mutate(pct = n / sum(n),
         pctlabel = paste0(round(pct*100), "%"))

# plot the bars as percentages, 
# in decending order with bar labels
#esto no funciona porqu edice que percent no existe 
ggplot(plotdata, 
       aes(x = reorder(race, -pct), y = pct)) + 
  geom_bar(stat="identity", fill="indianred3", color="black") +
  geom_text(aes(label = pctlabel), vjust=-0.25) +
  scale_y_continuous(labels = percent) +
  labs(x = "Race", 
       y = "Percent", 
       title  = "Participants by race")
#GRAFICAS SOBREPUESTAS 
ggplot(Marriage, aes(x=officialTitle)) + 
  geom_bar() +
  labs(x = "Officiate",
       y = "Frequency",
       title = "Marriages by officiate")


#como no se ven bien las etiquetas
#esto se puede corregir cambiando los ejes x y y 
#con la función coord_flip 
ggplot(Marriage, aes(x = officialTitle)) + 
  geom_bar() +
  labs(x = "",
       y = "Frequency",
       title = "Marriages by officiate") +
  coord_flip()
#otra forma de solucionarlo es rotar las etiquetas de los ejes 
ggplot(Marriage, aes(x=officialTitle)) + 
  geom_bar() +
  labs(x = "",
       y = "Frequency",
       title = "Marriages by officiate") +
  theme(axis.text.x = element_text(angle = 45, 
                                   hjust = 1))

#otra forma es escalar las etiquetas 
#para ello se agrega una nuevalinea
lbls <- paste0(c("","\n"), levels(Marriage$officialTitle))
ggplot(Marriage, 
       aes(x=factor(officialTitle, 
                    labels = lbls))) + 
  geom_bar() +
  labs(x = "",
       y = "Frequency",
       title = "Marriages by officiate")


#GRAFICA DE PASTEL 
#esto se hace con ggpie 
install.packages("ggpie")
library(ggpie)

ggpie(Marriage, race)
ggpie(Marriage, race, legend = FALSE,
      title = "Participants by race")









