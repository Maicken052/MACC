# COMPARACI�N DE MEDIAS MULTIVARIADAS ----------
if(!require("tidyverse")) install.packages("tidyverse")
if(!require("readxl")) install.packages("readxl")
if(!require("mvnormtest")) install.packages("mvnormtest")
if(!require("MVN")) install.packages("MVN")
if(!require("DescTools")) install.packages("DescTools")
if(!require("MVQuickGraphs")) install.packages("MVQuickGraphs")
if(!require("mclust")) install.packages("mclust")

#Combinación lineal de medias ----
Corcho_datos <- read_excel("C:/Users/Daniel Fonseca/Downloads/Corcho_datos.xlsx")

#Exploración de normalidad
#Pruebas Shapiro y Mardia
mshapiro.test(t(Corcho_datos))
mvn(data = Corcho_datos, mvnTest = "mardia")
mvn(data = Corcho_datos, mvnTest = "hz")

#qqplot multivariado
mvn(data = Corcho_datos,
    multivariatePlot = "qq")

#Suponiendo normalidad
#H0: mu_1 = mu_3 y mu_2 = mu_4

C_matriz = matrix(c(1, 0, -1, 0,
                    0, 1, 0, -1), byrow = TRUE, nrow = 2) 

n <- 28 
c_row <- nrow(C_matriz)

X_barra <- colMeans(Corcho_datos) 
S <- cov(Corcho_datos) 
  
CX_barra <- C_matriz %*% X_barra    
CSCt <- C_matriz %*% S %*% t(C_matriz)  
  
#Valor de prueba
T2_p <- n*t(CX_barra) %*% solve(CSCt) %*% CX_barra
T2_p

#Valor cr�tico
T2_c <- ((c_row)*(n-1))/(n-c_row)*qf(1-0.05, c_row, n-c_row)
T2_c

#Conclusión: Cómo T2_p < T2_c ent con una significancia de 5%, no se rechaza H0
#y se concluye que, en promedio, la cantidad de corcho en los cortes norte y sur
#es la misma y que la cantidad promedio de corcho en los cortes este y oeste es igual.

#Usando la funci�n de R (cuidado con la matriz)
HotellingsT2Test(as.matrix(Corcho_datos)%*%t(C_matriz), 
                 mu = c(0, 0))

#Comprobación
(n-c_row)*T2_p/(c_row*(n-1))

#Ejercicio: Para los mismos datos contrastar la hip�tesis
#H0: mu_1 = mu_2 = mu_3 = mu_4  vs  H1: existe al menos un i |= j tq mu_i |= mu_j

#Medias pareadas ----
Corrosion_datos <- read_excel("C:/Users/Daniel Fonseca/Downloads/Corrosion_datos.xlsx")
Corrosion_datos <- read_excel("C:/Users/prestamour/Downloads/Corrosion_datos.xlsx")

#Cree un data frame con las diferencias para cada variable
Corrosion_dif <- Corrosion_datos %>% 
  mutate(d1 = X1 - Y1, d2 = X2 - Y2) %>% 
  select(c(d1, d2))

#Exploración de normalidad
mshapiro.test(t(Corrosion_dif))

mvn(data = Corrosion_dif,
    mvnTest = "mardia")

mvn(data = Corrosion_dif,
    multivariatePlot = "qq")

#Prueba de hipótesis
n <- nrow(Corrosion_dif)
p <- ncol(Corrosion_dif)

d_barra <- colMeans(Corrosion_dif)

S_d <- cov(Corrosion_dif)

# Valor de prueba
T2_p <- n*t(d_barra) %*% solve(S_d) %*% d_barra
T2_p

# Valor crítico
T2_c <-  (p*(n-1))/(n-p) *qf(1-0.05, p, n-p)
T2_c

#Conclusión: Como T2_p > T2_c entonces con una significancia del 5% se recahza 
#H0 y se concluye que los tipos de esmaltes tienen efectos significativamente 
#diferentes, bajo las condiciones experimentales señaladas, respecto al control 
#de la corrosión en tales tuberias.

#Usando la función de R 
HotellingsT2Test(Corrosion_dif, mu = c(0,0))

