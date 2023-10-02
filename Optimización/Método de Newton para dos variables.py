import sympy as sp
import numpy as np
from sympy import *
from math import sqrt

def function():
    f = input("Ingrese la función: ")
    return f

def function_derivate(f, var, times):
    derivate = sp.diff(f, var, times)
    return derivate

def eval_function(f, point):
    result = f.evalf(subs={x: point[0], y: point[1]})
    return result

def newton(f, x1, gradient, hessian, h):
    gradient_x1 = np.array([eval_function(gradient[0], x1), eval_function(gradient[1], x1)])
    gradient_x1 = gradient_x1.astype(float)
    if(np.linalg.norm(gradient_x1) < h):
        f_x1 = eval_function(f, x1)
        print(f"La solución se encuentra en ({x1[0]},{x1[1]}) y el mínimo es {f_x1}")
        return None
    else:
        hessian_x1 = np.array([[eval_function(hessian[0][0], x1), eval_function(hessian[0][1], x1)],
                                [eval_function(hessian[1][0], x1), eval_function(hessian[1][1], x1)]])
        try:
            hessian_x1 = hessian_x1.astype(float)
            inv_hessian_x1 = np.linalg.inv(hessian_x1)
        except:
            print(f"La matriz no es invertible, por tanto no podemos hallar el mínimo")
            return None
        xk = x1 - (np.dot(inv_hessian_x1, gradient_x1))
        xk_minus_x1 = xk - x1
        xk_minus_x1 = xk_minus_x1.astype(float)
        if(np.linalg.norm(xk_minus_x1) < h):
            f_xk = eval_function(f, xk)
            print(f"La solución se encuentra en ({xk[0]},{xk[1]}), y el mínimo es {f_xk}")
            return None
        else:
            newton(f, xk, gradient, hessian, h)
            
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
    partial_diff_x_2 = function_derivate(f, x, 2)
    partial_diff_y_2 = function_derivate(f, y, 2)
    partial_diff_x_y = function_derivate(f, x, y)
    gradient = np.array([partial_diff_x, partial_diff_y])
    hessian = np.array([[partial_diff_x_2, partial_diff_x_y],
                        [partial_diff_x_y, partial_diff_y_2]])
    newton(f, x1, gradient, hessian, h)
else:
    print("Error: h debe ser mayor que 0")
