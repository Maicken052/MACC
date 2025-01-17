# An�lisis discriminante
# Clasificaci�n
library(readr)
library(mvnormtest)
library(MVN)
library(MVTests)
library(DescTools)
library(rstatix)
library(MASS) #lda y qda
if(!require("caret")) install.packages("caret")
if (!require("ggpubr")) install.packages("ggpubr")
library(tidyverse)
library(psych)
if (!require("klaR")) install.packages("klaR")

# Ejemplo 1 -----

Cesped <- read_table("D:/Anama/OneDrive - Pontificia Universidad Javeriana/URosario/2024 - II - UR/An�lisis Estad�stico de Datos/Material de clase - en R/10. An�lisis discriminante/Cesped.txt")

# Gr�fico de dispersi�n

Cesped %>% 
  mutate(Propietario = if_else(Propietario == 1, "S�", "No")) %>% 
  ggplot(aes(x = Ingreso, y = Lote, color = factor(Propietario)))+
  geom_point()+
  ylim(c(10,25))+
  xlim(c(60,150))+
  labs(color = "Propietario")+
  theme_minimal()

# Ejemplo 3 -----

S_p = matrix(c(11.255, 9.404, 7.149, 3.383,
               9.404, 13.532, 7.383, 2.553,
               7.149, 7.383, 11.574, 2.617,
               3.383, 2.553, 2.617, 5.809), byrow = TRUE, nrow = 4)

Xg1_barra <- c(12.57, 9.57, 11.49, 7.97)

Xg2_barra <- c(8.75, 5.33, 8.50, 4.75)

b_t <- t(solve(S_p) %*% (Xg1_barra - Xg2_barra))
b_t

#función de discriminación
#Y = 0.03 * X1 + 0.20 * X2 + 0.01 * X3 + 0.44 * X4 

#Umbral de decisión
Xc_barra <-  0.5*(Xg1_barra + Xg2_barra)
Xc_barra

umbral <- b_t %*% Xc_barra
umbral

#Así, la regla de clasificación es: si la función de discriminación estimada
#sobre un individuo es mayor o igual al umbral entonces el individuo
#se debe clasificar en el grupo 1, no sernil; mientras que si 
#es menor al umbral debe clasificarse como senil (grupo 2.)

#x_0 =(10, 8, 7, 5)
x_0 = c(10, 8, 7, 5)
b_t %*% x_0 < umbral 

#como el valor de la función es menor al umbral, entonces x_0 se clasifica como senil.

####
# An�lisis discriminante en R
# Ejemplo LDA -----

# Es una adaptaci�n del ejercicio 11.24 del libro gu�a. 
# Los datos est�n en el archivo bancarrota.dat
# 0: bancarrota, 1: no bancarrota
# Annual financial data are collected for bankrupt firms approximately 2 years prior to their
# bankruptcy and for financially sound firms at about the same time.The data on four variables,
# x1 = (cash flow)/(total debt), x2 = (net income)/(total assets),
# x3 = (current assets)/(current liabilities), 
# and x4 = (current assets)/(net sales).

Bancarrota <- read_table("C:/Users/prestamour/Downloads/T11-4.DAT")
  
# An�lisis de normalidad para cada poblaci�n -----
Bancarrota %>% count(poblacion)

# 1. Pruebe si las poblaciones son normales multivariadas
# 2. Si no lo son, seleccione el par de variables x1 y x4 y verifique de nuevo el supuesto.

bank_si <- Bancarrota %>% 
  filter(poblacion == 0) %>% 
  dplyr::select(-poblacion)


bank_no <- Bancarrota %>% 
  filter(poblacion == 1) %>% 
  dplyr::select(-poblacion)
  
mshapiro.test(t(bank_si))
mshapiro.test(t(bank_no))

mvn(data = bank_si,
    mvnTest = "mardia",
    multivariatePlot = "qq")

mvn(data = bank_no,
    mvnTest = "mardia",
    multivariatePlot = "qq")

# selecci�n de variables

Bancarrota_par <- Bancarrota %>% 
  dplyr::select(c(x1, x4, poblacion))

bank_si_par <- Bancarrota_par %>% 
  filter(poblacion == 0) %>% 
  dplyr::select(c(x1, x4))

bank_no_par <- Bancarrota_par %>% 
  filter(poblacion == 1) %>% 
  dplyr::select(c(x1, x4))

mshapiro.test(t(bank_si_par)) 
mshapiro.test(t(bank_no_par)) 

