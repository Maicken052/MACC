#=============================================================================================================#                                                           *libraries      
#=============================================================================================================#
import pygame
from pygame.locals import *
from dokusan import generators
import numpy as np
from copy import deepcopy
from functions import *
#=============================================================================================================#                                                 *Clase números de las casillas      
#=============================================================================================================#
class box_numbers(pygame.sprite.Sprite):  #Se hereda el init de la clase sprite de pygame
    def __init__(self, location: tuple, number:int = 0):
        super().__init__()
        
        #Condiciones para que el programa cumpla su función adecuadamente
        if(location[0] < 0 or location[1] < 0):
            raise ValueError ("No se reciben valores negativos")
        
        if(number not in range(0,10)):
            raise ValueError ("Solo se reciben valores del 0 al 9")

        #Parametros
        self.img_size = 25  #Tamaño de la imagen
        self.number = number  #Número de la casilla
        self.possible_imgs = {  #Posible imagen que va a tener la casilla
            0:"Images/WHITE.png",
            1:"Images/1.png",
            2:"Images/2.png",
            3:"Images/3.png",
            4:"Images/4.png",
            5:"Images/5.png",
            6:"Images/6.png",
            7:"Images/7.png",
            8:"Images/8.png",
            9:"Images/9.png",
        }
        self.image = load_image(self.possible_imgs[self.number], self.img_size, self.img_size)  #Se ajusta al tamaño deseado y se escoge una imagen del diccionario según el número que corresponda
        self.rect = self.image.get_rect(center = (location[0], location[1]))  #Rectangulo de la imagen que da las coordenadas

    #Métodos
    def set_number(self, num:int):  #Setter para actualizar el número de la casilla
        self.number = num
        self.update()

    def get_number(self):  #Getter para obtener el número de la casilla
        return self.number

    def update(self):  #Se cambia la imagen dependiendo del nuevo número de la casilla
        self.image = load_image(self.possible_imgs[self.number], self.img_size, self.img_size) 

    def draw(self, surface):  #Método para dibujar la imagen del número que va en la casilla 
        surface.blit(self.image, self.rect)
#=============================================================================================================#                                                          *Clase casilla   
#=============================================================================================================#
class box(pygame.sprite.Sprite):  #Se hereda el init de la clase sprite de pygame
    def __init__(self, num_in_box:int = 0, pos:tuple = (0, 0, 0, 0, 0, 0)):
        super().__init__()

        #Condiciones para que el programa cumpla su función adecuadamente
        if(num_in_box not in range(0,10)):
            raise ValueError ("Solo se reciben valores del 0 al 9")

        #Parametros
        self.img_size = WIDTH/21.34375  #Tamaño de la imagen
        self.image = load_image('Images/Box.png', self.img_size, self.img_size, True) #Se ajusta al tamaño deseado y se escoge la imagen correspondiente
        self.rect = self.image.get_rect()  #Se crea un rectangulo para que se pueda interactuar con la casilla
        self.correct_number = 0  #El número que debe ir en la casilla

        #Posición de la casilla (Arriba, Abajo, Drecha, Izquierda, Centro en x, Centro en y)
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

        self.data = box_numbers((self.rect.centerx, self.rect.centery), num_in_box)  #El dato dentro de la casilla es el número que corresponde

    #Métodos
    def get_data(self):  #Getter que retorna el número en la casilla
        return self.data.get_number()

    def get_correct_number(self):  #Getter que retorna el número correcto
        return self.correct_number

    def set_data(self, num:int):  #Primero se pone el dato de el sudoku resuelto, y después de el sudoku sin resolver que se ve en pantalla
        if self.correct_number == 0:
            self.correct_number = num
        else:
            self.data.set_number(num)

    def draw(self, surface): #Método para dibujar la casilla y su número
        surface.blit(self.image, self.rect)
        self.data.draw(surface)   
