#=============================================================================================================#
#                                                    *librerias  
#=============================================================================================================#
import pygame
from pygame.locals import *
from functions import load_image
#=============================================================================================================#
#                                           *Clase Botones de los números         
#=============================================================================================================#
class number_buttons(pygame.sprite.Sprite):  #Se hereda el init de la clase sprite de pygame
    def __init__(self, image_pic, img_size:tuple, pos:tuple, number:int):
        super().__init__()

        #Condiciones para que el programa cumpla su función adecuadamente
        if(pos[0] < 0 or pos[1] < 0):
            raise ValueError ("No se reciben valores negativos")
        
        if(number not in range(1,10)):
            raise ValueError ("Solo se reciben valores del 1 al 9")

        #Parametros
        self.image_pic = image_pic  #Png de la imagen
        self.number = number  #El número que va a guardar dicho botón
        self.image = load_image(self.image_pic, img_size[0], img_size[1], False, True)  #Se ajusta la imagen al tamaño deseado y se aplica la conversión alpha
        self.rect = self.image.get_rect(topleft = pos)  #Se crea un rectangulo para que se pueda interactuar con dicho botón y se le dan las coordenadas en la esquina superior izquierda
    
    #Métodos
    def get_number(self):  #Getter que retorna el número del botón
        return self.number

    def update(self, img_size:tuple, pos:tuple):  #Se actualiza el tamaño y la posición
        self.image = load_image(self.image_pic, img_size[0], img_size[1], False, True)  #Se ajusta la imagen al nuevo tamaño
        self.rect.update(pos, img_size)  #Se actualizan los parametros del rect

    def draw(self, surface):  #Dibuja la imagen del botón 
        surface.blit(self.image, self.rect)
#=============================================================================================================# 
#                                               *Clase Botones con acciones 
#=============================================================================================================#
class actions_buttons(): 
    def __init__(self, image_pic, img_size:tuple, pos:tuple):

        #Condiciones para que el programa cumpla su función adecuadamente
        if(pos[0] < 0 or pos[1] < 0):
            raise ValueError ("No se reciben valores negativos")

        #Parametros
        self.image_pic = image_pic  #Png de la imagen
        self.image = load_image(self.image_pic, img_size[0], img_size[1], False, True)  #Se ajusta la imagen al tamaño deseado y se aplica la conversión alpha
        self.rect = self.image.get_rect(topleft = pos)  #Se crea un rectangulo para que se pueda interactuar con dicho botón y se le dan las coordenadas en la esquina superior izquierda
    
    #Métodos
    def update(self, img_size:tuple, pos:tuple):  #Se actualiza el tamaño y la posición
        self.image = load_image(self.image_pic, img_size[0], img_size[1], False, True)  #Se ajusta la imagen al nuevo tamaño
        self.rect.update(pos, img_size)  #Se actualizan los parametros del rect

    def draw(self, surface):  #Dibuja la imagen del botón 
        surface.blit(self.image, self.rect)
#=============================================================================================================#
#                                                   *Clase palabra   
#=============================================================================================================#
class word(): 
    def __init__(self, text:str, size:int, color:tuple, pos:tuple):
        
        self.font = pygame.font.Font('Images/Font.TTF', size)  #Se elige la fuente para el texto
        self.text = text  #Texto que se muestra
        self.color = color  #Color del texto
        self.image = self.font.render(self.text, True, self.color)  #Se pone el texto y el color
        self.rect = self.image.get_rect(topleft = pos)  #Se obtiene el rectangulo y se ubica en las coordenadas dadas

    #Getters y setters
    @property
    def text_(self):  #Getter para obtener el texto
        return self.text

    @text_.setter
    def text_(self, text:str):  #Setter para poner el texto
        self.text = text
        self.image = self.font.render(self.text, True , self.color)  #Se actualiza el texto

    @property
    def color_(self):  #Getter para obtener el color
        return self.color
    
    @color_.setter
    def color_(self, color:tuple):  #Setter para poner el color
        self.color = color 
        self.image = self.font.render(self.text, True , self.color)  #Se actualiza el color

    #Métodos
    def update(self, size:int, pos:tuple):  #Se actualiza el tamaño y la posición
        self.font = pygame.font.Font('Images/Font.TTF', size)  #Se cambia el tamaño del texto
        self.image = self.font.render(self.text, True, self.color)  #Se pone el texto y el color actualizados al tamaño
        self.rect = self.image.get_rect(topleft = pos)  #Se obtiene el rect con el nuevo tamaño

    def draw(self, surface):  #Se dibuja el texto en la ventana
        surface.blit(self.image, self.rect)