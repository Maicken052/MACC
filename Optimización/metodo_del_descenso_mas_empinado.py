import sympy as sp
import numpy as np
from sympy import *
from math import sqrt
import scipy.optimize as optimize

def function():
    f = input("Ingrese la función: ")
    return f

def function_derivate(f, var, times):
    derivate = sp.diff(f, var, times)
    return derivate

def eval_function(f, point):
    result = f.evalf(subs={x: point[0], y: point[1]})
    return result

def descenso_mas_empinado(f, x1, gradient, h):
    try:
        gradient_x1 = np.array([eval_function(gradient[0], x1), eval_function(gradient[1], x1)])
        gradient_x1 = gradient_x1.astype(float)
        if(np.linalg.norm(gradient_x1) < h): #Si la norma del gradiente es menor que la tolerancia
            f_x1 = eval_function(f, x1)
            print(f"La solución se encuentra en ({x1[0]},{x1[1]}) y el mínimo es {f_x1}")
            return None
        else:
            dk = -1*gradient_x1
            def g(a): #Función auxiliar para minimizar
                return eval_function(f, x1+a*dk)
            res = optimize.minimize(g, 0, method='Nelder-Mead', bounds=[(0, None)]) #Método de Nelder-Mead para minimizar g
            lk = res.x[0]
            xk = x1 + lk*dk
            descenso_mas_empinado(f, xk, gradient, h)
    except:
        print("No se logró encontrar el mínimo, intente con otro punto inicial o con una tolerancia menor")
        return None

#Prueba
x_coord = float(input("ingrese la coordenada x del punto: "))
y_coord = float(input("ingrese la coordenada y del punto: "))
x1 = np.array([x_coord,y_coord])
h = float(input("ingrese la tolerancia: "))
x,y = sp.symbols("x y")
f = sp.sympify(function())

if (h > 0):
    partial_diff_x = function_derivate(f, x, 1)
    partial_diff_y = function_derivate(f, y, 1)
    gradient = np.array([partial_diff_x, partial_diff_y])
    descenso_mas_empinado(f, x1, gradient, h)
else:
    print("Error: h debe ser mayor que 0")