confidenceEllipse(X.mean = d_barra,
                  eig = eigen(S_d),
                  n = n,
                  p = p,
                  alpha = 0.05)

#Comparación de medias independientes -----
#Varianzas iguales
n1 <- 32
n2 <- 32

X1_barra <- c(15.97, 15.91, 27.19, 22.75)
X2_barra <- c(12.34, 13.91, 16.59, 21.94)

s1 <- matrix(c(5.192, 4.545, 6.522, 5.250,
               4.545, 13.184, 6.760, 6.266,
               6.522, 6.760, 28.67, 14.468,
               5.250, 6.266, 14.468, 16.645),
             byrow = TRUE, nrow = 4)

s2 <- matrix(c(9.136, 7.549, 5.531, 4.151,
               7.549, 18.60, 5.446, 5.446,
               5.531, 5.446, 13.55, 13.55,
               4.151, 5.446, 13.55, 28.00),
             byrow = TRUE, nrow = 4)

p <- length(X1_barra)

#Se asume que las matrices de varianzas y covarianzas poblacionales,
#aunque desconocidas, son iguales.

# Hallamos Sp
S_p <- ((n1-1)*s1 + (n2-1)*s2)/(n1+n2-2)
S_p

#Valor de prueba
T2_p <- ((n1*n2)/( n1+n2))*t(X1_barra - X2_barra) %*% solve(S_p) %*% (X1_barra - X2_barra)
T2_p

#Valor cr�tico
T2_c <- ((n1+n2-2)*p)/(n1+n2-p-1)*qf(1-0.05, df1=p, df2=n1+n2-p-1)
T2_c

# Conclusión: Como T2_p >>>>> T2_c entonces con una significancia del 5% se 
#rechaza H0 y se concluye que, en promedio, los hombres y mujeres tienen respuestas distintas
#con respecto a cada uno de los cuatro atributos.

# Ejemplo
alpha <- 0.05
n1 <- 50
n2 <- 50
p <- 2

X1barra <- matrix(c(8.3,4.1),ncol=1)
X2barra <- matrix(c(10.2,3.9),ncol=1)
X_dif = X1barra - X2barra 
S_1 <- matrix(c(2,1,1,6),ncol=2)
S_2 <- matrix(c(2,1,1,4),ncol=2)

#A ojo S_1 y S_2 son muy parecidas entonces vamos a asumirlas iguales 
#en la población.

S_pooled <- ((n1-1)*S_1+(n2-1)*S_2)/(n1+n2-2)

confidenceEllipse(X.mean = X_dif,
                  eig = eigen(S_pooled),
                  n = n1+n2,
                  p = p,
                  alpha = 0.05)

#Varianzas diferentes -----
#Tamaños de muestra grandes
banknote %>% View()

# El conjunto de datos consta de 6 mediciones físicas de 200 billetes suizos
# https://search.r-project.org/CRAN/refmans/MixGHD/html/banknote.html

banknote %>% count(Status)

# de aqui, n1 = n2 = 100 son lo suficientemente grandes para p = 6 variables
billetes_falsos <- banknote %>% 
  filter(Status == "counterfeit") %>% 
  select_if(is.numeric)

billetes_genuinos <- banknote %>% 
  filter(Status == "genuine") %>% 
  select_if(is.numeric)
  
#Análisis de normalidad
mshapiro.test(t(billetes_falsos))
mshapiro.test(t(billetes_genuinos))

MVN::mvn(billetes_falsos, 
    mvnTest = "mardia", 
    multivariatePlot = "qq")

mvn(billetes_genuinos, 
    mvnTest = "mardia", 
    multivariatePlot = "qq")

# Como los datos NO son normales, no podemos aplicar ninguna prueba para testear si
# sus matrices de varianzas y covarianzas difieren significativamente. Hagamos una
# exploración descriptiva.

# Exploración descriptiva
BF_barra <- colMeans(billetes_falsos)
BG_barra <- colMeans(billetes_genuinos)

S_F <- cov(billetes_falsos) 
S_G <- cov(billetes_genuinos)
  
# A simple vista si se ven comportamientos diferentes entre ambas matrices.
# Asumiremos que Sigma_1 != Sigma_2.

# Usamos la aproximación chi cuadrado para hacer la comparación de medias poblacionales:
  
