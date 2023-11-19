import numpy as np
from sympy import *
from scipy.optimize import minimize

def eval_function(f, point):
    sub = {}
    for i in range(len(point)):
        sub[x[i]] = point[i]
    result = f.evalf(subs=sub)
    return result

def barrera(f, x0, tol, mu, lamda, barrier):
    #Se reemplaza el mu y lamda que corresponda en la función de penalidad
    f_ = f.replace('mu', f'{mu}')
    f_ = f_.replace('lamda', f'{lamda}') 
    barrier_ = barrier.replace('mu', f'{mu}')
    barrier_ = barrier_.replace('lamda', f'{lamda}')

    #Se convierten las funciones de su forma string a expresiones
    fun = sympify(f_)
    pen = sympify(barrier_)

    #Se definen las funciones que se van a minimizar
    def g(x):
        return eval_function(fun, x)
    def h(x):
        return eval_function(pen, x)

    x1 = np.array(minimize(g, x0, method='Nelder-Mead').x) #Se minimiza la función objetivo

    #Si la penalidad es lo suficientemente pequeña, se retorna el punto mínimo
    if h(x1) < tol:
        return x1
    else:
        mu = 10*mu #Sino, se aumenta el valor de mu
        lamda = 0.1*lamda #Se disminuye el valor de lamda
        return barrera(f, x1, tol, mu, lamda, barrier)

#prueba
mu_ = 0.1  #Valor inicial de mu
lamda = 10 #Valor inicial de lamda
initial_point = [1,2]
h = 0.00000005 
f = '(x1-2)**4 + (x1-2*x2)**2' 
ineqrest = ['x1**2 - x2'] #Restricciones de desigualdad

x0 = np.array(initial_point)
dimentions = len(initial_point)+1
x = symbols(f"x1:{dimentions}")
penalty = '' #Función de penalidad

for i in range(len(ineqrest)): #Se agregan las restricciones de desigualdad a la función de penalidad
    if penalty != '':
        penalty = f'{penalty} + mu*max(0,{ineqrest[i]})**2' #Si ya hay restricciones de desigualdad, se suman las siguientes
    else:
        penalty = f'mu*max(0,{ineqrest[i]})**2' #Si aún no hay restricciones, se agrega la primera

barrier = ''

for i in range(len(ineqrest)): #Se agregan las restricciones de desigualdad a la función de barrera
    if barrier != '':
        barrier = f'{barrier} - lamda/({ineqrest[i]})' #Si ya hay restricciones de desigualdad, se suman las siguientes
    else:
        barrier = f'- lamda/({ineqrest[i]})' #Si aún no hay restricciones, se agrega la primera

f_penalized = f'{f} + {penalty} {barrier}' #Se agrega la función de penalidad y de barrera a la función objetivo
sol = barrera(f_penalized, x0, h, mu_, lamda, barrier)
print(f"la sol es: {sol} y el mínimo sería: {eval_function(sympify(f), sol)}")

'''
ejercicios del taller y sus puntos:

a)
minimice (x1-2)**4 + (x1-2*x2)**2
sujeto a x1**2 - x2 <= 0
punto inicial = [1,2]
sol = [0.94416989, 0.89145678]
min = 1.94621920079438

b)
minimice 100*(x2-x1**2)**2 + (1-x1)**2
sujeto a -3*x1 - 2*x2 + 12 <= 0, -2*x1 - x2 + 8 <= 0
punto inicial = [1,6]
sol = [2,4]
min = 1

c)
minimice 100*(x2-x1**2)**2 + (1-x1)**2
sujeto a 3*x1 + 2*x2 - 12 <= 0, 2*x1 + x2 - 8 <= 0
punto inicial = [-1,-1]
sol = [1,1]
min = 0
'''