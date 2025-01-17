# Ejemplos PCA - Gu�a 7

# Ejemplo 1.1 ----------

Sigma = matrix(c(1, -2, 0, -2, 5, 0, 0, 0, 2), 
               byrow = TRUE,
               nrow = 3)

Sigma

eigen(Sigma)

var_total <- sum(eigen(Sigma)$values)
var_total

eigen(Sigma)$values/var_total
# Ejemplo 1.2 ----------

Sigma = matrix(c(1, 4, 4, 100), 
               byrow = TRUE,
               nrow = 2)

V_menos <- solve(diag(diag(sqrt(Sigma))))
V_menos

Ro <- V_menos %*% Sigma %*% V_menos  
Ro

# Ejemplo 1.3 ----------

if(!require("tidyverse")) install.packages("tidyverse")
if(!require("readxl")) install.packages("readxl")
if(!require("MVQuickGraphs")) install.packages("MVQuickGraphs")
if(!require("mvnormtest")) install.packages("mvnormtest")
if(!require("MVN")) install.packages("MVN")
if(!require("MASS")) install.packages("MASS")
if(!require("DescTools")) install.packages("DescTools")
if(!require("MVTests")) install.packages("MVTests")
if(!require("readr")) install.packages("readr")
if(!require("gridExtra")) install.packages("gridExtra")
if(!require("ggpubr")) install.packages("ggpubr")
if(!require("rstatix")) install.packages("rstatix")
if(!require("corrplot")) install.packages("corrplot")
if(!require("RColorBrewer")) install.packages("RColorBrewer")
if(!require("lmtest")) install.packages("lmtest")
if(!require("car")) install.packages("car")
if(!require("mclust")) install.packages("mclust")

# Lectura de datos

Economicos <- Economicos <- read_excel("C:/Users/prestamour/Downloads/Economicos.xlsx")
  
Economicos %>% glimpse()

# Matriz de varianzas y covarianzas---

mat_S <- cov(Economicos)
mat_S

corrplot(cor(Economicos), method = "square", tl.cex = 0.7,
         col=brewer.pal(n=8, name="PuOr"),addCoef.col = "black",
         number.cex=0.7,type = "upper", diag = FALSE)

# Valores y vectores propios

auto_S <- eigen(mat_S)
auto_S$values
auto_S$vectors

# Variabilidad explicada por cada componente
var_total <- sum(auto_S$values)
var_total

porcentaje_variabilidad <- (auto_S$values/var_total)*100

# Variabilidad acumulada
acum = cumsum(porcentaje_variabilidad)


# Gráfico de pareto (minima cantidad de componentes que explican el 80% de la variabilidad total)
tabla <- tibble(k = c(1,2,3,4,5), var_acum = acum)

tabla %>% ggplot(aes(x= k, y = var_acum))+
  geom_line() + 
  geom_point() +
  geom_hline(yintercept = 80, color ="red") +
  geom_text(aes(label = after_stat(round(y,1))), 
            nudge_x = 0.25, nudge_y = 3.25)+
  ggtitle("Grafico de pareto")+
  xlab("# de componentes")+
  ylab("variabilidad acumulada")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Gráfico de elbow
tabla <- tibble(k = c(1,2,3,4,5), var_exp = porcentaje_variabilidad)

tabla %>% ggplot(aes(x= k, y = porcentaje_variabilidad))+
  geom_line() + 
  geom_point() +
  geom_text(aes(label = after_stat(round(y,1))), 
            nudge_x = 0.25, nudge_y = 3.25)+
  ggtitle("Grafico de elbow")+
  xlab("# de componentes")+
  ylab("% de variabilidad explicada")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Componentes estandarizadas---
mat_R <- cor(Economicos)
corrplot(mat_R, method = "square", tl.cex = 0.7,
         col=brewer.pal(n=8, name="PuOr"),addCoef.col = "black",
         number.cex=0.7,type = "upper", diag = FALSE, order = 'FPC')

#si hay globos hay fiesta para PCA: hay info repetida que se podría 'resumir/organizar'

#valores y vectores propios

auto_R <- eigen(mat_R)
auto_R$values
auto_R$vectors

# Variabilidad explicada por cada componente
var_total <- sum(auto_R$values)
var_total

porcentaje_variabilidad <- (auto_R$values/var_total)*100

# Variabilidad acumulada
acum = cumsum(porcentaje_variabilidad)

# Gráfico de pareto (minima cantidad de componentes que explican el 80% de la variabilidad total)
tabla <- tibble(k = c(1,2,3,4,5), var_acum = acum)

tabla %>% ggplot(aes(x= k, y = var_acum))+
  geom_line() + 
  geom_point() +
  geom_hline(yintercept = 80, color ="red") +
  geom_text(aes(label = after_stat(round(y,1))), 
            nudge_x = 0.25, nudge_y = 3.25)+
  ggtitle("Grafico de pareto")+
  xlab("# de componentes")+
  ylab("variabilidad acumulada")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Gráfico de elbow
tabla <- tibble(k = c(1,2,3,4,5), var_exp = porcentaje_variabilidad)

tabla %>% ggplot(aes(x= k, y = porcentaje_variabilidad))+
  geom_line() + 
  geom_point() +
  geom_text(aes(label = after_stat(round(y,1))), 
            nudge_x = 0.25, nudge_y = 3.25)+
  ggtitle("Grafico de elbow")+
  xlab("# de componentes")+
  ylab("% de variabilidad explicada")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))

#Gráfica de valores propios (considerar que la varianza explique más de una variable)
tabla <- tibble(k = c(1,2,3,4,5), lambda_i = auto_R$values)

tabla %>% ggplot(aes(x= k, y = lambda_i))+
  geom_line() + 
  geom_point() +
  geom_hline(yintercept = 1) +
  geom_text(aes(label = after_stat(round(y,1))), 
            nudge_x = 0.25, nudge_y = 3.25)+
  ggtitle("Gráfico de valores propios")+
  xlab("# de componentes")+
  ylab("valor propio")+
  theme_minimal()+
  theme(plot.title = element_text(hjust = 0.5))