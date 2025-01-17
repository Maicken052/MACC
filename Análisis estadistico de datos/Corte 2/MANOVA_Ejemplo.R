# Ejemplos guía 5 -----

# Ejemplo 2.1

x_11 <- matrix(c(9,3), byrow = TRUE, nrow = 2)
x_12 <- matrix(c(6,2), byrow = TRUE, nrow = 2)
x_13 <- matrix(c(9,7), byrow = TRUE, nrow = 2)

x_21 <- matrix(c(0,4), byrow = TRUE, nrow = 2)
x_22 <- matrix(c(2,0), byrow = TRUE, nrow = 2)

x_31 <- matrix(c(3,8), byrow = TRUE, nrow = 2)
x_32 <- matrix(c(1,9), byrow = TRUE, nrow = 2)
x_33 <- matrix(c(2,7), byrow = TRUE, nrow = 2)


n_1 <- 3
n_2 <- 2
n_3 <- 3

n <- n_1 + n_2 + n_3
g <- 3 #Cantidad de poblaciones 
p <- 2 #Número de variables

x1_b <- (1/3)*(x_11+x_12+x_13)
x2_b <- (1/2)*(x_21+x_22)
x3_b <- (1/3)*(x_31+x_32+x_33)

x_b <- ((n_1*x1_b)+(n_2*x2_b)+(n_3*x3_b))/n

# Matriz suma de cuadrados y de productos cruzados Between

B <- n_1*((x1_b-x_b)%*%t(x1_b-x_b))+
n_2*((x2_b-x_b)%*%t(x2_b-x_b))+
n_3*((x3_b-x_b)%*%t(x3_b-x_b))

# Matriz suma de cuadrados y de productos cruzados Within

W_1 <- (x_11-x1_b)%*%t(x_11-x1_b)+(x_12-x1_b)%*%t(x_12-x1_b)+(x_13-x1_b)%*%t(x_13-x1_b)

W_2 <- (x_21-x2_b)%*%t(x_21-x2_b)+(x_22-x2_b)%*%t(x_22-x2_b)
  
W_3 <- (x_31-x3_b)%*%t(x_31-x3_b)+(x_32-x3_b)%*%t(x_32-x3_b)+(x_33-x3_b)%*%t(x_33-x3_b)

# los x_ij - xi_b son los vectores de residuales

W = W_1 + W_2 + W_3
W

# Lambda de Wilk

lambda_ast <- (det(W))/(det(B+W))
lambda_ast

# como p = 2 y g = 3 entonces por la tabla tenemos el estadístico de prueba

L_p <- ((1-sqrt(lambda_ast))/sqrt(lambda_ast))*((n - g - 1)/(g-1))
L_p

# que sigue una distribución F con 2*(g-1) y 2*(n-g-1) grados de libertad
# as�, el valor crítico al 5% es

L_c <- qf(0.95, 2*(g-1), 2*(n-g-1))
L_c

# Conclusión: Como L_p > L_c, con una significancia del 5% se rechaza H0 y se concluye que 
#Hay un tratamiento que tiene distinto efecto en la población.


# Ejemplo 2.2
# construir los IC simult�neos para el ejemplo anterior

# Como se rechaz� H0, tiene sentido analizarlos

# trat_1 - trat_2

x1_b-x2_b

alpha <- 0.05
alpha_ast <- alpha/(p*g*(g-1))

t <- qt(1-alpha_ast, n-g)

x1_b-x2_b-t*sqrt((diag(W))/(n-g)*(1/n_1+1/n_2))
x1_b-x2_b+t*sqrt((diag(W))/(n-g)*(1/n_1+1/n_2))

# An�lisis.
#Como el IC con los tratamientos 1 y 2 sobre la variable 2 contienen al cero (-6.44;10.44)
#entonces la media de esa variable no difiere entre estos dos tratamientos.
#Contrario sucede para la variable 1 donde la media en el primer tratamiento excede a la del segundo
#entre 1.55 y 12.45 unidades.


# trat_1 - trat_3

alpha <- 0.05
alpha_ast <- alpha/(p*g*(g-1))

t <- qt(1-alpha_ast, n-g)

x1_b-x3_b-t*sqrt((diag(W))/(n-g)*(1/n_1+1/n_3))
x1_b-x3_b+t*sqrt((diag(W))/(n-g)*(1/n_1+1/n_3))

# Análisis.
#Como el IC con los tratamientos 1 y 3 sobre la variable 2 contienen al cero (-11.54;3.54)
#entonces la media de esa variable no difiere entre estos dos tratamientos.
#Contrario sucede para la variable 1 donde la media en el primer tratamiento excede a la del segundo
#entre 1.12 y 10.87 unidades.

# trat_2 - trat_3

alpha <- 0.05
alpha_ast <- alpha/(p*g*(g-1))

t <- qt(1-alpha_ast, n-g)

x2_b-x3_b-t*sqrt((diag(W))/(n-g)*(1/n_2+1/n_3))
x2_b-x3_b+t*sqrt((diag(W))/(n-g)*(1/n_2+1/n_3))

# An�lisis.
#Como el IC con los tratamientos 2 y 3 sobre la variable 2 contienen al cero (-6.44;4.44)
#entonces la media de esa variable no difiere entre estos dos tratamientos.
#lo mismo sucede para la variable 1 dado que contiene al 0 (-14.43, 2.43),
#entonces la media de esa variable no difiere entre los dos tratamientos.
