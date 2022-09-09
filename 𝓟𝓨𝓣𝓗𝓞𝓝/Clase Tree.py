class Tree:
    def __init__(self, izq, der):
        self.left=izq
        self.right=der
        
    def Hoja_o_Rama(self):
        if self.left==None:
            print("Hoja")
        else:
            print("Rama")

Hoja=Tree(None, None)
Rama=Tree(Hoja, Hoja)
Arbol1=Tree(Rama, Hoja)
Arbol2=Tree(Hoja, Rama)
Arbol3=Tree(Rama, Rama)
A = Tree(Tree(Tree(Tree(None, None), Tree(None, None)), Tree(Tree(None, None), Tree(None, None))), Tree(Tree(Tree(None, None), Tree(None, None)), Tree(None, None)))

def num_Hojas(arb):
    if arb.left==None:
        return 1
    else:
        return num_Hojas(arb.left)+num_Hojas(arb.right)

def num_nodos(arb):
    if arb.left==None:
        return 1
    else:
        return 1+num_nodos(arb.left)+num_nodos(arb.right)

def num_aristas(arb):
    if arb.left==None:
        return 0
    else:
        return 2+num_aristas(arb.left)+num_aristas(arb.left)
        
print(num_Hojas(Hoja)+num_Hojas(Rama)+num_Hojas(Arbol1)+num_Hojas(Arbol2))