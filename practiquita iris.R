iris
library(datasets)
mtcars
Titanic
qplot(
  iris$Sepal.Length, 
  geom="bar"
)
qplot(
  iris$Sepal.Length, 
  geom="bar", 
  fill = I("deeppink"),
  colour = I("deeppink4")
)
qplot(
  iris$Sepal.Length, 
  geom="bar", 
  fill = I("deeppink"),
  xlab = "Length", 
  ylab = "Number of flowers", 
  main = "Sepal Length", 
)
library(lm)

