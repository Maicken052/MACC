#=============================================================================================================#
#                                                    *librerias  
#=============================================================================================================#
import pygame
from pygame.locals import *
from dokusan import generators
import numpy as np
from copy import deepcopy
from functions import load_image
#=============================================================================================================#
#                                           *Clase números de las casillas      
#=============================================================================================================#
class box_numbers(pygame.sprite.Sprite): 
    def __init__(self, img_size:tuple, pos:tuple, number:int = 0):
        
        #Condiciones para que el programa cumpla su función adecuadamente
        if(pos[0] < 0 or pos[1] < 0):
            raise ValueError ("No se reciben valores negativos")
        
        if(number not in range(0,10)):
            raise ValueError ("Solo se reciben valores del 0 al 9")

        #Parametros
        self.img_size = img_size #Tamaño de la imagen
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
        self.image = load_image(self.possible_imgs[self.number], self.img_size[0], self.img_size[1])  #Se ajusta al tamaño deseado y se escoge una imagen del diccionario según el número que corresponda
        self.rect = self.image.get_rect(center = pos)  #Rectangulo con las coordenadas para posicionar la imagen

    #Métodos
    def set_number(self, num:int):  #Setter para actualizar el número de la casilla
        self.number = num
        self.image = load_image(self.possible_imgs[self.number], self.img_size[0], self.img_size[1]) 

    def get_number(self):  #Getter para obtener el número de la casilla
        return self.number

    def update(self, img_size:tuple, pos:tuple):  #Se actualiza el tamaño y la posición
        self.img_size = img_size  #Se actualiza el parametro del tamaño
        self.image = load_image(self.possible_imgs[self.number], self.img_size[0], self.img_size[1])  #Se ajusta la imagen al nuevo tamaño
        self.rect.size = img_size  #Se ajusta el tamaño del rect
        self.rect.center = pos  #Se ajusta el centro del rect

    def draw(self, surface):  #Dibuja la imagen del número que va en la casilla
        surface.blit(self.image, self.rect)
#=============================================================================================================# 
#                                                 *Clase casilla   
#=============================================================================================================#
class box(pygame.sprite.Sprite): 
    def __init__(self, img_size:tuple, num_size:tuple, pos:tuple, num_in_box:int = 0, background_color:int = 0):
        super().__init__()

        #Condiciones para que el programa cumpla su función adecuadamente
        if(num_in_box not in range(0,10)):
            raise ValueError ("Solo se reciben valores del 0 al 9")

        #Parametros
        self.image = load_image('Images/Box.png', img_size[0], img_size[1], True) #Se ajusta al tamaño deseado y se escoge la imagen que corresponda
        self.rect = self.image.get_rect()  #Se crea un rectangulo para que se pueda interactuar con la casilla

        #Posición de la casilla (Arriba, Abajo, Derecha, Izquierda, Centro en x, Centro en y)
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

        self.data = box_numbers(num_size, (self.rect.centerx, self.rect.centery), num_in_box)  #El dato dentro de la casilla es el número que corresponde
        self.correct_number = 0  #El número que debe ir en la casilla
        self.background_color = background_color  #El color de fondo de la casilla(Puede ser verde si esta bien, rojo si esta mal, y blanco si no se pone nada)

        #Imagen del color verde dentro de la casilla
        self.correct_num_color = load_image("Images/LightGreen.png", self.rect.width/1.5, self.rect.height/1.5)  #Se carga la imagen verde con su tamaño (derivado del tamaño de la casilla)
        self.correct_num_color_rect = self.correct_num_color.get_rect(center = self.rect.center)  #Se obtiene el rect

        #Imagen del color rojo dentro de la casilla
        self.wrong_num_color = load_image("Images/LightRed.png", self.rect.width/1.5, self.rect.height/1.5)  #Se carga la imagen roja con su tamaño (derivado del tamaño de la casilla)
        self.wrong_num_color_rect = self.wrong_num_color.get_rect(center = self.rect.center)  #Se obtiene el rect

    #Métodos
    def get_data(self):  #Getter que retorna el número en la casilla
        if self.background_color == 2:  #Si el fondo está en rojo, es porque el número esta mal, por lo que se considera como si no tuviera nada y retorna 0
            return 0
        else:
            return self.data.get_number()

    def get_correct_number(self):  #Getter que retorna el número correcto
        return self.correct_number

    def set_data(self, num:int, option:int, color:int = 0):  #setter con dos opciones
        if option == 1:  #Poner el número que se ve en la ventana y el color de fondo
            self.data.set_number(num)
            self.background_color = color
        if option == 2:  #Poner el dato correcto
            self.correct_number = num

    def update(self, img_size:tuple, num_size:tuple, pos:tuple):  #Se actualiza el tamaño y la posición
        self.image = load_image('Images/Box.png', img_size[0], img_size[1], True)  #Se ajusta la imagen al nuevo tamaño
        self.rect.size= img_size  #Se ajusta el tamaño del rect

        #Actualizar posición de la casilla (Arriba, Abajo, Derecha, Izquierda, Centro en x, Centro en y)
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

        self.data.update(num_size, (self.rect.centerx, self.rect.centery))  #Se actualiza el tamaño del número dentro de la casilla y su posición

        #Se actualiza el color verde de la casilla
        self.correct_num_color = load_image("Images/LightGreen.png", self.rect.width/1.5, self.rect.height/1.5)  #Se ajusta la imagen al nuevo tamaño
        self.correct_num_color_rect = self.correct_num_color.get_rect(center = self.rect.center)  #Se ajusta el rect del color al nuevo tamaño y posición

        #Se actualiza el color rojo de la casilla
        self.wrong_num_color = load_image("Images/LightRed.png", self.rect.width/1.5, self.rect.height/1.5)  #Se ajusta la imagen al nuevo tamaño
        self.wrong_num_color_rect = self.wrong_num_color.get_rect(center = self.rect.center)  #Se ajusta el rect del color al nuevo tamaño y posición


    def draw(self, surface): #Dibuja la casilla, su color de fondo y número según corresponda
        if self.background_color == 0:  #Si no lleva color de fondo
            surface.blit(self.image, self.rect)  #Primero se dibuja la casilla
            self.data.draw(surface)  #Y después el dato

        if self.background_color == 1:  #Si se pone color verde de fondo
            surface.blit(self.correct_num_color, self.correct_num_color_rect)  #Se coloca el color verde
            surface.blit(self.image, self.rect)  #Después se dibuja la casilla
            self.data.draw(surface)  #Y por último se coloca el dato

        if self.background_color == 2:  #Si se pone color rojo de fondo
            surface.blit(self.wrong_num_color, self.wrong_num_color_rect)  #Se coloca el color rojo
            surface.blit(self.image, self.rect)  #Después se dibuja la casilla
            self.data.draw(surface)  #Y por último se coloca el dato
