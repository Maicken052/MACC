#Estadística descriptiva multivariada
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("psych")) install.packages("psych")
if(!require("ggpubr")) install.packages("ggpubr")
if(!require("GGally")) install.packages("GGally")
if(!require("corrplot")) install.packages("corrplot")
if(!require("RColorBrewer")) install.packages("RColorBrewer")
if(!require("gmodels")) install.packages("gmodels")
if(!require("readr")) install.packages("readr")
if(!require("dplyr")) install.packages("dplyr")
if(!require("vcdExtra")) install.packages("vcdExtra")
if(!require("aplpack")) install.packages("aplpack")

#Leer datos
StudentsPerformance <- read_csv("C:/Users/Daniel Fonseca/Downloads/StudentsPerformance.csv")
StudentsPerformance %>%  glimpse()

#Cambiar nombre de las columnas
Datos_estudiantes <- 
  StudentsPerformance %>% 
  rename(race = `race/ethnicity`,
         parental_edu = `parental level of education`,
         test_prep = `test preparation course`,
         math_score = `math score`,
         reading_score = `reading score`,
         writing_score = `writing score`) %>% 
  mutate_if(is.character, as.factor)

Datos_estudiantes %>% glimpse()

#Caso cuantitativo
Datos_estudiantes_cuanti <- Datos_estudiantes %>%  select_if(is.numeric)

tabla <- describeBy(Datos_estudiantes_cuanti, omit = TRUE, group = Datos_estudiantes$gender, quant = c(.25, .75))

tabla

#Boxplots (score de géneros distintos)
bxp_math <- Datos_estudiantes %>% 
  ggboxplot(x = "gender", y = "math_score", 
            color = "gender", palette = "jco",
            width = 0.5)+
  ggtitle("Math score")+
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

bxp_read <- Datos_estudiantes %>% 
  ggboxplot(x = "gender", y = "reading_score", 
            color = "gender", palette = "jco",
            width = 0.5)+
  ggtitle("Reading score")+
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

bxp_write <- Datos_estudiantes %>% 
  ggboxplot(x = "gender", y = "writing_score", 
            color = "gender", palette = "jco",
            width = 0.5)+
  ggtitle("Writing score")+
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(bxp_math, bxp_read, bxp_write,
          common.legend = TRUE, legend = "bottom", nrow = 1)

#Densidad (score de preparación o no)
dens_math <- Datos_estudiantes %>% 
  ggdensity(x = "math_score", add = "mean",
            color = "test_prep",
            fill = "test_prep") +
  ggtitle("Math score") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

dens_read <- Datos_estudiantes %>% 
  ggdensity(x = "reading_score", add = "mean",
            color = "test_prep",
            fill = "test_prep") +
  ggtitle("Reading score") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

dens_write <- Datos_estudiantes %>% 
  ggdensity(x = "writing_score", add = "mean",
            color = "test_prep",
            fill = "test_prep") +
  ggtitle("Writing score") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(dens_math, dens_read, dens_write,
          common.legend = TRUE, legend = "bottom", nrow = 1)

#Histograma (score de almuerzos distintos)
hist_math <- Datos_estudiantes %>% 
  gghistogram(x = "math_score", add = "mean",
              color = "lunch",
              fill = "lunch", palette = c("#00AFBB", "#E7B800")) +
  ggtitle("Math score") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

hist_read <- Datos_estudiantes %>% 
  gghistogram(x = "reading_score", add = "mean",
              color = "lunch",
              fill = "lunch", palette = c("#00AFBB", "#E7B800")) +
  ggtitle("Reading score") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

hist_write <- Datos_estudiantes %>% 
  gghistogram(x = "writing_score", add = "mean",
              color = "lunch",
              fill = "lunch", palette = c("#00AFBB", "#E7B800")) +
  ggtitle("Writing score") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(hist_math, hist_read, hist_write,
          common.legend = TRUE, legend = "bottom", nrow = 1)

#Correlación entre score de math y reading
cor(Datos_estudiantes$math_score, Datos_estudiantes$reading_score)

