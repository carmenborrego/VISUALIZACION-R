#TRANFORMACIÓN DE DATOS 
library(kable)
set.seed(4)
aves<- data.frame(sp1= sample(1:90, 10), sp2= sample(100:250, 10))

insectos<- data.frame(sp1= sample(5:99, 10), sp2= sample(1000:2500, 10))

##¿Qué pasa cuando transformamos?
aveT <- round(cbind(aves, sqrt(aves),log(aves)),2)
colnames(aveT) <- paste(rep(c("sp1", "sp2"), 3), c("","","sqrt", "sqrt", "log", "log"), sep=".")
aveT
aves


insT <- round(cbind(insectos, sqrt(insectos),log(insectos)),2) 
colnames(insT) <- paste(rep(c("sp1", "sp2"), 3), c("","","sqrt", "sqrt", "log", "log"), sep=".")
insT
