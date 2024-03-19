#TRANSFORMACION LOGARITMICA DE LOS DATOS 
#DE VOLUMEN DE BÚSQUEDA DEL TÉRMINO DE BÚSQUEDA "TITANIC" 
#OBTENIDOS DE GOOGLE TRENDS 
library(readxl)
volumen<-read_xlsx("E:/UPIIC/MATERIAL DE CLASES/ANALITICA Y VISUALIZACION/TITANIC TRENDS.xlsx")
summary(volumen$`VOLUMEN BUSQUEDA`)
boxplot(volumen$`VOLUMEN BUSQUEDA`, ylim=c(2,100))
hist(volumen$`VOLUMEN BUSQUEDA`, main="Histograma Volumen de Búsqueda")
library(ggplot2)
qplot(volumen$`VOLUMEN BUSQUEDA`, 
      geom = "histogram")
qplot(volumen$`VOLUMEN BUSQUEDA`, 
      geom = "histogram",
      binwidth = 25, colour = I("black"),
      xlab = "Semanas", ylab="Frecuencia",
      main="Histograma Volumen de Búsqueda")
plot(volumen$`VOLUMEN BUSQUEDA`, type="l", main="Volumen de Búsqueda",
     xlab="Tiempo", ylab="Volumen de búsqueda")
logaritmo<-log(volumen$`VOLUMEN BUSQUEDA`)
plot(logaritmo, type="l")
boxplot(logaritmo)
