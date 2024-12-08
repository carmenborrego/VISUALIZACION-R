library(dplyr)
library(readr)
library(ggalluvial)
library(ggplot2)

#llamamos al archivo que utilizaremos
#el archivo debe estar en el mismo directorio de trabajo 
#si no es así, tendremos que poner la ruta completa 
titanic <- read_csv("titanic.csv")
titanic_table <- titanic %>%
  #se agrupan los datos por clase, sexo y si sobrevivieron o no
  group_by(Class, Sex, Survived) %>%
  count() #pedimos que cuente cuántos hay de cada caso 
#creamos una variable factor Yes o No
#las siguientes líneas nos darán una talba de frecuencia 
#que nos indicará cuántas personas sobrevieron o no 
#por sexo y clase 
titanic_table$Survived <- factor(titanic_table$Survived, 
                                 levels = c("Yes", "No"))
#se muestran las primeras lineas como ejemplo 
head(titanic_table)
#creamos el gráfico a partir de la tabla 
ggplot(titanic_table,
       aes(axis1 = Class, #indicamos que variable va en cada eje
           axis2 = Sex,
           axis3 = Survived,
           y = n)) +
  geom_alluvium(aes(fill = Class)) + #indicamos el tipo de grafico 
  scale_fill_manual(values = c("hotpink", "seagreen3", "orange", "turquoise")) + #con este argumento podemos cambiar colores
  theme_classic() + #con este argumento cambiamos el estilo del grafico
  geom_stratum() + #crea rectángulos para separar los datos
  geom_text(stat = "stratum", #sirve para etiquetar 
            aes(label = after_stat(stratum)))

  