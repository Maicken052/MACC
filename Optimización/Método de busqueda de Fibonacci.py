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
            print(f"para lambda = {l}, f(f((1-lambda)*x1 + lambda*x2)) = {fl} es mayor que el max(f(x1),f(x2)) = {m}")
            return False
        l = l + 0.001
    return True

def fibonacci(n:float):
    if n <= 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fibonacci(n-1) + fibonacci(n-2)

def hallar_n(a:float, b:float, h:float):
    n = 1
    while fibonacci(n) < (b-a)/h:
        n = n + 1
    return n 

def fibonacci_search(a:float, b:float, h:float, e:float, n:float, k:float, f:str):
    d = b - a  #Se calcula la longitud del intervalo
    fib = fibonacci(n-k-1)/(fibonacci(n-k))  #Se calcula el valor de fibonacci
    l = a + (1 - fib) * d  #Se calcula el punto lambda
    u = a + (fib * d)  #Se calcula el punto mu
    if k == n-2:  #Condición de finalización
        u = l + e
        fl = eval_function(f, l) 
        fu =eval_function(f, u)
        if fl > fu:
            a = l
        if fu > fl:
            b = u
        m = ((a+b)/2, eval_function(f, (a+b)/2))  #Se toma el punto intermedio del intervalo como el minimo
        print(f"el minimo se encuentra en: {m}")
        return None
    else:   
        fl = eval_function(f, l)  #Se evalua la funcion en el punto lambda
        fu = eval_function(f, u)  #Se evalua la funcion en el punto mu
        k = k + 1
        if fl >= fu:  #Si el valor de la funcion en lambda es mayor que el valor de la funcion en mu, se toma el intervalo [l, b]
            fibonacci_search(l, b, h, e, n, k, f)
        if fu > fl:  #Si el valor de la funcion en mu es menor que el valor de la funcion en lambda, se toma el intervalo [a, u]
            fibonacci_search(a, u, h, e, n, k, f)
    

#Prueba
a = float(input("ingrese el limite inferior: "))
b = float(input("ingrese el limite superior: "))
h = float(input("ingrese la tolerancia: "))
e = h/10
n = hallar_n(a, b, h)
x = sp.Symbol("x")
f = sp.sympify(function())
if (a < b and h > 0 and cuasiconvexidad(f, a, b)): 
    sol1 = fibonacci_search(a, b, h, e, n, 0, f)
else:
    print("Error: a debe ser menor que b, h debe ser mayor que 0 y la función debe ser cuasiconvexa estricta en el intervalo dado")

a = float(input("ingrese el limite inferior: "))
b = float(input("ingrese el limite superior: "))
h = float(input("ingrese la tolerancia: "))
e = h/10
n = hallar_n(a, b, h)
x = sp.Symbol("x")
f = sp.sympify(function())
if (a < b and h > 0 and cuasiconvexidad(f, a, b)): 
    sol2 = fibonacci_search(a, b, h, e, n, 0, f)
else:
    print("Error: a debe ser menor que b, h debe ser mayor que 0 y la función debe ser cuasiconvexa estricta en el intervalo dado")

if(sol1[1] < sol2[1]):
    print(f"El minimo se encuentra en: {sol1}")
else:
    print(f"El minimo se encuentra en: {sol2}")