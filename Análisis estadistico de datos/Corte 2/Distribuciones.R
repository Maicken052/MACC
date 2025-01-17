# Ejemplos gu�a 3

library(tidyverse)
library(readxl)
install.packages("ConfidenceEllipse")
library(ConfidenceEllipse)

# Ejemplo 1.1 -----

X <- matrix(c(6,10,8,
              9,6,3),byrow=FALSE,ncol=2)
view(X)
mu_0 <- matrix(c(9,5), byrow=FALSE, nrow = 2)
view(mu_0)

n <- nrow(X)
p <- ncol(X)

X_barra <- colMeans(X)
view(X_barra)
  
S <- cov(X)
print(S)

S_inv <- solve(S)
print(S_inv)


T2 <- n * t((X_barra - mu_0)) %*% S_inv %*% (X_barra - mu_0)
print(T2)

print((n-p)/(p*(n-1)))
  # Antes de la recolecci�n de los datos, T^2 tiene la distribuci�n ((n-1)*p)/(n-p)*F(p,n-p)
  # 4F(2, 1)
  
  # Halle los percentiles 90, 95 y 98 de T^2
print(4*qf(c(.90, .95, .98), df1=2, df2=1)) 

  
  
  # Ejemplo 1.2 -----
sweat_data <- read_excel("C:/Users/prestamour/Downloads/sweat data.xlsx", 
                         col_names = FALSE)
sweat_data <- read_excel("C:/Users/Daniel Fonseca/Downloads/sweat_data.xlsx",col_names = FALSE)
view(sweat_data)

#cambie los nombres de las variables a tasa_sudor, sodio y potasio
sweat_data <- 
  sweat_data %>% 
  rename(tasa_sudor = ...1,
         sodio = ...2,
         potasio = ...3) 

#X barra muestra
X_barra <- colMeans(sweat_data)
view(X_barra)

#mu0
mu_0 <- matrix(c(4,50,10), byrow=FALSE, nrow = 3)

#Núm de filas y columnas
n <- nrow(sweat_data)
p <- ncol(sweat_data)

#S muestral
S <- cov(sweat_data)
print(S)

#Inversa de S
S_inv <- solve(S)
print(S_inv)

#T cuadrado (valor de prueba)
T2 <- n * t((X_barra - mu_0)) %*% S_inv %*% (X_barra - mu_0)
print(T2)

f <- (p*(n-1))/(n-p)
f2 <- ((n-p)*T2)/(p*(n-1))
a <- 0.1

#valor crítico
print(f*qf(1-a, df1=p, df2=n-p)) 

# Conclusión: Como T2>Vc, con una significancia del 10% se rechaza H0 y se concluye que la media no es mu0

#p-value P(F(p,n-p) > T2*(n-p)/p*(n-1))
pf(f2, p, n-p, lower.tail = FALSE) 


# qqplots (en ggplot)
sweat_data %>% 
  ggplot(aes(sample = tasa_sudor))+
  stat_qq()

sweat_data %>% 
  ggplot(aes(sample = sodio))+
  stat_qq()

sweat_data %>% 
  ggplot(aes(sample = potasio))+
  stat_qq()
#H0: Hay normalidad vs H1: No hay normalidad
shapiro.test(sweat_data$tasa_sudor)
shapiro.test(sweat_data$sodio)
shapiro.test(sweat_data$potasio)

#como el p-value es mayor a 0.05, no rechazamos h0 y se concluye que las variables pueden ser normales


# Ejemplo 2.1 -----
radia <- read_excel("C:/Users/prestamour/Downloads/radia.xlsx")

alpha <- 0.05

radia_trans <- radia %>% 
  mutate(rad_closed_sq = close^0.25, rad_open_sq = open^0.25) %>% 
  select(-c(close, open))

# qqplots datos originales
radia %>% 
  ggplot(aes(sample = open))+
  stat_qq()

radia %>% 
  ggplot(aes(sample = close))+
  stat_qq()

shapiro.test(radia$open)
shapiro.test(radia$close)

# qqplots datos transformados
radia_trans %>% 
  ggplot(aes(sample = rad_open_sq))+
  stat_qq()

radia_trans %>% 
  ggplot(aes(sample = rad_closed_sq))+
  stat_qq()

shapiro.test(radia_trans$rad_open_sq)
shapiro.test(radia_trans$rad_closed_sq)


X <- as.matrix(radia_trans)
n <- nrow(radia_trans)
p <- ncol(radia_trans) 
  
X_barra <- colMeans(X)
S <- cov(X)
S_inv <- solve(S)
  
inRegion <- function(mu, med_mu, InvS, n_size, signi){
    return(n_size * t((med_mu - mu)) %*% InvS %*% (med_mu - mu) <= (p*(n_size-1))/(n_size-p)*qf(1-signi, df1=p, df2=n_size-p))
}

inRegion(mu = matrix(c(0.63,0.57),
                     ncol = 1),
         med_mu = X_barra,
         InvS = S_inv,
         n_size = n,
         signi = alpha)

# Gr�fica de la elipse
# https://cran.r-project.org/web/packages/ConfidenceEllipse/vignettes/confidence-ellipse.html

elipse_95 <- confidence_ellipse(radia_trans, 
                                x = rad_closed_sq, 
                                y = rad_open_sq,
                                conf_level = 0.95)
dim(X_barra) <- c(2,1)
ggplot() +
  geom_path(data = elipse_95, aes(x = x, y = y), color = "blue", linewidth = 1L) +
  geom_point(data = radia_trans, aes(x = rad_closed_sq, y = rad_open_sq), color = "black", size = 1L)+
  geom_point(data = as_tibble(X_barra), aes(x = X_barra[1,1], y = X_barra[2,1]), color = "red")+
  labs(x = "Radiación puerta cerrada", y = "Radiación puerta abierta") +
  theme_minimal() +
  theme(legend.position = "none")

