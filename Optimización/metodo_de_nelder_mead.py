import sympy as sp
import numpy as np
from sympy import *
from math import sqrt
from ast import literal_eval
import warnings
warnings.filterwarnings("error")

def function():
    f = input("Ingrese la función: ")
    return f

def eval_function(f, point):
    sub = {}
    for i in range(len(point)):
        sub[X[i]] = point[i]
    result = f.evalf(subs=sub)
    return result

def remove_(X, r):
    removed = r
    X_new = []
    flag = False
    for i in X:
        if not flag:
            if not np.array_equal(i, removed):
                X_new.append(i)
            else:
                flag = True #Si ya se removió el punto, entonces se agrega el resto de puntos
        else:
            X_new.append(i)
    return X_new

def change_xh(X_, Xh, xi, f_xi):
    X_ = remove_(X_, Xh)
    Xh = np.array([])
    for i in range(dimentions-1):
        Xh = np.append(Xh, xi[i])
    Xh = np.append(Xh, f_xi)
    X_.append(Xh)
    return X_

def nelder_y_mead(f, X_, h):
    try:
        #Paso 1. Ordenar: Ordenamos los vectores de mayor a menor según su última coordenada f(xi)
        f_points = [] 
        for i in range(dimentions):
            f_xi = X_[i][-1]
            f_points.append(f_xi)

        #ordenamos los f(xi)
        f_points.sort(reverse=True) #Ordenamos de mayor a menor
        f_xh = f_points[0]
        f_xg = f_points[1]
        f_xl = f_points[-1]

        #Obtenemos los puntos correspondientes a f_xh, f_xg y f_xl
        for x in X_:
            if x[-1] == f_xh:
                Xh = x
                X_ = remove_(X_, Xh)
                break
        
        for x in X_:
            if x[-1] == f_xg:
                Xg = x
                X_ = remove_(X_, Xg)
                break

        for x in X_:
            if x[-1] == f_xl:
                Xl = x
                break
        
        X_.append(Xh)
        X_.append(Xg)

        #Calculamos el promedio de f(xi)
        prom_f = 0
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
            print(f"La solución se encuentra en {tuple(Xl[0:dimentions-1])}, y el mínimo es {f_xl}")
            return None
        
        #Paso 2. Reflejar: Calculamos el centroide y el punto de reflexión
        xh = Xh[0:dimentions-1]
        xg = Xg[0:dimentions-1]
        xl = Xl[0:dimentions-1]
        xc = (1/(len(f_points)-1))*(xg + xl)
        xr = (1+alpha)*xc - alpha*xh
        f_xr = eval_function(f, xr)

        if f_xl <= f_xr < f_xg: #Caso 1
            X_ = change_xh(X_, Xh, xr, f_xr)
            nelder_y_mead(f, X_, h, )

        elif f_xr < f_xl: #Caso 2 (Paso 3. Expandir)
            xe = (1+(alpha*gamma))*xc - (alpha*gamma)*xh
            f_xe = eval_function(f, xe)
            if f_xe < f_xr:
                X_ = change_xh(X_, Xh, xe, f_xe)
                nelder_y_mead(f, X_, h)
            elif f_xe >= f_xr:
                X_ = change_xh(X_, Xh, xr, f_xr)
                nelder_y_mead(f, X_, h)
        elif f_xr >= f_xg: #Caso 3 (Paso 4. Contraer)
            #Contracción externa
            if f_xg <= f_xr < f_xh:
                xce = (1+(alpha*beta))*xc - (alpha*beta)*xh
                f_xce = eval_function(f, xce)
                if f_xce <= f_xr:
                    X_ = change_xh(X_, Xh, xce, f_xce)
                    nelder_y_mead(f, X_, h)
                elif f_xce > f_xr:
                    paso5(X_, xl, h)
            #Contracción interna
            if f_xr >= f_xh:
                xci = (1-beta)*xc + beta*xh
                f_xci = eval_function(f, xci)
                if f_xci < f_xh:
                    X_ = change_xh(X_, Xh, xci, f_xci)
                    nelder_y_mead(f, X_, h)
                elif f_xci >= f_xh:
                    paso5(X_, xl, h)
    except:
        print(f"La función no tiene valor mínimo o no fue posible encontrarlo")

def paso5(X_, xl, h):
    Y = []
    #Paso 5. Encoger
    for i in range(dimentions):
        Yi = np.array([])
        yi = xl + delta*(X_[i][0:dimentions-1] - xl)
        f_yi = eval_function(f, yi)
        for j in range(dimentions-1):
            Yi = np.append(Yi, yi[j])
        Yi = np.append(Yi, f_yi)
        Y.append(Yi)
    nelder_y_mead(f, Y, h)

#Prueba
initial_point = list(literal_eval(input("ingrese el punto inicial : ")))
x1 = np.array(initial_point)
dimentions = len(initial_point)+1
h = float(input("ingrese la tolerancia: "))
X = sp.symbols(f"x1:{dimentions}")
f = sp.sympify(function())

if (h > 0):
    #Definimos los parámetros
    alpha = 1
    gamma = 2
    delta = 0.5
    beta = 0.5

    #obtenemos los puntos cercanos a x1
    closest_points = [x1]
    e = np.array([])
    for i in range(dimentions-1):
        e = np.append(e, 0)

    for i in range(dimentions-1):
        e[i] = 1
        x_ = x1 + delta*e
        e[i] = 0
        closest_points.append(x_)

    #Creamos los vectores de los puntos (coordenada en Rn)
    X_ = []
    for i in range(dimentions):
        Xi = np.array([])
        for j in range(dimentions-1):
            Xi = np.append(Xi, closest_points[i][j])
        f_xi = eval_function(f, closest_points[i])
        Xi = np.append(Xi, f_xi)
        X_.append(Xi)

    #Inicializamos el método
    nelder_y_mead(f, X_, h)
else:
    print("Error: h debe ser mayor que 0")