import robots

r1 = robots.Robot("soldador")
r2 = robots.Robot("ensamblador")
r3 = robots.Robot("soldador")
r4 = robots.Robot("ensamblador")

l1 = robots.Linea("Ensamblaje 1")

l1.incluir((r1,r2))
l1.incluir((r4,r3))
l1.incluir((r1,r3))

print(l1.activar())
print(l1.activar())
