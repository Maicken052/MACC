# An�lisis can�nico de correlaciones
# Ejemplos gu�a 8

library(expm)

# Ejemplo 1

S_11 <- matrix(c(1, 0.4, 0.4, 1), 
               byrow = TRUE, nrow = 2)

S_12 <- matrix(c(0.5, 0.6, 0.3, 0.4),
               byrow = TRUE, nrow = 2)

S_21 <- t(S_12)

S_22 <- matrix(c(1, 0.2, 0.2, 1),
               byrow = TRUE, nrow = 2)

# Construir el primer par de variables can�nicas
# Hallamos la matriz M1 para el primer conjunto

M1 <- sqrtm(solve(S_11)) %*% S_12 %*% (solve(S_22)) %*% S_21 %*% sqrtm(solve(S_11))  
M1

# Valores y vectores propios de M1

vec_1 <- eigen(M1)
vec_1

sqrt(vec_1$values)

# calculamos el vector de coeficientes

a_1 <- t(vec_1$vectors[,1]) %*% sqrtm(solve(S_11))
a_1

# Hallamos la matriz M2 para el segundo conjunto

M2 <- sqrtm(solve(S_22)) %*% S_21 %*% (solve(S_11)) %*% S_12 %*% sqrtm(solve(S_22))  
M2

# Valores y vectores propios de M2

vec_2 <- eigen(M2) 
vec_2

sqrt(vec_2$values)

# calculamos el vector de coeficientes

b_1 <- t(vec_2$vectors[,1]) %*% sqrtm(solve(S_22))
b_1

# As�, el primer par de variables can�nicas est� dado por
# U_1 = -0.8559647X1^(1) - 0.2777371X2^(1)
# V_1 = 0.5448119Y1^(2) + 0.7366455Y2^(2)

# Veamos que tienen varianza 1
# Var(U_1)
a_1 %*% S_11 %*% t(a_1) 

# Var(V_1)
b_1 %*% S_22 %*% t(b_1)

# y su correlaci�n can�nica es:

rho_1 <- a_1 %*% S_12 %*% t(b_1)
rho_1

# Ejemplo 2
install.packages("CCA")
library(CCA)
library(tidyverse)

# Datos: https://search.r-project.org/CRAN/refmans/CCA/html/nutrimouse.html

# Consideremos X a las 10 primeras medidas gen�ticas y Y a la composici�n lip�dica
data("nutrimouse")
Gen <- nutrimouse$gene
Lip <- nutrimouse$lipid

library(psych)

Gen %>% describe()
Lip %>% describe()
# por la diferencia de escala, estandaricemos los datos

Gen_esc <- scale(Gen[,1:10])
Lip_esc <- scale(Lip)
ncol(Gen_esc)
ncol(Lip_esc)

# Revisi�n de correlaciones individuales

library(corrplot)
corr = cor(Gen_esc, Lip_esc)
corrplot(corr)

# An�lisis can�nico de correlaciones
Anco <- cc(Gen_esc, Lip_esc)

# correlaciones can�nicas
Anco$cor

#Tener altos valores para los primeros 5 pares de variables canónicas indica
#que en efecto hay una alta relación colineal entre la expresión genética de los
#primeros 10 genes considerados y las mediciones lipidicas (de grasa) en el 
#higado de los ratones

# coeficientes variables can�nicas en X
Anco$xcoef 

sort(Anco$xcoef[,1])
#De aquí, U1 = -0.46288496ADSS1 - 0.29533757ACC1 - 0.24823859ADISP - 0.22671241X36b4
#+ 0.05893858ACBP + 0.07292433ACAT1 + 0.12522028ACAT2 + 0.17749773ACOTH 
#+ 0.65017954ACC2 + 0.90164379ALDH3

#La variable más importante para esta primera variable canónica es ALDH3 seguida
#por ACC2 y la que menos aporta es ACBP


# coeficientes variables can�nicas en Y
Anco$ycoef
sort(Anco$ycoef[,1])
#De aquí V1 = 2.132264C20.3n.3 + ... + 159.870427C18.2n.6
#La variable más importante para esta variable canónica es C18.2n.6, y la que menos
#aporta es C20.3n.3

# construyamos la primera variable can�nica para X
a_is <- Anco$xcoef 
  
a1 <- a_is[,1] 
a1%*%t(Gen_esc)

# las variables can�nicas est� en la tabla scores
U = Anco$scores$xscores
V = Anco$scores$yscores
colnames(U) = c("U1", "U2", "U3", "U4", "U5", "U6", "U7", "U8", "U9", "U10") 
colnames(V) = c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10") 
# Grafiquemos el primer par de variables can�nicas

plot(Anco$scores$xscores[,1], Anco$scores$yscores[,1])

# se observa la alta correlaci�n entre las variables can�nicas.
corr = cor(U, V)
corrplot(corr)
corrplot(cor(U))
corrplot(cor(V))

#Podemos ver que se cumple que la varianza de todas las variables canónicas es 1,
#además que la correlación entre variables de distintos pares es 0, y entre variables
#del mismo grupo (U o v) es 0.

# Tambi�n es �til graficar las variables can�nicas vs las variables originales

plot(Anco$scores$xscores[,1], Gen_esc[,"ACBP"])
plot(Anco$scores$xscores[,1], Gen_esc[,"ALDH3"])

