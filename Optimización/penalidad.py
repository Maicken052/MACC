import numpy as np
from sympy import *
from scipy.optimize import minimize

def eval_function(f, point):
    sub = {}
    for i in range(len(point)):
        sub[x[i]] = point[i]
    result = f.evalf(subs=sub)
    return result

def penalidad(f, x0, tol, mu, penalty):
    #Se reemplaza el mu que corresponda en la función de penalidad
    f_ = f.replace('mu', f'{mu}') 
    penalty_ = penalty.replace('mu', f'{mu}')

    #Se convierten las funciones de su forma string a expresiones
    fun = sympify(f_)
    pen = sympify(penalty_)

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
        return penalidad(f, x1, tol, mu, penalty)

#prueba
mu_ = 0.1  #Valor inicial de mu
initial_point = [0,0,0] 
h = 0.000005 
f = 'x1+x2+x3' 
eqrest = ['x1**2+x2**2-x3']  #Restricciones de igualdad
ineqrest = ['x1**2+x3**2-4'] #Restricciones de desigualdad

x0 = np.array(initial_point)
dimentions = len(initial_point)+1
x = symbols(f"x1:{dimentions}")
penalty = '' #Función de penalidad

for i in range(len(eqrest)): #Se agregan las restricciones de igualdad a la función de penalidad
        if penalty != '':
            penalty = f'{penalty} + mu*({eqrest[i]})**2' #Si ya hay restricciones de igualdad, se suman las siguientes
        else:
            penalty = f'mu*({eqrest[i]})**2' #Si aún no hay restricciones, se agrega la primera

for i in range(len(ineqrest)): #Se agregan las restricciones de desigualdad a la función de penalidad
    if penalty != '':
        penalty = f'{penalty} + mu*max(0,{ineqrest[i]})**2' #Si ya hay restricciones de desigualdad, se suman las siguientes
    else:
        penalty = f'mu*max(0,{ineqrest[i]})**2' #Si aún no hay restricciones, se agrega la primera

f_penalized = f'{f} + {penalty}' #Se agrega la función objetivo a la función de penalidad
sol = penalidad(f_penalized, x0, h, mu_, penalty)
print(f"la sol es: {sol} y el mínimo sería: {eval_function(sympify(f), sol)}")

'''
ejercicios del taller y sus puntos:

a)
minimice x1**2 + 2*x2**2 + 3*x3**2 - 4*x2*x3 - 4*x1 - 2*x2
sujeto a x1 + x2 + x3 - 10 = 0
punto inicial = [8,1,1]
sol = [3,4,3]
min = 0

b)
minimice 100*(x2-x1**2)**2 + (1-x1)**2
sujeto a -3*x1 - 2*x2 + 12 <= 0, -2*x1 - x2 + 8 <= 0
punto inicial = [1,6]
sol = [2,4]
min = 1

c)
minimice 100*(x2-x1**2)**2 + (1-x1)**2
sujeto a 3*x1 + 2*x2 - 12 <= 0, 2*x1 + x2 - 8 <= 0
punto inicial = [0,0]
sol = [1,1]
min = 0
'''