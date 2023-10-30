import sympy as sp
from sympy import *

def function_derivate(f, var, times):
    derivate = sp.diff(f, var, times)
    return derivate

def eval_function(f, x1_, x2_):
    result = f.evalf(subs={x1:x1_, x2:x2_})
    return result

x1, x2, s1, s2, m1, m2 = sp.symbols("x1 x2 s1 s2 m1 m2")
f = 2*x1**2+2*x1*x2*x2**2-10*x1-10*x2
g = x1**2+2*x2**2+s1**2-5
h = 3*x1+x2+s2**2-6

ec1 = Eq(diff(f,x1,1)-m1*diff(g,x1,1)+m2*diff(h,x1,1), 0)
ec2 = Eq(diff(f,x2,1)-m1*diff(g,x2,1)+m2*diff(h,x2,1), 0)
ec3 = Eq(diff(f,s1,1)-m1*diff(g,s1,1)+m2*diff(h,s1,1), 0)
ec4 = Eq(diff(f,s2,1)-m1*diff(g,s2,1)+m2*diff(h,s2,1), 0)
ec5 = Eq(g, 0)
ec6 = Eq(h, 0)

sol = solve((ec1, ec2, ec3, ec4, ec5, ec6), x1, x2, s1, s2, m1, m2)
print("la solución es")
display(sol)
