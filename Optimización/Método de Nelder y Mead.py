import sympy as sp
import numpy as np
from sympy import *
from math import sqrt

def function():
    f = input("Ingrese la función: ")
    return f

def eval_function(f, point):
    result = f.evalf(subs={x: point[0], y: point[1]})
    return result

def remove_(X, r):
    removed = r
    X = [array for array in X if not np.array_equal(array, removed)]
    return X

def nelder_y_mead(f, X1, X2, X3, h):
    #Paso 1. Ordenar: Ordenamos los vectores de mayor a menor según su tercer coordenada f(xi)
    X = [X1, X2, X3]
    f_points = [X1[2], X2[2], X3[2]]
    
    f_xh = max(f_points)
    f_points.remove(f_xh)
    for x in X:
        if x[2] == f_xh:
            Xh = x
            X = remove_(X, x)
            break

    f_xl = min(f_points)
    f_points.remove(f_xl)
    for x in X:
        if x[2] == f_xl:
            Xl = x
            X = remove_(X, x)
            break

    f_xg = f_points[0]
    if len(X) == 0: #Si los tres puntos son iguales (Máxima recursión alcanzada)
        print(f"La solución se encuentra en ({Xl[0]},{Xl[1]}), y el mínimo es {Xl[2]}")
        return None
    else:
        Xg = X[0]

    #Calculamos el promedio de las terceras coordenadas f(xi)
    prom_f = 0
    f_points = [X1[2], X2[2], X3[2]]
    for f_i in f_points:      
        prom_f += f_i
    prom_f = prom_f/len(f_points)

    #Calculamos la varianza
    var = 0
    for f_i in f_points:
        var += (f_i - prom_f)**2
    var = var/len(f_points)

    #Si la varianza es menor que h, entonces el punto Xl es el mínimo
    if var < h:
        if(Xl[2] < 0.0000000000000000000000000000000000000000001):
            Xl[2] = 0
        print(f"La solución se encuentra en ({Xl[0]},{Xl[1]}), y el mínimo es {Xl[2]}")
        return None
    elif(var-h > 1000000000000000000000000000000000): #Si la varianza aumenta hacia un número muy grande, quiere decir que siempre hay un valor más pequeño, por lo que la función no tendría mínimo
        print("La función no tiene valor mínimo o no fue posible encontrarlo")
        return None

    #Paso 2. Reflejar: Calculamos el centroide y el punto de reflexión
    xh = Xh[0:2]
    xl = Xl[0:2]
    xg = Xg[0:2]
    xc = (1/(len(f_points)-1))*(xg + xl)
    xr = (1+alpha)*xc - alpha*xh
    f_xr = eval_function(f, xr)

    if f_xl <= f_xr < f_xg: #Caso 1
        Xh = np.array([xr[0], xr[1], f_xr])
        nelder_y_mead(f, Xh, Xg, Xl, h)

    elif f_xr < f_xl: #Caso 2 (Paso 3. Expandir)
        xe = (1+(alpha*gamma))*xc - (alpha*gamma)*xh
        f_xe = eval_function(f, xe)
        if f_xe < f_xr:
            Xh = np.array([xe[0], xe[1], f_xe])
            nelder_y_mead(f, Xh, Xg, Xl, h)
        elif f_xe >= f_xr:
            Xh = np.array([xr[0], xr[1], f_xr])
            nelder_y_mead(f, Xh, Xg, Xl, h)

    elif f_xr >= f_xg: #Caso 3 (Paso 4. Contraer)
        #Contracción externa
        if f_xg <= f_xr < f_xh:
            xce = (1+(alpha*beta))*xc - (alpha*beta)*xh
            f_xce = eval_function(f, xce)
            if f_xce <= f_xr:
                Xh = np.array([xce[0], xce[1], f_xce])
                nelder_y_mead(f, Xh, Xg, Xl, h)
            elif f_xce > f_xr:
                paso5(xh, xg, xl, h)
            
        #Contracción interna
        if f_xr >= f_xh:
            xci = (1-beta)*xc + beta*xh
            f_xci = eval_function(f, xci)
            if f_xci < f_xh:
                Xh = np.array([xci[0], xci[1], f_xci])
                nelder_y_mead(f, Xh, Xg, Xl, h)
            elif f_xci >= f_xh:
                paso5(xh, xg, xl, h)

def paso5(xh, xg, xl, h):
    #Paso 5. Encoger
    y1 = xl + delta*(xh - xl)
    y2 = xl + delta*(xg - xl)
    y3 = xl

    f_y1 = eval_function(f, y1)
    f_y2 = eval_function(f, y2)
    f_y3 = eval_function(f, y3)

    Y1 = np.array([y1[0], y1[1], f_y1])
    Y2 = np.array([y2[0], y2[1], f_y2])
    Y3 = np.array([y3[0], y3[1], f_y3])

    nelder_y_mead(f, Y1, Y2, Y3, h)

#Prueba
x_coord = float(input("ingrese la coordenada x del punto: "))
y_coord = float(input("ingrese la coordenada y del punto: "))
x1 = np.array([x_coord,y_coord])
h = float(input("ingrese la tolerancia: "))
x,y = sp.symbols("x y")
f = sp.sympify(function())

if (h > 0):
    #Definimos los parámetros
    alpha = 1
    gamma = 2
    delta = 0.5
    beta = 0.5

    #obtenemos los puntos cercanos a x1
    x2 = x1 + delta*np.array([1,0])
    x3 = x1 + delta*np.array([0,1])

    #Evaluamos los puntos en la función
    f_x1 = eval_function(f, x1)
    f_x2 = eval_function(f, x2)
    f_x3 = eval_function(f, x3)

    #Creamos los vectores de los puntos (coordenada en R3)
    X1 = np.array([x1[0], x1[1], f_x1])
    X2 = np.array([x2[0], x2[1], f_x2])
    X3 = np.array([x3[0], x3[1], f_x3])

    #Inicializamos el método
    nelder_y_mead(f, X1, X2, X3, h)
else:
    print("Error: h debe ser mayor que 0")
