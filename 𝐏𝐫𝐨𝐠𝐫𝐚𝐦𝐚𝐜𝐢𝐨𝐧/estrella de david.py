import turtle

alex=turtle.Turtle()
window=turtle.Screen()

def triangle (t, size):
    for i in range(3):
        t.forward(size)
        t.left(360/3)
  
for i in range(6):
    triangle(alex, 30)
    alex.forward(30)
    alex.right(360/6)
    
        


window.mainloop()