#=============================================================================================================#
#                                             *Clase subcuadricula  
#=============================================================================================================#
class subgrid(pygame.sprite.Sprite):  #Se hereda el init de la clase sprite de pygame
    def __init__(self, img_size:tuple, box_size:tuple, num_size:tuple, pos:tuple):
        super().__init__()

        self.image = load_image('Images/WHITE.png', img_size[0], img_size[1]) #Se ajusta al tamaño deseado y se escoge la imagen correspondiente
        self.rect = self.image.get_rect()  #Se crea un rectangulo para que se pueda interactuar con la subcuadricula

        #Posición de la subcuadricula (Arriba, Abajo, Derecha, Izquierda, Centro en x, Centro en y)
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
                    1: (self.rect.top, None, None, self.rect.left, None, None), #Superior izquierdo 
                    2: (self.rect.top, None, None, None, self.rect.centerx, None), #Superior centrado
                    3: (self.rect.top, None, self.rect.right, None, None, None), #Superior derecho

                    4: (None, None, None, self.rect.left, None, self.rect.centery), #Centro izquierda
                    5: (None, None, None, None, self.rect.centerx, self.rect.centery), #Centro 
                    6: (None, None, self.rect.right, None, None, self.rect.centery), #Centro derecha
                    
                    7: (None, self.rect.bottom, None, self.rect.left, None, None), #Inferior izquierda
                    8: (None, self.rect.bottom, None, None, self.rect.centerx, None), #Inferior centrado
                    9: (None, self.rect.bottom, self.rect.right, None, None, None), #Inferior derecha
                    }

        #Creación de una matriz con todos los objetos casilla
        self.rows = 3  #Número de filas
        self.columns = 3  #Número de columnas
        self.matrix_of_boxes = []
        self.box_group = pygame.sprite.Group()  #Grupo sprite con los objetos casilla
        count = 1

        for i in range(self.rows):
            list_of_rows = []  #crea la lista donde guarda cada fila con casillas
            for j in range(self.columns):
                box_ = box(box_size, num_size, self.pos_of_boxes[count]) #crea un objeto casilla y le asigna valor 0, junto con su debida posición
                list_of_rows.append(box_) #lo agrega a la lista de fila
                self.box_group.add(box_)  #Se agrega la casilla al grupo casilla
                count += 1
            self.matrix_of_boxes.append(list_of_rows)

    #Métodos
    def get_data(self, x:int, y:int):  #Getter para obtener el dato de la casilla que esta en la matriz
        return self.matrix_of_boxes[x][y].get_data()

    def get_box_group(self):  #Getter para obtener el grupo sprite de casillas
        return self.box_group
        
    def set_data(self, num:int, x:int, y:int, option:int):  #Setter para poner un dato en una casilla de la matriz según la opción
        if option == 1:
            self.matrix_of_boxes[x][y].set_data(num, 1)
        if option == 2:
            self.matrix_of_boxes[x][y].set_data(num, 2)
    
    def update(self, img_size:tuple, box_size:tuple, num_size:tuple, pos:tuple):  #Se actualiza el tamaño y la posición
        self.image = load_image('Images/WHITE.png', img_size[0], img_size[1])  #Se ajusta la imagen al nuevo tamaño
        self.rect.size = img_size  #Se ajusta el tamaño del rect

        #Se actualiza la posición de la subcuadricula (Arriba, Abajo, Derecha, Izquierda, Centro en x, Centro en y)
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

        #Se actualiza la posición que le corresponde a cada casilla
        self.pos_of_boxes.update({
            1: (self.rect.top, None, None, self.rect.left, None, None), #Superior izquierdo 
            2: (self.rect.top, None, None, None, self.rect.centerx, None), #Superior centrado
            3: (self.rect.top, None, self.rect.right, None, None, None), #Superior derecho

            4: (None, None, None, self.rect.left, None, self.rect.centery), #Centro izquierda
            5: (None, None, None, None, self.rect.centerx, self.rect.centery), #Centro 
            6: (None, None, self.rect.right, None, None, self.rect.centery), #Centro derecha
            
            7: (None, self.rect.bottom, None, self.rect.left, None, None), #Inferior izquierda
            8: (None, self.rect.bottom, None, None, self.rect.centerx, None), #Inferior centrado
            9: (None, self.rect.bottom, self.rect.right, None, None, None), #Inferior derecha
        })

        count = 1
        for i in range(self.rows):
            for j in range(self.columns):
                self.matrix_of_boxes[i][j].update(box_size, num_size, self.pos_of_boxes[count])  #Se actualizan los parametros de cada casilla
                count += 1     

    def draw(self, surface):  #Dibuja la subcuadricula, invocando el draw de cada casilla
        surface.blit(self.image, self.rect)  #Primero se dibuja la subcuadricula
        for i in range(self.rows):
            for j in range(self.columns):
                self.matrix_of_boxes[i][j].draw(surface)  #Y después cada casilla