# An�lisis descriptivo -----
# Construya boxplots para cada variable segmentada por poblaci�n
# identifique cu�l de las dos variables parece tener mayor poder discriminante.
# Analice dicho poder discriminante usando tambi�n un diagrama de dispersi�n.
# Calcule y compare medias y desviaciones de x1 y x4 entre poblaciones. Analice.
names <- colnames(Bancarrota_par)

b1 <- Bancarrota_par %>%
  ggboxplot(x = "poblacion", y = names[1],
            color = names[3], palette = "jco",
            width = 0.5) +
  labs(title = paste("Boxplot of", names[1], "by poblacion")) +
  theme_minimal()

b2 <- Bancarrota_par %>%
  ggboxplot(x = "poblacion", y = names[2],
            color = names[3], palette = "jco",
            width = 0.5) +
  labs(title = paste("Boxplot of", names[2], "by poblacion")) +
  theme_minimal()

ggarrange(b1, b2, ncol = 2)

Bancarrota_par %>% 
  ggplot(aes(x=x1, y=x4, color = factor(poblacion))) + 
  geom_point()

Bancarrota %>% 
  group_by(poblacion) %>% 
  summarise(media_x1 = mean(x1),
            media_x4 = mean(x4),
            desv_x1 = sd(x1),
            desv_x4 = sd(x4))

#Parece que la variable x1 tiene mayor poder para separar indiviuos que estan o no en bancarrota.
# An�lisis de igualdad de varianzas -----
cor(bank_si_par)
cor(bank_no_par)

# Box's test
BoxM(bind_rows(bank_si_par, bank_no_par),
     group = Bancarrota$poblacion)

#Las matrices de varianzas y covarianzas son iguales entre las poblaciones, y por tanto, se usa un clasificador lineal

# LDA -----
# Modelo
modelo_lda <- lda(poblacion ~., data = Bancarrota_par)
modelo_lda

# Predicci�n sobre la base completa
predict(modelo_lda)
predict(modelo_lda)$class



# matriz de confusi�n

table(predict(modelo_lda)$class, Bancarrota_par$poblacion)

# APER

APER = (6+3)/(21+25) 
APER
#Se estima una tasa de error del 19.56%

# partici�n entrenamiento - validaci�n

train_index <- createDataPartition(Bancarrota_par$poblacion,
                                   p = 0.8, 
                                   list = FALSE)

bank_train <- Bancarrota_par[train_index,]
bank_test <- Bancarrota_par[-train_index,]

prop.table(table(bank_train$poblacion))
prop.table(table(bank_test$poblacion))

# modelo en train

modelo_lda_train <- lda(poblacion ~., data = bank_train)
modelo_lda_train

#Y = 5.4237X1 + 0.4420X4

# predicci�n en validaci�n

predict(modelo_lda_train, bank_test)
predict(modelo_lda_train, bank_test)$class

# matriz de confusi�n

table(predict(modelo_lda_train, bank_test)$class, bank_test$poblacion)

# APER 
APER_val = 3/9 
APER_val

# leave one out
modelo_lda_cv <- lda(poblacion ~., CV = TRUE, data = Bancarrota_par)
modelo_lda_cv

# matriz de confusi�n

table(Bancarrota_par$poblacion, modelo_lda_cv$class)

# APER

APER_cv = (3+8)/(21+25)
APER_cv

#El APER sobre todos los datos subestima el porcentaje de error real, cuando se usa la partición el APER es muy
#sensible, pero en la mayoría de los casos, debería aumentar con respecto al primero. La estimación más robusta
#del APER es la que se obtiene con la validación leave one out. Así, se estima una tasa de error con el LDA
#de 23.91%.

# Ejemplo QDA -----

# Usando las variables X2, X3 y X4:
Bancarrota_tri <- Bancarrota %>% 
  select(-x1) %>% 
  mutate(poblacion = as.factor(poblacion))

# Hacer exploraci�n descriptiva de las variables segmentadas por la poblaci�n
# Estad�grafos
describeBy(Bancarrota_tri, group = factor(Bancarrota$poblacion))

# Gr�ficos (boxplots e histogramas)
names <- colnames(Bancarrota_tri)

b1 <- Bancarrota_tri %>%
  ggboxplot(x = "poblacion", y = names[1],
            color = names[4], palette = "jco",
            width = 0.5) +
  labs(title = paste("Boxplot of", names[1], "by poblacion")) +
  theme_minimal()

