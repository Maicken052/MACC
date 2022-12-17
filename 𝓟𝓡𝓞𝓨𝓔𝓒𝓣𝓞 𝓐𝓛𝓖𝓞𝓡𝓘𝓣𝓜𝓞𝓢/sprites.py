import pygame, random
from pygame.locals import *
import functions
from functions import WIDTH, HEIGHT, WHITE
from dokusan import generators
import numpy as np
from copy import deepcopy

#Clase numeros botones
class Numbers(pygame.sprite.Sprite):
    def __init__(self, image, x, y, number:int):
        super().__init__()

        if(x < 0 or y < 0):
            raise ValueError ("No se reciben valores negativos")
        
        if(number not in range(1,10)):
            raise ValueError ("Solo se reciben valores del 1 al 9")

        self.tam = WIDTH/13.66
        self.image = pygame.transform.scale(image, (self.tam, self.tam))
        self.pos_x = x
        self.pos_y = y
        self.number = number
        self.rect = self.image.get_rect()
        self.rect.topleft = ((self.pos_x, self.pos_y))

    def get_number(self):
        return self.number

    def draw(self, surface):
        surface.blit(self.image, self.rect)
    
    def checkForInput(self, position):
        if position[0] in range(self.rect.left, self.rect.right) and position[1] in range(self.rect.top, self.rect.bottom):
            return self.number
        else:
            return 0

#Clase numeros casillas
class Numbers_casillas(pygame.sprite.Sprite):
    def __init__(self, x, y, number:int=0):
        super().__init__()
        
        if(x < 0 or y < 0):
            raise ValueError ("No se reciben valores negativos")
        
        if(number not in range(0,10)):
            raise ValueError ("Solo se reciben valores del 0 al 9")

        self.tam = WIDTH/50
        self.number = number
        self.num_images = {
            0:"Imagenes/WHITE.png",
            1:"Imagenes/1.png",
            2:"Imagenes/2.png",
            3:"Imagenes/3.png",
            4:"Imagenes/4.png",
            5:"Imagenes/5.png",
            6:"Imagenes/6.png",
            7:"Imagenes/7.png",
            8:"Imagenes/8.png",
            9:"Imagenes/9.png",
        }
        self.image = functions.load_image(self.num_images[self.number], self.tam, self.tam, True) # convertir la imagen en un formato aceptado por pygame para ser tratado
        self.rect = self.image.get_rect()
        self.rect.centerx = x
        self.rect.centery = y

    def set_number(self, num:int):
        self.number = num
        self.update()

    def get_number(self):
        return self.number

    def update(self):
        self.image = functions.load_image(self.num_images[self.number], self.tam, self.tam, True) # convertir la imagen en un formato aceptado por pygame para ser tratado


    def draw(self, surface):
        surface.blit(self.image, self.rect)


#class casilla---------------------------------------------------------
class Casilla(pygame.sprite.Sprite):
    def __init__(self, dat:int = 0, pos:tuple= (0, 0, 0, 0, 0, 0)):
        super().__init__()

        if(dat not in range(0,10)):
            raise ValueError ("Solo se reciben valores del 0 al 9")

        self.prev_data = 0
        self.tam = WIDTH/20.2
        self.picture = 'Imagenes/Casilla.png' # localización de la imagen a ser usada para la clase
        self.image = functions.load_image(self.picture, self.tam, self.tam, True) # convertir la imagen en un formato aceptado por pygame para ser tratado
        self.rect = self.image.get_rect()

        if pos[0] != None:
            self.rect.top = pos[0]
        if pos[1] != None:
            self.rect.bottom = pos[1]
        if pos[2] != None:
            self.rect.right = pos[2]
        if pos[3] != None:
            self.rect.left = pos[3]
        if pos[4] != None:
            self.rect.centerx = pos[4]
        if pos[5] != None:
            self.rect.centery = pos[5]
        
        self._dato = Numbers_casillas(self.rect.centerx, self.rect.centery, dat)

    def get_dato(self):
        return self._dato.get_number()

    def set_dato(self, dato:int):
        if self.prev_data == 0 and dato == 0 and self._dato.get_number() != 0:
            self.prev_data = self._dato.get_number()
        self._dato.set_number(dato)
        self.update()
 
    def printc(self):
        print(self._dato, end= " ") #imprime el número y sigue en la misma linea

    def update(self):
        self._dato.update()
        

    def draw(self, surface): #Método para mostrar el sprint en pantalla
                             # surface = pantalla
        surface.blit(self.image, self.rect)
        self._dato.draw(surface)        