# Ejercicio 2
X1 <- mtcars[, c("disp", "hp", "wt")]
X2 <- mtcars[, c("mpg", "qsec")]

X1_esc <- scale(X1)
X2_esc <- scale(X2)

# Revisi�n de correlaciones individuales

library(corrplot)
corr = cor(X1_esc, X2_esc)
corrplot(corr)

# An�lisis can�nico de correlaciones

Anco <- cc(X1_esc, X2_esc)

# correlaciones can�nicas
Anco$cor

#Se tienen valores altos de correlación para los dos pares de variables canónicas,
#por lo que se considera que los dos subsets están bastante correlacionados

# coeficientes variables can�nicas en X
Anco$xcoef 

sort(Anco$xcoef[,1])
#De aquí, U1 = -0.52497527wt - 0.48782014hp - 0.08337853disp

#La variable más importante para esta primera variable canónica es wt seguida
#por hp y la que menos aporta es disp

# coeficientes variables can�nicas en Y
Anco$ycoef
sort(Anco$ycoef[,1])
#De aquí V1 = 0.1258716qsec + 0.9407449mpg
#La variable más importante para esta variable canónica es mpg, y la que menos
#aporta es qsec

# las variables can�nicas est� en la tabla scores
U = Anco$scores$xscores
V = Anco$scores$yscores
colnames(U) = c("U1", "U2") 
colnames(V) = c("V1", "V2") 
# Grafiquemos el primer par de variables can�nicas

plot(Anco$scores$xscores[,1], Anco$scores$yscores[,1])

# se observa la alta correlaci�n entre las variables can�nicas.
corr = cor(U, V)
corrplot(corr)
corrplot(cor(U))
corrplot(cor(V))

#Podemos ver que se cumple que la varianza de todas las variables canónicas es 1,
#además que la correlación entre variables de distintos pares es 0, y entre variables
#del mismo grupo (U o v) es 0.

# Tambi�n es �til graficar las variables can�nicas vs las variables originales
plot(Anco$scores$xscores[,1], X1_esc[,"wt"])
plot(Anco$scores$xscores[,1], X1_esc[,"hp"])

# Diccionario de variables mtcars
# https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/mtcars

#Ejercicio ----

# Matriz R11 (5x5)
S_11 <- matrix(c(
  1.0, 0.49, 0.53, 0.49, 0.51,
  0.49, 1.0, 0.57, 0.46, 0.53,
  0.53, 0.57, 1.0, 0.57, 0.57,
  0.49, 0.46, 0.57, 1.0, 0.57,
  0.51, 0.53, 0.57, 0.57, 1.0
), nrow = 5, byrow = TRUE)

# Matriz R12 (5x7)
S_12 <- matrix(c(
  0.33, 0.32, 0.20, 0.19, 0.30, 0.37, 0.21,
  0.30, 0.21, 0.16, 0.08, 0.27, 0.35, 0.20,
  0.31, 0.23, 0.14, 0.07, 0.24, 0.37, 0.18,
  0.24, 0.22, 0.12, 0.19, 0.21, 0.29, 0.16,
  0.38, 0.32, 0.17, 0.23, 0.32, 0.36, 0.27
), nrow = 5, byrow = TRUE)

# Matriz R21 (7x5) - Transpuesta de R12
S_21 <- t(S_12)

# Matriz R22 (7x7)
S_22 <- matrix(c(
  1.0, 0.43, 0.27, 0.24, 0.34, 0.37, 0.40,
  0.43, 1.0, 0.33, 0.26, 0.54, 0.32, 0.58,
  0.27, 0.33, 1.0, 0.25, 0.46, 0.29, 0.45,
  0.24, 0.26, 0.25, 1.0, 0.28, 0.30, 0.27,
  0.34, 0.54, 0.46, 0.28, 1.0, 0.35, 0.59,
  0.37, 0.32, 0.29, 0.30, 0.35, 1.0, 0.31,
  0.40, 0.58, 0.45, 0.27, 0.59, 0.31, 1.0
), nrow = 7, byrow = TRUE)

M1 <- sqrtm(solve(S_11)) %*% S_12 %*% (solve(S_22)) %*% S_21 %*% sqrtm(solve(S_11))  
M1

# Valores y vectores propios de M1

vec_1 <- eigen(M1)
vec_1

sqrt(vec_1$values)

# calculamos el vector de coeficientes

a_1 <- t(vec_1$vectors[,1]) %*% sqrtm(solve(S_11))
a_1

# Hallamos la matriz M2 para el segundo conjunto

M2 <- sqrtm(solve(S_22)) %*% S_21 %*% (solve(S_11)) %*% S_12 %*% sqrtm(solve(S_22))  
M2

# Valores y vectores propios de M2

vec_2 <- eigen(M2) 
vec_2

sqrt(vec_2$values)

# calculamos el vector de coeficientes

b_1 <- t(vec_2$vectors[,1]) %*% sqrtm(solve(S_22))
b_1

# Veamos que tienen varianza 1
# Var(U_1)
a_1 %*% S_11 %*% t(a_1) 

# Var(V_1)
b_1 %*% S_22 %*% t(b_1)

# y su correlaci�n can�nica es:
rho_1 <- a_1 %*% S_12 %*% t(b_1)
rho_1