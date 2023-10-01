import sympy as sp
from sympy import *
from math import sqrt

def function():
    f = input("Ingrese la función: ")
    return f

def eval_function(f, x_num: float):
    result = f.evalf(subs={x: x_num})
    return result

def cuasiconvexidad(f:str, x1:int, x2:int):
    l = 0
    m = max(eval_function(f, x1), eval_function(f, x2))
    while l <= 1:
        segment = (1-l)*x1+l*x2
        fl = eval_function(f, segment)
        if(fl > m):
            print(f"para lambda = {l}, f((1-lambda)*x1 + lambda*x2) = {fl} es mayor que el max(f(x1),f(x2)) = {m}")
            return False
        l = l + 0.001
    return True

alpha = (sqrt(5) - 1) / 2

def golden_section_search(a:float, b:float, h:float, f:str, i:int):
    if b-a < h:  #Si el intervalo es menor que la longitud final de incertidumbre, se para la busqueda
        m = ((a+b)/2, eval_function(f, (a+b)/2))  #Se toma el punto intermedio del intervalo como el minimo
        print(f"el minimo se encuentra en: {m}, y se realizaron {i} iteraciones")
        return None
    
    d = b - a  #Se calcula la longitud del intervalo
    l = a + (1 - alpha) * d  #Se calcula el punto lambda
    u = a + (alpha * d)  #Se calcula el punto mu
    fl = eval_function(f, l)  #Se evalua la funcion en el punto lambda
    fu =eval_function(f, u)  #Se evalua la funcion en el punto mu 
    if fl >= fu:  #Si el valor de la funcion en lambda es mayor que el valor de la funcion en mu, se toma el intervalo [l, b]
        golden_section_search(l, b, h, f, i+1)
    if fu > fl:  #Si el valor de la funcion en mu es menor que el valor de la funcion en lambda, se toma el intervalo [a, u]
        golden_section_search(a, u, h, f, i+1)

#Prueba
a = float(input("ingrese el limite inferior: "))
b = float(input("ingrese el limite superior: "))
h = float(input("ingrese la tolerancia: "))
x = sp.Symbol("x")
f = sp.sympify(function())
if (a < b and h > 0 and cuasiconvexidad(f, a, b)): 
    golden_section_search(a, b, h, f, 0)
else:
    print("Error: a debe ser menor que b, h debe ser mayor que 0 y la función debe ser cuasiconvexa estricta en el intervalo dado")