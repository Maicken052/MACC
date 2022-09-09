#=============================================================================================================================================================
#                                                                        Modulos
#=============================================================================================================================================================
import tkinter as t
from tkinter import messagebox
from matplotlib.pyplot import *
from matplotlib.figure import Figure
from matplotlib import style
import matplotlib.animation as anim
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2Tk
import numpy as np
from math import*
import math
#=============================================================================================================================================================
#                                                           Caracteristicas de la ventana
#=============================================================================================================================================================
ventana=t.Tk()#crear ventana de tkinter
ventana.title("Fun Graphic")#titulo de la ventana
ventana.geometry("900x800")#tamaño de la ventana
style.use("fivethirtyeight")#agregar un estilo al contenedor
fg=Figure()#
ax=fg.add_subplot(111)#Achatar (Primer digito) 
cv=FigureCanvasTkAgg(fg, ventana)#crea contenedor donde va a estar la grafica
cv.draw()
cv.get_tk_widget().pack(side=t.TOP, fill=t.BOTH, expand=1)#expansión del contenedor

ventana.mainloop()