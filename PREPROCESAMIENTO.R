caret::preProcess()
library(caret)
library(lattice)
library(AppliedPredictiveModeling)
#esta función muestra de forma compacta o abreviada los contenidos 
str(iris)

transparentTheme(trans = .4)
featurePlot(x = iris[, 1:4], 
            y = iris$Species, 
            plot = "pairs",
            ## Add a key at the top
            auto.key = list(columns = 3))

#scatter plot con elipses que encierran cada tipo de flor
featurePlot(x = iris[, 1:4], 
            y = iris$Species, 
            plot = "ellipse",
            ## Add a key at the top
            auto.key = list(columns = 3))

#gráficos de distribución de probabilidad sobrepuestos
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


#gráficos de caja 
featurePlot(x = iris[, 1:4], 
            y = iris$Species, 
            plot = "box", 
            ## Pass in options to bwplot() 
            scales = list(y = list(relation="free"),
                          x = list(rot = 90)),  
            layout = c(4,1 ), 
            auto.key = list(columns = 2))

#Se hace una práctica de regresión utlizando Boston Housing 
library(mlbench)
data(BostonHousing)
regVar <- c("age", "lstat", "tax")
str(BostonHousing[, regVar])

#cuando los predictores son continuos, se utiliza 
#featurePlot ara crear scatter plots para cada uno
#de los predictores con el resultado 
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
#las escalas para cada eje de las x son diferentes 
#la funcion scales=list(y=list(relation="free")) hace esto posible 
#también puede hacerse esto utilizando la función xyplot de lattice 
#también se le agrega una línea de regresión 

featurePlot(x = BostonHousing[, regVar], 
            y = BostonHousing$medv, 
            plot = "scatter",
            type = c("p", "smooth"),
            span = .5,
            layout = c(3, 1))

#preprocesamiento 
#Creación de variables dummy 
library(earth)
data(etitanic)
head(model.matrix(survived ~ ., data = etitanic))

#utilizamos la función dummyvars
dummies <- dummyVars(survived ~ ., data = etitanic)
head(predict(dummies, newdata = etitanic))

