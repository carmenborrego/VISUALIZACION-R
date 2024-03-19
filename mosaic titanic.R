#mosaico con base del titanic 
#en las graficas de mosaico 
#las frecuencias de una tabla de contingencia multidimensional
#se representan por regiones rectangulares anidadas 
#proporcionales a la frecuencia de la celda 
#el color y el sombreado pueden ser utilizados para representar 
#los residuales de un modelo ajustado 
install.packages("vcd")
library(vcd)
ftable(Titanic)
mosaic(Titanic)
#si se agrega el argumento shade=TRUE la figura se colorea
#basado en los residuales de Pearson de un modelo ajustado 
#el argumento legend=TRUE muestra la leyenda para los residuales 

mosaic(Titanic, shade=TRUE, legend=TRUE)
mosaic(~Class+Sex+Age+Survived, data=Titanic, shade=TRUE, legend=TRUE)
#se toma el modelo que se encuentra para verificar la independencia 
#de las variables 
#la hipótesis nula de que las variables son independientes se 
#rechaza ya que el p value es muy pequeño 




