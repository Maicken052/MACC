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
#=============================================================================================================#
#                                          *Revisar si un botón está oprimido     
#=============================================================================================================#
def check_if_pressed(button, size):  #Revisa si un botón númerico esta oprimido, y lo devuelve a su estado normal
        if button != None:
            button.click(size)
            button = None
#=============================================================================================================#
#                                                   *Reiniciar juego    
#=============================================================================================================#
def restart(game_grid, dificult:int, pressed_button, button_size):  #Reinicia todos los elementos de la partida
    game_grid.generator(dificult)  
    lifes = 5
    put_hint = False 
    check_if_pressed(pressed_button, button_size)
    number_obtained = 0 
    return lifes, put_hint, number_obtained