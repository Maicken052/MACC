import turtle

def square (t, size):
    for i in range(4):
        t.forward(size)
        t.left(90)
        
def spiral (t, size):
    for i in range(5):
        square(t, size)
        t.left(90)
        t.forward(size)
        size = size * 0.5
    



ven = turtle.Screen()
tank = turtle.Turtle()

spiral(tank, 200)


    
ven.mainloop()