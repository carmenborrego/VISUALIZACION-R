library(ggplot2)
#se trabaja con el conjunto de datos mtcars incluido en r 
#mtcars stands for Motor Trend Car Road Tests 
mtcars
#el nombre del automovil es un dato cualitativo 
#se utiliza la funcion qplot para crear un graifco de barras
#es posible que se requiera instalar el paquete farver para que corra 

qplot(
  mtcars$cyl, 
  geom="bar"
  )
#los valores posibles son 4, 6 y 8 
# para cambiar los colores se utiliza fill 
qplot(
  mtcars$cyl, 
  geom="bar", 
  fill = I("blue"),
  colour = I("red")
)
#si el argumento de clour no se incluye la linea será 
#del mismo color que la de las barras 
#el parámero xlab y el parametro ylab especifican los 
#nombres de los ejes x y y 
#el parametro main 
qplot(
  mtcars$cyl, 
  geom="bar", 
  fill = I("blue"),
  xlab = "Cylinders", 
  ylab = "Number of Vehicles", 
  main = "Cylinders in mtcars", 
  )

#ahora haremos el histograma
#los histogramas se utilizan para visualizar la frecuencia 
#de valores numericos (datos cuanti) y no culali 
#se trabajara con horse power
qplot(mtcars$hp, 
      geom = "histogram")
#cuando este codigo se corre aparce el warning del bins 
# se arregla disminuyendo bindwidth a 25 
qplot(mtcars$hp, 
      geom = "histogram",
      binwidth = 25)
qplot(mtcars$hp, 
      geom = "histogram",
      binwidth = 25, 
      colour = I("black"), 
      xlim=c(50, 350), 
      xlab="Horsepower", 
      ylab="Number of cars"
      )
#si queremos que las barras no tengan color se utiliza 
#la funcion alpha 
qplot(mtcars$hp, 
      geom = "histogram",
      binwidth = 25, 
      colour = I("black"), 
      xlim=c(50, 350), 
      xlab="Horsepower", 
      ylab="Number of cars", 
      alpha = I(0), 
      main= "Histogram"
)


#PIECHART 
#para crearlo se debe primero crear una grafica de barras aplidas 
#que pone las barras en el eje vertical en vez de separar las barras 
#en el eje horizontal 

barp<-ggplot(mtcars, aes(x=1, y=sort(mtcars$carb), fill=sort(mtcars$carb))) +
  geom_bar(stat="identity")
print(barp)

#para crear el pie chart se agrega coord_polar 
#la funcion teta evita que los datos se pandeen 
#y permite que se vean los las etiquetas en la grafica 

barp<-barp + coord_polar(theta='y')
print(barp)
#se puede modificar para que sea más simple y se le 
#puede quitar las etiquetas 
#el fondo gris se le puede quitar con el argumento panel
barp <- barp + theme (
  axis.line = element_blank(),
  axis.text.x = element_blank(), 
  axis.text.y = element_blank(),
  axis.ticks = element_blank(), 
  axis.title.y = element_blank(),
  panel.background = element_blank()) +
  labs(y="Carburators")
print(barp)


#Scatter plot 
#se utiliza la funcion qplot 
qplot(mpg, wt, data =(mtcars))
#se procede a hacer una personalización de la gráfica 
#cambiamos a ggplot 
ggplot(mtcars, aes(x=mpg, y=wt))+ geom_point(shape=19)
ggplot(mtcars, aes(x=mpg, y=wt))+ geom_point(shape=19)

mtcars$cylFactor <- factor(mtcars$cyl)
ggplot(mtcars, aes(x=mpg, y=wt, shape = cylFactor)) + geom_point()

#se va a agregar color 
ggplot(mtcars, aes(x=mpg, y=wt)) + geom_point(shape =19, colour ="blue")

#el color también se puee utilizar para representar una tercera variable
#se va a utilizar la variable cylinder 
ggplot(mtcars, aes(x=mpg, y=wt , color =cyl))+ geom_point(shape=19)

ggplot(mtcars, aes(x=mpg, y=wt, color=cylFactor)) + 
  geom_point(shape=19)+
  labs(colour="Cylinders")+
  xlab("Miles per Gallon")+
  ylab("Weight")+
  ggtitle("Scatterplot")

#graficas de linea y regresión 
#para esta grafica se va a trabajar con el conjunto de datos
#EuStockMarkets
EuStockMarkets
EuStockMarketsDF<-as.data.frame(EuStockMarkets)
head(EuStockMarketsDF)
ggplot(EuStockMarketsDF, aes(x=c(1:nrow(EuStockMarketsDF)), y=DAX))+
  geom_line()
