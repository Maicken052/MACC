from functions import *
from Grid_sprites import *
import pytest

screen = pygame.display.set_mode((WIDTH, HEIGHT))  #Se crea una pantalla para que se usen los elementos y se puedan testear

def test_load_images():  #Test para la funcion load_image
    with pytest.raises(FileNotFoundError):
        load_image('one.png')

    with pytest.raises(TypeError):
        load_image("Images/Background.png", WIDTH)
        load_image(3, WIDTH)
        load_image(True, WIDTH)


def test_num_class():  #Test para las clases de números
    with pytest.raises(ValueError):
        nine = number_bottons('Images/nine.png', (1080, -(HEIGHT/1.25)), 9)
        six = number_bottons('Images/six.png', (-750, (HEIGHT/1.25)), 6)
        four = number_bottons('Images/four.png', (530, (HEIGHT/1.25)), -4)
        two = number_bottons('Images/two.png', (310, (HEIGHT/1.25)), 10)
        seven = box_numbers((-10, 10), 7)
        one = box_numbers((10, 10), 11)

def test_box_class():  #Test para las casillas
    with pytest.raises(ValueError):
        box_1 = box(40, (0, 0, 0, 0 ,0, 0))
        box_2 = box(-5, (0, 0, 0, 0 ,0, 0))

def test_sudoku_logic():  #Test para la lógica del sudoku
    grid_ = grid((WIDTH/2, HEIGHT/2))
    with pytest.raises(TypeError):
        grid_.sudoku_solver(4)
        grid_.sudoku_solver("str")
        grid_.sudoku_solver(True)
        grid_.sudoku_solver({})
        grid_.sudoku_solver(())