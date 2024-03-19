set.seed(4)
#SE CREA UN CONJUNTO DE DATOS HIPOTETICO CON 2 MUESTRAS 
aves<- data.frame(sp1= sample(1:90, 10), sp2= sample(100:250, 10))
#SE APLICA LA FORMULA DE LA ESTANDARIZACIÓN QUE SALE 
#DE LA FÓRMULA 
avesE <- (aves[,1]-mean(aves[,1]))/sd(aves[,1])
avesE
round(mean(avesE),1);sd(avesE) 
#SE APRECIA QUE SU MEDIA ES 0 Y LA DESV STD ES 1 
#ESTO SON PROPIEDADES DE LAS VARIABLES ESTANDARIZADAS 


