# Regresi�n lineal m�ltiple univariada
if(!require("corrplot")) install.packages("corrplot")
if(!require("RColorBrewer")) install.packages("RColorBrewer")
if(!require("readr")) install.packages("readr")
if(!require("lmtest")) install.packages("lmtest")
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("car")) install.packages("car")

# Datos -----

heart_data <- read_csv("C:/Users/sergioa.garcia/Downloads/heart.data.csv", 
                       col_types = cols(...1 = col_skip()))
  
heart_data %>% dim()
heart_data %>% glimpse()

# El objetivo es predecir el porcentaje de habitantes que tienen enfermedad 
# card�aca con base en el porcentaje de fumadores y de usuarios de bicicleta
# que hay en la poblaci�n.

# Exploraci�n descriptiva -----

# An�lisis de correlaci�n
mat_cor <- cor(heart_data)
  
  corrplot(mat_cor, method = "square", tl.cex = 0.7,
           col=brewer.pal(n=8, name="PuOr"),addCoef.col = "black", 
           number.cex=0.7,type = "upper", diag = FALSE)

#En esta matriz se observa que biking es la variable más correlacionada con la respuesta,
#mientras que smoking tiene una correlación no muy alta. Entre las variables de smoking
#y biking hay casi nula correlación, por lo que no tenemos problema de multicolinealidad.
  
# Linealidad
heart_data %>% 
  ggplot(aes(x=smoking, y = heart.disease))+
  geom_point()+
  ggtitle("Enfermedad cardíaca vs Fumador")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

heart_data %>% 
  ggplot(aes(x=biking, y = heart.disease))+
  geom_point()+
  ggtitle("Enfermedad cardíaca vs Ciclista")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))


# At�picos (boxplot) y forma normal (histograma)

heart_data %>% 
  ggplot(aes(heart.disease, y=0))+
  geom_boxplot(width = 0.25)+
  ylim(-0.5,0.5)+
  ggtitle("Boxplot Enfermedad card�aca")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))


#breaks <- pretty(range(heart_data$heart.disease),
#                 n = nclass.sturges(heart_data$heart.disease),
#                 min.n = 1)

heart_data %>%
  ggplot(aes(heart.disease))+
  geom_histogram(fill = "white", col = "black")+
  ggtitle("histograma enfermedad card�aca")+
  ylab("")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))


# Modelo RLM ----------

modelo_heart <- lm(heart.disease ~ biking + smoking, data = heart_data)
  summary(modelo_heart)
anova(modelo_heart)
qt(0.975, 495)
fitted(modelo_heart)
residuals(modelo_heart)

AIC(modelo_heart)
BIC(modelo_heart)


# Verificaci�n de supuestos ----------

# An�lisis de multicolinealidad
# https://www.r-bloggers.com/2023/12/exploring-variance-inflation-factor-vif-in-r-a-practical-guide/
vif_values <- vif(modelo_heart)
vif_values

#Como los beefs dieron cercanos a 1 (que es su valor más bajo), ent el modelo no tiene problemas
#de colinealidad.

# An�lisis de residuales

residuos_heart <- 
  
  hist()
boxplot()

# Gr�ficos de diagn�stico

par(mfrow = c(2,2))
plot()

# Residuals vs leverage points
# Criterio de outliers: residuos estandarizados a m�s de 3 sd de la media
# Leverage points: h_ii > 3p/n donde p es la cantidad de predictoras
# https://online.stat.psu.edu/stat501/lesson/11/11.2#:~:text=The%20leverage%20h%20i%20i,regression%20coefficients%20including%20the%20intercept).

# Algunas pruebas
# Normalidad
shapiro.test()

# No correlaci�n
# H0: la correlaci�n entre los errores es 0
dwtest()



# Predicci�n ----------
# http://www.sthda.com/english/articles/40-regression-analysis/166-predict-in-r-model-predictions-and-confidence-intervals/

# Intervalo de confianza para la respuesta media

# Usando el modelo ajustado se desea predecir el porcentaje promedio
# de habitantes con enfermedad card�aca en tres poblaciones cuyos
# valores para las predictoras son:

nuevas <- tibble(biking = c(2.14, 8.37, 62.86), 
                 smoking = c(1.58, 26.49, 32.75))
nuevas

predict()

# Intervalo de confianza para la respuesta

# Usando el modelo ajustado se desea predecir el porcentaje
# de habitantes con enfermedad card�aca en las tres poblaciones
# anteriores:

predict()

# Material adicional de consulta
# https://library.virginia.edu/data/articles/diagnostic-plots
# http://www.sthda.com/english/articles/40-regression-analysis/168-multiple-linear-regression-in-r/
# https://www.spsanderson.com/steveondata/posts/2023-11-13/index.html#:~:text=To%20create%20a%20prediction%20interval%20in%20R%2C%20we%20can%20use,function%20to%20calculate%20prediction%20intervals.



# EJERCICIO EN CASA ----------

data("marketing", package = "datarium")

# El objetivo es predecir las ventas con base en la inversi�n en publicidad en 
# los tres canales de difusi�n.

# 1) Ajuste un modelo de regresi�n lineal m�ltiple a los datos. Haga an�lisis de residuales.
# 2) Con base en el an�lisis de significancia elimine la(s) variable(s) que no son 
# significativas para el modelo y aj�stelo de nuevo. Haga an�lisis de residuales para el
# nuevo modelo. 
# 3) Pruebe transformar la variable dependiente con logaritmo, ra�z cuadrada y 1/y, ajuste 
# los modelos y haga an�lisis de residuales. �Logra el supuesto de normalidad?
# 4) Compare el AIC y el BIC de todos los modelos ajustados y escoja el que obtenga menores 
# valores.