#Diagrama de dispersión math vs reading
Datos_estudiantes %>% 
  ggplot(aes(x = math_score, y = reading_score))+
  geom_point()+
  geom_smooth(method = lm, color = "red")+
  stat_cor(r.accuracy = 0.01, aes(label = ..r.label..))+
  ggtitle("Diagrama de dispersión\n math vs reading")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Diagrama de dispersión math vs reading géneros distintos
Datos_estudiantes %>% 
  ggplot(aes(x = math_score, y = reading_score, color = gender))+
  geom_point()+
  geom_smooth(method = lm)+
  stat_cor(r.accuracy = 0.01, aes(label = ..r.label..))+
  ggtitle("Diagrama de dispersión\n math vs reading")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Diagrama de dispersión math vs reading con y sin curso de preparación
Datos_estudiantes %>% 
  ggplot(aes(x = math_score, y = reading_score, color = test_prep))+
  geom_point()+
  geom_smooth(method = lm)+
  stat_cor(r.accuracy = 0.01, aes(label = ..r.label..))+
  ggtitle("Diagrama de dispersión\n math vs reading")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Matriz de covarianza
Mat_cor <- cor(Datos_estudiantes %>% select_if(is.numeric))
Mat_cor

#Gráfico de correlación
corrplot(Mat_cor, tl.cex = 0.7,col=brewer.pal(n=8, name="PuOr"))

#Solo la triangular superior
corrplot(Mat_cor,  method="number", tl.cex = 0.7,
         col=brewer.pal(n=8, name="PuOr"),addCoef.col = "black", 
         number.cex=0.7,type = "upper", diag = FALSE)

#Matriz de dispersión
Datos_estudiantes %>% 
  select_if(is.numeric) %>% 
  ggpairs(mapping = aes(color = Datos_estudiantes$gender), diag = list(continuous = wrap("densityDiag", alpha = 0.5)))+
  ggtitle("Matriz de diagramas de dispersión")+
  # theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Diagrama hexagonal
Datos_estudiantes %>% 
  ggplot(aes(math_score, reading_score))+
  geom_hex()+
  scale_fill_gradient2()+
  ggtitle("Diagrama hexagonal")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Tabla de contingencia
CrossTable(Datos_estudiantes$gender, Datos_estudiantes$parental_edu)
chisq.test(Datos_estudiantes$gender, Datos_estudiantes$parental_edu)

#Gráfico de barras
Datos_estudiantes %>%
  count(gender, parental_edu) %>%
  group_by(gender) %>%
  mutate(prop = n / sum(n)) %>%
  ungroup() %>%

  ggplot(aes(gender, fill=parental_edu))+ 
  geom_bar(position = "fill")+
  geom_text(aes(label = scales::percent(prop), 
                y = prop, 
                group = parental_edu), 
            position = position_fill(vjust = 0.5)) +
  ggtitle("Diagrama de barras apiladas\n Gender y Parental education level")+
  labs(x="Gender", y="")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Gráfico de mosaico
table <- xtabs(~ parental_edu + gender, data = Datos_estudiantes)
gargs <- list(interpolate=c(1,2,4,8))
mosaic(table, 
       shade=TRUE,
       gp_args=gargs,
       labeling = labeling_border(rot_labels = c(45,0, 0, 0), 
                                  offset_label =c(.5,.5,0, 0),
                                  varnames = c(TRUE, TRUE),
                                  just_labels=c("center","right"),
                                  tl_varnames = FALSE),
       main = "Gráfico de mosaico: Gender vs Parental Education Level")

#Caras de Chernoff
n <- nrow(Datos_estudiantes)  # Número total de filas
k <- floor(n / 35)  # Tamaño de la muestra deseado
indices <- seq(1, n, by = k)
muestra_datos <- Datos_estudiantes[indices, ] 

datos_cher = muestra_datos %>%
  select(math_score, reading_score, writing_score)

faces(datos_cher, face.type = 2, labels = Datos_estudiantes$test_prep)

#
train_and_test2 <- read_csv("C:/Users/Daniel Fonseca/Downloads/train_and_test2.csv")

Titanic <- 
  train_and_test2 %>% 
  rename(survive = `2urvived`) %>% 
  mutate_if(is.character, as.factor)

mosaic(~ Sex + sibsp + Pclass + survive, data = Titanic,
       shade = TRUE, legend = TRUE,
       main = "Gráfico de mosaico")