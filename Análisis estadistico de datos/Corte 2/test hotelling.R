# INFERENCIAS SOBRE EL VECTOR DE MEDIAS ----
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("mvnormtest")) install.packages("mvnormtest")
if(!require("MVN")) install.packages("MVN")
if(!require("MASS")) install.packages("MASS")
if(!require("DescTools")) install.packages("DescTools")

# lectura de datos ----

datos_medias <- Ejercicio_medias <- read_csv("C:/Users/prestamour/Downloads/Ejercicio_medias.csv")
datos_medias <- datos_medias %>% 
  dplyr::select(-...1)

  # Supuesto de normalidad ----
# https://cran.r-project.org/web/packages/MVN/vignettes/MVN.html

# Pruebas de hip�tesis
# Test Shapiro Wilks Multivariado
mshapiro.test(t(datos_medias))

# Otros tests
# Mardia's test
mvn(data = datos_medias,
    mvnTest = "mardia")

# Henze-Zirkler's test
mvn(data = datos_medias,
    mvnTest = "hz")

# Royston's test
mvn(data = datos_medias,
    mvnTest = "royston")

# Doornik-Hansen's test
mvn(data = datos_medias,
    mvnTest = "dh")

# Energy test
mvn(data = datos_medias,
    mvnTest = "energy")


# Gr�ficos diagn�sticos
mvn(data = datos_medias,
    multivariatePlot = "qq")

mvn(data = datos_medias,
    univariatePlot = "qqplot")

#Como hay una ligera desviación en la cola derecha de la variable 4, analizaremos su test
shapiro.test(datos_medias$V4)

mvn(data = datos_medias,
    univariatePlot = "histogram")


# Pruebas univariadas
mvn(data = datos_medias,
    univariateTest = "SW")

# Prueba T^2 Hotelling ----

# Los datos se supone que provienen de una 
# poblaci�n con media mu = c(11.5, 8, 4, 9)

# Calculemos vector de medias y matriz de
# varianzas y covarianzas muestrales

X_barra <- colMeans(datos_medias)

S <- cov(datos_medias)
R <- cor(datos_medias)

# Aplique la prueba t univariada a cada
# columna para testear las medias individuales

# (use t.test)

t.test(datos_medias$V1, mu = 11.5)
t.test(datos_medias$V2, mu = 8)
t.test(datos_medias$V3, mu = 4)
t.test(datos_medias$V4, mu = 9)

# Pruebe la hip�tesis multivariada
#H0: mu =[11.5, 8, 4, 9] vs mu != [11.5, 8, 4, 9]
HotellingsT2Test(datos_medias, 
                 mu = c(11.5, 8, 4, 9))

#Conclusión: como  p-value = 0.6126 > 0.05 = alpha entonces con una significancioa de 5% No se rechaza H0 y se concluye que 
#los datos provienen de una distribución normal de vector de medias [11.5, 8, 4, 9]