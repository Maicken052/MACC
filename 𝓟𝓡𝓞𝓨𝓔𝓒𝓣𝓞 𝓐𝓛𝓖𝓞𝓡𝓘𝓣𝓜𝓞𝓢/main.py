#=============================================================================================================#                                                           *libraries      
#=============================================================================================================#
import sys
import pygame
from pygame.locals import *
from functions import WIDTH, HEIGHT, WHITE, RED, load_image
from sprites import Cuadricula, number_bottons, Words
#=============================================================================================================#                                                             *Main         
#=============================================================================================================#
def main():
    game = True  #Ciclo del Juego
    FPS = 60

    #Config de la ventana
    screen = pygame.display.set_mode((WIDTH, HEIGHT))
    clock = pygame.time.Clock()
    icon = load_image("Images/Icon.png")
    background_image = load_image("Images/Background.png", WIDTH, HEIGHT)
    pygame.display.set_caption('Sudoku')
    pygame.display.set_icon(icon)

    #Variables para las vidas
    global lifes
    lifes = 5
    lifes_text = Words(f"Lifes: {lifes}", 40, RED, (WIDTH/6, HEIGHT/20))  #Se define los paramentros del texto de vidas

    #Variable para el número que se obtiene al oprimir el click izquierdo
    global number_obtained 
    number_obtained = 0

    #Botones de los números
    one = number_bottons(pygame.image.load('Images/One.png').convert_alpha(), (WIDTH/5.62139918, HEIGHT/1.13), 1)
    two = number_bottons(pygame.image.load('Images/Two.png').convert_alpha(), (WIDTH/3.86968839, HEIGHT/1.13), 2)
    three = number_bottons(pygame.image.load('Images/Three.png').convert_alpha(), (WIDTH/2.9503239, HEIGHT/1.13), 3)
    four = number_bottons(pygame.image.load('Images/Four.png').convert_alpha(), (WIDTH/2.383944155, HEIGHT/1.13), 4)
    five = number_bottons(pygame.image.load('Images/Five.png').convert_alpha(), (WIDTH/2, HEIGHT/1.13), 5)
    six = number_bottons(pygame.image.load('Images/Six.png').convert_alpha(), (WIDTH/1.72257239, HEIGHT/1.13), 6)
    seven = number_bottons(pygame.image.load('Images/Seven.png').convert_alpha(), (WIDTH/1.5127353, HEIGHT/1.13), 7)
    eight = number_bottons(pygame.image.load('Images/Eight.png').convert_alpha(), (WIDTH/1.3484698, HEIGHT/1.13), 8)
    nine = number_bottons(pygame.image.load('Images/Nine.png').convert_alpha(), (WIDTH/1.21638468, HEIGHT/1.13), 9)

    button_numbers_group = pygame.sprite.Group()  #Añade los botones a un grupo
    button_numbers_group.add(one)
    button_numbers_group.add(two)
    button_numbers_group.add(three)
    button_numbers_group.add(four)
    button_numbers_group.add(five)
    button_numbers_group.add(six)
    button_numbers_group.add(seven)
    button_numbers_group.add(eight)
    button_numbers_group.add(nine)
    
    #Crear y generar una cuadricula
    grid = Cuadricula((WIDTH/2, HEIGHT/2))
    grid.generador()
    box_group = grid.get_casillas_group()

    #*Ciclo while del juego
    while game:
        clock.tick(FPS)

        screen.blit(background_image, (0, 0))  #Poner el fondo
        grid.draw(screen)  #Pone en pantalla la cuadricula
        button_numbers_group.draw(screen)  #Pone en pantalla los botones de los números
        lifes_text.draw(screen)  #Pone en pantalla las vidas

        #Detectar las entradas del teclado o ratón

        for event in pygame.event.get():  #Si el usurario quiere salir
            if event.type == QUIT:  #Si se presiona el boton con la X roja
                pygame.quit()
                sys.exit(0)
            elif event.type == KEYDOWN:
                if event.key == K_ESCAPE:  #Si se presiona la tecla escape
                    sys.exit(0)


            if event.type == MOUSEBUTTONDOWN and event.button == 1:  #Si se oprime el click izquierdo

                for pulsed_button in button_numbers_group.sprites():  #Revisa todos los botones
                    if pulsed_button.rect.collidepoint(pygame.mouse.get_pos()):  #Si el mouse esta oprimido en la posición de un botón, se obtiene el número del botón.
                        number_obtained = pulsed_button.get_number()
                        break

                for box in box_group.sprites():  #Revisa todas las casillas
                    if box.rect.collidepoint(pygame.mouse.get_pos()):  #Si el mouse esta oprimido en la posición de una casilla.
                        if number_obtained != 0 and box.get_dato() == 0:  #se pone el número obtenido anteriormente (si se obtuvo alguno) en la casilla.
                            if box.solved_data == number_obtained:  #Si el número que se va a colocar en la casilla es correcto
                                box.set_dato(number_obtained)
                            else:
                                lifes -= 1  #Si no, se quita una vida

        grid.update()  #Se actualiza la cuadricula en pantalla después de la acción del jugador
        lifes_text.text = f"lifes: {lifes}"  #Se actualizan las vidas
        lifes_text.update()

        if lifes <= 0:  #Si se acaban las vidas, se pierde el juego
            game = False

        pygame.display.flip() #Actualizar contenido en pantalla

if __name__ == '__main__':
    pygame.init()
    main()