# Regresión lineal múltiple univariada ----
# Análisis matricial

# Ejemplo 1.1 ----

z1 <- matrix(c(-2, -1, 0, 1, 2), byrow = TRUE, nrow = 5)
y <- matrix(c(0, 0, 1, 1, 3), byrow = TRUE, nrow = 5)

# matriz de diseño
Z <- matrix(c(rep(1, 5), z1), byrow = FALSE, nrow = 5)

n <- nrow(z1)
  
# Ejemplo 1.3 ----
beta_g <- solve(t(Z) %*% Z) %*% t(Z) %*% y 

y_est <- Z %*% beta_g
y_est

residuales <- y - y_est
suma_de_residuales <- t(residuales) %*% residuales 
 
# Así el modelo es y =  1 + o.7z1 + e

# Ejemplo 1.4 ----
# En este caso, la matriz de diseño tiene una columna adicional: la de los cuadrados de z_1

Z_1 <- matrix(c(rep(1,5), z1, z1^2), byrow = FALSE, nrow = 5)
  
beta_g1 <- solve(t(Z_1) %*% Z_1) %*% t(Z_1) %*% y
beta_g1


# El modelo será y = 0.5714 + 0.7z1 + 0.21z1^2 + e



# Ejemplo 1.5 ----
# calculamos primero las estimaciones y_gorro como Z*beta_g

y_gorro <- Z %*% beta_g
y_barra <- mean(y)
y_gorro_barra <- mean(y_gorro)

SCT <- t(y) %*% y - n*y_barra^2  
SCT  

SCR <- t(y_gorro) %*% y_gorro - n*y_gorro_barra^2
SCR  

SCE <- t(residuales) %*% residuales 
SCE

R2 <- SCR / SCT
R2

# que, en efecto, es el cuadrado del coeficiente de correlaci�n lineal:
cor(z1,y)^2

# An�lisis: mediante el modelo de regresi�n lineal, la variable z1 explica 
#el 81.7% de la variabilidad de la respuesta, y es un buen ajuste.

# Además, con SCE podemos hallar la estimación de sigma2
s2 <- SCE/(n-1-1)
  
s2

# Ejemplo 1.6 ----

# Usemos la otra expresi�n para calcular la suma de cuadrados del error
# SCE = Y'Y - beta_g'*Z'Y
SCE_1 <-  t(y)%*%y -t(beta_g1)%*%t(Z_1)%*%y  
SCE_1

# as�,

s2_1 <- SCE_1/(n-(2+1))
s2_1

s_1 <- sqrt(s2_1)
s_1

# el valor de c_22 lo obtenemos de
solve(t(Z_1)%*%Z_1)
c_22 <- solve(t(Z_1)%*%Z_1)[3,3]

# Luego, el estad�stico de prueba es
t_p <- (beta_g1[3] - 0)/(s_1*sqrt(c_22))
t_p

t_c <- qt(1-0.025, 2)
t_c

#Conclusión: Como el t_p cae en zona de no rechazo (-4.30 < 1.68 < 4.30) entonces
#con una significancia del 5%, NO se rechaza H0 y se concluye que beta_2=0,
#es decir, la variable z1^2 NO es significativa para el modelo: no hay curvatura.

#PD: Cuando me piden probar la significancia de B_i, la prueba de hipótesis siempre es
#H0: B_i = 0 vs H1: B_i != 0

# Ejemplo 1.7 ----

#(a)
z_0 <- matrix(c(1,1), nrow = 2)
z_0

# Estimaci�n puntual
t(z_0) %*% beta_g #Reemplazar en la eq

# Estimaci�n por IC
t(z_0) %*% beta_g - qt(0.95, n-(1+1))*sqrt((t(z_0)%*%solve(t(Z)%*%Z)%*%z_0)*s2)
t(z_0) %*% beta_g + qt(0.95, n-(1+1))*sqrt((t(z_0)%*%solve(t(Z)%*%Z)%*%z_0)*s2)

#la respuesta promedio pronosticada es de 1.7 y con una confianza del 90%, el intervalo
#que contiene el valor real de 'E(Y)' cuando z1 = 1 es de (0.9195, 2.4805) 

#(b)
z_0 <- matrix(c(1,1), nrow = 2)
z_0

# Estimaci�n puntual
t(z_0) %*% beta_g

# Estimaci�n por IC
t(z_0) %*% beta_g - qt(0.95, n-(1+1))*sqrt((1+t(z_0)%*%solve(t(Z)%*%Z)%*%z_0)*s2)
t(z_0) %*% beta_g + qt(0.95, n-(1+1))*sqrt((1+t(z_0)%*%solve(t(Z)%*%Z)%*%z_0)*s2)

#la respuesta pronosticada cuando z1 = 1 es de 1.7 y con una confianza del 90%, el intervalo
#que contiene el valor real de 'Y' cuando z1 = 1 es de (0.0752, 3.3248). Note que hay más incertidumbre
#cuando se pronostica el valor de la variable que cuando se pronostica su media.
