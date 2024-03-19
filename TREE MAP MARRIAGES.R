library(treemapify)
library(mosaicData)
library(ggplot2)
library(dplyr)
plotdata <- Marriage %>%
  count(officialTitle)
#el tree map sirve como una alternativa al grifico de pie 
ggplot(plotdata, 
       aes(fill = officialTitle, area = n)) +
  geom_treemap() + 
  labs(title = "Marriages by officiate")

ggplot(plotdata, 
       aes(fill = officialTitle, 
           area = n, 
           label = officialTitle)) +
  geom_treemap() + 
  geom_treemap_text(colour = "white", 
                    place = "center") +
  labs(title = "Marriages by officiate") +
  theme(legend.position = "none")


