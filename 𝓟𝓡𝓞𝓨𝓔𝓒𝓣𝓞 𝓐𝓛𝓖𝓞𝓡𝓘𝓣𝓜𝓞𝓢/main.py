#=============================================================================================================#                                                           *librerias      
#=============================================================================================================#
import sys
import pygame
from pygame.locals import *
from functions import *
from sprites import grid, number_buttons, word, actions_buttons
#=============================================================================================================#                                                        *Colores usados 
#=============================================================================================================#
RED_1 = (213, 57, 48)  #Color rojo 1 en RGB
GREEN = (18, 247, 51)  #Color verde en RGB
ORANGE = (255, 129, 0)  #Color blanco en RGB
RED_2 = (255, 17, 0)  #Color rojo 2 en RGB
WHITE = (255, 255, 255)  #Color blanco en RGB
GREY = (169, 169, 169)  #Color gris en RGB
#=============================================================================================================#                                                             *Main         
#=============================================================================================================#
def main():
    game = True  #Ciclo del Juego
    FPS = 60

    #Config de la ventana
    screen = pygame.display.set_mode((WIDTH, HEIGHT))  #Pantalla
    clock = pygame.time.Clock()  #Reloj
    icon = load_image("Images/Icon.png")  #Icono de la esquina de la ventana
    background_image = load_image("Images/Background.png", WIDTH, HEIGHT)  #Fondo
    pygame.display.set_caption('Sudoku')  #Nombre de la ventana
    pygame.display.set_icon(icon)

    #Variables para las vidas
    global lifes
    lifes = 5  #Cantidad de vidas
    lifes_text = word(f"Lifes: {lifes}", 45, RED_1, (WIDTH/1.588, HEIGHT/20))  #Se define los paramentros del texto de vidas

    #Dificultades
    y_pos = HEIGHT/1.062496240601504 #Posición y de las dificultades
    easy_xpos = WIDTH/1.366  #Posición x de la dificultad fácil
    medium_xpos = WIDTH/1.18782608695652  #Posición x de la dificultad media
    dificult_xpos = WIDTH/1.05076923076923  #posición x de la dificultad difícil

    easy = word(f"easy", 30, GREEN, (easy_xpos, y_pos))  #Se crea la palabra "easy" con sus debidos parametros
    easy_dificult = 50
    medium = word(f"medium", 30, GREY, (medium_xpos, y_pos))  #Se crea la palabra "medium" con sus debidos parametros
    medium_dificult = 100
    hard = word(f"hard", 30, GREY, (dificult_xpos, y_pos))  #Se crea la palabra "hard" con sus debidos parametros
    hard_dificult = 150

    dificult = easy_dificult  #Dificultad inicial

    #Variable para el número que se obtiene al oprimir el click izquierdo
    global number_obtained 
    number_obtained = 0

    #Botones de los números
    first_xpos = WIDTH/1.524553571428572  #Posición x de la primera fila
    first_ypos = HEIGHT/2.616888888888888  #Posición y de la primera fila
    second_xpos = WIDTH/1.31853281853282  #Posición x de la segunda fila
    second_ypos = HEIGHT/1.72331707317073  #Posición y de la segunda fila
    third_xpos = WIDTH/1.161564625850349  #Posición x de la tercera fila
    third_ypos = HEIGHT/1.284654545454545  #Posición y de la tercera fila

    one = number_buttons('Images/One.png', (first_xpos, first_ypos), 1)  #Se crean los 9 botones con sus debidos parametros
    two = number_buttons('Images/Two.png', (second_xpos, first_ypos), 2)
    three = number_buttons('Images/Three.png', (third_xpos, first_ypos), 3)
    four = number_buttons('Images/Four.png', (first_xpos, second_ypos), 4)
    five = number_buttons('Images/Five.png', (second_xpos, second_ypos), 5)
    six = number_buttons('Images/Six.png', (third_xpos, second_ypos), 6)
    seven = number_buttons('Images/Seven.png', (first_xpos, third_ypos), 7)
    eight = number_buttons('Images/Eight.png', (second_xpos, third_ypos), 8)
    nine = number_buttons('Images/Nine.png', (third_xpos, third_ypos), 9)

    button_numbers_group = pygame.sprite.Group()  #Se añaden los botones a un grupo sprite
    button_numbers_group.add(one)
    button_numbers_group.add(two)
    button_numbers_group.add(three)
    button_numbers_group.add(four)
    button_numbers_group.add(five)
    button_numbers_group.add(six)
    button_numbers_group.add(seven)
    button_numbers_group.add(eight)
    button_numbers_group.add(nine)

    #Botones de acciones
    buttons_width = WIDTH/6.83  #Anchura de los botones de pista y solución
    hint = actions_buttons('Images/HintButton.png', (WIDTH/1.484782608695652, HEIGHT/5.43507692307694), buttons_width, HEIGHT/8.94379746835443)  #Botón de "Pista"
    put_hint = False  #Variable para saber si la pista esta activa o no
    answer = actions_buttons('Images/AnswerButton.png', (WIDTH/1.18782608695652, HEIGHT/5.43507692307694), buttons_width, HEIGHT/8.94379746835443)  #Botón de "respuesta"
    new_game = actions_buttons('Images/NewGameButton.png', (WIDTH/1.665853658536585, HEIGHT/1.062496240601504), buttons_width, HEIGHT/12.3957894736842)  #Botón de "Nuevo juego"

    #Crear y generar una cuadricula
    game_grid = grid((WIDTH/3.86968838526912, HEIGHT/2))  #Se crea la cuadricula
    game_grid.generator(dificult)  #Se genera la partida
    subgrid_group = game_grid.get_subgrid_group()  #Grupo de subcuadriculas
    lines_size = WIDTH/1.93484419263456  #Tamaño de las lineas de la cuadricula
    lines = load_image("Images/Sudoku_lines.png",lines_size, lines_size, False, True)  #Lineas de la cuadricula
    
    #*Ciclo while del juego
    while game:
        clock.tick(FPS)

        screen.blit(background_image, (0, 0))  #Poner el fondo
        game_grid.draw(screen)  #Pone en pantalla la cuadricula
        screen.blit(lines, (0, 0))  #Poner el fondo
        button_numbers_group.draw(screen)  #Pone en pantalla los botones de los números
        lifes_text.draw(screen)  #Pone en pantalla las vidas
        easy.draw(screen) #Pone en pantalla la dificultad facil
        medium.draw(screen) #Pone en pantalla la dificultad media
        hard.draw(screen) #Pone en pantalla la dificultad dificil
        new_game.draw(screen)  #Pone en pantalla el botón de "juego nuevo"
        hint.draw(screen)  #Pone en pantalla el botón de "pista"
        answer.draw(screen)  #Pone en pantalla el botón de "solución"

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

                for subgrid in subgrid_group.sprites():  #Revisa todas las subcuadriculas
                    if subgrid.rect.collidepoint(pygame.mouse.get_pos()):  #Si el mouse esta oprimido en la posición de una subcuadricula
                        box_group = subgrid.get_box_group()  #Creamos el grupo de casillas de la subcuadricula
                        for box in box_group.sprites():
                            if box.rect.collidepoint(pygame.mouse.get_pos()):  #Si el mouse esta oprimido en la posición de una casilla
                                if put_hint:  #Si el botón de pista esta activo
                                    box.set_data(box.get_correct_number())
                                    put_hint = False
                                    break
                                if number_obtained != 0 and box.get_data() == 0:  #si se obtuvo un número del botón y la casilla no tiene número
                                    if box.get_correct_number() == number_obtained:  #Si el número que se va a colocar en la casilla es correcto
                                        box.set_data(number_obtained)
                                    else:
                                        lifes -= 1  #Si no, se quita una vida
                    
                if hint.rect.collidepoint(pygame.mouse.get_pos()):  #Si se oprime el botón de pista
                    put_hint = True
                    
                if answer.rect.collidepoint(pygame.mouse.get_pos()):  #Si se oprime el botón de resolver
                    for subgrid in subgrid_group.sprites():  #Revisa todas las subcuadriculas
                        box_group = subgrid.get_box_group()  #Creamos el grupo de casillas de la subcuadricula
                        for box in box_group.sprites():  #Revisa todas las casillas
                            if box.get_data() == 0:  #Si aún no tiene dato la casilla
                                box.set_data(box.get_correct_number())  #Se coloca el dato resuelto

                if new_game.rect.collidepoint(pygame.mouse.get_pos()):  #Si se oprime el boton de juego nuevo
                    game_grid.generator(dificult)  #Generamos una nueva partida
                    lifes = 5  #Y reiniciamos las vidas

                if easy.rect.collidepoint(pygame.mouse.get_pos()):  #Si se cambia a la dificultad facil
                    #Se pone en color solo el botón de easy
                    easy.color_ = GREEN
                    medium.color_ = GREY
                    hard.color_ = GREY
                    dificult = easy_dificult  #Se pone dificultad facil
                    game_grid.generator(dificult)  #Se genera una nueva partida
                    lifes = 5  #Se reinician las vidas

                if medium.rect.collidepoint(pygame.mouse.get_pos()):  #Si se cambia a la dificultad medio
                    #Se pone en color solo el botón de medium
                    easy.color_ = GREY
                    medium.color_ = ORANGE
                    hard.color_ = GREY
                    dificult = medium_dificult  #Se pone dificultad media
                    game_grid.generator(dificult)  #Se genera una nueva partida
                    lifes = 5  #Se reinician las vidas
                
                if hard.rect.collidepoint(pygame.mouse.get_pos()):  #Si se cambia a la dificultad dificil
                    #Se pone en color solo el botón de hard
                    easy.color_ = GREY
                    medium.color_ = GREY
                    hard.color_ = RED_2
                    dificult = hard_dificult  #Se pone dificultad dificil
                    game_grid.generator(dificult)  #Se genera una nueva partida
                    lifes = 5  #Se reinician las vidas
                    
        lifes_text.text_ = f"lifes: {lifes}"  #Se actualizan las vidas

        if lifes <= 0:  #Si se acaban las vidas, se pierde el juego
            game = False

        pygame.display.flip() #Actualizar contenido en pantalla

if __name__ == '__main__':
    pygame.init()
    main()