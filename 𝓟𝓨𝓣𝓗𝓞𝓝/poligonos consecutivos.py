import turtle

manuelita=turtle.Turtle()
window=turtle.Screen()

def draw_poly(t, n, sz):
    for i in range(n):
        t.forward(sz)
        t.left(360/n)
        
lados=4

for i in range(6):
    manuelita.color("red")
    draw_poly(manuelita, lados, 30)
    manuelita.penup()
    manuelita.forward(30+100)
    manuelita.pendown()
    lados=lados+1
    
        


window.mainloop()
