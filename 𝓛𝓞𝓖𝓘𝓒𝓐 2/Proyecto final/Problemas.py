from itertools import combinations
from Logica import *
import matplotlib.pyplot as plt
import matplotlib.patches as patches
from matplotlib.offsetbox import AnnotationBbox, OffsetImage
from types import MethodType

def escribir_equis(self, literal):
    if '-' in literal:
        atomo = literal[1:]
        neg = 'No h'
    else:
        atomo = literal
        neg = 'H'
    x, y  = self.inv(atomo)
    return f"{neg}ay una X en la casilla ({x},{y})"

class Equis:

    '''
    Clase para representar el problema de poner
    tres equis en un tablero 7x7 sin que queden 3
    seguidas y que hayan exactamente 3 por fila y columna.
    '''

    def __init__(self):
        self.XenC = Descriptor([7,7])
        self.XenC.escribir = MethodType(escribir_equis, self.XenC)
        CI = self.CI()
        r2 = self.regla2()
        r3 = self.regla3()
        self.reglas = [CI, r2, r3]
        self.rules = '(' + r3 + 'Y' + r2 + ')'


    def CI(self):
        I = {self.XenC.P([1,2]), self.XenC.P([4,2]), self.XenC.P([5,2]),
        self.XenC.P([2,3]), self.XenC.P([3,3]),self.XenC.P([4,0]), self.XenC.P([6,6]), self.XenC.P([0,0]),
        self.XenC.P([1,0]), self.XenC.P([0,5])}
        return Ytoria(I)
    
    def regla2(self):
        Direcciones = []
        formula1 = ''
        inicial = True
        for x in range(0,7):
            for y in range(5):
                if inicial:
                    formula1 = '(' + '(' + self.XenC.P([x,y]) + 'Y' + self.XenC.P([x,y+1]) + ')' + '>-' + self.XenC.P([x,y+2]) + ')'
                    inicial = False
                else:
                    formula1 = "(" + formula1 + "Y" + '(' + '(' + self.XenC.P([x,y]) + 'Y' + self.XenC.P([x,y+1]) + ')' + '>-' +                                 self.XenC.P([x,y+2]) + '))'
        formula2 = ''
        inicial = True
        for y in range(0,7):
            for x in range(5):
                if inicial:
                    formula2 = '(' + '(' + self.XenC.P([x,y]) + 'Y' + self.XenC.P([x+1,y]) + ')' + '>-' + self.XenC.P([x+2,y]) + ')'
                    inicial = False
                else:
                    formula2 = "(" + formula2 + "Y" + '(' + '(' + self.XenC.P([x,y]) + 'Y' + self.XenC.P([x+1,y]) + ')' + '>-' +                       self.XenC.P([x+2,y]) + '))'
        formula3 = ''
        inicial = True
        for x in range(5):
            for y in range(5):
                if inicial:
                    formula3 = '(' + '(' + self.XenC.P([x,y]) + 'Y' + self.XenC.P([x+1,y+1]) + ')' + '>-' + self.XenC.P([x+2,y+2]) + ')'
                    inicial = False
                else:
                    formula3 = "(" + formula3 + "Y" + '(' + '(' + self.XenC.P([x,y]) + 'Y' + self.XenC.P([x+1,y+1]) + ')' + '>-' +                               self.XenC.P([x+2,y+2]) + '))'
        formula4 = ''
        inicial = True
        for x in range(5):
            for y in range(2,7):
                if inicial:
                    formula4 = '(' + '(' + self.XenC.P([x,y]) + 'Y' + self.XenC.P([x+1,y-1]) + ')' + '>-' + self.XenC.P([x+2,y-2]) + ')'
                    inicial = False
                else:
                    formula4 = "(" + formula4 + "Y" + '(' + '(' + self.XenC.P([x,y]) + 'Y' + self.XenC.P([x+1,y-1]) + ')' + '>-' +                               self.XenC.P([x+2,y-2]) + '))'

        Direcciones.append(formula1)
        Direcciones.append(formula2)
        Direcciones.append(formula3)
        Direcciones.append(formula4)
        regla2 = Ytoria(Direcciones)
        return regla2

    def regla3(self):
        formula1_1 = ''
        formulaF = ''
        inicial_2 = True
        for x in range(0,7):
            inicial = True
            for y in range(0,7):
                for w in range(0,7):
                    if w!=y:
                        for z in range(0,7):
                            if z!=y and z!=w: 
                                if inicial:
                                    formula1_1 = '((' + self.XenC.P([x,y]) + 'Y' + self.XenC.P([x,w]) + ')' + 'Y' + self.XenC.P([x,z]) + ')'
                                    inicial = False
                                else:
                                    formula1_1 = "(" + formula1_1 + "O" + '((' + self.XenC.P([x,y]) + 'Y' + self.XenC.P([x,w]) + ')' + 'Y' +                                     self.XenC.P([x,z]) + ')' + ")"
            if inicial_2:
                    formulaF = formula1_1
                    inicial_2=False
            else:
                formulaF = "(" + formulaF + 'Y' + formula1_1 + ')' 
        formula1_2 = ''
        formulaF_2 = ''
        inicial_2 = True
        for y in range(0,7):
            inicial = True
            for x in range(0,7):
                for w in range(0,7):
                    if w!=x:
                        for z in range(0,7):
                            if z!=x and z!=w: 
                                if inicial:
                                    formula1_2 = '((' + self.XenC.P([x,y]) + 'Y' + self.XenC.P([w,y]) + ')' + 'Y' + self.XenC.P([z,y]) + ')'
                                    inicial = False
                                else:
                                    formula1_2 = "(" + formula1_2 + "O" + '((' + self.XenC.P([x,y]) + 'Y' + self.XenC.P([w,y]) + ')' + 'Y' +                                     self.XenC.P([z,y]) + ')' + ")"
            if inicial_2:
                formulaF_2 = formula1_2
                inicial_2=False
            else:
                formulaF_2 = "(" + formulaF_2 + 'Y' + formula1_2 + ')'
        Direcciones_2 = []
        Direcciones_2.append(formulaF)
        Direcciones_2.append(formulaF_2)
        regla3 = Ytoria(Direcciones_2)
        return regla3
    
    def visualizar(self, I):
        # Inicializo el plano que contiene la figura
        fig, axes = plt.subplots()
        fig.set_size_inches(5.8,5.8)
        axes.get_xaxis().set_visible(False)
        axes.get_yaxis().set_visible(False)
        # Dibujo el tablero
        step = 1/7
        tangulos = []
        # Creo las líneas del tablero
        for j in range(7):
            locacion = j * step
            # Crea linea horizontal en el rectangulo
            tangulos.append(patches.Rectangle(*[(0, step + locacion), 1, 0.005],\
                    facecolor='black'))
            # Crea linea vertical en el rectangulo
            tangulos.append(patches.Rectangle(*[(step + locacion, 0), 0.005, 1],\
                    facecolor='black'))
        for t in tangulos:
            axes.add_patch(t)
        # Cargando imagen de caballo
        arr_img = plt.imread("./img/equis.png", format='png')
        imagebox = OffsetImage(arr_img, zoom=0.1)
        imagebox.image.axes = axes
        # Creando las direcciones en la imagen de acuerdo a literal
        direcciones = {}
        direcciones[(0,0)] = [0.07, 0.93]
        direcciones[(0,1)] = [0.22, 0.93]
        direcciones[(0,2)] = [0.36, 0.93]
        direcciones[(0,3)] = [0.50, 0.93]
        direcciones[(0,4)] = [0.65, 0.93]
        direcciones[(0,5)] = [0.79, 0.93]
        direcciones[(0,6)] = [0.93, 0.93]
        direcciones[(1,0)] = [0.07, 0.79]
        direcciones[(1,1)] = [0.22, 0.79]
        direcciones[(1,2)] = [0.36, 0.79]
        direcciones[(1,3)] = [0.50, 0.79]
        direcciones[(1,4)] = [0.65, 0.79]
        direcciones[(1,5)] = [0.79, 0.79]
        direcciones[(1,6)] = [0.93, 0.79]
        direcciones[(2,0)] = [0.07, 0.65]
        direcciones[(2,1)] = [0.22, 0.65]
        direcciones[(2,2)] = [0.36, 0.65]
        direcciones[(2,3)] = [0.50, 0.65]
        direcciones[(2,4)] = [0.65, 0.65]
        direcciones[(2,5)] = [0.79, 0.65]
        direcciones[(2,6)] = [0.93, 0.65]
        direcciones[(3,0)] = [0.07, 0.50]
        direcciones[(3,1)] = [0.22, 0.50]
        direcciones[(3,2)] = [0.36, 0.50]
        direcciones[(3,3)] = [0.50, 0.50]
        direcciones[(3,4)] = [0.65, 0.50]
        direcciones[(3,5)] = [0.79, 0.50]
        direcciones[(3,6)] = [0.93, 0.50]
        direcciones[(4,0)] = [0.07, 0.36]
        direcciones[(4,1)] = [0.22, 0.36]
        direcciones[(4,2)] = [0.36, 0.36]
        direcciones[(4,3)] = [0.50, 0.36]
        direcciones[(4,4)] = [0.65, 0.36]
        direcciones[(4,5)] = [0.79, 0.36]
        direcciones[(4,6)] = [0.93, 0.36]
        direcciones[(5,0)] = [0.07, 0.22]
        direcciones[(5,1)] = [0.22, 0.22]
        direcciones[(5,2)] = [0.36, 0.22]
        direcciones[(5,3)] = [0.50, 0.22]
        direcciones[(5,4)] = [0.65, 0.22]
        direcciones[(5,5)] = [0.79, 0.22]
        direcciones[(5,6)] = [0.93, 0.22]
        direcciones[(6,0)] = [0.07, 0.07]
        direcciones[(6,1)] = [0.22, 0.07]
        direcciones[(6,2)] = [0.36, 0.07]
        direcciones[(6,3)] = [0.50, 0.07]
        direcciones[(6,4)] = [0.65, 0.07]
        direcciones[(6,5)] = [0.79, 0.07]
        direcciones[(6,6)] = [0.93, 0.07]
        for k in I:
            if (ord(k) >= self.XenC.rango[0]) and (ord(k) <= self.XenC.rango[1]):
                x, y = self.XenC.inv(k)
                if I[k]:
                    ab = AnnotationBbox(imagebox, direcciones[(x,y)], frameon=False)
                    axes.add_artist(ab)
        plt.show()