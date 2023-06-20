import turtle

alex=turtle.Turtle()
window=turtle.Screen()

def draw_poly(t, n, sz):
    for i in range(n):
        t.forward(sz)
        t.left(360/n)
        
lados=4


for i in range(6):
    alex.color("blue")
    draw_poly(alex, lados, 15)
    alex.forward(200)
    alex.left(360/6)
    lados=lados+1
    
        


window.mainloop()