b2 <- Bancarrota_tri %>%
  ggboxplot(x = "poblacion", y = names[2],
            color = names[4], palette = "jco",
            width = 0.5) +
  labs(title = paste("Boxplot of", names[2], "by poblacion")) +
  theme_minimal()

b3 <- Bancarrota_tri %>%
  ggboxplot(x = "poblacion", y = names[3],
            color = names[4], palette = "jco",
            width = 0.5) +
  labs(title = paste("Boxplot of", names[3], "by poblacion")) +
  theme_minimal()

ggarrange(b1, b2, b3, ncol = 3)

b1 <- Bancarrota_tri %>% 
  gghistogram(x = "x2", add = "mean",
              color = "poblacion",
              fill = "poblacion", palette = c("#00AFBB", "#E7B800")) +
  ggtitle("X2") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

b2 <- Bancarrota_tri %>% 
  gghistogram(x = "x3", add = "mean",
              color = "poblacion",
              fill = "poblacion", palette = c("#00AFBB", "#E7B800")) +
  ggtitle("X3") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

b3 <- Bancarrota_tri %>% 
  gghistogram(x = "x4", add = "mean",
              color = "poblacion",
              fill = "poblacion", palette = c("#00AFBB", "#E7B800")) +
  ggtitle("X4") +
  labs(y = "")+
  theme(plot.title = element_text(hjust = 0.5))

ggarrange(b1, b2, b3,
          common.legend = TRUE, legend = "bottom", nrow = 1)

# Haga an�lisis de normalidad para ambas poblaciones

Bancarrota_tri <- Bancarrota %>% 
  select(c(x2, x3, x4, poblacion)) %>% 
  mutate(poblacion = as.factor(poblacion))

bank_si_tri <- Bancarrota_tri %>% 
  filter(poblacion == 0) %>% 
  select(c(x2, x3, x4))

bank_no_tri <- Bancarrota_tri %>% 
  filter(poblacion == 1) %>% 
  select(c(x2, x3, x4))

mshapiro.test(t(bank_si_tri)) 
mshapiro.test(t(bank_no_tri)) 

mvn(data = bank_no_tri,
    mvnTest = "hz")

mvn(data = bank_si_tri,
    mvnTest = "hz")

mvn(data = bank_no_tri,
    mvnTest = "mardia",
    multivariatePlot = "qq")

mvn(data = bank_si_tri,
    mvnTest = "mardia",
    multivariatePlot = "qq")
# Compare las matrices de varianzas y covarianzas
cor(bank_si_tri)
cor(bank_no_tri)

# Box's test
BoxM(bind_rows(bank_si_tri, bank_no_tri),
     group = Bancarrota$poblacion)

# Se rechaza la hip de igualdad, eso quiere decir que no podemos usar un modelo lineal
# discriminante. Es necesario construir un QDA (que, a su vez, es más robusto
# que el LDA a la falta de normalidad multivariada).

# QDA -----
# Modelo
modelo_qda <- qda(poblacion ~., data = Bancarrota_tri) 
modelo_qda

# Gr�fico del QDA
partimat(factor(poblacion) ~ x2 + x3 + x4, data = Bancarrota_tri, method = "qda")

# Pron�sticos
predict(modelo_qda)
predict(modelo_qda)$class

# matriz de confusi�n
table(predict(modelo_qda)$class, Bancarrota_tri$poblacion)

# APE
APER_qda = 4/(21+25)
APER_qda

# Hacer el modelo QDA y calcular APER usando:

# partici�n entrenamiento - validaci�n

train_index <- createDataPartition(Bancarrota_tri$poblacion,
                                   p = 0.8, 
                                   list = FALSE)

bank_train <- Bancarrota_tri[train_index,]
bank_test <- Bancarrota_tri[-train_index,]

prop.table(table(bank_train$poblacion))
prop.table(table(bank_test$poblacion))

# modelo en train
modelo_qda_train <- qda(poblacion ~., data = bank_train)
modelo_qda_train

# predicci�n en validaci�n

predict(modelo_qda_train, bank_test)
predict(modelo_qda_train, bank_test)$class

# matriz de confusi�n

table(predict(modelo_qda_train, bank_test)$class, bank_test$poblacion)

# APER 
APER_val = 1/9 
APER_val

# leave one out
modelo_qda_cv <- qda(poblacion ~., CV = TRUE, data = Bancarrota_tri)
modelo_qda_cv

# matriz de confusi�n

table(Bancarrota_tri$poblacion, modelo_qda_cv$class)

# APER

APER_cv = (6+2)/(21+25)
APER_cv