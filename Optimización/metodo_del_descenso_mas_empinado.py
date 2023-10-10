import sympy as sp
import numpy as np
from sympy import *
from math import sqrt
from scipy.optimize import minimize
from ast import literal_eval

def function():
    f = input("Ingrese la función: ")
    return f

def function_derivate(f, var, times):
    derivate = sp.diff(f, var, times)
    return derivate

def eval_function(f, point):
    sub = {}
    for i in range(len(point)):
        sub[X[i]] = point[i]
    result = f.evalf(subs=sub)
    return result

def gradient(f):
    gradient = np.array([])
    for x in X:
        gradient = np.append(gradient, function_derivate(f, x, 1))
    return gradient

def evaluated_gradient(gradient, point):
    gradient_point = np.array([])
    for i in range(len(point)):
        gradient_point = np.append(gradient_point, eval_function(gradient[i], point))
    return gradient_point

def descenso_mas_empinado(f, x1, gradient, h):
    try:
        gradient_x1 = evaluated_gradient(gradient, x1)
        gradient_x1 = gradient_x1.astype(float)
        if(np.linalg.norm(gradient_x1) < h): #Si la norma del gradiente es menor que la tolerancia
            f_x1 = eval_function(f, x1)
            print(f"La solución se encuentra en {tuple(x1)} y el mínimo es {f_x1}")
            return None
        else:
            dk = -1*gradient_x1
            def g(a): #Función auxiliar para minimizar
                return eval_function(f, x1+a*dk)
            res = minimize(g, 0, method='Nelder-Mead', bounds=[(0, None)]) #Método de Nelder-Mead para minimizar g
            lk = res.x[0]
            xk = x1 + lk*dk
            descenso_mas_empinado(f, xk, gradient, h)
    except:
        print(f"No se logró encontrar el mínimo, intente con otro punto inicial o con una tolerancia menor")
        return None

#Prueba
initial_point = list(literal_eval(input("ingrese el punto inicial : ")))
x1 = np.array(initial_point)
dimentions = len(initial_point)+1
h = float(input("ingrese la tolerancia: "))
X = sp.symbols(f"x1:{dimentions}")
f = sp.sympify(function())
if (h > 0):
    descenso_mas_empinado(f, x1, gradient(f), h)
else:
    print("Error: h debe ser mayor que 0")