#class subcuadricula--------------------------------------------------
class Subcuadricula(pygame.sprite.Sprite):
    def __init__(self, fila=3, columna=3, pos:tuple = (0, 0, 0, 0, 0, 0)):
        super().__init__()

        self.li = [2,1,0]
        self.tam = WIDTH/7.2
        self.picture = 'Imagenes/Subcuadricula.png' # localización de la imagen a ser usada para la clase
        self.image = functions.load_image(self.picture, self.tam, self.tam, True) # convertir la imagen en un formato aceptado por pygame para ser tratado
        self.image.fill(WHITE)
        self.rect = self.image.get_rect()

        if pos[0] != None:
            self.rect.top = pos[0]
        if pos[1] != None:
            self.rect.bottom = pos[1]
        if pos[2] != None:
            self.rect.right = pos[2]
        if pos[3] != None:
            self.rect.left = pos[3]
        if pos[4] != None:
            self.rect.centerx = pos[4]
        if pos[5] != None:
            self.rect.centery = pos[5]

        self.filas=fila
        self.columnas=columna
        self.matriz=[]
        self.casillas_group = pygame.sprite.Group()

        self.pos_casillas = {
                    1: (self.rect.top, None, self.rect.right, None, None, None), 
                    2: (self.rect.top, None, None, None, self.rect.centerx, None),
                    3: (self.rect.top, None, None, self.rect.left, None, None),

                    4: (None, None, self.rect.right, None, None, self.rect.centery),
                    5: (None, None, None, None, self.rect.centerx, self.rect.centery),
                    6: (None, None, None, self.rect.left, None, self.rect.centery),
                    
                    7: (None, self.rect.bottom, self.rect.right, None, None, None),
                    8: (None, self.rect.bottom, None, None, self.rect.centerx, None),
                    9: (None, self.rect.bottom, None, self.rect.left, None, None)
                    }
  
        self.contador = 1
        for f in range(self.filas):
            lis=[] #crea la lista vacia donde guarda cada fila
            for c in range(self.columnas):
                cas = Casilla(0, self.pos_casillas[self.contador]) #crea un objeto casilla
                self.casillas_group.add(cas)
                lis.append(cas) #lo agrega a la lista de fila
                self.contador += 1
            self.matriz.append(lis)

            
           
    def prin(self):
        for i in range(self.filas):
            for j in range(self.columnas):
                self.matriz[i][j].printc()
            print("\t")
    
    def get_dato(self, x, y):
        return self.matriz[x][y].get_dato()

    def set_dato(self, num:int, x:int, y:int):
        self.matriz[x][self.li[y]].set_dato(num)
      

    def insert(self, fila, columna, num):
        c = self.matriz[fila][columna]
        c.setCasilla(num)
       
    def revisar_sub(self, num):
        for i in range(self.filas):
            for j in range(self.columnas):
                if self.matriz[i][j].getCasilla()==num:
                    return False
        return True

    def update(self):
        # for f in range(self.filas):
        #     for c in range(self.columnas):
        #         self.matriz[f][c].update()
        self.casillas_group.update()
    
    def casillitas(self):
        lista=[] 
        for i in range(self.filas):
            for j in range(self.columnas):
                lista.append(self.matriz[i][j])
        return lista
    
    def get_casillas_group(self):
        return self.casillas_group

    def draw(self, surface): #Método para mostrar el sprint en pantalla
                             # surface = pantalla
        surface.blit(self.image, self.rect)
        for i in range(self.filas):
            for j in reversed(range(self.columnas)):
                (self.matriz[i][j]).draw(surface)

        

