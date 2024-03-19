#MULTICOLINEALIDAD (ES LA SEGUNDA PARTE DE ECONOMETRIA)
#ESTO SE HACE CON EL VIF (VARIANCE INFLATION FACTOR)
#ESTES MIDE LA FUERZA DE LA CORRELACIÓN ENTRE 
#LAS VARIABLES PREDICTIVAS EN UN MODELO 
#TOMA UN VALOR ENTRE 1 E INFINITO 

#VIF=1 NO HAY CORRELACIÓN ENTRE UN PREDICTOR DADO 
#CUALQUIER OTRO PREDICTOR EN EL MODELO 
#VIF= ENTRE 1 Y 5 HAY UNA CORRELACION MODERADA ENTRE UNA 
#VARIABLE PREDCTORA Y OTRAS VARIABLES PREDICTORAS EN EL MODELO 
#VIF MAYOR A 5: HAY UNA CORRELACIÓN SEVERA ENTRE UNA VARIALBE
#PREDICTORA Y OTRAS VARIABLES PREDICTORAS EN EL MODELO 

#SE SIMULAN LOS DATOS 
df = data.frame(rating = c(90, 85, 82, 88, 94, 90, 76, 75, 87, 86),
                points=c(25, 20, 14, 16, 27, 20, 12, 15, 14, 19),
                assists=c(5, 7, 7, 8, 5, 7, 6, 9, 9, 5),
                rebounds=c(11, 8, 10, 6, 6, 9, 6, 10, 10, 7))
#RATING ES LA VARIABLE DE RESPUESTA Y LAS OTRAS SON PREDICTORAS
library(car)
model <- lm(rating ~ points + assists + rebounds, data=df)
vif(model)
#el resultado son los valores 
#3n este caso como los valores de vif están cerca de 1
#la multicolinealidad no es un problema en este modelo 
#en caso de que hubiera multicolinealidad
#la solucion seria remover las variables altamente correlacionadas 


