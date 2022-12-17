import subprocess, pygame, platform, ctypes
from pygame.locals import *
import os

WHITE = (255, 255, 255)

sistema = platform.system() #Obtiene el sistema operativo del pc desde donde se esté ejecutando

def screen_size(): # Obtine la resolución de la pantalla dependiendo del sistema operativo
    if sistema == 'Linux':
        size = (None, None)
        args = ["xrandr", "-q", "-d", ":0"]
        proc = subprocess.Popen(args,stdout=subprocess.PIPE)
        for line in proc.stdout:
            if isinstance(line, bytes):
                line = line.decode("utf-8")
                if "Screen" in line:
                    size = (int(line.split()[7]),  int(line.split()[9][:-1]))
        return size
    else:
        user32 = ctypes.windll.user32
        user32.SetProcessDPIAware()
        WIDTH, HEIGHT = user32.GetSystemMetrics(0), user32.GetSystemMetrics(1)
        return WIDTH, HEIGHT


#-------Tamaño de la pantalla------
WIDTH = screen_size()[0]
HEIGHT = screen_size()[1] - (screen_size()[1]*0.06)


def load_image(filename, width=None, height=None, transparent=False):   #covierte las imagenes a el formato aceptado por pygame y le da las dimensiones deseadas,
                                                                        #ademas de poder quitar el fondo
    try: imagen = pygame.image.load(filename)
    except pygame.error:
        raise SystemExit

    if width != None and height == None or width == None and height != None:
        raise TypeError ("No se puede convertir solo una dimensión de la imagen")

    if width != None and height != None:     #Si width o height son diferentes de "None", redefine el tamaño de la imagen con los parametros dados
        imagen = pygame.transform.scale(imagen, (width, height))
    
    imagen = imagen.convert()

    if transparent:     #Si transparent es igual a True, entonces se le quita el fondo a la imagen
        color = pygame.PixelArray(imagen)
        imagen.set_colorkey(color[0, 0], RLEACCEL)

    return imagen

def countdown(num_of_secs):
    while num_of_secs:
        m, s = divmod(num_of_secs, 60)
        min_sec_format = '{:02d}:{:02d}'.format(m, s)

# def load_images(path):
#     images =  [load_image(path + os.sep + file_name,  WIDTH, HEIGHT) for file_name in sorted(os.listdir(path))]
#     return images

# def load_screen(screen, clock, FPS):
#     images = load_images(path='Carga') 
#     background = AnimatedBackground(position=(0, 0), images=images, delay = 0.03)
#     all_sprites = pygame.sprite.Group(background)
#     active = True

#     while active:
#         dt = clock.tick(FPS)
#         all_sprites.update(dt)

#         screen.blit(background.image, background.rect)

#         all_sprites.draw(screen)
