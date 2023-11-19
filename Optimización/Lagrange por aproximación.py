import numpy as np
from scipy.optimize import minimize

#a)
def f(x):
     return x[1]*np.exp(x[0]-x[2])
def restriccion1(x):
    return 9*x[0]**2+4*x[1]**2+36*x[2]**2-36

def restriccion2(x):
    return x[0]*x[1]+x[1]*x[2]-1
 
rest1 = {"type":"eq", "fun":restriccion1}
rest2 = {"type":"eq", "fun":restriccion2}
rest = [rest1, rest2]
x0 = np.array([1,1,1])
sol = minimize(f,x0,constraints=rest, method="trust-constr")
print(sol)

#b)
def f(x):
     return x[0]+x[1]+x[2]

def restriccion1(x):
    return x[0]**2-x[1]**2-x[2]

def restriccion2(x):
    return x[0]**2+x[2]**2-4
 
rest1 = {"type":"eq", "fun":restriccion1}
rest2 = {"type":"eq", "fun":restriccion2}
rest = [rest1, rest2]
x0 = np.array([0,0,0])
sol = minimize(f,x0,constraints=rest, method="trust-constr")
print(sol)


#c)
def f(x):
     return 100*(x[1]-x[0]**2)**2+(1-x[0])**2

def restriccion1(x):
    return 3*x[0]+2*x[1]-12

def restriccion2(x):
    return 2*x[0]+x[1]-8
 
rest1 = {"type":"ineq", "fun":restriccion1}
rest2 = {"type":"ineq", "fun":restriccion2}
rest = [rest1, rest2]
x0 = np.array([10,10])
sol = minimize(f,x0,constraints=rest, method="trust-constr")
print(sol)

#d)
def f(x):
     return 100*(x[1]-x[0]**2)**2+(1-x[0])**2

def restriccion1(x):
    return -3*x[0]-2*x[1]+12

def restriccion2(x):
    return -2*x[0]-x[1]+8
 
rest1 = {"type":"ineq", "fun":restriccion1}
rest2 = {"type":"ineq", "fun":restriccion2}
rest = [rest1, rest2]
x0 = np.array([0,0])
sol = minimize(f,x0,constraints=rest, method="trust-constr")
print(sol)
