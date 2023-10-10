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

def newtonCG(f, x1, gradient, hessian, h):
    try:
        gradient_x1 = evaluated_gradient(gradient, x1)
        gradient_x1 = gradient_x1.astype(float)
        if(np.linalg.norm(gradient_x1) < h): #Si la norma del gradiente es menor que la tolerancia
            f_x1 = eval_function(f, x1)
            print(f"La solución se encuentra en {tuple(x1)} y el mínimo es {f_x1}")
            return None
        else:
            g1 = np.transpose(gradient_x1)
            d1 = -1*g1
            G = [g1]
            D = [d1]
            X_ = [x1]
            i = 0
            while i <= dimentions:
                #a) Calcular xk+1
                hessian_xk = evaluated_hessian(hessian, X_[i])
                lk = np.dot(-1*np.transpose(G[i]), D[i])/np.dot(np.dot(np.transpose(D[i]), hessian_xk), D[i])
                x_k1 = X_[i] + lk*D[i]
                X_.append(x_k1)

                #b) Calcular gk+1
                gradient_xk1 = evaluated_gradient(gradient, X_[i+1])
                g_k1 = np.transpose(gradient_xk1)
                G.append(g_k1)

                #c) Calcular dk+1
                if(i<dimentions):
                    b_k = np.dot(np.dot(np.transpose(G[i]), hessian_xk), D[i])/np.dot(np.dot(np.transpose(D[i]), hessian_xk), D[i])
                    d_k1 = -1*G[i+1] + b_k*D[i]
                    D.append(d_k1)

                i+=1
            newtonCG(f, X_[dimentions], gradient, hessian, h)
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
    newtonCG(f, x1, gradient(f), hessian(f), h)
else:
    print("Error: h debe ser mayor que 0")
