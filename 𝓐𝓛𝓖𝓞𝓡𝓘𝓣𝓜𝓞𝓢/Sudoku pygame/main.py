#=============================================================================================================#     
#                                                    *librerias      
#=============================================================================================================#
import sys
import pygame
from pygame.locals import *
from functions import load_image
from Grid_sprites import grid
from Buttons_sprites import number_buttons, actions_buttons, word
#=============================================================================================================#     
#                                                  *Colores usados 
#=============================================================================================================#
RED_1 = (213, 57, 48)  #Color rojo 1 en RGB
GREEN = (18, 247, 51)  #Color verde en RGB
ORANGE = (255, 129, 0)  #Color blanco en RGB
RED_2 = (255, 17, 0)  #Color rojo 2 en RGB
WHITE = (255, 255, 255)  #Color blanco en RGB
GREY = (169, 169, 169)  #Color gris en RGB
#=============================================================================================================#      
#                                                       *Main         
#=============================================================================================================#
def main():
    game = True  #Ciclo del Juego
    FPS = 60
    
    #Fullscreen
    screen_info = pygame.display.Info()  #Información de la pantalla en la que se esta corriendo el juego
    WIDTH = screen_info.current_w #Ancho de la pantalla
    HEIGHT = screen_info.current_h #Largo de la pantalla
    fullscreen = False  #Variable para activar la pantalla completa

    #Config de la ventana
    design_width = 1280  #Ancho base para el que fue diseñado el juego
    design_height = 720  #Alto base para el que fue diseñado el juego
    screen = pygame.display.set_mode((design_width, design_height), pygame.RESIZABLE)  #Pantalla redimensionable
    clock = pygame.time.Clock()  #Reloj
    background_image = load_image("Images/Background.png", design_width, design_height)  #Fondo
    icon = load_image("Images/Icon.png")  #Icono de la esquina de la ventana
    pygame.display.set_caption('Sudoku')  #Nombre de la ventana
    pygame.display.set_icon(icon)

    #Variables para las vidas
    global lifes
    lifes = 5  #Cantidad de vidas
    text_size = 45  #Tamaño
    lifes_text = word(f"Lifes: {lifes}", text_size, RED_1, (775, 18))  #Se define los paramentros del texto de vidas

    #Dificultades
    easy_dificult = 50  #Dificultad fácil
    medium_dificult = 100  #Dificultad media
    hard_dificult = 150  #Dificultad dificil
    dificult = easy_dificult  #Dificultad inicial
    dificult_size = 28 #Tamaño del texto de las dificultades

    easy = word(f"easy", dificult_size, GREEN, (930, 673))  #Se crea la palabra "easy" con sus debidos parametros
    medium = word(f"medium", dificult_size, GREY, (1035, 673))  #Se crea la palabra "medium" con sus debidos parametros
    hard = word(f"hard", dificult_size, GREY, (1180, 673))  #Se crea la palabra "hard" con sus debidos parametros

    #Botones de acciones
    buttons_width = 200  #Anchura de los botones de pista y solución
    hint_height = 79  #Altura del botón de pista
    answer_height = 79  #Altura del botón de solución

    new_game_width = 160  #Ancho del botón de nuevo juego
    new_game_height = 46  #Alto del botón de nuevo juego
    put_hint = False  #Variable para saber si la pista esta activa o no
    
    hint = actions_buttons('Images/HintButton.png', (buttons_width, hint_height), (800, 90))  #Botón de "Pista"
    answer = actions_buttons('Images/AnswerButton.png', (buttons_width, answer_height), (1035, 90))  #Botón de "respuesta"
    new_game = actions_buttons('Images/NewGameButton.png', (new_game_width, new_game_height), (757, 665))  #Botón de "Nuevo juego"

    #Variable para el número que se obtiene al oprimir el click izquierdo sobre un botón numérico
    global number_obtained 
    number_obtained = 0
    
    #Config de los botones númericos
    buttons_size = (140, 140)  #Tamaño de los botones
    first_xpos = 805 #Posición x de la primera fila
    first_ypos = 210 #Posición y de la primera fila
    second_xpos = 945 #Posición x de la segunda fila
    second_ypos = 350  #Posición y de la segunda fila
    third_xpos = 1085 #Posición x de la tercera fila
    third_ypos = 490 #Posición y de la tercera fila

    one = number_buttons('Images/One.png', buttons_size, (first_xpos, first_ypos), 1)  #Botón 1
    two = number_buttons('Images/Two.png', buttons_size, (second_xpos, first_ypos), 2)  #Botón 2
    three = number_buttons('Images/Three.png', buttons_size, (third_xpos, first_ypos), 3)  #Botón 3
    four = number_buttons('Images/Four.png', buttons_size, (first_xpos, second_ypos), 4)  #Botón 4
    five = number_buttons('Images/Five.png', buttons_size, (second_xpos, second_ypos), 5)  #Botón 5
    six = number_buttons('Images/Six.png', buttons_size, (third_xpos, second_ypos), 6)  #Botón 6
    seven = number_buttons('Images/Seven.png', buttons_size, (first_xpos, third_ypos), 7)  #Botón 7
    eight = number_buttons('Images/Eight.png', buttons_size, (second_xpos, third_ypos), 8)  #Botón 8
    nine = number_buttons('Images/Nine.png', buttons_size, (third_xpos, third_ypos), 9)  #Botón 9

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

    #Crear una cuadricula y generar un sudoku
    grid_size = (693, 664)  #Tamaño de la cuadricula
    subgrid_size = (211,203)  #Tamaño de la subcuadriculo
    box_size = (69, 66)  #Tamaño de la casilla
    num_size = (25, 25)  #Tamaño de los números dentro de la casilla
    game_grid = grid(grid_size, subgrid_size, box_size, num_size, (377, 360))  #Se crea la cuadricula
    game_grid.generator(dificult)  #Se genera la partida
    lines = load_image("Images/Sudoku_lines.png",753, 720, False, True)  #Lineas de la cuadricula

    #*Ciclo while del juego
    while game:
        clock.tick(FPS)
        screen.fill(WHITE)

        screen.blit(background_image, (0, 0))  #Poner el fondo
        game_grid.draw(screen)  #Pone la cuadricula
        screen.blit(lines, (0, 0))  #Poner las lineas del sudoku
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

            if event.type == KEYDOWN:
                if event.key == K_ESCAPE:  #Si se presiona la tecla escape
                    sys.exit(0)

                if event.key == K_f:  #Si se presiona la tecla f, se pone o se quita pantalla completa
                    fullscreen = not fullscreen
                    if fullscreen:  #Si se pone la pantalla completa
                        screen = pygame.display.set_mode((WIDTH, HEIGHT), pygame.FULLSCREEN)  #Se pone el ancho y alto del monitor y se usa el flag de fullscreen
                        background_image = load_image("Images/Background.png", WIDTH, HEIGHT)  
                        lines = load_image("Images/Sudoku_lines.png", WIDTH/1.7, HEIGHT, False, True) 

                        #*Actualizar todos los sprites

                        #Actualizar textos
                        if HEIGHT < WIDTH:  #Condiciones para que los textos no den problemas al cambiar el tamaño de la pantalla
                            if WIDTH - HEIGHT <= 270:
                                new_lifes_size = round((WIDTH*text_size)/design_width)
                                new_dificult_size = round((WIDTH*dificult_size)/design_width)
                            else:
                                new_lifes_size = round((HEIGHT*text_size)/design_height)
                                new_dificult_size = round((HEIGHT*dificult_size)/design_height)          
                        else:
                            new_lifes_size = round((WIDTH*text_size)/design_width)
                            new_dificult_size = round((WIDTH*dificult_size)/design_width)

                        lifes_text.update(new_lifes_size, (WIDTH/1.65, HEIGHT/40)) 
                        easy.update(new_dificult_size, (WIDTH/1.376, HEIGHT/1.0698)) 
                        medium.update(new_dificult_size,(WIDTH/1.236, HEIGHT/1.0698)) 
                        hard.update(new_dificult_size, (WIDTH/1.0847, HEIGHT/1.0698)) 

                        #Actualizar botones
                        new_buttons_width = (WIDTH*buttons_width)/design_width  
                        new_hint_height = (HEIGHT*hint_height)/design_height
                        new_answer_height = (HEIGHT*answer_height)/design_height 
                        New_new_game_width = (WIDTH*new_game_width)/design_width
                        New_new_game_height = (HEIGHT*new_game_height)/design_height  

                        hint.update((new_buttons_width, new_hint_height), (WIDTH/1.6, HEIGHT/8))  
                        answer.update((new_buttons_width, new_answer_height), (WIDTH/1.2367, HEIGHT/8))  
                        new_game.update((New_new_game_width, New_new_game_height), (WIDTH/1.69, HEIGHT/1.0827)) 

                        #Actualizar botones numericos
                        new_buttons_size = ((WIDTH*buttons_size[0])/design_width, (HEIGHT*buttons_size[1])/design_height)  
                        first_xpos =  WIDTH/1.590062111801243
                        first_ypos = HEIGHT/3.42857142857143 
                        second_xpos = WIDTH/1.354497354497355 
                        second_ypos = HEIGHT/2.057142857142855  
                        third_xpos = WIDTH/1.17972350230415 
                        third_ypos = HEIGHT/1.46938775510204 

                        one.update(new_buttons_size, (first_xpos, first_ypos))
                        two.update(new_buttons_size, (second_xpos, first_ypos))
                        three.update(new_buttons_size, (third_xpos, first_ypos))
                        four.update(new_buttons_size, (first_xpos, second_ypos))
                        five.update(new_buttons_size, (second_xpos, second_ypos))
                        six.update(new_buttons_size, (third_xpos, second_ypos))
                        seven.update(new_buttons_size, (first_xpos, third_ypos))
                        eight.update(new_buttons_size, (second_xpos, third_ypos))
                        nine.update(new_buttons_size, (third_xpos, third_ypos))

                        #Actualizar cuadriculo y todo lo de dentro
                        new_grid_size = ((WIDTH*grid_size[0])/design_width, (HEIGHT*grid_size[1])/design_height)
                        new_subgrid_size = ((WIDTH*subgrid_size[0])/design_width, (HEIGHT*subgrid_size[1])/design_height)
                        new_box_size = ((WIDTH*box_size[0])/design_width, (HEIGHT*box_size[1])/design_height)
                        new_num_size = ((WIDTH*num_size[0])/design_width, (HEIGHT*num_size[1])/design_height)
                        new_pos = ((WIDTH/1.7)/2, HEIGHT/2)
                        game_grid.update(new_grid_size, new_subgrid_size, new_box_size, new_num_size, new_pos)
                    else:
                        screen = pygame.display.set_mode((design_width, design_height), pygame.RESIZABLE)  #Si se quita la pantalla completa, se deja todo como estaba antes

            #Acomodar el tamaño de la ventana
            if event.type == VIDEORESIZE:
                if not fullscreen:
                    screen = pygame.display.set_mode((event.w, event.h), pygame.RESIZABLE)  #Se actualiza el tamaño de la ventana
                    background_image = load_image("Images/Background.png", event.w, event.h)  
                    lines = load_image("Images/Sudoku_lines.png", event.w/1.7, event.h, False, True) 

                    #*Actualizar todos los sprites

                    #Actualizar textos
                    if event.h < event.w:  #Condiciones para que los textos no den problemas al cambiar el tamaño de la pantalla
                        if event.w - event.h <= 270:
                            new_lifes_size = round((event.w*text_size)/design_width)
                            new_dificult_size = round((event.w*dificult_size)/design_width)
                        else:
                            new_lifes_size = round((event.h*text_size)/design_height)
                            new_dificult_size = round((event.h*dificult_size)/design_height)          
                    else:
                        new_lifes_size = round((event.w*text_size)/design_width)
                        new_dificult_size = round((event.w*dificult_size)/design_width)

                    lifes_text.update(new_lifes_size, (event.w/1.65, event.h/40)) 
                    easy.update(new_dificult_size, (event.w/1.376, event.h/1.0698)) 
                    medium.update(new_dificult_size,(event.w/1.236, event.h/1.0698)) 
                    hard.update(new_dificult_size, (event.w/1.0847, event.h/1.0698)) 

                    #Actualizar botones
                    new_buttons_width = (event.w*buttons_width)/design_width  
                    new_hint_height = (event.h*hint_height)/design_height
                    new_answer_height = (event.h*answer_height)/design_height 
                    New_new_game_width = (event.w*new_game_width)/design_width
                    New_new_game_height = (event.h*new_game_height)/design_height  

                    hint.update((new_buttons_width, new_hint_height), (event.w/1.6, event.h/8))  
                    answer.update((new_buttons_width, new_answer_height), (event.w/1.2367, event.h/8))  
                    new_game.update((New_new_game_width, New_new_game_height), (event.w/1.69, event.h/1.0827)) 

                    #Actualizar botones numericos
                    new_buttons_size = ((event.w*buttons_size[0])/design_width, (event.h*buttons_size[1])/design_height)  
                    first_xpos =  event.w/1.590062111801243
                    first_ypos = event.h/3.42857142857143 
                    second_xpos = event.w/1.354497354497355 
                    second_ypos = event.h/2.057142857142855  
                    third_xpos = event.w/1.17972350230415 
                    third_ypos = event.h/1.46938775510204 

                    one.update(new_buttons_size, (first_xpos, first_ypos))
                    two.update(new_buttons_size, (second_xpos, first_ypos))
                    three.update(new_buttons_size, (third_xpos, first_ypos))
                    four.update(new_buttons_size, (first_xpos, second_ypos))
                    five.update(new_buttons_size, (second_xpos, second_ypos))
                    six.update(new_buttons_size, (third_xpos, second_ypos))
                    seven.update(new_buttons_size, (first_xpos, third_ypos))
                    eight.update(new_buttons_size, (second_xpos, third_ypos))
                    nine.update(new_buttons_size, (third_xpos, third_ypos))

                    #Actualizar cuadriculo y todo lo de dentro
                    new_grid_size = ((event.w*grid_size[0])/design_width, (event.h*grid_size[1])/design_height)
                    new_subgrid_size = ((event.w*subgrid_size[0])/design_width, (event.h*subgrid_size[1])/design_height)
                    new_box_size = ((event.w*box_size[0])/design_width, (event.h*box_size[1])/design_height)
                    new_num_size = ((event.w*num_size[0])/design_width, (event.h*num_size[1])/design_height)
                    new_pos = ((event.w/1.7)/2, event.h/2)
                    game_grid.update(new_grid_size, new_subgrid_size, new_box_size, new_num_size, new_pos)

            if event.type == MOUSEBUTTONDOWN and event.button == 1:  #Si se oprime el click izquierdo
                for pulsed_button in button_numbers_group.sprites():  #Revisa todos los botones
                    if pulsed_button.rect.collidepoint(pygame.mouse.get_pos()):  #Si el mouse esta oprimido en la posición de un botón, se obtiene el número del botón.
                        number_obtained = pulsed_button.get_number()
                        break
                
                subgrid_group = game_grid.get_subgrid_group()  #Grupo de subcuadriculas
                for subgrid in subgrid_group.sprites():  #Revisa todas las subcuadriculas
                    if subgrid.rect.collidepoint(pygame.mouse.get_pos()):  #Si el mouse esta oprimido en la posición de una subcuadricula
                        box_group = subgrid.get_box_group()  #Creamos el grupo de casillas de la subcuadricula
                        for box in box_group.sprites():
                            if box.rect.collidepoint(pygame.mouse.get_pos()):  #Si el mouse esta oprimido en la posición de una casilla
                                if put_hint:  #Si el botón de pista esta activo
                                    if box.get_data() == 0:
                                        box.set_data(box.get_correct_number(), 1, 1)  #Se pone el número correcto y se pone el fondo verde
                                        put_hint = False  #Se desactiva la pista
                                        break

                                if number_obtained != 0 and box.get_data() == 0:  #si se obtuvo un número del botón y la casilla no tiene número
                                    if box.get_correct_number() == number_obtained:  #Si el número que se va a colocar en la casilla es correcto
                                        box.set_data(number_obtained, 1, 1)  #Se coloca el número y se coloca fondo verde
                                    else:
                                        box.set_data(number_obtained, 1, 2)  #Si no, se coloca fondo rojo
                                        lifes -= 1  #y se quita una vida

                                    number_obtained = 0  #Se reinicia el número que estaba oprimido
                    
                if hint.rect.collidepoint(pygame.mouse.get_pos()):  #Si se oprime el botón de pista
                    put_hint = True  #Se activa la posibilidad de pista
                    
                if answer.rect.collidepoint(pygame.mouse.get_pos()):  #Si se oprime el botón de resolver
                    for subgrid in subgrid_group.sprites():  #Revisa todas las subcuadriculas
                        box_group = subgrid.get_box_group()  #Creamos el grupo de casillas de la subcuadricula
                        for box in box_group.sprites():  #Revisa todas las casillas
                            if box.get_data() == 0:  #Si aún no tiene dato la casilla
                                box.set_data(box.get_correct_number(), 1, 1)  #Se coloca el dato resuelto y el fondo verde

                if new_game.rect.collidepoint(pygame.mouse.get_pos()):  #Si se oprime el boton de juego nuevo
                    game_grid.generator(dificult)  #Generamos una nueva partida
                    lifes = 5  #Y reiniciamos las vidas
                    put_hint = False #Se quita la pista
                    number_obtained = 0  #Se quita el número que estuviera seleccionado

                if easy.rect.collidepoint(pygame.mouse.get_pos()):  #Si se cambia a la dificultad facil
                    #Se pone en color solo el botón de easy
                    easy.color_ = GREEN
                    medium.color_ = GREY
                    hard.color_ = GREY
                    dificult = easy_dificult  #Se pone dificultad facil
                    game_grid.generator(dificult)  #Se genera una nueva partida
                    lifes = 5  #Se reinician las vidas
                    put_hint = False #Se quita la pista
                    number_obtained = 0  #Se quita el número que estuviera seleccionado

                if medium.rect.collidepoint(pygame.mouse.get_pos()):  #Si se cambia a la dificultad medio
                    #Se pone en color solo el botón de medium
                    easy.color_ = GREY
                    medium.color_ = ORANGE
                    hard.color_ = GREY
                    dificult = medium_dificult  #Se pone dificultad media
                    game_grid.generator(dificult)  #Se genera una nueva partida
                    lifes = 5  #Se reinician las vidas
                    put_hint = False #Se quita la pista
                    number_obtained = 0  #Se quita el número que estuviera seleccionado
                
                if hard.rect.collidepoint(pygame.mouse.get_pos()):  #Si se cambia a la dificultad dificil
                    #Se pone en color solo el botón de hard
                    easy.color_ = GREY
                    medium.color_ = GREY
                    hard.color_ = RED_2
                    dificult = hard_dificult  #Se pone dificultad dificil
                    game_grid.generator(dificult)  #Se genera una nueva partida
                    lifes = 5  #Se reinician las vidas
                    put_hint = False #Se quita la pista
                    number_obtained = 0  #Se quita el número que estuviera seleccionado
                    
        lifes_text.text_ = f"lifes: {lifes}"  #Se actualizan las vidas

        if lifes <= 0:  #Si se acaban las vidas, se pierde el juego
            game = False

        pygame.display.update() #Actualizar contenido en pantalla

if __name__ == '__main__':
    pygame.init()
    main()