library(tidyverse)
library(patchwork)
library(ggrepel)
install.packages("skimr")
library(skimr)
install.packages("DataExplorer")
library("DataExplorer")
cars<-read.csv("E:/UPIIC/MATERIAL DE CLASES/ANALITICA Y VISUALIZACION/car_prices.csv")
theme <- theme(plot.margin = margin(10, 10, 10, 5, "mm"),              
               plot.background = element_rect(fill = "#f6f5f4"), 
               plot.title = element_text(size = 24),                   
               plot.subtitle = element_text(size = 16),                
               axis.text = element_text(size = 16),
               axis.title = element_text(size = 16),              
               legend.title = element_text(size = 16),                 
               legend.text = element_text(size = 14)) 

options(warn = -1)
cols(
  year = col_double(),
  make = col_character(),
  model = col_character(),
  trim = col_character(),
  body = col_character(),
  transmission = col_character(),
  vin = col_character(),
  state = col_character(),
  condition = col_double(),
  odometer = col_double(),
  color = col_character(),
  interior = col_character(),
  seller = col_character(),
  mmr = col_double(),
  sellingprice = col_double(),
  saledate = col_character()
)
nrow(cars)
head(cars)
skim(cars)
#se visualizan los nas 
options(repr.plot.width = 12, repr.plot.height = 8)
plot_missing(
  cars,
  group = list(Good = 0.002, OK = 0.05, Bad = 0.8, Remove = 1),
  missing_only = FALSE, # true if you want to show only the columns with missing valuse (important if you have high number of features with no missing values)
  geom_label_args = list(),
  title = 'Missing values in each column',
  ggtheme = theme,
  theme_config = list(legend.position = c("top")))


unique_values <- rapply(cars,function(x) length(unique(x)))
unique_values
cars$vin[duplicated(cars$vin)]
filter(cars, vin == ('2cndl13f056137366') | vin == ('waulfafh7dn005779') |vin == ('1ftsw21r48ed06505'))
unique(cars$year)
unique(cars$make)
unique(cars$model)
unique(cars$transmission)
unique(cars$color)
unique(cars$body)
unique(cars$condition)
cars <- cars %>%
  mutate(interior = gsub('—', "Unknown", cars$interior))%>%
  mutate(color = gsub('—', "Unknown", cars$color))
unique(cars$color)
unique(cars$interior)
unique(cars$state)
faulty_states <- cars %>% 
  filter(str_detect(state, "3vwd"))
nrow(faulty_states)
head(faulty_states, 3)
cars1<- cars[!grepl("3vwd", cars$state),]
cars$state = toupper(cars$state)
unique(cars$state)
head(filter(cars, state == 'ON'), 1)
head(filter(cars, state == 'NS'), 1)
head(filter(cars, state == 'QC'), 1)
cars.year <- cars     # let me keep everything for the sale vs 'year' visualization
cars <- na.omit(cars) # remove na for the rest of the analysis
cars$make <- str_to_title(cars$make)
cars$model <- str_to_title(cars$model)
cars$body <- str_to_title(cars$body)


mean(cars$sellingprice)
max(cars$sellingprice)
min(cars$sellingprice)
filter(cars, sellingprice > 175000 )
filter(cars, (sellingprice <= 1))

options(repr.plot.width = 16, repr.plot.height = 6)
hist <- ggplot(cars, aes(x = sellingprice )) + 
  geom_histogram(binwidth=2000, fill='#FF9999')+
  labs(title ="Sale Price distribution. ")+
  theme

box <- ggplot(cars, aes( y = sellingprice ) ) +
  geom_boxplot(fill='#4DE5B1') + 
  labs(title ="Boxplot of Sale Price") +
  theme
hist + box


options(repr.plot.width = 14, repr.plot.height = 12)
bar <- ggplot(cars, aes(x = transmission, fill = transmission )) + 
  geom_bar(stat ='count', color='#000000' , alpha=0.96)+
  geom_text(aes(label=..count..),stat='count', position=position_dodge(0.9),vjust=-0.5, color='black')+
  labs(title="Transmission System", subtitle ="Automatic cars are the majority. Afterall, we are dealing with\nAmerican car owners. No surprise here." )+
  theme +
  theme(axis.text.x = element_text(angle = 0, hjust=0.5))

box1 <- ggplot(cars, aes(x = transmission, y = sellingprice, fill = transmission)) +
  geom_boxplot()+
  labs(title="Sale price: full scale", subtitle ="Relatively more 'outliers' in\nthe Automatic cars category" )+
  theme 

box2 <- ggplot(cars, aes(x = transmission, y = sellingprice, fill = transmission)) +
  geom_boxplot()+
  labs(title="Sale price: Zoomed in", subtitle ="Automatic cars sold for slightly\n higher price." )+
  theme + ylim(0, 30000)

bar /( box1  + box2)


options(repr.plot.width = 12, repr.plot.height = 6)
ggplot(head(cars,nrow(cars)), aes(x =mmr, y =sellingprice, na.rm =TRUE)) + 
  geom_point(color='#f00000')+
  labs(title='MMR vs SalePrice', subtitle = 'The MMR values are well in agreedment with the SalePrice\nexcept few outliers!')+
  annotate(geom = "curve", x = 50000, y = 207000, xend = 25000, yend = 230000, curvature = 0.25,   
           arrow = arrow(length = unit(3, "mm")))+
  annotate(geom = "segment", x = 0, xend = 200000, y = 0, yend = 200000, color='blue')+
  annotate(geom='text', x=50000, y=200000, label='Weird Outlier!', size=6, color='navyblue')+        
  theme


filter(cars, sellingprice > 100000 & mmr < 25000)
filter(cars, (sellingprice < 50000) & (mmr > 100000))


options(repr.plot.width = 10, repr.plot.height = 8)
df <- filter(cars, sellingprice > 150000)

p10<-ggplot(df, aes(x = year, y =sellingprice, label = make)) + 
  geom_point(color='#f00000')+
  geom_text_repel(aes(label = make), size=5.5)+
  labs(title='High-priced selected cars', subtitle='That Ford car looks out of place indeed. The rest are luxury brands.')+
  annotate(geom = "curve", x = 2013, y = 220000, xend = 2014, yend = 230000, curvature = -0.25,   
           arrow = arrow(length = unit(3, "mm")))+
  annotate(geom='text', x=2013, y=215000, label='A weird outlier indeed!', size=6, color='navyblue')+       
  theme 
p10



options(repr.plot.width = 12, repr.plot.height = 6)
ggplot(cars, aes(x =odometer, y =sellingprice, na.rm =TRUE)) + 
  geom_point(color='#f00000')+
  labs(title='Odometer vs Sale Price')+
  theme

