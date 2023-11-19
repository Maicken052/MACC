import numpy as np
from scipy.optimize import minimize

#d)
def f(x):
    return ((x[0]-2.628)/0.146)*100000+((20-x[1])/2)*100000+((x[2]-2.628)/0.146)*100000+((20-x[3])/2)*100000+((x[4]-2.628)/0.146)*100000+((20-x[5])/2)*100000+(x[6]-4.6)*100000

bounds_x1 = (2.628, 2.92)
bounds_x2 = (16, 20)
bounds_x3 = (2.628, 2.92)
bounds_x4 = (16, 20)
bounds_x5 = (2.628, 2.92)
bounds_x6 = (16, 20)
bounds_x7 = (0, 4,6)

bounds = [bounds_x1, bounds_x2, bounds_x3, bounds_x4, bounds_x5, bounds_x6, bounds_x7]
x0 = np.array([2.7,17,2.7,17,2.7,17,0])
sol = minimize(f,x0, bounds=bounds, method="Nelder-Mead")
print(sol.x)