#=============================================================================================================#
#                                                *Clase cuadricula
#=============================================================================================================#
class grid(pygame.sprite.Sprite):  #Se hereda el init de la clase sprite de pygame
    def __init__(self,img_size:tuple, subgrid_size:tuple, box_size:tuple, num_size:tuple, pos:tuple):
        super().__init__()

        #Condiciones para que el programa cumpla su función adecuadamente
        if(pos[0] < 0 or pos[1] < 0):
            raise ValueError ("No se reciben valores negativos")

        self.image = load_image('Images/WHITE.png', img_size[0], img_size[1])  #Se ajusta al tamaño deseado y se escoge la imagen correspondiente 
        self.rect = self.image.get_rect(center = pos)  #Se crea el rectangulo centrado en la posición dada

        self.pos_of_subgrids = {  #Posición que va a tener cada una de las 9 subcuadriculas, dependiendo de las coordenadas del rectangulo de la cuadricula
                    1: (self.rect.top, None, None, self.rect.left, None, None), #Superior izquierdo 
                    2: (self.rect.top, None, None, None, self.rect.centerx, None), #Superior centrado
                    3: (self.rect.top, None, self.rect.right, None, None, None), #Superior derecho

                    4: (None, None, None, self.rect.left, None, self.rect.centery), #Centro izquierda
                    5: (None, None, None, None, self.rect.centerx, self.rect.centery), #Centro 
                    6: (None, None, self.rect.right, None, None, self.rect.centery), #Centro derecha
                    
                    7: (None, self.rect.bottom, None, self.rect.left, None, None), #Inferior izquierda
                    8: (None, self.rect.bottom, None, None, self.rect.centerx, None), #Inferior centrado
                    9: (None, self.rect.bottom, self.rect.right, None, None, None), #Inferior derecha
                    }

        self.sudoku = []  #En esta matriz se almacena el sudoku sin resolver
        self.solved_sudoku = []  #En esta matriz se almacena el sudoku resuelto

        #Creación de una matriz con las subcuadriculas
        self.rows = 3  #Número de filas
        self.columns = 3  #Número de columnas
        self.matrix_of_subgrids = []
        self.subgrid_group = pygame.sprite.Group() #Grupo de subcuadriculas
        count = 1

        for i in range(self.rows):
            list_of_rows = []  #Se crea una lista que guarda las rows
            for j in range(self.columns):
                sub = subgrid(subgrid_size, box_size, num_size, self.pos_of_subgrids[count])  #Se crea la subcuadricula con la posición correspondiente
                list_of_rows.append(sub)  #Se agrega la lista
                self.subgrid_group.add(sub)  #Se agrega al grupo
                count += 1
            self.matrix_of_subgrids.append(list_of_rows)  #Se agrega la fila a la matriz

    #Métodos
    def get_data(self, x:int, y:int, xs:int, ys:int):  #Getter que retorna una casilla, dependiendo del indice de la cuadricula y subcuadricula
        return self.matrix_of_subgrids[x][y].get_data(xs, ys)

    def get_subgrid_group(self):  #Getter que retorna el grupo sprite de subcuadriculas
        return self.subgrid_group

    def set_data(self, num:int, x:int, y:int, xs:int, ys:int, option: int):  #Setter que pone un dato en una casilla, dependiendo del indice de la cuadricula, subcuadricula y la opción escogida
        if option == 1:
            self.matrix_of_subgrids[x][y].set_data(num, xs, ys, 1)
        if option == 2:
            self.matrix_of_subgrids[x][y].set_data(num, xs, ys, 2)

    def update(self, img_size:tuple, subgrid_size:tuple, box_size:tuple, num_size:tuple, pos:tuple):
        self.image = load_image('Images/WHITE.png', img_size[0], img_size[1])  #Se ajusta la imagen al nuevo tamaño
        self.rect.size = img_size  #Se ajusta el tamaño del rect
        self.rect.center = pos  #Se ajusta el centro del rect

        #Se actualiza la posición que le corresponde a cada casilla
        self.pos_of_subgrids.update({
            1: (self.rect.top, None, None, self.rect.left, None, None), #Superior izquierdo 
            2: (self.rect.top, None, None, None, self.rect.centerx, None), #Superior centrado
            3: (self.rect.top, None, self.rect.right, None, None, None), #Superior derecho

            4: (None, None, None, self.rect.left, None, self.rect.centery), #Centro izquierda
            5: (None, None, None, None, self.rect.centerx, self.rect.centery), #Centro 
            6: (None, None, self.rect.right, None, None, self.rect.centery), #Centro derecha
            
            7: (None, self.rect.bottom, None, self.rect.left, None, None), #Inferior izquierda
            8: (None, self.rect.bottom, None, None, self.rect.centerx, None), #Inferior centrado
            9: (None, self.rect.bottom, self.rect.right, None, None, None), #Inferior derecha
        })

        count = 1
        for i in range(self.rows):
            for j in range(self.columns):
                (self.matrix_of_subgrids[i][j]).update(subgrid_size, box_size, num_size, self.pos_of_subgrids[count])  #Se actualizan los parametros de cada subcuadricula
                count+=1

    def draw(self, surface): #Dibuja la cuadricula, invocando el draw de cada subcuadricula
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

    def generator(self, dificult: int):  #Función encargada de generar un sudoku y llenar las casillas con el dato del sudoku incompleto que se muestra en la ventana, además del dato correcto para su posterior verificación y reiniciar el color de las casillas.

        self.sudoku = np.array(list(str(generators.random_sudoku(avg_rank = dificult)))).reshape(9,9).astype(int)  #Se crea el sudoku en base a un generador
        self.solved_sudoku = self.sudoku_solver(deepcopy(self.sudoku))  #Se hace una copia del sudoku para no modificar la variable original, despúes se usa la función para resolver ese sudoku y se guarda en una variable

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
                self.set_data(self.sudoku[f][c], x, y, xs, c%3, 1)
                self.set_data(self.solved_sudoku[f][c], x, y, xs, c%3, 2)
            if xs == 2:
                xs = 0
            else:
                xs += 1