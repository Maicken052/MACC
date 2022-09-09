class Persona:
    def __init__(self, nombre, apellido, edad):
        self.name=nombre
        self.lastname=apellido
        self.age=edad
        self.id=0
        
    def info(self):
        print(f"{self.name} {self.lastname}, {self.age} años\n")
    

class Integrante(Persona):
    def asignar_id(self, numero):
        self.id=numero
    
    def modif_edad(self, edadn):
        self.age=edadn
        
    def __str__(self):
        a=f"Nombre: {self.name}\nApellido: {self.lastname}\nEdad: {self.age}\nidentificación: {self.id}\n"
        return a
    
    
class Grupo:
    def __init__(self, nombre, integrantes):
        self.nombre=nombre
        self.integrantes=integrantes
        self.listado=[]
    
    def agregar_integrante(self, integrante):
        if len(self.listado)<self.integrantes:
            self.listado.append(integrante)
        else:
            return "Cupo no disponible en el grupo"
    
    def buscar_mayor_menor(self, cadena):
        edad_mayor=0
        edad_menor=0
        edad_comM=0
        edad_comm=100
        
        for integrante in self.listado:
            if cadena=="mayor":
                if integrante.age>edad_comM:
                    edad_mayor=integrante.age
                    edad_comM=edad_mayor
            elif cadena=="menor":
                if integrante.age<edad_comm:
                    edad_menor=integrante.age
                    edad_comm=edad_menor
        
        for integrante in self.listado:
            if cadena=="mayor":
                if edad_mayor==integrante.age:
                    print(f"{integrante.name} {integrante.lastname}\n")
                    
            if cadena=="menor":
                if edad_menor==integrante.age:
                    print(f"{integrante.name} {integrante.lastname}\n")
            
    def __str__(self):
        msn=f"{self.nombre}\n\n"
        for integrante in self.listado:
            msn+=str(integrante)+"\n\n"
            
        return msn
            
    
