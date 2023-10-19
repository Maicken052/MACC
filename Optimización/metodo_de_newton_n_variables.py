import sympy as sp
import numpy as np
from sympy import *
from math import sqrt
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

def hessian(f):
    hessian = []
    for x in X:
        row = []
        for y in X:
            row.append(function_derivate(f, x, y))
        hessian.append(row)
    return np.array(hessian)
    
def evaluated_gradient(gradient, point):
    gradient_point = np.array([])
    for i in range(len(point)):
        gradient_point = np.append(gradient_point, eval_function(gradient[i], point))
    return gradient_point

def evaluated_hessian(hessian, point):
    hessian_point = []
    for i in range(len(point)):
        row = []
        for j in range(len(point)):
            row.append(eval_function(hessian[i][j], point))
        hessian_point.append(row)
    return np.array(hessian_point)

def newton(f, x1, gradient, hessian, h):
    gradient_x1 = evaluated_gradient(gradient, x1)
    gradient_x1 = gradient_x1.astype(float)
    if(np.linalg.norm(gradient_x1) < h): #Si la norma del gradiente es menor que la tolerancia
        f_x1 = eval_function(f, x1)
        print(f"La solución se encuentra en {tuple(x1)} y el mínimo es {f_x1}")
        return None
    else:
        hessian_x1 = evaluated_hessian(hessian, x1)
        hessian_x1 = hessian_x1.astype(float)
        try:
            inv_hessian_x1 = np.linalg.inv(hessian_x1)
        except:
            print(f"La matriz no es invertible, por tanto no podemos hallar el mínimo")
            return None
        xk = x1 - (np.dot(inv_hessian_x1, gradient_x1))
        xk_minus_x1 = xk - x1
        xk_minus_x1 = xk_minus_x1.astype(float)
        if(np.linalg.norm(xk_minus_x1) < h):
            f_xk = eval_function(f, xk)
            print(f"La solución se encuentra en{tuple(xk)}, y el mínimo es {f_xk}")
            return None
        else:
            newton(f, xk, gradient, hessian, h)
            
#Prueba
initial_point = list(literal_eval(input("ingrese el punto inicial : ")))
x1 = np.array(initial_point)
dimentions = len(initial_point)+1
h = float(input("ingrese la tolerancia: "))
X = sp.symbols(f"x1:{dimentions}")
f = sp.sympify(function())
if (h > 0):
    newton(f, x1, gradient(f), hessian(f), h)
else:
    print("Error: h debe ser mayor que 0")
