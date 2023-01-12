#=============================================================================================================#     
#                                                    *librerias      
#=============================================================================================================#
import sys
import pygame
from pygame.locals import *
from functions import load_image, check_if_pressed, restart
from Grid_sprites import grid
from Buttons_sprites import number_buttons, actions_buttons, word
#=============================================================================================================#     
#                                                  *Colores usados 
#=============================================================================================================#
RED_1 = (213, 57, 48)  
GREEN = (18, 247, 51)  
ORANGE = (255, 129, 0) 
RED_2 = (255, 17, 0) 
WHITE = (255, 255, 255) 
GREY = (169, 169, 169)  
#=============================================================================================================#      
#                                                       *Main         
#=============================================================================================================#
def main():
    game = True  
    FPS = 60
    
    #Config para el fullscreen
    screen_info = pygame.display.Info()  #Información de la pantalla en la que se esta corriendo el juego
    WIDTH = screen_info.current_w 
    HEIGHT = screen_info.current_h 
    fullscreen = False  

    #Config de la ventana
    design_width = 1280  #Ancho base para el que fue diseñado el juego
    design_height = 720  #Alto base para el que fue diseñado el juego
    screen = pygame.display.set_mode((design_width, design_height), pygame.RESIZABLE)  
    clock = pygame.time.Clock()  
    background_image = load_image("Images/Background.png", design_width, design_height)  
    icon = load_image("Images/Icon.png")  
    pygame.display.set_caption('Sudoku')  
    pygame.display.set_icon(icon)

    #Texto de las vidas
    global lifes
    lifes = 5  
    lifes_size = 45  
    lifes_text = word(f"Lifes: {lifes}", lifes_size, RED_1, (775, 18))  

    #Dificultades
    dificult_size = 28 
    easy = word(f"easy", dificult_size, GREEN, (930, 673))  
    medium = word(f"medium", dificult_size, GREY, (1035, 673))  
    hard = word(f"hard", dificult_size, GREY, (1180, 673))  
    easy_dificult = 50  
    medium_dificult = 100  
    hard_dificult = 150  
    global dificult
    dificult = easy_dificult  

    #Botones de acciones (Pista, Solución y juego nuevo)
    buttons_width = 200  
    buttons_height = 79 
    new_game_width = 160  
    new_game_height = 46  
    hint = actions_buttons('Images/HintButton.png', (buttons_width, buttons_height), (800, 90))  
    answer = actions_buttons('Images/AnswerButton.png', (buttons_width, buttons_height), (1035, 90))  
    new_game = actions_buttons('Images/NewGameButton.png', (new_game_width, new_game_height), (757, 665))  
    global put_hint
    put_hint = False 
    
    #Config de los botones númericos
    buttons_size = (140, 140)  
    first_xpos = 805 
    first_ypos = 210 
    second_xpos = 945 
    second_ypos = 350  
    third_xpos = 1085
    third_ypos = 490 
    one = number_buttons('Images/One.png', buttons_size, (first_xpos, first_ypos), 1)  
    two = number_buttons('Images/Two.png', buttons_size, (second_xpos, first_ypos), 2)  
    three = number_buttons('Images/Three.png', buttons_size, (third_xpos, first_ypos), 3)  
    four = number_buttons('Images/Four.png', buttons_size, (first_xpos, second_ypos), 4)  
    five = number_buttons('Images/Five.png', buttons_size, (second_xpos, second_ypos), 5)  
    six = number_buttons('Images/Six.png', buttons_size, (third_xpos, second_ypos), 6)  
    seven = number_buttons('Images/Seven.png', buttons_size, (first_xpos, third_ypos), 7)  
    eight = number_buttons('Images/Eight.png', buttons_size, (second_xpos, third_ypos), 8)  
    nine = number_buttons('Images/Nine.png', buttons_size, (third_xpos, third_ypos), 9) 
    button_numbers_group = pygame.sprite.Group()  
    button_numbers_group.add(one)
    button_numbers_group.add(two)
    button_numbers_group.add(three)
    button_numbers_group.add(four)
    button_numbers_group.add(five)
    button_numbers_group.add(six)
    button_numbers_group.add(seven)
    button_numbers_group.add(eight)
    button_numbers_group.add(nine)
    global number_obtained 
    number_obtained = 0
    global pressed_button
    pressed_button = None

    #Crear una cuadricula y generar un sudoku
    grid_size = (693, 664)  
    subgrid_size = (211,203)  
    box_size = (69, 66)  
    num_size = (25, 25)  
    game_grid = grid(grid_size, subgrid_size, box_size, num_size, (377, 360))  
    grid_lines = load_image("Images/Sudoku_lines.png",753, 720, False, True)  
    game_grid.generator(dificult)  
    subgrid_group = game_grid.get_subgrid_group() 

    #*Ciclo while del juego
    while game:
        clock.tick(FPS)  #Fotogramas por segundo
        screen.fill(WHITE)  #Cambio de fotograma

        #Colocar todos los elementos en la ventana
        screen.blit(background_image, (0, 0))  
        game_grid.draw(screen)  
        screen.blit(grid_lines, (0, 0))  
        lifes_text.draw(screen)  
        hint.draw(screen)  
        answer.draw(screen) 
        button_numbers_group.draw(screen)  
        new_game.draw(screen)  
        easy.draw(screen) 
        medium.draw(screen) 
        hard.draw(screen)  

        #Detectar las entradas del teclado o ratón
        for event in pygame.event.get():  
            if event.type == QUIT:  #Si se presiona el boton con la X roja
                pygame.quit()
                sys.exit(0)

            if event.type == KEYDOWN:
                if event.key == K_ESCAPE:  #Si se presiona la tecla escape
                    sys.exit(0)

                if event.key == K_f:  #Si se presiona la tecla f, se pone o se quita pantalla completa
                    fullscreen = not fullscreen
                    if fullscreen:  
                        screen = pygame.display.set_mode((WIDTH, HEIGHT), pygame.FULLSCREEN)  
                        background_image = load_image("Images/Background.png", WIDTH, HEIGHT)  
                        grid_lines = load_image("Images/Sudoku_lines.png", WIDTH/1.7, HEIGHT, False, True) 

                        #*Actualizar todos los sprites (Se usa la regla de 3 con los tamaños para mantener la proporción)
                        #Actualizar textos
                        if HEIGHT < WIDTH:  #Condiciones para que los textos no den problemas al cambiar el tamaño de la pantalla
                            if WIDTH - HEIGHT <= 270:
                                lifes_size = round((WIDTH*45)/design_width)
                                dificult_size = round((WIDTH*28)/design_width)
                            else:
                                lifes_size = round((HEIGHT*45)/design_height)
                                dificult_size = round((HEIGHT*28)/design_height)          
                        else:
                            lifes_size = round((WIDTH*45)/design_width)
                            dificult_size = round((WIDTH*28)/design_width)

                        lifes_text.update(lifes_size, (WIDTH/1.65, HEIGHT/40)) 
                        easy.update(dificult_size, (WIDTH/1.376, HEIGHT/1.0698)) 
                        medium.update(dificult_size,(WIDTH/1.236, HEIGHT/1.0698)) 
                        hard.update(dificult_size, (WIDTH/1.0847, HEIGHT/1.0698)) 

                        #Actualizar botones
                        buttons_width = (WIDTH*200)/design_width  
                        buttons_height = (HEIGHT*79)/design_height
                        buttons_height = (HEIGHT*79)/design_height 
                        new_game_width = (WIDTH*160)/design_width
                        new_game_height = (HEIGHT*46)/design_height  
                        hint.update((buttons_width, buttons_height), (WIDTH/1.6, HEIGHT/8))  
                        answer.update((buttons_width, buttons_height), (WIDTH/1.2367, HEIGHT/8))  
                        new_game.update((new_game_width, new_game_height), (WIDTH/1.69, HEIGHT/1.0827)) 

                        #Actualizar botones numericos
                        buttons_size = ((WIDTH*140)/design_width, (HEIGHT*140)/design_height)  
                        first_xpos =  WIDTH/1.590062111801243
                        first_ypos = HEIGHT/3.42857142857143 
                        second_xpos = WIDTH/1.354497354497355 
                        second_ypos = HEIGHT/2.057142857142855  
                        third_xpos = WIDTH/1.17972350230415 
                        third_ypos = HEIGHT/1.46938775510204 
                        one.update(buttons_size, (first_xpos, first_ypos))
                        two.update(buttons_size, (second_xpos, first_ypos))
                        three.update(buttons_size, (third_xpos, first_ypos))
                        four.update(buttons_size, (first_xpos, second_ypos))
                        five.update(buttons_size, (second_xpos, second_ypos))
                        six.update(buttons_size, (third_xpos, second_ypos))
                        seven.update(buttons_size, (first_xpos, third_ypos))
                        eight.update(buttons_size, (second_xpos, third_ypos))
                        nine.update(buttons_size, (third_xpos, third_ypos))

                        #Actualizar la cuadricula
                        grid_size = ((WIDTH*693)/design_width, (HEIGHT*664)/design_height)
                        subgrid_size = ((WIDTH*211)/design_width, (HEIGHT*203)/design_height)
                        box_size = ((WIDTH*69)/design_width, (HEIGHT*66)/design_height)
                        num_size = ((WIDTH*25)/design_width, (HEIGHT*25)/design_height)
                        pos = ((WIDTH/1.7)/2, HEIGHT/2)
                        game_grid.update(grid_size, subgrid_size, box_size, num_size, pos)
                    else:
                        screen = pygame.display.set_mode((design_width, design_height), pygame.RESIZABLE)  #Si se quita la pantalla completa, se deja todo como estaba antes

            #Acomodar el tamaño de la ventana (event.w y event.h son las dimensiones actuales de la pantalla)
            if event.type == VIDEORESIZE:
                if not fullscreen:
                    screen = pygame.display.set_mode((event.w, event.h), pygame.RESIZABLE) 
                    background_image = load_image("Images/Background.png", event.w, event.h)  
                    grid_lines = load_image("Images/Sudoku_lines.png", event.w/1.7, event.h, False, True) 

                    #*Actualizar todos los sprites (Se usa la regla de 3 con los tamaños para mantener la proporción)
                    #Actualizar textos
                    if event.h < event.w:  #Condiciones para que los textos no den problemas al cambiar el tamaño de la pantalla
                        if event.w - event.h <= 270:
                            lifes_size = round((event.w*45)/design_width)
                            dificult_size = round((event.w*28)/design_width)
                        else:
                            lifes_size = round((event.h*45)/design_height)
                            dificult_size = round((event.h*28)/design_height)          
                    else:
                        lifes_size = round((event.w*45)/design_width)
                        dificult_size = round((event.w*28)/design_width)

                    lifes_text.update(lifes_size, (event.w/1.65, event.h/40)) 
                    easy.update(dificult_size, (event.w/1.376, event.h/1.0698)) 
                    medium.update(dificult_size,(event.w/1.236, event.h/1.0698)) 
                    hard.update(dificult_size, (event.w/1.0847, event.h/1.0698)) 

                    #Actualizar botones
                    buttons_width = (event.w*200)/design_width  
                    buttons_height = (event.h*79)/design_height
                    buttons_height = (event.h*79)/design_height 
                    new_game_width = (event.w*160)/design_width
                    new_game_height = (event.h*46)/design_height  
                    hint.update((buttons_width, buttons_height), (event.w/1.6, event.h/8))  
                    answer.update((buttons_width, buttons_height), (event.w/1.2367, event.h/8))  
                    new_game.update((new_game_width, new_game_height), (event.w/1.69, event.h/1.0827)) 

                    #Actualizar botones numericos
                    buttons_size = ((event.w*140)/design_width, (event.h*140)/design_height)  
                    first_xpos =  event.w/1.590062111801243
                    first_ypos = event.h/3.42857142857143 
                    second_xpos = event.w/1.354497354497355 
                    second_ypos = event.h/2.057142857142855  
                    third_xpos = event.w/1.17972350230415 
                    third_ypos = event.h/1.46938775510204 
                    one.update(buttons_size, (first_xpos, first_ypos))
                    two.update(buttons_size, (second_xpos, first_ypos))
                    three.update(buttons_size, (third_xpos, first_ypos))
                    four.update(buttons_size, (first_xpos, second_ypos))
                    five.update(buttons_size, (second_xpos, second_ypos))
                    six.update(buttons_size, (third_xpos, second_ypos))
                    seven.update(buttons_size, (first_xpos, third_ypos))
                    eight.update(buttons_size, (second_xpos, third_ypos))
                    nine.update(buttons_size, (third_xpos, third_ypos))

                    #Actualizar la cuadricula
                    grid_size = ((event.w*693)/design_width, (event.h*664)/design_height)
                    subgrid_size = ((event.w*211)/design_width, (event.h*203)/design_height)
                    box_size = ((event.w*69)/design_width, (event.h*66)/design_height)
                    num_size = ((event.w*25)/design_width, (event.h*25)/design_height)
                    pos = ((event.w/1.7)/2, event.h/2)
                    game_grid.update(grid_size, subgrid_size, box_size, num_size, pos)

            #Fluidez de los botones
            for pulsed_button in button_numbers_group.sprites(): 
                if  pulsed_button != pressed_button:
                        pulsed_button.smoothness(buttons_size)

            hint.smoothness((buttons_width, buttons_height))
            answer.smoothness((buttons_width, buttons_height))
            new_game.smoothness((new_game_width, new_game_height))
            easy.smoothness(dificult_size)
            medium.smoothness(dificult_size)
            hard.smoothness(dificult_size)
            
            if event.type == MOUSEBUTTONDOWN and event.button == 1:  #Si se oprime el click izquierdo
                
                #Se revisan los botones numericos en caso de que se haya oprimido el click izquierdo sobre uno de ellos
                for pulsed_button in button_numbers_group.sprites(): 
                    if pulsed_button.rect.collidepoint(pygame.mouse.get_pos()):  
                        check_if_pressed(pressed_button, buttons_size)  #Revisa si hay alguno oprimido para volverlo a su estado normal
                        pulsed_button.click((buttons_size[0]*0.90, buttons_size[1]*0.90))  #Oprime el botón sobre el que se hizo click izquierdo
                        pressed_button = pulsed_button
                        number_obtained = pulsed_button.get_number()  #Se guarda en una variable el valor obtenido del botón
                        break
                        
                #Se revisa la cuadricula en caso de que se haya oprimido el click izquierdo en una casilla
                for subgrid in subgrid_group.sprites():  #Se revisan las subcuadriculas
                    if subgrid.rect.collidepoint(pygame.mouse.get_pos()): 
                        box_group = subgrid.get_box_group()  
                        for box in box_group.sprites():  #Después cada casilla de la subcuadricula
                            if box.rect.collidepoint(pygame.mouse.get_pos()):  

                                if put_hint:  #Si el botón de pista esta activo
                                    if box.get_data() == 0:
                                        box.set_data(box.get_correct_number(), 1, 1)  #Se pone el número correcto y se pone el fondo verde
                                        put_hint = False 
                                        break

                                if number_obtained != 0 and box.get_data() == 0:  #si se obtuvo un número del botón y la casilla no tiene número
                                    if box.get_correct_number() == number_obtained:  #Si el número que se va a colocar en la casilla es correcto
                                        box.set_data(number_obtained, 1, 1)  
                                    else:
                                        box.set_data(number_obtained, 1, 2)  #Si no, se coloca fondo rojo
                                        lifes -= 1  

                                    check_if_pressed(pressed_button, buttons_size)
                                    number_obtained = 0  #Se reinicia el número que estaba oprimido
                
                #Si se oprime el botón de pista
                if hint.rect.collidepoint(pygame.mouse.get_pos()):  
                    hint.click((buttons_width*0.85, buttons_height*0.85))
                    put_hint = True  
                
                #Si se oprime el botón de resolver
                if answer.rect.collidepoint(pygame.mouse.get_pos()):  
                    answer.click((buttons_width*0.85, buttons_height*0.85))

                    for subgrid in subgrid_group.sprites():  
                        box_group = subgrid.get_box_group() 
                        for box in box_group.sprites():  
                            if box.get_data() == 0:  #Si aún no tiene dato la casilla
                                box.set_data(box.get_correct_number(), 1, 1)  #Se coloca el dato resuelto y el fondo verde

                #Si se oprime el boton de juego nuevo
                if new_game.rect.collidepoint(pygame.mouse.get_pos()):  
                    new_game.click((new_game_width*0.85, new_game_height*0.85))
                    lifes, put_hint, number_obtained = restart(game_grid, dificult, pressed_button, buttons_size)

                #Si se cambia a la dificultad facil
                if easy.rect.collidepoint(pygame.mouse.get_pos()):  
                    easy.click(round(dificult_size*0.80))
                    easy.color_ = GREEN  #Se pone en color solo el botón de easy
                    medium.color_ = GREY
                    hard.color_ = GREY
                    dificult = easy_dificult  
                    lifes, put_hint, number_obtained = restart(game_grid, dificult, pressed_button, buttons_size)

                #Si se cambia a la dificultad medio
                if medium.rect.collidepoint(pygame.mouse.get_pos()):  
                    medium.click(round(dificult_size*0.80))
                    easy.color_ = GREY
                    medium.color_ = ORANGE  #Se pone en color solo el botón de medium
                    hard.color_ = GREY
                    dificult = medium_dificult  
                    lifes, put_hint, number_obtained = restart(game_grid, dificult, pressed_button, buttons_size)
                
                #Si se cambia a la dificultad dificil
                if hard.rect.collidepoint(pygame.mouse.get_pos()):  
                    hard.click(round(dificult_size*0.80))
                    easy.color_ = GREY
                    medium.color_ = GREY
                    hard.color_ = RED_2  #Se pone en color solo el botón de hard
                    dificult = hard_dificult  
                    lifes, put_hint, number_obtained = restart(game_grid, dificult, pressed_button, buttons_size)
                    
        lifes_text.text_ = f"lifes: {lifes}"  #Se actualizan las vidas

        if lifes <= 0:  #Si se acaban las vidas, se pierde el juego
            game = False  #TODO: Actualizar el fin del juego

        pygame.display.update() #Actualizar contenido en pantalla

if __name__ == '__main__':
    pygame.init()
    main()