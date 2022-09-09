import grupos

int1=grupos.Integrante("Pepito", "Perez", 25)
int1.asignar_id(12345)
int1.info()

int2=grupos.Integrante("Fulanito", "de Tal", 10)
int2.asignar_id(56789)
print(int2)
int2.modif_edad(20)

grp = grupos.Grupo("prueba", 2)
grp.agregar_integrante(int1)
grp.agregar_integrante(int2)
grp.buscar_mayor_menor("mayor")
grp.buscar_mayor_menor("menor")

print(grp)


int3=grupos.Integrante("Perensefo", "de Tal", 30)
grp.agregar_integrante(int3)
