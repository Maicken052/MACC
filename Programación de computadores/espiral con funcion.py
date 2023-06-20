import turtle

def triangulo (long, tortuga):
    for i in range(3):
        tortuga.forward(long)
        tortuga.left(360/3)
        
vent = turtle.Screen()
tank = turtle.Turtle()

dist=10

for i in range(40):
    triangulo(dist, tank)
        
    tank.forward(dist)
    tank.right(15)
    dist = dist * 1.05
    
vent.mainloop()