a)
import sympy as sp

x, y, z = sp.var('x, y, z')
lamda, mu = sp.symbols('lamda, mu')

f = y*sp.exp(x - z)
h = 9*x*2 + 4*y2 + 36*z*2 - 36  
g = x*y + y*z - 1 

L = f - lamda*h - mu*g
gradL = [sp.diff(L, var) for var in [x, y, z]]
eqs = gradL + [h] + [g]

sol = sp.solve(eqs, [x, y, z, lamda, mu], dict=True)

print("la solución es:")
print(sol)
print("")
print("y la función evaluada en los puntos extremos da:")
print([f.subs(p) for p in sol])

b)
import sympy as sp

x, y, z = sp.var('x, y, z')
lamda, mu = sp.symbols('lamda, mu')

f = x + y + z
h = x*2 - y*2 - z 
g = x*2 + z*2 - 4 

L = f - lamda*h - mu*g
gradL = [sp.diff(L, var) for var in [x, y, z]]
eqs = gradL + [h] + [g]

sol = sp.solve(eqs, [x, y, z, lamda, mu], dict=True)

print("la solución es:")
print(sol)
print("")
print("y la función evaluada en los puntos extremos da:")
print([f.subs(p) for p in sol])

c)
import sympy as sp

x, y, z, s1, s2 = sp.var('x, y, z, s1, s2')
lamda, mu = sp.symbols('lamda, mu')

f = 100*(y - x*2)2 + (1 - x)*2
h = 3*x + 2*y - 12 - s1**2 
g = 2*x + y - 8 - s2**2 

L = f - lamda*h - mu*g
gradL = [sp.diff(L, var) for var in [x, y, s1, s2]]
eqs = gradL + [h] + [g]

sol = sp.solve(eqs, [x, y, s1, s2, lamda, mu], dict=True)

print("la solución es:")
print(sol)
print("")
print("y la función evaluada en los puntos extremos da:")
print([f.subs(p) for p in sol])

d)
import sympy as sp

x, y, z, s1, s2 = sp.var('x, y, z, s1, s2')
lamda, mu = sp.symbols('lamda, mu')

f = 100*(y - x*2)2 + (1 - x)*2
h = 3*x + 2*y - 12 + s1**2 
g = 2*x + y - 8 + s2**2 

L = f - lamda*h - mu*g
gradL = [sp.diff(L, var) for var in [x, y, s1, s2]]
eqs = gradL + [h] + [g]

sol = sp.solve(eqs, [x, y, s1, s2, lamda, mu], dict=True)

print("la solución es:")
print(sol)
print("")
print("y la función evaluada en los puntos extremos da:")
print([f.subs(p) for p in sol])