ggplot(EuStockMarketsDF, aes(x=c(1:nrow(EuStockMarketsDF)), y=DAX))+
  geom_line(size=1.5, colour="light blue")+
  labs(x="TIme", y="Stocks")

dax_smi_plot<-ggplot()+
  geom_line(data=EuStockMarketsDF, aes(x=c(1:nrow(EuStockMarketsDF))
                                       , y=DAX), size=1.5, colour="light blue")+
  geom_line(data=EuStockMarketsDF, aes(x=c(1:nrow(EuStockMarketsDF))
                                       , y=SMI), size=1.5, colour="red")+
  labs(x="Time", y="Stocks")
print(dax_smi_plot)

all_stocks<-ggplot()+
  geom_line(data = EuStockMarketsDF, aes(x=c(1:nrow(EuStockMarketsDF)), y=DAX),
            size=1, colour="light blue",) + 
  geom_line(data = EuStockMarketsDF, aes(x=c(1:nrow(EuStockMarketsDF)), y=SMI),
            size=1, colour="red",) +
  geom_line(data = EuStockMarketsDF, aes(x=c(1:nrow(EuStockMarketsDF)), y=CAC),
            size=1, colour="purple",) +
  geom_line(data = EuStockMarketsDF, aes(x=c(1:nrow(EuStockMarketsDF)), y=FTSE),
            size=1, colour="green",) +
  labs(x="Time", y ="Stocks")
print(all_stocks)

#se le hacen modificaciones 
legend_stocks <- all_stocks + 
  xlab("Days")+
  ylab("Price")+
  ggtitle("Eu Stocks")
print(legend_stocks)



#ahora se hace una grafica de regresion lineal simple 
ggplot(mtcars, aes (x=mpg, y=wt))+
  geom_point(shape=19)+
  geom_smooth(method ="lm", se=TRUE, color="red")
#si pones methods en vez de method la linea se hace curva 
#jugar con se true and false y ver qué pasa 

mtcars
#se agrega ahora una tercera variable 
ggplot(mtcars, aes(x=mpg,y=wt,color=cylFactor))+
  geom_point(shape=19)+
  geom_smooth(method="lm", se=TRUE, color="red") + 
  xlab("Miles per Gallon")+
  ylab("Weight")+
  labs(colour = "Cylinders")+
  ggtitle("Linear Regression")

#también se puede crear un modelo gaussiano 
#esto hace que la curva se ajuste más a los datos en vez de que sea 
#una linea recta nada más 
#se cambia únicamente el método de lm a auto y se ve que la linea se curvea
ggplot(mtcars, aes(x=mpg,y=wt,color=cylFactor))+
  geom_point(shape=19)+
  geom_smooth(method="auto", se=TRUE, color="red") + 
  xlab("Miles per Gallon")+
  ylab("Weight")+
  labs(colour = "Cylinders")+
  ggtitle("Linear Regression")

#ahora se elaborará una nuve de palabras 
#una nube de palabras es una imagen compuesta de 
#palabras que ocurren en un texto 
#el tamaño de una palabra indica su importancia 
#para crear la nube se necesita un archivo de texto 
#se utilizará la funcion dir.create para crear un directorio 
install.packages("tm") #text mining 
install.packages("wordcloud") #transforma en algo que R pueda entender
library(tm)
library(wordcloud) #crea la visualización 

dir.create("/file_path/wordcloud")
download.file("http://ibm.box.com/shared/static/cmid70rpa7xe4ocitcga1bve7r0kqnia.txt",
              destfile="/file_path/wordcloud/churchill_speeches.txt", quiet=TRUE)

#se selecciona el directorio donde se localiza el texto 


library(wordcloud2)
demoFreq
#ploteo básico
wordcloud2(data=demoFreq, size=1.6)
#se pueden cambiar los colores de las palabras utilizando el argumento color 
#se puede utilizar un vector de colores o utilizar random-dark 
#o random-light y el fondo se puede customizar con backgroundColor 
wordcloud2(data=demoFreq, size=1.6, color="random-dark")
wordcloud2(data=demoFreq, size=1.6, color="random-light")
#para utilizar el vector de colores 
wordcloud2(demoFreq, size=1.6, color=rep_len( c("green","blue"), 
                                              nrow(demoFreq) ) )
