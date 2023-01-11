#=============================================================================================================#
#                                                     *librerias      
#=============================================================================================================#
import pygame
from pygame.locals import *
#=============================================================================================================#
#                                          *Función para cargar imagenes      
#=============================================================================================================#
def load_image(filename, width = None, height = None, transparent = False, alpha = False):  #convierte las imagenes a el formato aceptado por pygame y le da las dimensiones deseadas
    try: image = pygame.image.load(filename)
    except pygame.error:
        raise SystemExit  #Si la imagen no es valida, muestra un error

    if width != None and height != None:  #Si se coloca un ancho y un alto como parametros, redefine el tamaño de la imagen
        image = pygame.transform.scale(image, (width, height))
    
    if alpha:
        image = image.convert_alpha()  #  Conversión alpha
    else:
        image = image.convert()  #Conversión estandar

    if transparent:  #Quita el fondo a la imagen
        color = pygame.PixelArray(image)
        image.set_colorkey(color[0, 0], RLEACCEL)

    return image