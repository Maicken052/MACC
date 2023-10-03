import sympy as sp
from sympy import *
from math import sqrt

def function():
    f = input("Ingrese la función: ")
    return f

def function_derivate(f):
    derivate = sp.diff(f, x)
    return derivate

def eval_function(f, x_num):
    result = f.evalf(subs={x: x_num})
    return result

def pseudoconvexidad(f, f_diff, a, b):
    aDiff = eval_function(f_diff, a)
    expr = aDiff*(b-a)
    if(expr >= 0):
        f_a = eval_function(f, a)
        f_b = eval_function(f, b)
        if(f_b < f_a): #Si f(b) < f(a), la función no es pseudoconvexa 
            return False
    return True  #Si la expresión no es mayor o igual a 0, por vacuidad se retorna True

def biseccion(f, f_diff, a, b, h):
    if b - a < h: #Condición de finalización
        m = ((a+b)/2, eval_function(f, (a+b)/2))
        print(f"El minimo se encuentra en: {m}")
        return None
    else:
        lambda_ = (a+b)/2
        lambaDiff = eval_function(f_diff, lambda_)
        if lambaDiff == 0: #Si la derivada en lambda es igual a 0, se toma lambda como el minimo
            m = (lambda_, eval_function(f, lambda_))
            print(f"El minimo se encuentra en: {m}")
            return None
        elif(lambaDiff > 0): #Si la derivada en lambda es mayor que 0, se toma el intervalo [a, lambda]
            biseccion(f, f_diff, a, lambda_, h)
        elif(lambaDiff < 0): #Si la derivada en lambda es menor que 0, se toma el intervalo [lambda, b]
            biseccion(f, f_diff, lambda_, b, h)

#Prueba
a = float(input("ingrese el limite inferior: "))
b = float(input("ingrese el limite superior: "))
h = float(input("ingrese la tolerancia: "))
x = sp.Symbol("x")
f = sp.sympify(function())
f_diff = function_derivate(f)
if (h > 0 and pseudoconvexidad(f, f_diff, a, b)):
    biseccion(f, f_diff, a, b, h)
else:
    print("Error: h debe ser mayor que 0 y la función debe ser pseudoconvexa estricta en el intervalo dado")