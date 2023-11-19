import numpy as np
from scipy.optimize import minimize
from math import exp

#a)
def f(x):
    return x[1]*exp(x[0]-x[2])

def restriccion1(x):
    return x[0]*x[1] + x[1]*x[2] - 1

def restriccion2(x):
    return -9*x[0]**2 - 4*x[1]**2 - 36*x[2]**2 + 36

rest1 = {"type":"eq", "fun":restriccion1}
rest2 = {"type":"ineq", "fun":restriccion2}
rest = [rest1, rest2]
x0 = np.array([1,1,0])
sol = minimize(f,x0,constraints=rest, method="trust-constr")
print(sol.x)

