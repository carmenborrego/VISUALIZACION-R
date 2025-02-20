library(readxl)
library(tidyplots)
library(tidyverse)
library(showtext)
gifts_age <- read_excel("YOUTPATH/gifts_age.xlsx")

#pivoteo por edad
age <- gifts_age %>%
  pivot_longer(cols = c(SpendingCelebrating, Candy, 
                        Flowers, Jewelry, GreetingCards, 
                        EveningOut, Clothing, GiftCards),
               names_to = "Category",
               values_to = "Spending")

#creo paleta de colores propia
valentines_colors <- c("deeppink", "deeppink4", "hotpink",
                       "lightpink", "red", "plum2")

#esto se ahce para que el gráfico tenga letra times new roman
font_add("Times New Roman", regular = "times.ttf")
showtext_auto()

gasto <- age |> 
  tidyplot(y=Spending, x=Category, color= Age) |>
  add_areastack_relative(alpha = .8) |> #alpha modifica la saturacion
  adjust_x_axis(rotate_labels = TRUE) |> #si no se rotan, quedan empalmados
  add_title("Valentine´s spending per age") |>
  adjust_colors(new_colors = valentines_colors) |>
  adjust_size(width = 200, height = 100, unit = "mm") |>
  adjust_font(fontsize = 20, face = "bold",family = "Times New Roman") |>
  adjust_legend_position(position ="right") |>
  add_caption("Souce: Valentine´s Day Consumer data, available at Kaggle")
  
plot(gasto)

gasto2 <- age |> 
  tidyplot(y=Spending, x=Category, color= Age) |>
  add_barstack_relative(alpha = .8) |> #alpha modifica la saturacion
  adjust_x_axis(rotate_labels = TRUE) |> #si no se rotan, quedan empalmados
  add_title("Valentine´s spending per age") |>
  adjust_colors(new_colors = valentines_colors) |>
  adjust_size(width = 200, height = 100, unit = "mm") |>
  adjust_font(fontsize = 20, face = "bold",family = "Times New Roman") |>
  adjust_legend_position(position ="right") |>
  add_caption("Souce: Valentine´s Day Consumer data, available at Kaggle")

plot(gasto2)

gasto3 <- age |> 
  tidyplot(y=Spending, x=Category, color= Age) |>
  add_barstack_absolute(alpha = .8) |> #alpha modifica la saturacion
  adjust_x_axis(rotate_labels = TRUE) |> #si no se rotan, quedan empalmados
  add_title("Valentine´s spending per age") |>
  adjust_colors(new_colors = valentines_colors) |>
  adjust_size(width = 200, height = 100, unit = "mm") |>
  adjust_font(fontsize = 20, face = "bold",family = "Times New Roman") |>
  adjust_legend_position(position ="right") |>
  add_caption("Souce: Valentine´s Day Consumer data, available at Kaggle")

plot(gasto3)

#género 
gifts_gender <- read_excel("C:/Users/carmenbs/Downloads/BLOG/gifts_gender.xlsx")
view(energy)

pivot_gender <- gifts_gender %>%
  pivot_longer(cols = c(Men, Women),
               names_to = "Sex",
               values_to = "Spending")
sex_valentines <- c("lightskyblue", "hotpink")
pivot_gender |>
  tidyplot(x=Category, y=Spending, color = Sex) |>
  add_sum_bar(width= 0.03) |>
  add_sum_dot() |> 
  add_sum_value(accuracy = 1, fontsize = 20) |> 
  adjust_x_axis(rotate_labels = TRUE) |> 
  remove_x_axis_title() |> 
  add_title(title="Spending per sex") |>
  adjust_colors(new_colors = sex_valentines) |>
  adjust_size(width=200, height=100) |>
  adjust_font(fontsize = 20, face = "bold",family = "Times New Roman") |>
  add_caption("Souce: Valentine´s Day Consumer data, available at Kaggle")
  
  
  


