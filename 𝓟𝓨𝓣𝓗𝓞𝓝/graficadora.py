import tkinter as tk #tkinter es una biblioteca que nos sirve para cerar la interfaz
from tkinter import messagebox 
from matplotlib.pyplot import * #el .pyplot nos proporcionará una forma de graficar
from matplotlib.figure import Figure #propiedades de una figura
from matplotlib import style #mejorar la apariencia de la gráfica
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2Tk #el backend nos permitirá interactuar con la ventana y el navigation importar los íconos



raiz=tk.Tk() #crear la ventana
raiz.title("Fun Graphic") #titulo

raiz.geometry("700x600") #"tamaño de la ventana"
style.use("dark_background") #nombre del estilo que vamos a usar  
fig=Figure() #creamos una figura
ax=fig.add_subplot(111) #creamos un eje y lo ponemos en posición


c=FigureCanvasTkAgg(fig,raiz) #crear el contenedor que va a tener la gráfica
c.draw()#para que aparezca el contenedor
c.get_tk_widget().pack(side=tk.TOP,fill=tk.BOTH,expand=1) #tamaño y ubicación

barra=NavigationToolbar2Tk(c,raiz) #creamos la barra de navegación
barra.update() #para que se actualice


b1=tk.Button(raiz, text="graficar") #creamos el botón para graficar
entrada=tk.Entry(raiz, width=55) #creamos la entrada de la función y le ponemos tamaño
entrada.pack(side=tk.BOTTOM) #ubicación
b1.pack(side=tk.BOTTOM) #ubicación del botón
raiz.mainloop()

