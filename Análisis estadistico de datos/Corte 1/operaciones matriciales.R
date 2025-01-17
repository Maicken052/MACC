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

Student_Perf_ <- read_csv("C:/Users/prestamour/Downloads/Student_Performance_2.csv")

#Renombrar y quitar las actividades extracurriculares
Datos_prueba <- Student_Perf_ %>% 
  select(-`Extracurricular Activities`) %>% 
  rename(Horas_estudio = `Hours Studied`,
         Prueba_inter = `Previous Scores`,
         Horas_sueño = `Sleep Hours`,
         Simulacros = `Sample Question Papers Practiced`,
         Puntaje_final = `Performance Index`)

#Obtener el vector de medias
medias <- colMeans(Datos_prueba)
medias

n <- 10000
uno <- c(rep(1, n))
dim(uno) <- c(n,1)

(1/n)*t(uno)%*%as.matrix(Datos_prueba)

#Matriz de varianzas y covarianzas
mat_S <- cov(Datos_prueba)
mat_S
det(mat_S) #Varianza general
sum(diag(mat_S)) #Varianza total

1/(n-1)*t(as.matrix(Datos_prueba))%*%(diag(n)-(1/n)*uno%*%t(uno))%*%as.matrix(Datos_prueba)

#Matriz de correlación
mat_R <- cor(Datos_prueba)
mat_R

D_menos <- diag(1/sqrt(diag(cov(Datos_prueba))))
D_menos %*% mat_S %*% D_menos

#Gráfica de matriz de correlación
corrplot(mat_R, tl.cex = 0.7, col=brewer.pal(n=8, name="PuOr"))
