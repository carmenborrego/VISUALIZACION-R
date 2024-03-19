#NORMALIZACION EN R 
#MÉTODO 1: TRANSFORMACIÓN LOGARITMICA 
# SE CREAN L0S DATOS
gfg <- c(244, 753, 596, 645, 874, 141,
         639, 465, 999, 654)
#se plotean los datos originales
plot(gfg, type="l")
#AHORA SE NORMALIZAN LOS DATOS
gfg1 <-log(gfg)
gfg1
plot(gfg1, type="l")


#normalizacion con escala std 
# Create data
gfg <- c(244,753,596,645,874,141,639,465,999,654)
gfg
plot(gfg, type="l")
# normalizing data
gfg <- as.data.frame(scale(gfg)) 
gfg
plot(gfg$V1, type="l")


#min max con caret
library(caret)
#se crean los datos
gfg <- c(244,753,596,645,874,141,639,465,999,654)
plot(gfg, type="l")
ss <- preProcess(as.data.frame(gfg), method=c("range"))
gfg <- predict(ss, as.data.frame(gfg))
gfg

#normalización utilizando estandarizacion z 
# Input vector
gfg <- c(244, 753, 596, 645, 874, 141, 639, 465, 999, 654)
plot(gfg, type="l")
# Z-score standardization
gfg_standardized <- (gfg - mean(gfg)) / sd(gfg)
# View the standardized vector
print(gfg_standardized)
plot(gfg_standardized, type="l")

summary(gfg_standardized)


