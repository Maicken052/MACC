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

def newtonCG(f, x1, gradient, hessian, h):
    try:
        gradient_x1 = np.array([eval_function(gradient[0], x1), eval_function(gradient[1], x1)])
        gradient_x1 = gradient_x1.astype(float)
        if(np.linalg.norm(gradient_x1) < h): #Si la norma del gradiente es menor que la tolerancia
            f_x1 = eval_function(f, x1)
            print(f"La solución se encuentra en ({x1[0]},{x1[1]}) y el mínimo es {f_x1}")
            return None
        else:
            g1 = np.transpose(gradient_x1)
            d1 = -1*g1
            G = [g1]
            D = [d1]
            X = [x1]
            i = 0
            while i <= 2:
                #a) Calcular xk+1
                hessian_xk = np.array([[eval_function(hessian[0][0], X[i]), eval_function(hessian[0][1], X[i])],
                                    [eval_function(hessian[1][0], X[i]), eval_function(hessian[1][1], X[i])]])
                lk = np.dot(-1*np.transpose(G[i]), D[i])/np.dot(np.dot(np.transpose(D[i]), hessian_xk), D[i])
                x_k1 = X[i] + lk*D[i]
                X.append(x_k1)

                #b) Calcular gk+1
                gradient_xk1 = np.array([eval_function(gradient[0], X[i+1]), eval_function(gradient[1], X[i+1])])
                g_k1 = np.transpose(gradient_xk1)
                G.append(g_k1)

                #c) Calcular dk+1
                if(i<3):
                    b_k = np.dot(np.dot(np.transpose(G[i]), hessian_xk), D[i])/np.dot(np.dot(np.transpose(D[i]), hessian_xk), D[i])
                    d_k1 = -1*G[i+1] + b_k*D[i]
                    D.append(d_k1)
                i+=1
            newtonCG(f, X[3], gradient, hessian, h)
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
    partial_diff_x_2 = function_derivate(f, x, 2)
    partial_diff_y_2 = function_derivate(f, y, 2)
    partial_diff_x_y = function_derivate(f, x, y)
    gradient = np.array([partial_diff_x, partial_diff_y])
    hessian = np.array([[partial_diff_x_2, partial_diff_x_y],
                        [partial_diff_x_y, partial_diff_y_2]])
    newtonCG(f, x1, gradient, hessian, h)
else:
    print("Error: h debe ser mayor que 0")
