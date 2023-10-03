import sympy as sp
from sympy import *
from math import sqrt

def function():
    f = input("Ingrese la función: ")
    return f

def function_derivate(f, times = 1):
    derivate = sp.diff(f, x, times)
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

def newton(f, f_diff, f_diff_2, a, h):
    if(abs(eval_function(f_diff, a)) < h):
        m = (a, eval_function(f, a))
        print(f"El minimo se encuentra en: {m}")
        return None
    else:
        a_k = a - eval_function(f_diff, a)/eval_function(f_diff_2, a)
        if(abs(a_k - a) < h):
            m = (a_k, eval_function(f, a_k))
            print(f"El minimo se encuentra en: {m}")
            return None
        else:
            newton(f, f_diff, f_diff_2, a_k, h)

#Prueba
a = float(input("ingrese el limite inferior: "))
b = float(input("ingrese el limite superior: "))
h = float(input("ingrese la tolerancia: "))
x = sp.Symbol("x")
f = sp.sympify(function())
f_diff = function_derivate(f)
f_diff_2 = function_derivate(f, 2)
if(h > 0 and pseudoconvexidad(f, f_diff, a, b)):
    newton(f, f_diff, f_diff_2, (a+b)/2, h)
else:
    print("Error: h debe ser mayor que 0 y la función debe ser pseudoconvexa estricta en el intervalo dado")