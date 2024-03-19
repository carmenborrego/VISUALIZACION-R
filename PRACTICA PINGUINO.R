library(palmerpenguins)
data<-penguins
dataraw<-penguins_raw
caret::preProcess()
library(caret)
library(lattice)
library(AppliedPredictiveModeling)
str(penguins)


transparentTheme(trans = .4)
featurePlot(x = penguins[, 3:6], 
            y = penguins$species, 
            plot = "pairs",
            ## Add a key at the top
            auto.key = list(columns = 3))

transparentTheme(trans = .9)
featurePlot(x = penguins[, 3:6], 
            y = penguins$species,
            plot = "density", 
            ## Pass in options to xyplot() to 
            ## make it prettier
            scales = list(x = list(relation="free"), 
                          y = list(relation="free")), 
            adjust = 1.5, 
            pch = "|", 
            layout = c(4, 1), 
            auto.key = list(columns = 3))

featurePlot(x = penguins[, 3:6], 
            y = penguins$species, 
            plot = "box", 
            ## Pass in options to bwplot() 
            scales = list(y = list(relation="free"),
                          x = list(rot = 90)),  
            layout = c(4,1 ), 
            auto.key = list(columns = 2))


