import sympy as sp
from sympy import sin, cos, log, sqrt, ln, exp

def function():
    f = input("Ingrese la función: ")
    return f

def function_derivate(f):
    derivate = sp.diff(f, x)
    return derivate

def eval_function(f, x_num: float):
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

def biseccion(a, b, h, f, f_diff):
    if b - a < h:
        x = (a+b)/2
        y = eval_function(f, x)
        print(f"El minimo se encuentra en: ({x},{y})")
        return None
    else:
        lambda_ = (a+b)/2
        lambaDiff = eval_function(f_diff, lambda_)
        if lambaDiff == 0:
            y: eval_function(f, lambda_)
            return (f"El minimo se encuentra en: ({lambda_},{y})")
        elif(lambaDiff > 0):
            b = lambda_
            biseccion(a, b, h, f, f_diff)
        elif(lambaDiff < 0):
            a = lambda_
            biseccion(a, b, h, f, f_diff)

#Prueba
a = float(input("ingrese el limite inferior: "))
b = float(input("ingrese el limite superior: "))
h = float(input("ingrese la tolerancia: "))
x = sp.Symbol("x")
f = sp.sympify(function())
f_diff = function_derivate(f)
if (a < b and h > 0 and pseudoconvexidad(f, f_diff, a, b)): 
    biseccion(a, b, h, f, f_diff)
else:
    print("Error: a debe ser menor que b, h debe ser mayor que 0 y la función debe ser pseudoconvexa estricta en el intervalo dado")