HotellingsT2Test( billetes_falsos, billetes_genuinos, test = "chi")

#Conclusión: Como p-value < 0.05 entonces con una significancia del 5% se rechaza
#H0 y se concluye que los billetes falsos y los billetes genuinos tienen en promedio
#dimensiones distintas.

#a mano
chi_p <- t(BF_barra-BG_barra)%*%solve(1/100*S_F + 1/100*S_G)%*%(BF_barra-BG_barra)
chi_p

chi_c <- qchisq(0.95, 6)
chi_c

# claramente chi_p > chi_c y la hipótesis de igualdad de medias se rechaza

# Construyamos los intervalos de confianza simultáneos para cada diferencia
# de medias entre las variables:

#Para la primera variable
a1 = c(1,0,0,0,0,0)
dim(a1) <- c(6,1)
a1

sqrt(chi_c)*sqrt(t(a1)%*%(1/100*S_F + 1/100*S_G)%*%a1)

t(a1)%*%(BF_barra-BG_barra)-sqrt(chi_c)*sqrt(t(a1)%*%(1/100*S_F + 1/100*S_G)%*%a1)
t(a1)%*%(BF_barra-BG_barra)+sqrt(chi_c)*sqrt(t(a1)%*%(1/100*S_F + 1/100*S_G)%*%a1)

#Para todos al tiempo
lim_inf <- diag(6)%*%(BF_barra-BG_barra)-sqrt(chi_c)*sqrt(diag(diag(6)%*%(1/100*S_F + 1/100*S_G)%*%diag(6)))
lim_sup <- diag(6)%*%(BF_barra-BG_barra)+sqrt(chi_c)*sqrt(diag(diag(6)%*%(1/100*S_F + 1/100*S_G)%*%diag(6)))

Sim_CI <- bind_cols(colnames(billetes_falsos), lim_inf, lim_sup) %>% 
  rename(variable = "...1",
         lim_inf = "...2",
         lim_sup = "...3")

Sim_CI

#Análisis: Con una confianza del 95%, En promedio, la longitud de los billetes falsos y genuinos es la misma
#En Left, Right, Bottom, Top, los billetes falsos son más grandes que los genuinos
#En la diagonal, los billetes genuinos son más grandes que los falsos

# Tamaños de muestra pequeños
Bacteria_datos <- read_excel("C:/Users/prestamour/Downloads/Bacteria_datos.xlsx",
                             sheet = 1)

NoBacteria_datos <- read_excel("C:/Users/prestamour/Downloads/Bacteria_datos.xlsx",
                               sheet = 2)


# En el análisis de normalidad no se recomienda usar la prueba
# Shapiro pues los tamaños de muestra son muy pequeños (n1 = 13, n2 = 10)

# mshapiro.test(t(Bacteria_datos))
# mshapiro.test(t(NoBacteria_datos))

MVN::mvn(Bacteria_datos, 
    mvnTest = "mardia")

MVN::mvn(NoBacteria_datos, 
    mvnTest = "mardia")

MVN::mvn(Bacteria_datos,
    mvnTest = "hz")

MVN::mvn(NoBacteria_datos,
    mvnTest = "hz")

# Como se tiene el supuesto de normalidad en ambas poblaciones
# podemos ver rápidamente si las matrices de varianzas y
# covarianzas son iguales o no

# Usamos el test Box's M (no vamos a entrar en detalles)
install.packages("MVTests")
library(MVTests)

BoxM(bind_rows(Bacteria_datos, NoBacteria_datos),
     group = c(rep(1, nrow(Bacteria_datos)),
               rep(2, nrow(NoBacteria_datos))))

#H0: Sigma_1 = Sigma_2   vs   H1: Sigma_1 != Sigma_2
#Como p-value = 0.0001088601 entonces con una significancia del 5% se concluye que
#la matriz de varianzas y covarianzas muestrales son distintas 

test_bacterias <- TwoSamplesHT2(bind_rows(Bacteria_datos, NoBacteria_datos),
                                group = c(rep(1, nrow(Bacteria_datos)),
                                          rep(2, nrow(NoBacteria_datos))),
                                Homogenity = FALSE)

summary(test_bacterias)