#=============================================================================================================#                                                          *Clase subcuadricula  
#=============================================================================================================#
class subgrid(pygame.sprite.Sprite):  #Se hereda el init de la clase sprite de pygame
    def __init__(self, pos:tuple = (0, 0, 0, 0, 0, 0)):
        super().__init__()

        self.img_size = WIDTH/6.89898989898989  #Tamaño de la imagen
        self.image = load_image('Images/WHITE.png', self.img_size, self.img_size, True) #Se ajusta al tamaño deseado y se escoge la imagen correspondiente
        self.rect = self.image.get_rect()  #Se crea un rectangulo para que se pueda interactuar con la subcuadricula
        self.rows = 3  #Número de filas
        self.columns = 3  #Número de columnas

        #Posición de la subcuadricula (Arriba, Abajo, Drecha, Izquierda, Centro en x, Centro en y)
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

        self.pos_of_boxes = {  #Posición que van a tener cada una de las 9 casillas, dependiendo de las coordenadas del rectangulo de la subcuadricula
                    1: (self.rect.top, None, None, self.rect.left-1, None, None), #Superior izquierdo 
                    2: (self.rect.top, None, None, None, self.rect.centerx, None), #Superior centrado
                    3: (self.rect.top, None, self.rect.right, None, None, None), #Superior derecho

                    4: (None, None, None, self.rect.left-1, None, self.rect.centery), #Centro izquierda
                    5: (None, None, None, None, self.rect.centerx, self.rect.centery), #Centro 
                    6: (None, None, self.rect.right, None, None, self.rect.centery), #Centro derecha
                    
                    7: (None, self.rect.bottom, None, self.rect.left-1, None, None), #Inferior izquierda
                    8: (None, self.rect.bottom, None, None, self.rect.centerx, None), #Inferior centrado
                    9: (None, self.rect.bottom, self.rect.right, None, None, None), #Inferior derecha
                    }

        #Creación de una matriz con todos los objetos casilla
        self.matrix_of_boxes = []
        self.box_group = pygame.sprite.Group()  #Grupo sprite con los objetos casilla
        count = 1

        for i in range(self.rows):
            list_of_rows = []  #crea la lista donde guarda cada fila con casillas
            for j in range(self.columns):
                box_ = box(0, self.pos_of_boxes[count]) #crea un objeto casilla y le asigna valor 0, junto con su debida posición
                list_of_rows.append(box_) #lo agrega a la lista de fila
                self.box_group.add(box_)  #Se agrega la casilla al grupo casilla
                count += 1
            self.matrix_of_boxes.append(list_of_rows)

    #Métodos
    def get_data(self, x:int, y:int):  #Getter para obtener el dato de la casilla que esta en la matriz
        return self.matrix_of_boxes[x][y].get_data()

    def set_data(self, num:int, x:int, y:int):  #Setter para poner un dato en una casilla de la matriz
        self.matrix_of_boxes[x][y].set_data(num)

    def get_box_group(self):  #Getter para obtener el grupo sprite de casillas
        return self.box_group
    
    def draw(self, surface):  #Método para dibujar la subcuadricula, invocando los draw de cada casilla
        surface.blit(self.image, self.rect)  #Primero se dibuja la subcuadricula
        for i in range(self.rows):
            for j in range(self.columns):
                (self.matrix_of_boxes[i][j]).draw(surface)  #Y después cada casilla
