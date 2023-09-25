from math import *

def function():
    f = input("Ingrese la función: ")
    return f

def eval_function(f:str, x:float):
    abc = "abcdefghijklmnñopqrstuvwxyz"
    flist = list(f)
    try:
        for i in range(len(f)-1):
            if f[i] == "x":
                if i == 0:
                    if f[i+1] not in abc:
                        flist[i] = str(x)
                if i == len(f)-1:
                    if f[i-1] not in abc:
                        flist[i] = str(x)
                else:
                    if f[i-1] not in abc and f[i+1] not in abc:
                        flist[i] = str(x)
        f = "".join(flist)
        return eval(f)
    except Exception as e:
        return f"Error al evaluar la función: {e}"

def cuasiconvexidad(f:str, x1:int, x2:int):
    l = 0
    m = max(eval_function(f, x1), eval_function(f, x2))
    while l <= 1:
        segment = (1-l)*x1+l*x2
        fl = eval_function(f, segment)
        if(fl > m):
            print(f"el punto ({segment},{eval_function(f, segment)}) es mayor que {m}")
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
k = 0
f = function()

if (a < b and h > 0 and cuasiconvexidad(f, a, b)): 
    fibonacci_search(a, b, h, e, n, k, f)
else:
    print("Error: a debe ser menor que b, h debe ser mayor que 0 y la función debe ser cuasiconvexa estricta en el intervalo dado")
