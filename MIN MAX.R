#PRACTICA DE ESCALA MIN MAX UTILIZANDO 
#DATOS DE PIB NACIONAL DE ESPAÑA 
#SE TOMÓ PIB Y VARIACIÓN DEL PIB 
library(readxl)
datos<-read_xlsx("E:/UPIIC/MATERIAL DE CLASES/ANALITICA Y VISUALIZACION/PRACTICA MIN MAX.xlsx")
head(datos)
summary(datos)
#ahora se crea una serie de tiempo 
pib<-ts(datos$PIB, frequency=4, start=c(1995,1))
print(pib)
variacion<-ts(datos$VARIACION, frequency=4, start=c(1995,1))
pibnormal<-ts(datos$PIBNORM, frequency=4, start=c(1995,1))
varnormal<-ts(datos$VARNORM, frequency=4, start=c(1995,1))


#AJUSTAR LA ESCALA PARA QUE LA PRÁCTICA TENGA MÁS SENTIDO
#LA LINEA DE VARIACION SE DEBE COMO UNA CONSTANTE 
plot(pib, main="PIB/Variación Trimestral", ylim=c(0,362400),
     xlab="Trimestre", ylab="PIB/Variación")
lines(variacion, col="red")
legend("topleft", legend=c("PIB", "Variación"), 
       col=c("black", "red"), lty=1, cex=0.8)

#EL PROBLEMA DE LA ESCALA SE ARREGLA CON EL REESCALAMIENTO
#EN ESTE CASO EL REESCALAMIENTO SE HIZO EN LA MISMA 
#BASE DE EXCEL PARA QUE FUERA MÁS RAPIDO Y PRACTICO 
plot(pibnormal, main="PIB y Variación del PIB (Variables Trimestrales)",
     ylim=c(-1,1), ylab="PIB/Variación", xlab="Trimestre")
lines(varnormal, col="red")
legend("bottomleft",
       legend=c("PIB", "Variación"),
       col=c("black", "red"), lty=1, cex=0.8)