#=============================================================================================================#                                                          *Clase cuadricula
#=============================================================================================================#
class grid(pygame.sprite.Sprite):  #Se hereda el init de la clase sprite de pygame
    def __init__(self, pos:tuple = (0, 0)):
        super().__init__()

        self.img_size = WIDTH/2.09188361408882 #Tamaño de la imagen
        self.image = load_image('Images/WHITE.png', self.img_size, self.img_size, False, True)  #Se ajusta al tamaño deseado y se escoge la imagen correspondiente 
        self.rect = self.image.get_rect()  #Se crea el rectangulo

        #Ubicación de la cuadricula
        self.rect.centerx = pos[0]
        self.rect.centery = pos[1]

        self.pos_of_subgrids = {  #Posición que va a tener cada una de las 9 subcuadriculas, dependiendo de las coordenadas del rectangulo de la cuadricula
                    1: (self.rect.top+1, None, None, self.rect.left+1, None, None), #Superior izquierdo 
                    2: (self.rect.top+1, None, None, None, self.rect.centerx, None), #Superior centrado
                    3: (self.rect.top+1, None, self.rect.right, None, None, None), #Superior derecho

                    4: (None, None, None, self.rect.left+1, None, self.rect.centery), #Centro izquierda
                    5: (None, None, None, None, self.rect.centerx, self.rect.centery), #Centro 
                    6: (None, None, self.rect.right, None, None, self.rect.centery), #Centro derecha
                    
                    7: (None, self.rect.bottom-1, None, self.rect.left+1, None, None), #Inferior izquierda
                    8: (None, self.rect.bottom-1, None, None, self.rect.centerx, None), #Inferior centrado
                    9: (None, self.rect.bottom-1, self.rect.right, None, None, None), #Inferior derecha
                    }

        self.sudoku = []  #En esta matriz se almacena el sudoku sin resolver
        self.solved_sudoku = []  #En esta matriz se almacena el sudoku resuelto
        self.rows = 3  #Número de filas
        self.columns = 3  #Número de columnas

        #Creación de una matriz con las subcuadriculas
        self.matrix_of_subgrids = []
        self.subgrid_group = pygame.sprite.Group() #Grupo de subcuadriculas
        count = 1

        for i in range(self.rows):
            list_of_rows = []  #Se crea una lista que guarda las rows
            for j in range(self.columns):
                sub = subgrid(self.pos_of_subgrids[count])  #Se crea la subcuadricula con la posición correspondiente
                list_of_rows.append(sub)  #Se agrega la lista
                self.subgrid_group.add(sub)  #Se agrega al grupo
                count += 1
            self.matrix_of_subgrids.append(list_of_rows)  #Se agrega la fila a la matriz

    #Métodos
    def get_data(self, x:int, y:int, xs:int, ys:int):  #Getter que retorna una casilla, dependiendo del indice de la cuadricula y subcuadricula
        return self.matrix_of_subgrids[x][y].get_data(xs, ys)

    def set_data(self, num:int, x:int, y:int, xs:int, ys:int):  #Setter que pone un número en una casilla, dependiendo del indice de la cuadricula y subcuadricula
        self.matrix_of_subgrids[x][y].set_data(num, xs, ys)

    def get_subgrid_group(self):  #Getter que retorna el grupo sprite de subcuadriculas
        return self.subgrid_group

    def draw(self, surface): #Método para dibujar la cuadricula, invocando los draw de cada subcuadricula
        surface.blit(self.image, self.rect)  #Primero se dibuja la cuadricula
        for i in range(self.rows):
            for j in range(self.columns):
                (self.matrix_of_subgrids[i][j]).draw(surface)  #Y después cada subcuadricula

    #*Logica Sudoku
    def possible_num(self, row, column, num, grid):  #Función que busca si un número ya está en la fila, columna o subcuadricula deseada
        for i in range(0, 9):  #Revisamos toda la fila, y si el número ya está, retorna false
            if grid[row][i] == num:
                return False

        for i in range(0, 9):  #Revisamos toda la columna, y si el número ya está, retorna false
            if grid[i][column] == num:
                return False

        row_sub = (row//3)*3  #Se obtiene la fila inicial de la subcuadricula
        col_sub = (column//3)*3  #Se obtiene la columna inicial de la subcuadricula

        for i in range(0,3):
            for j in range(0,3):
                if grid[row_sub + i][col_sub + j] == num:  #Revisamos la subcuadricula, y si el número ya está, retorna false
                    return False
        return True

    def sudoku_solver(self, grid):
        #Se revisa que el dato ingresado sea valido
        if(type(grid) != np.ndarray):  
            raise TypeError("Ingrese una matriz")

        for row in range(0,9):
            for column in range(0,9):
                if grid[row][column] == 0:  #Si esa casilla esta sin resolver
                    for num in range(1, 10):
                        if(self.possible_num(row, column, num, grid)):  #Si el número es una posible solución
                            grid[row][column] = num
                            posible_result = self.sudoku_solver(grid)  #Se hace la recursión
                            if(type(posible_result) == np.ndarray):  #Si el resultado es una solución valida, devuelve la cuadricula
                                return posible_result
                            else:
                                grid[row][column] = 0  #Sino, se vuelve a buscar
                    return None
        return grid

    def generator(self, dificult: int):  #Función encargada de generar un sudoku y llenar las casillas con el dato del sudoku incompleto que se muestra en la ventana, además del dato correcto para su posterior verificación.
        self.sudoku = np.array(list(str(generators.random_sudoku(avg_rank = dificult)))).reshape(9,9).astype(int)  #Se crea el sudoku en base a un generador
        self.solved_sudoku= self.sudoku_solver(deepcopy(self.sudoku))  #Se hace una copia del sudoku para no modificar la variable original, despúes se usa la función para resolver ese sudoku y se guarda en una variable
        xs = 0
        x = 0
        y = 0
        #Con las variables x, y recorremos la subcuadricula, mientras que con xs y el modulo 3 de c, recorremos las casillas, para que se llene la cuadricula de la misma manera que se recorre la matriz normalmente.
        for f in range(9):      
            if f <= 2:
                x = 0
            elif 2 < f <= 5:
                x = 1
            elif 5 < f <= 8:
                x = 2
            for c in range(9):
                if c <= 2:
                    y = 0
                elif 2 < c <= 5:
                    y = 1
                elif 5 < c <= 8:
                    y = 2
                self.set_data(self.solved_sudoku[f][c], x, y, xs, c%3)
                self.set_data(self.sudoku[f][c], x, y, xs, c%3)
            if xs == 2:
                xs = 0
            else:
                xs += 1
#=============================================================================================================#                                                 *Clase Botones de los números         
#=============================================================================================================#
class number_buttons(pygame.sprite.Sprite):  #Se hereda el init de la clase sprite de pygame
    def __init__(self, image, location:tuple, number:int):
        super().__init__()

        #Condiciones para que el programa cumpla su función adecuadamente
        if(location[0] < 0 or location[1] < 0):
            raise ValueError ("No se reciben valores negativos")
        
        if(number not in range(1,10)):
            raise ValueError ("Solo se reciben valores del 1 al 9")

        #Parametros
        self.number = number  #El número que va a guardar dicho botón
        self.img_size = WIDTH/9.75714285714285  #Tamaño de la imagen
        self.image = load_image(image, self.img_size, self.img_size, False, True)  #Se ajusta la imagen al tamaño deseado y se aplica la conversión alpha
        self.rect = self.image.get_rect(center = (location[0], location[1]))  #Se crea un rectangulo para que se pueda interactuar con dicho botón
    
    #Métodos
    def get_number(self):
        return self.number

    def draw(self, surface):  #Método para dibujar la imagen del botón 
        surface.blit(self.image, self.rect)
#=============================================================================================================#                                                     *Clase Botones con acciones 
#=============================================================================================================#
class actions_buttons(pygame.sprite.Sprite):  #Se hereda el init de la clase sprite de pygame
    def __init__(self, image, location:tuple, width:int, height:int):
        super().__init__()

        #Condiciones para que el programa cumpla su función adecuadamente
        if(location[0] < 0 or location[1] < 0):
            raise ValueError ("No se reciben valores negativos")

        #Parametros
        self.img_width = width  #Ancho de la imagen
        self.img_height = height  #Largo de la imagen
        self.image = load_image(image, self.img_width, self.img_height, False, True)  #Se ajusta la imagen al tamaño deseado 
        self.rect = self.image.get_rect(center = (location[0], location[1]))  #Se crea un rectangulo para que se pueda interactuar con dicho botón
    
    def draw(self, surface):  #Método para dibujar la imagen del botón 
        surface.blit(self.image, self.rect)
#=============================================================================================================#                                                          *Clase palabra   
#=============================================================================================================#
class word(pygame.sprite.Sprite, pygame.font.Font):  #Se hereda el init de la clase sprite y font de pygame
    def __init__(self, text: str, size: int, color: tuple, location:tuple, multicolor=False):
        super().__init__()
        
        self.font = pygame.font.Font('Images/Lifes_font.TTF', size)  #Se elige la fuente para el texto
        self.text = text
        self.color = color
        self.multicolor = multicolor
        self.image = self.font.render(text, True, color)  #Se pone el texto y el color
        self.rect = self.image.get_rect(center = (location[0], location[1]))  #Se obtiene el rectangulo y se ubica en las coordenadas dadas

    @property
    def text_(self):  #Getter para obtener el texto
        return self.text

    @text_.setter
    def text_(self, text: str):  #Setter para poner el texto
        self.text = text
        self.update()

    @property
    def color_(self):  #Getter para obtener el color
        return self.color
    
    @color_.setter
    def color_(self, color: tuple):  #Setter para poner el color
        self.color = color
        self.update()
    
    def update(self):  #Se actualiza el texto para modificar la cantidad de vidas
        self.image = self.font.render(self.text, True , self.color)

    def draw(self, surface):  #Se dibuja el texto en la ventana
        surface.blit(self.image, self.rect)