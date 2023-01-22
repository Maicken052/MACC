#=============================================================================================================#
#                                                    *librerias  
#=============================================================================================================#
import pygame
from pygame.locals import *
from functions import load_image
#=============================================================================================================#
#                                              *Clase pantalla de carga         
#=============================================================================================================#
class loading_screen():
    def __init__(self):
        self.gif = []  #Lista donde se guarda el gif con cada una de las imagenes

        for i in range(30):  #Se añaden las imagenes a la lista
            self.gif.append(load_image(f"Loading screen/{i}.png", 1280, 720))

        self.current_img = 0  

        self.image = self.gif[self.current_img]
        self.rect = self.image.get_rect(center = (640, 360))
        
    def update(self, speed):  #Hacer que las imagenes parezcan un gif
        self.current_img += speed
        if self.current_img < len(self.gif):
            self.image = self.gif[int(self.current_img)]
        else:
            self.current_img = 0

    def draw(self, surface):
        surface.blit(self.image, self.rect)
        
    def run(self, surface):
        self.draw(surface)
        self.update(0.4)