if(!require("tidyverse")) install.packages("tidyverse")
if(!require("readr")) install.packages("readr")
if(!require("mvnormtest")) install.packages("mvnormtest")
if(!require("MVN")) install.packages("MVN")
if(!require("DescTools")) install.packages("DescTools")
if(!require("ConfidenceEllipse")) install.packages("ConfidenceEllipse")
if(!require("e1071")) install.packages("e1071")

#Carga de datos
banco_datos <- read_csv("C:/Users/Daniel Fonseca/Downloads/Taller_1.csv",
                     col_types = cols(...1 = col_skip()))
view(banco_datos)

# Exploración de normalidad
# Pruebas Shapiro y Mardia
mshapiro.test(t(banco_datos))
mvn(data = banco_datos, mvnTest = "mardia")$multivariateNormality
mvn(data = banco_datos, mvnTest = "hz")$multivariateNormality
# qqplot multivariado
mvn(data = banco_datos,
    multivariatePlot = "qq")$multivariatePlot

#Transformación

skewness(banco_datos$V2)
skewness(banco_datos$V3)

# Definir la función que aplica la raíz cúbica y conserva el signo
root_with_sign <- function(x) {
  sign(x) * abs(x)^(1/14)
}

log_with_sign <- function(x) {
  sign(x) * (log1p(abs(x)))^(1/2)
}

banco_datos$V2 <- log_with_sign(banco_datos$V2)
banco_datos$V3 <- root_with_sign(banco_datos$V3)

skewness(banco_datos$V2)
skewness(banco_datos$V3)

mshapiro.test(t(banco_datos))
mvn(data = banco_datos, mvnTest = "mardia")
mvn(data = banco_datos, mvnTest = "hz")

# qqplot multivariado
mvn(data = banco_datos,
    multivariatePlot = "qq")

# Crear el Q-Q plot
mvn(data = banco_datos,
    univariatePlot = "qqplot")

mvn(data = banco_datos,
    univariatePlot = "histogram")

#T2
HotellingsT2Test(banco_datos,
                 mu = c(0.7, cubic_root_with_sign(0.14), log_with_sign(1.21), 0.6))

HotellingsT2Test(banco_datos,
                 mu = c(1.2, cubic_root_with_sign(0.09), log_with_sign(1.49), 0.2))

#Elipse
banco_datos_subvector = banco_datos %>% select(V3, V4)

mshapiro.test(t(banco_datos_subvector))
mvn(data = banco_datos_subvector, mvnTest = "mardia")
mvn(data = banco_datos_subvector, mvnTest = "hz")

X_barra = colMeans(banco_datos_subvector)
S = cov(banco_datos_subvector)
n = nrow(banco_datos_subvector)
p = ncol(banco_datos_subvector)

confidenceEllipse(X.mean = X_barra,
                  eig = eigen(S),
                  n = n,
                  p = p,
                  alpha = 0.05)

#Matriz
C_matriz = matrix(c(1, -1, 0, 0), byrow = TRUE, nrow = 1) 
HotellingsT2Test(as.matrix(banco_datos)%*%t(C_matriz), 
                 mu = c(0))

dif = as.matrix(banco_datos)%*%t(C_matriz)
colMeans(dif)

res <- t.test(x=dif, conf.level=0.95)
res$conf.int