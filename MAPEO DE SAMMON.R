#ESCALAMIENTO MULTIMENSIONAL 
#MDS
#SE UTILIZA IRIS 
#SE REESCALAN LAS VARIABLES DIVIDIENDOLAS ENTRE SU DESV STD
data(iris)
variris <- apply(iris[,-5],2,var)
iris.adjusted <- sweep(iris[,-5],2,sqrt(variris),"/")

#ESCALA TORGERSON-GOWER 
iris.scal <- cmdscale(dist(iris.adjusted),k=2,eig=T)
library(MASS)
eqscplot(iris.scal$points,type="n")
text(iris.scal$point,row.names(iris),cex=.8)
eqscplot(iris.scal$points,type="n")
text(iris.scal$point,labels = iris[row.names(iris),5],cex=.8)


iris.scal$GOF



variable.scal <- cmdscale(1/cor(iris[,-5]),k=2,eig=T)
eqscplot(variable.scal$points,type="n")
text(variable.scal$point,row.names(cor(iris[,-5])),cex=.8)




iris.sammon <- sammon(dist(iris.adjusted[-102,]),k=2)
eqscplot(iris.sammon$points,type="n")
text(iris.sammon$points,label=row.names(iris[-102,]),cex=.8)
iris.sammon$stress
scree.plot = function(d, k) {
  stresses=sammon(d, k=k)$stress
  for(i in rev(seq(k-1)))  
    stresses=append(stresses,sammon(d, k=i)$stress)
  plot(seq(k),rev(stresses), type="b", xaxp=c(1,k, k-1), ylab="Stress", xlab="Number of dimensions")
}
scree.plot(dist(iris.adjusted[-102,]), k=6)
#EL RESULTADO INDICA QUE UNA SOLUCIÓN 2D PODRÍA SER ADECUADA 
iris.sh<-Shepard(dist(iris.adjusted[-102,]), iris.sammon$points, p=2)
plot(iris.sh, pch=".")
lines(iris.sh$x, iris.sh$yf, type = "S")