class Cuadricula(pygame.sprite.Sprite):
    def __init__(self, filas= 3, columnas= 3, pos:tuple = (0, 0)):
        super().__init__()

        self.li = [2,1,0]
        self.tam = WIDTH/2.4
        self.picture = 'Imagenes/Cuadricula.png' # localización de la imagen a ser usada para la clase
        self.image = functions.load_image(self.picture, self.tam, self.tam, True) # convertir la imagen en un formato aceptado por pygame para ser tratado
        self.rect = self.image.get_rect()
        self.mat_rand = np.array(list(str(generators.random_sudoku(avg_rank=100)))).reshape(9,9).astype(int)
        self.mat_complete = []

        self.rect.centerx = pos[0]
        self.rect.centery = pos[1]
        self.rect.top = 0

        self.filas = filas
        self.columnas = columnas
        self.matriz = []
        self.subcuadricula_group = pygame.sprite.Group()

        self.contador = 1
        self.pos_subcuadricula = {
                    1: (self.rect.top, None, self.rect.right, None, None, None), 
                    2: (self.rect.top, None, None, None, self.rect.centerx, None),
                    3: (self.rect.top, None, None, self.rect.left, None, None),

                    4: (None, None, self.rect.right, None, None, self.rect.centery),
                    5: (None, None, None, None, self.rect.centerx, self.rect.centery),
                    6: (None, None, None, self.rect.left, None, self.rect.centery),
                    
                    7: (None, self.rect.bottom, self.rect.right, None, None, None),
                    8: (None, self.rect.bottom, None, None, self.rect.centerx, None),
                    9: (None, self.rect.bottom, None, self.rect.left, None, None)
                    }

        for f in range(self.filas):
            lis = []
            for c in range(self.columnas):
                sub = Subcuadricula(self.filas, self.columnas, self.pos_subcuadricula[self.contador])
                self.subcuadricula_group.add(sub)
                lis.append(sub)
                self.contador += 1
            self.matriz.append(lis)

    def prin(self):
        for i in range(self.filas):
            for j in range(self.columnas):
                self.matriz[i][j].prin()
            print("\n")
    
    def get_dato(self, x:int, y:int, xs:int, ys:int):
        return self.matriz[x][y].get_dato(xs, ys)

    def set_dato(self, num:int, x:int, y:int, xs:int, ys:int):
        self.matriz[x][self.li[y]].set_dato(num, xs, ys)

    def draw(self, surface): #Método para mostrar el sprint en pantalla
                             # surface = pantalla

        surface.blit(self.image, self.rect)
        for i in range(self.filas):
            for j in reversed(range(self.columnas)):
                (self.matriz[i][j]).draw(surface)
                
    def update(self):
        self.subcuadricula_group.update()

    #Logica Sudoku

    def posible_numero(self, fila, columna, numero, mat):
        for i in range(0, 9):
            if mat[fila][i] == numero:
                return False

        for i in range(0, 9):
            if mat[i][columna] == numero:
                return False

        x_sub = (fila//3)*3
        y_sub = (columna//3)*3

        for i in range(0,3):
            for j in range(0,3):
                if mat[x_sub + i][y_sub + j] == numero:
                    return False

        return True

    def sudoku_solver(self, mat):
        if(type(mat) != np.ndarray):
            raise TypeError("Ingrese una matriz")
        for filas in range(0,9):
            for columnas in range(0,9):
                if mat[filas][columnas] == 0:
                    for numero in range(1, 10):
                        if(self.posible_numero(filas, columnas, numero, mat)):
                            mat[filas][columnas] = numero
                            posible_result = self.sudoku_solver(mat)
                            if(type(posible_result) == np.ndarray):
                                return posible_result
                            else:
                                mat[filas][columnas] = 0
                    return None
        return mat
    
    def erase(self):
        desition = [True, False, False, False]

        xs = 0
        x = 0
        y = 0
        for f in range(9):
            
            if f<=2:
                x = 0
            elif 2<f<=5:
                x = 1
            elif 5<f<=8:
                x = 2
            for c in range(9):
                if c == 0 or c == 1 or c == 2:
                    y = 0
                elif c == 3 or c == 4 or c==5:
                    y = 1
                elif c == 6 or c == 7 or c == 8:
                    y = 2
                if random.choice(desition):
                    self.set_dato(0, x, y, xs, c%3)
            if xs == 2:
                xs = 0
            else:
                xs += 1

    def generador(self):
        self.mat_complete = self.sudoku_solver(deepcopy(self.mat_rand))
        xs = 0
        x = 0
        y = 0
        print(self.mat_complete, end="\n")
        for f in range(9):
            
            if f<=2:
                x = 0
            elif 2<f<=5:
                x = 1
            elif 5<f<=8:
                x = 2
            for c in range(9):
                if c == 0 or c == 1 or c == 2:
                    y = 0
                elif c == 3 or c == 4 or c==5:
                    y = 1
                elif c == 6 or c == 7 or c == 8:
                    y = 2
                self.set_dato(self.mat_complete[f][c], x, y, xs, c%3)
            if xs == 2:
                xs = 0
            else:
                xs += 1
        self.erase()


    def get_casillas_group(self):
        casillas_group = pygame.sprite.Group()

        for f in range(self.filas):
            for c in range(self.columnas):
                group = self.matriz[f][c].get_casillas_group().sprites()
                for sprite in group:
                    casillas_group.add(sprite)

        return casillas_group


class AnimatedBackground(pygame.sprite.Sprite):
    def __init__(self, position, images, delay):
        super(AnimatedBackground, self).__init__()

        self.images = itertools.cycle(images)
        self.image = next(self.images)
        self.rect = pygame.Rect(position,  self.image.get_rect().size)

        self.animation_time = delay
        self.current_time = 0

    def update(self, dt):
        self.current_time += dt
        if self.current_time >= self.animation_time:
            self.current_time = 0
            self.image = next(self.images)


class Words(pygame.sprite.Sprite, pygame.font.Font):
    def __init__(self, text: str, size: int, color, location, multicolor=False):
        super().__init__()
        
        self.font = pygame.font.Font('Imagenes/04B_30__.TTF', size)
        self._text = text
        self._color = color
        self.multicolor = multicolor
        self.image = self.font.render(text, True, self.color)
        self.rect = self.image.get_rect()
        self.rect.centerx = location[0]
        self.rect.centery = location[1]

    #--------setters and getters---------
    @property
    def text(self):
        return self._text

    @text.setter
    def text(self, text):
        self._text = text

    @property
    def color(self):
        return self._color
    
    @color.setter
    def color(self, color):
        self._color = color


    def update(self):
        self.image = self.font.render(self.text, 1 , self.color)
        return self.image


    def draw(self, surface):
        surface.blit(self.image, self.rect)