#para cambiar el fondo 
wordcloud2(demoFreq, size=1.6, color='random-light', 
           backgroundColor="black")
#también se puede cambiar la forma de la nube 
#esto se hace con el argumento shape 
#las formas disponibles son: circle, cardioid, diamond, triangle-forward
#triangle, pentagon, star 

wordcloud2(demoFreq, size = 0.7, shape = 'star')
#se puede utilizar también una imagen propia, utilizar un directorio propio
wordcloud2(demoFreq, figPath = "~/Desktop/R-graph-gallery/img/other/peaceAndLove.jpg", 
           size = 1.5, color = "skyblue", backgroundColor="black")
##https://github.com/holtzy/R-graph-gallery/blob/master/img/other/peaceAndLove.jpg

#también se puede cambiar la orientación de las palabras 
wordcloud2(demoFreq, size = 2.3, minRotation = -pi/6, maxRotation = -pi/6, rotateRatio = 1)
#version en chino 
wordcloud2(demoFreqC, size = 2, fontFamily = "????????????", 
           color = "random-light", 
           backgroundColor = "grey")
#también se puede poner una letra o un texto como figura 
#esto corre pero no sale la letra 
letterCloud(demoFreq, word = "R", color='random-light',
            backgroundColor='black')
letterCloud(demoFreq, word = "PEACE", color="white",
            backgroundColor="pink",wordSize = 5,
            shuffle=TRUE, shape="UPIIC")
letterCloud(demoFreq,"R")

library(wordcloud2)
letterCloud(demoFreq,"UPIIC")


#radar chats #no funcionara 
library(scales)
library(ggplot2)
library(ggradar)
library(dplyr)
#se va a hacer con mtcars
mtcars %>%
add_rownames(var="group")  %>%
mutate_each(funs(rescale), -group) %>%
head(3) %>% select(1:10) -> mtcars_radar



#gtráfica de waffle 
#este tipo de gráficas ayudan a visualizar los datos en relación con un todo 
#o resaltar el progreso dado un umbral 
#es más fácil leer gráficas de waffle que gráficas de pie cuando 
#las rebanadas de la gráfica de pie se vuelven muy pequeñas 
#en el ejemplo se muestra el gasto de los hogares clasificados en 4 categorias 
#cada cuadrito representa $934 de gasto 
library(waffle)
#se crea un vector para el nombre 
expense<-c('Health ($43,212)'=43212,
           'Education ($113,412)'=113412,
           'Transportation ($20,231)'=20231,
           'Entertainment ($28,145)'=28145)
print(expense)
waffle(expense/1235, rows=5, size=0.3, 
       colors = c("#c7d4b6", "#a3aabd", "#a0d0de", "#97b5cf"),
       title= "Imaginary household Expenses Each Year", 
       xlab="1 square = $934")

#BOXPLOT 
set.seed(1234)
set_a<-rnorm(200, mean=1, sd=2)
set_b<-rnorm(200, mean=0, sd=1)
#se crea un dataframe con ambos conjuntos 
df<-data.frame(label=factor(rep(c("A", "B"), each=200)), value=c(set_a, set_b))
library(ggplot2)
library(plotly)
ggplot(df, aes(x=label , y =value))+geom_boxplot()

#se practica con mtcars
summary(mtcars)
#se crea una gráfica con qplot 
#en el eje de las x va el número de cilindros, que es más una categoría
#que un atributo numerico y por ello se aplica el argumento factor
#en el eje de las y se usa las millas por galon 
qplot(factor(cyl), mpg, data=mtcars, geom="boxplot")
#también se puede graficar utilizando la funcion ggplot 
cars<-ggplot(mtcars, aes(factor(cyl), mpg))
cars + geom_boxplot()

#práctica de cuartiles 
conjunto<-c(3, 5, 7, 8, 12, 13, 14, 18, 21)
summary(conjunto)

#MAPAS
#para crear mapas interactivos se utiliza la libreria leaflet
library(leaflet)
#mapata de la torre Eiffel 
#primero se usa la función leaflet que genera un objeto que representa 
#un mapa vacío 
map<-leaflet() %>% addTiles() %>% 
  add_markers(lng=73.9851, lat=40.7589, popup="Times Square")
#luego se agrega la capa de titulo 
#esto permite hacer zoom y ver las ciudades y paises a detalle 




devtools::install_github("lchiffon/wordcloud2")
sessionInfo()
library(wordcloud)

letterCloud(demoFreq, word = "R", size = 2, 
            letterFont)

