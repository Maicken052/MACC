#=============================================================================================================================================================
#                                                                          Modulos                                                                           #
#=============================================================================================================================================================
import tkinter as t
from tkinter import messagebox
from matplotlib.pyplot import *
from matplotlib.figure import Figure
from matplotlib import style
import matplotlib.animation as anim
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2Tk
import numpy as np
import math

#=============================================================================================================================================================
#                                                               Caracteristicas de la ventana                                                                #
#=============================================================================================================================================================
ventana=t.Tk()#Crear ventana de tkinter
ventana.title("Fun Graphic")#Titulo de la ventana
ventana.geometry("900x800")#Tamaño de la ventana
style.use("fivethirtyeight")#Agregar un estilo a la grafica
fg=Figure()#Crea el recuadro de la grafica
ax=fg.add_subplot(111)#Contraer o alargar el recuadro(primer digito en el eje y, segundo digito en el eje x) del 1 al 9, desplazar con el tercer digito (de 1 a 6)
cv=FigureCanvasTkAgg(fg, ventana)#Crea contenedor donde va a estar la grafica
cv.get_tk_widget().pack(side=t.TOP, fill=t.BOTH, expand=1)#Expansión del contenedor
cv.draw() #Para que aparezcan las modificaciones al contenedor
tlb=NavigationToolbar2Tk(cv, ventana)#Importar iconos de navegación #toolbar
tlb.update()#Actualizar los iconos

#=============================================================================================================================================================
#                                                          Rangos y Funciones especiales a graficar                                                          #
#=============================================================================================================================================================
r1=False #Rango 1
r2=""#Rango 2
r3=""#Rango 3
function_np={"sin":"np.sin","cos":"np.cos", "sqrt":"np.sqrt", "exp":"np.exp", "log":"np.log", "abs":"np.abs"} #guardar las funciones especiales en un diccionario
#=============================================================================================================================================================
#                                                                       Graficadora                                                                          #
#=============================================================================================================================================================
def reemplazar(p): #Reemplaza la abreviación que usamos en las funciones especiales por su metodo para que funcionen al graficarlas
    for i in function_np:
        if i in p:
            p=p.replace(i, function_np[i])
    return p
    
def represent():
    global graf_dt
    global r3
    global r1
    texto_ori=func_entry.get()#El texto que obtiene de la barra para ingresar la función 
    if range_entry.get()!="":
        range_x=range_entry.get()#El rango en x que obtiene de la barra para ingresar rango
        r3=range_x.split(",")#Separar el rango
        r1=True
    graf_dt=reemplazar(texto_ori)
    ani.event_source.start()
    
def animate(i):
    global r1
    global r2
    if r1==True:
        try:
            min=float(r3[0])
            max=float(r3[1])#Son los valores que obtenemos del split anterior
            if min<max:
                x=np.arange(min, max, 0.01)
                r2=[min, max]
            else:
                r1=False
        except:
            messagebox.showwarning("el rango es incorrecto")
            r1=False
            range_entry.delete(0, len(range_entry.get()))#Borra lo que haya en el recuadro de rango de x
    else:
        if r2!="":
         x=np.arange(r2[0], r2[1], 0.01)   
        else:
          x=np.arange(0,10,0.01)#Si no se da un rango, se asume uno del 0 hasta el 10
    try:
        sl=eval(graf_dt)#Evaluar los datos ingresados
        ax.clear()#Limpia la grafica anterior
        ax.plot(x, sl)#Grafica la función
    except:
        ax.plot()
        
    ax.axhline(0, color="black")
    ax.axvline(0, color="black")
    ani.event_source.stop()#Detener el evento
    
ani=anim.FuncAnimation(fg, animate, interval=1000)
#=============================================================================================================================================================
#                                                                   Botones Y Barras de acción                                                               #
#=============================================================================================================================================================
bo1=t.Button(ventana, text="graficar", command=represent)#Crear botón de "graficar"
func_entry=t.Entry(ventana, width=60)#Crear espacio de entrada para ingresar función
range_entry=t.Entry(ventana, width=20)#Crear entrada de variación de rango en x
bo1.pack(side=t.BOTTOM)
range_entry.pack(side=t.RIGHT)#Ubicar entrada de variación de rango en x
func_entry.pack(side=t.BOTTOM)#Ubicar el espacio para ingresar función

show()#Muestra la gráfica
ventana.mainloop()#Hacer visible la ventana