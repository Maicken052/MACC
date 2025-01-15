#Librerías
import numpy as np
from sympy import *
from scipy.optimize import minimize
import time

#Variables a usar en las funciones
global u_min, u_max, r_min, r_max, u_price, r_price, nf_per, f_obj, f_pen_nf, n

#Evaluar una expresión en un punto
def eval_function(f, point):
    sub = {}
    for i in range(len(point)):
        sub[x[i]] = point[i]
    result = f.evalf(subs=sub)
    return result

#Creación de la función objetivo según el número de estructuras
def funcion_objetivo():
    f_obj = ''

    for i in range(n):
        if f_obj != '': #Si no es la primera iteración, se suma el siguiente término
            f_obj = f'{f_obj} + ((x{i+1}-{u_min})/0.146)*{u_price} + (({r_max}-x{i+n+1})/2)*{r_price}'
        else: #Si es la primera iteración, no se suma nada
            f_obj = f'((x{i+1}-{u_min})/0.146)*{u_price} + (({r_max}-x{i+n+1})/2)*{r_price}'

    return sympify(f_obj) #Se retorna la función objetivo como una expresión

#Creación de la función de penalidad de el número de fallas
def funcion_de_penalizacion_nf():
    mu = 10**20 #Valor muy grande de mu
    nf = '' #Función del número de fallas calculadas

    for i in range(n):
        if nf != '': #Si no es la primera iteración, se suma el siguiente término
            nf = f'{nf} * 1/(x{i+1}-{u_min}) * 1/({r_max}-x{i+n+1})'
        else: #Si es la primera iteración, no se suma nada
            nf = f'1/(x{i+1}-{u_min}) * 1/({r_max}-x{i+n+1})'

    f_pen_nf = f'{mu}*max(0,({nf})-{nf_per})' #Se crea la función de penalidad de el número de fallas

    return sympify(f_pen_nf), sympify(nf)

#Función de penalidad de U
def funcion_de_penalizacion_u(x):
    count = 0
    for i in range(n):
        if x[i] >= u_min and x[i] <= u_max: #Si el valor de U está dentro de los límites, no hay penalidad
            pass
        else:
            count += 1
    return count

#Función de penalidad de R
def funcion_de_penalizacion_r(x):
    count = 0
    for i in range(n):
        if x[i+n] >= r_min and x[i+n] <= r_max: #Si el valor de U está dentro de los límites, no hay penalidad
            pass
        else:
            count += 1
    return count

#Función de penalidad a minimizar
def f(x):
    mu = 10**20 #Valor muy grande de mu

    pen_u = funcion_de_penalizacion_u(x) #Número de penalidades de U (U_i fuera de los límites)
    pen_r = funcion_de_penalizacion_r(x) #Número de penalidades de R (R_i fuera de los límites)

    return eval_function(f_obj, x) + eval_function(f_pen_nf, x) + pen_u*mu + pen_r*mu


n = int(input("Ingrese el número de estructuras: "))
u_min = float(input("Ingrese el límite inferior de la longitud del arco seco: "))
u_max = float(input("Ingrese el límite superior de la longitud del arco seco: "))
r_min = float(input("Ingrese el límite inferior de la resistencia de puesta a tierra: "))
r_max = float(input("Ingrese el límite superior de la resistencia de puesta a tierra: "))
u_price = float(input("Ingrese el precio del paso del arco seco: "))
r_price = float(input("Ingrese el precio del paso de la resistencia de puesta a tierra: "))
nf_per = float(input("Ingrese el número de fallas permitidas: "))

#Creación del punto inicial
u_point = (u_min + u_max)/2
r_point = (r_min + r_max)/2
x0 = []

#Se agregan los puntos iniciales de U
for i in range(n): 
    x0.append(u_point)

#Se agregan los puntos iniciales de R
for i in range(n):
    x0.append(r_point)

x0 = np.array(x0)

#variables a usar en las funciones
num_vars = len(x0)+1
x = symbols(f"x1:{num_vars}")

#Se crean las funciones objetivo y de penalidad de el número de fallas
f_obj = funcion_objetivo()
f_pen_nf = funcion_de_penalizacion_nf()[0]

# Guarda el tiempo de inicio
tiempo_inicio = time.time()

#Inicializa el método de Nelder-Mead con el punto inicial dado y tolerancia 0.1
sol = minimize(f,x0, method="Nelder-Mead", tol = 0.1)

# Guarda el tiempo de finalización
tiempo_fin = time.time()

# Calcula la diferencia
tiempo_total_segundos = tiempo_fin - tiempo_inicio

# Convierte a minutos
tiempo_total_minutos = tiempo_total_segundos / 60

#Imprime los resultados
print(f"La solución está dada por:")
for i in range(n):
    print(f"U{i+1}: {sol.x[i]}")
    print(f"R{i+1}: {sol.x[i+n]}")
print(f"El costo total de los materiales sería de {eval_function(f_obj, sol.x)}")
print(f"Y número de fallas calculadas sería {eval_function(funcion_de_penalizacion_nf()[1], sol.x)}")
print(f"El código tomó {tiempo_total_minutos:.2f} minutos en ejecutarse.")

