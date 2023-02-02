import turtle

alex=turtle.Turtle()
window=turtle.Screen()

def square (t, sz):
    for i in range(2):
        t.color("red")
        t.left(360/4)
        t.forward(sz)
    for j in range(2):
        t.color("blue")
        t.left(360/4)
        t.forward(sz)
    
lado=16
for i in range(10):
    square(alex, lado)
    alex.right(45)
    alex.penup()
    alex.forward(lado*(2**0.5))
    alex.left(45)
    alex.pendown()
    lado=lado*3

window.mainloop()