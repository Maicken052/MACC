#=============================================================================================================#                                                           *libraries      
#=============================================================================================================#
import subprocess, pygame, platform, ctypes
from pygame.locals import *
#=============================================================================================================#                                                     *Config de la pantalla   
#=============================================================================================================#
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

WIDTH = screen_size()[0]  #Ancho de la pantalla
HEIGHT = screen_size()[1]- screen_size()[1]*0.08  #Largo de la pantalla
#=============================================================================================================#                                                   *Función para cargar imagenes      
#=============================================================================================================#
def load_image(filename, width=None, height=None, transparent=False, alpha=False):  #covierte las imagenes a el formato aceptado por pygame y le da las dimensiones deseadas
    try: imagen = pygame.image.load(filename)
    except pygame.error:
        raise SystemExit  #Si la imagen no es valida, muestra un error

    if width != None and height != None:  #Si width y height existen, redefine el tamaño de la imagen con los parametros dados
        imagen = pygame.transform.scale(imagen, (width, height))
    
    if alpha:
        imagen = imagen.convert_alpha()  #  Conversión alpha
    else:
        imagen = imagen.convert()  #Conversión estandar

    if transparent:  #Si transparent es igual a True, entonces se le quita el fondo a la imagen
        color = pygame.PixelArray(imagen)
        imagen.set_colorkey(color[0, 0], RLEACCEL)

    return imagen