# Así, la H0 se rechaza y se concluye que existe diferencia significativa
# al 5% entre los dos suelos en términos de las medias de pH, potasio y 
# nitrógeno. Como ningún IC contiene a 0 entonces todas las variables difieren
# en media.

###########################Perros################################
Perros_datos <- read_excel("C:/Users/Daniel Fonseca/Downloads/Perros_datos.xlsx")
view(Perros_datos)
Perros_datos <- Perros_datos %>% 
  dplyr::select(-Perro)

#Exploración de normalidad
mshapiro.test(t(Perros_datos))
mvn(data = Perros_datos, mvnTest = "mardia")
mvn(data = Perros_datos, mvnTest = "hz")

#qqplot multivariado
mvn(data = Perros_datos,
    multivariatePlot = "qq")

#Suponiendo normalidad
#H0: mu_1 = mu_3 y mu_2 = mu_4
C_matriz = matrix(c(-1, -1, 1, 1,
                    1, -1, 1, -1,
                    1, -1, -1, 1), byrow = TRUE, nrow = 3) 

n <- 19
c_row <- nrow(C_matriz)

X_barra <- colMeans(Perros_datos) 
S <- cov(Perros_datos) 

CX_barra <- C_matriz %*% X_barra    
CSCt <- C_matriz %*% S %*% t(C_matriz)  

# Valor de prueba
T2_p <- n*t(CX_barra) %*% solve(CSCt) %*% CX_barra
T2_p

# Valor crítico
T2_c <- ((c_row)*(n-1))/(n-c_row)*qf(1-0.05, c_row, n-c_row)
T2_c

# Conclusión: Cómo T2_p > T2_c ent con una significancia de 5%, se rechaza H0
#y se concluye que, en promedio, El hatolano, o la diferencia de presión de CO2, 
#o el contraste H-CO2 si influyen en el anestésico.

#Usando la función de R
HotellingsT2Test(as.matrix(Perros_datos)%*%t(C_matriz), 
                 mu = c(0, 0, 0))

###########Labs############
labs_datos <- read_excel("C:/Users/Daniel Fonseca/Downloads/labs_datos.xlsx", 
                         col_types = c("skip", "text", "text", 
                                       "text", "text"))
labs_datos <- read_excel("C:/Users/prestamour/Downloads/labs_datos.xlsx", 
                         col_types = c("skip", "text", "text", 
                                       "text", "text"))
labs_datos <- labs_datos[-1,]
labs_datos <- 
  labs_datos %>% 
  rename(X1_BOD = `Commercial lab`,
         X2_SS = ...2,
         Y1_BOD = `State lab of hygiene`,
         Y2_SS = ...4) 

# Convertir todas las columnas 'chr' a 'numeric'
labs_datos[] <- lapply(labs_datos, function(x) {
  if (is.character(x)) as.numeric(x) else x
})

labs_datos_dif <- labs_datos %>% 
  mutate(d1 = X1_BOD - Y1_BOD, d2 = X2_SS - Y2_SS) %>% 
  select(c(d1, d2))

# Exploración de normalidad
mshapiro.test(t(labs_datos_dif))

MVN::mvn(data = labs_datos_dif,
    mvnTest = "mardia")

MVN::mvn(data = labs_datos_dif,
    multivariatePlot = "qq")

# Prueba de hipótesis
n <- nrow(labs_datos_dif)
p <- ncol(labs_datos_dif)

d_barra <- colMeans(labs_datos_dif)

S_d <- cov(labs_datos_dif)

# Valor de prueba
T2_p <- n*t(d_barra) %*% solve(S_d) %*% d_barra
T2_p

# Valor crítico
T2_c <-  (p*(n-1))/(n-p) *qf(1-0.05, p, n-p)
T2_c

# Conclusión: Como T2_p > T2_c entonces con una significancia del 5% se recahza 
#H0 y se concluye que los laboratorios no coinciden en los resultados de residuos.

# Usando la función de R 
HotellingsT2Test(labs_datos_dif, mu = c(0,0))

#Elipse
confidenceEllipse(X.mean = d_barra,
                  eig = eigen(S_d),
                  n = n,
                  p = p,
                  alpha = 0.05)