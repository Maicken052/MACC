from functions import *
from sprites import *
import pytest

screen = pygame.display.set_mode((WIDTH, HEIGHT))

def test_load_images():
    with pytest.raises(FileNotFoundError):
        load_image('one.png')

    with pytest.raises(TypeError):
        load_image("Imagenes/Fondo.png", WIDTH)
        load_image(3, WIDTH)
        load_image(True, WIDTH)


def test_clases_numeros():
    with pytest.raises(ValueError):
        one = Numbers(pygame.image.load('Imagenes/one.png').convert_alpha(), 200, (HEIGHT/1.25), 1)
        nine = Numbers(pygame.image.load('Imagenes/nine.png').convert_alpha(), 1080, -(HEIGHT/1.25), 9)
        six = Numbers(pygame.image.load('Imagenes/six.png').convert_alpha(), -750, (HEIGHT/1.25), 6)
        four = Numbers(pygame.image.load('Imagenes/four.png').convert_alpha(), 530, (HEIGHT/1.25), -4)
        two = Numbers(pygame.image.load('Imagenes/two.png').convert_alpha(), 310, (HEIGHT/1.25), 10)
        n = Numbers_casillas(-10, 10, 7)

def test_clases_casillas():
    with pytest.raises(ValueError):
        casilla_p = Casilla(40, (0, 0, 0, 0 ,0, 0))
        casilla_p2 = Casilla(-5, (0, 0, 0, 0 ,0, 0))

def test_logica_sudoku():
    cuadricula = Cuadricula(3, 3, (WIDTH/2, HEIGHT/2))
    with pytest.raises(TypeError):
        cuadricula.sudoku_solver(4)
        cuadricula.sudoku_solver("str")
        cuadricula.sudoku_solver(True)
        cuadricula.sudoku_solver({})
        cuadricula.sudoku_solver(())