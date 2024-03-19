#todo lo que puede hacer caret
library(caret)
str(iris)
library(AppliedPredictiveModeling)
transparentTheme(trans = .4)
featurePlot(x = iris[, 1:4], 
            y = iris$Species, 
            plot = "pairs",
            ## agrega la clave para cada tipo de flor
            auto.key = list(columns = 3))

featurePlot(x = iris[, 1:4], 
            y = iris$Species, 
            plot = "ellipse", #encierra las clases
            auto.key = list(columns = 3))


transparentTheme(trans = .9)
featurePlot(x = iris[, 1:4], 
            y = iris$Species,
            plot = "density", 
            ## Pass in options to xyplot() to 
            ## make it prettier
            scales = list(x = list(relation="free"), 
                          y = list(relation="free")), 
            adjust = 1.5, 
            pch = "|", 
            layout = c(4, 1), 
            auto.key = list(columns = 3))

#gráficas de densidad superpuestas
transparentTheme(trans = .9)
featurePlot(x = iris[, 1:4], 
            y = iris$Species,
            plot = "density", #indica el tipo de gráfica
            scales = list(x = list(relation="free"), 
                          y = list(relation="free")), 
            adjust = 1.5, 
            pch = "|", 
            layout = c(4, 1), 
            auto.key = list(columns = 3))

#graficos de caja 
featurePlot(x = iris[, 1:4], 
            y = iris$Species, 
            plot = "box", 
            ## Pass in options to bwplot() 
            scales = list(y = list(relation="free"),
                          x = list(rot = 90)),  
            layout = c(4,1 ), 
            
            
#ahora se utiliza la base de Boston Housing para 
#hacer regresion 
library(mlbench)
data(BostonHousing)
regVar <- c("age", "lstat", "tax")
str(BostonHousing[, regVar])
#en este caso los predictores son continuos 
#por lo que se puede utilizar diagrama de dispersión
#para cada uno de los predictos 
theme1 <- trellis.par.get()
theme1$plot.symbol$col = rgb(.2, .2, .2, .4)
theme1$plot.symbol$pch = 16
theme1$plot.line$col = rgb(1, 0, 0, .7)
theme1$plot.line$lwd <- 2
trellis.par.set(theme1)
featurePlot(x = BostonHousing[, regVar], 
            y = BostonHousing$medv, 
            plot = "scatter", 
            layout = c(3, 1))

featurePlot(x = BostonHousing[, regVar], 
            y = BostonHousing$medv, 
            plot = "scatter",
            type = c("p", "smooth"),
            span = .5,
            layout = c(3, 1))

library(earth)
data(etitanic)
head(model.matrix(survived ~ ., data = etitanic))
dummies <- dummyVars(survived ~ ., data = etitanic)
head(predict(dummies, newdata = etitanic))

data(mdrr)
data.frame(table(mdrrDescr$nR11))
#se aprecia que estos predictores pueden tener 
#varianza cercana a cero y eso puede ser un problema 
#cuando los conjntos de datos se parten para hacer 
#cross validation o bootstrap 
#la función nearZeroVar se utiliza para identificar 
#variables con esta caracteristica
#el argumento saveMetrics se utiliza para mostrar detalles
#por default es false 
nzv <- nearZeroVar(mdrrDescr, saveMetrics= TRUE)
nzv[nzv$nzv,][1:10,]
#La funcion dim muestra la dimensión de un objeto 
dim(mdrrDescr)
nzv <- nearZeroVar(mdrrDescr)
filteredDescr <- mdrrDescr[, -nzv]
dim(filteredDescr)


#identificación de predictores correlacionados 
#dada una matriz de correlación 
#otros modelos se pueden beneficiar de la reducción del nivel
#de correlación entre los predictores 
#la función findCorrelation marca predictores para a ser eliminados
descrCor <-  cor(filteredDescr)
highCorr <- sum(abs(descrCor[upper.tri(descrCor)]) > .999)
descrCor <- cor(filteredDescr)
summary(descrCor[upper.tri(descrCor)])
highlyCorDescr <- findCorrelation(descrCor, cutoff = .75)
filteredDescr <- filteredDescr[,-highlyCorDescr]
descrCor2 <- cor(filteredDescr)
summary(descrCor2[upper.tri(descrCor2)])

#centralización y escalamiento 
set.seed(96)
inTrain <- sample(seq(along = mdrrClass), length(mdrrClass)/2)

training <- filteredDescr[inTrain,]
test <- filteredDescr[-inTrain,]
trainMDRR <- mdrrClass[inTrain]
testMDRR <- mdrrClass[-inTrain]

preProcValues <- preProcess(training, method = c("center", "scale"))

trainTransformed <- predict(preProcValues, training)
testTransformed <- predict(preProcValues, test)


#TRANSFORMACIÓN DE PREDICTORES 
#PCA 
#EN ALGUNOS CASOS ES NECESARIO UTILIZAR EL ANALISIS DE COMPO
#NENTES PRINCIPALES PARA TRANSFORMAR LOS DATOS EN UN 
#SUBESPACIO MÁS PEQUEÑO DONDE LAS VARIABLES NO ESTÉN CORRELACIONADAS 
#preProcess puede aplicar la transformación incluyendo "pca" en el argumento
#method
#de manera similar, ICA analisis de componentes independientes 
#también puede ser utilizado para encontrar nuevas variables 
#que son combinaciones lineales del conjunto original 
#tal que sus componentes son independientes 

library(AppliedPredictiveModeling)
transparentTheme(trans = .4)
plotSubset <- data.frame(scale(mdrrDescr[, c("nC", "X4v")])) 
xyplot(nC ~ X4v,
       data = plotSubset,
       groups = mdrrClass, 
       auto.key = list(columns = 2))  

transformed <- spatialSign(plotSubset)
transformed <- as.data.frame(transformed)
xyplot(nC ~ X4v, 
       data = transformed, 
       groups = mdrrClass, 
       auto.key = list(columns = 2)) 



preProcValues2 <- preProcess(training, method = "BoxCox")
trainBC <- predict(preProcValues2, training)
testBC <- predict(preProcValues2, test)
preProcValues2






























