#install.packages("correlation")
library(correlation)
correlation(iris, method="pearson")

correlation(iris, method="spearman")
correlation(iris, method = "kendall")
correlation(iris, method = "pearson", 
            select = c("Sepal.Length", "Sepal.Width"),
            p_adjust = "none")


library(mosaicData)
library(dplyr)
library(ggplot2)
#install.packages("ggcorrplot")
library(ggcorrplot)
data("SaratogaHouses")
# select numeric variables
df <- dplyr::select_if(SaratogaHouses, is.numeric)
# calulate the correlationsk
r <- cor(df, use="complete.obs")
redondeada<-round(r,2)
ggcorrplot(r)
ggcorrplot(r, 
           hc.order = TRUE, 
           type = "lower",
           lab = TRUE)



#CORRELCION MTCARS 
library(ggpubr)
my_data <- mtcars
head(my_data, 6)
ggscatter(my_data, x = "mpg", y = "wt", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Miles/(US) gallon", ylab = "Weight (1000 lbs)")
# Shapiro-Wilk normality test for mpg
#se prueba la hipotesis de que los datos provienen de una normal
#no rechazo que esta variable tenga distribución normal 
shapiro.test(my_data$mpg) # => p = 0.1229
# Shapiro-Wilk normality test for wt
shapiro.test(my_data$wt) # => p = 0.09
#no hay evidencia que indique no es normal al 10% de significancia
# mpg
ggqqplot(my_data$mpg, ylab = "MPG")
# wt
ggqqplot(my_data$wt, ylab = "WT")
res <- cor.test(my_data$wt, my_data$mpg, 
                method = "pearson")
res
# Extract the p.value
res$p.value
# Extract the correlation coefficient
res$estimate


#kendall
res2 <- cor.test(my_data$wt, my_data$mpg, 
                 method="kendall")
res2


#spearman 
res2 <-cor.test(my_data$wt, my_data$mpg,  
                method = "spearman")
res2