#medidas de similitud 
dens <- data.frame(T.bil = c(1, 1, 2, 3), G.spi = c(21, 8, 13, 5),
                   C.tri = c(11, 3, 7, 5), C.sca = c(16, 0, 9, 4))
row.names(dens) <- LETTERS[1:4] #con esto se indica que serán 
#letras de la primera a la cuarta del alfabeto las que se usarán
dens
#ahora se genera un gráfico para ver qué tanto se parecen 
#las 2 primeras especies 
#el argumento par es por parámetros en un ambiente gráfico 
#se puede utilizar para configurar o consultar parámetros gráficos 
#mar es un vector numérico combinado que da el número de 
#lineas de margen a ser especificadas en las 4 esquinas de la gráfica
#mgp es el margen para el título del eje, las etiquetas y la línea de eje
#tcl es la longitud de las marcas de etiqueta como fracciones del peso 
#de una línea o texto 
par(mar=c(4,4,1,1), mgp=c(1,0.3,0), tcl= -0.2)
plot(dens[,1:2], type = "n", cex.axis=0.8, xlim=c(0,20), ylim=c(0,25)) 
text(dens[,1:2], row.names(dens), col ="blue")
#en la figura resultante se aprecia que hay una diferencia entre 
#la composición de las especies en A contra las de D 
#es decir, que la similitud entre el sitio A y el sitio D es menor 
#que en los otros sitios 

comp <- dens
comp[comp>0] <- 1 #Generamos una matriz de presencia ausencia
comp
a <- sum(colSums(comp[1:2,])==1&comp[2,]==0)#Ocurren en A pero no en B
b <- sum(colSums(comp[1:2,])==1&comp[1,]==0)#Ocurren en B pero no en A
c <- sum(colSums(comp[1:2,])==2) #ocurren en A y B

a;b;c
#ahora se obtiene el valor de similitud entre los dos primeros sitios
#a y b 
#las los valores salen de las ecuaciones 
Sorensen <- (2*c)/(a+b+(2*c))
Jaccard <- c/(a+b+c)
Simpson <- c/c+min(a,b)

Sorensen; Jaccard; Simpson
#según el indice de soresen estos dos sitios 
#son parecidos en un 85.7% mientras que para el índice de 
#jaccard es el 75% y para simpson son iguales 






