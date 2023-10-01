import sympy as sp
from sympy import *

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
        if(f_b < f_a):
            return False
    return True

def biseccion(a, b, h, f, f_diff, k):
    if b - a < h:
        m = ((a+b)/2, eval_function(f, (a+b)/2))
        print(f"El minimo se encuentra en: {m}")
        return None
    else:
        lambda_ = (a+b)/2
        lambaDiff = eval_function(f_diff, lambda_)
        if lambaDiff == 0:
            m = (lambda_, eval_function(f, lambda_))
            print(f"El minimo se encuentra en: {m}")
            return None
        elif(lambaDiff > 0):
            b = lambda_
            biseccion(a, b, h, f, f_diff, k+1)
        elif(lambaDiff < 0):
            a = lambda_
            biseccion(a, b, h, f, f_diff, k+1)

#Prueba
a = float(input("ingrese el limite inferior: "))
b = float(input("ingrese el limite superior: "))
h = float(input("ingrese la tolerancia: "))
x = sp.Symbol("x")
f = sp.sympify(function())
f_diff = function_derivate(f)
if (a < b and h > 0 and pseudoconvexidad(f, f_diff, a, b)):
    biseccion(a, b, h, f, f_diff, 1)
else:
    print("Error: a debe ser menor que b, h debe ser mayor que 0 y la función debe ser pseudoconvexa estricta en el intervalo dado")