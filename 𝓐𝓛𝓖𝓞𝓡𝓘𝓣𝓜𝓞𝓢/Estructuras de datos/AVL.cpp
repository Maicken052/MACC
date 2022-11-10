#include<iostream>
#include<cmath>
#define SPACE 10
using namespace std;

//---------------------------CLASE NODO-------------------------//
class Nodo{
    //Atributos
    int dato;
    Nodo* izq;
    Nodo* der;

public:  
    //Constructores
    Nodo(int i){
        dato = i;
        izq = NULL;
        der = NULL;
    }
    
    Nodo(){
        dato = 0;
        izq = NULL;
        der = NULL;
    }
    
    //Getters
    int getDato(){
        return dato;
    }
    
    Nodo* getIzq(){
    return izq;
    }
    
    Nodo* getDer(){
    return der;
    }
    
    //Setters
    void setDato(int i){
        dato = i;
    }
    
    void setIzq(Nodo* i){
        izq = i;
    }
    
    void setDer(Nodo* i){
        der = i;
    }
    
    //Métodos
    bool isHoja(){
        return izq == NULL && der == NULL;
    }
    
    bool hasIzq(){
        return izq!=NULL;
    }
    
    bool hasDer(){
        return der!=NULL;    
    }
};

//---------------------------CLASE TREE-------------------------//
class Tree{
    //Atributos
    Nodo* root;
    
public:
    //Constructor
    Tree(){
        root = NULL;
    }
    
    //Métodos
    int getHeight(Nodo* t){
        if(t != NULL){ //El nodo tiene que existir
            if(t->isHoja()){ //Si es una hoja, tiene altura 1
                return 1;
            }else{
                int i = getHeight(t->getIzq());
                int d = getHeight(t->getDer());
                int m = max(i, d);
                return m+1; //De lo contrario, tiene la altura de su hijo más alto sumado a el.
            }
        }else{
            return 0;
        }
    }
    
    bool isIzq_Heavy(Nodo* t){
        return getHeight(t->getIzq())>getHeight(t->getDer());  //Saber si el lado izquierdo es el desbalanceado
    }
    
    bool isHijo_Izq(int d){
        Nodo* p = es_padre(d);  //Obtenemos el padre de el dato
        if(p != NULL){  //Si el papá es Null, es la raiz
            if(p->getIzq() == NULL){  //Si el papá no tiene hijo izquierdo
                return false;
            }else{
                return p->getIzq()->getDato() == d;  //Si el hijo izquierdo del papá es el dato ingresado
            }
        }
        return false;
    }

    bool isBalanced(Nodo* t){
        int i = getHeight(t->getIzq());  //Sacamos la altura del hijo izquierdo
        int d = getHeight(t->getDer());  //Sacamos la altura del hijo derecho
        return abs(i-d)<=1;  //Si el valor absoluto de la resta de ambas alturas es menor o igual a uno, esta balanceado
    }
    
    void t_izqOder(bool p, Nodo* pt, Nodo* z){  //Saber si el nodo que va a ser el nuevo hijo de pt va a la izquierda o derecha.
        if(p){
            pt->setIzq(z);
        }else{
            pt->setDer(z);
        }
    }
    
    Nodo* es_padre(int x, Nodo* t){
        if(t != NULL){  //Si el nodo existe
            if(t->getDato() == x){  //Si el nodo es la raíz, no tiene padre
                return NULL;
            }
            if(x<t->getDato()){  //Si el dato es menor al nodo, buscamos a la izquierda
                if(t->hasIzq()){  //Revisamos que exista el nodo izquierdo
                    if(t->getIzq()->getDato() == x){  //Si el nodo izquierdo es el dato, retornamos el nodo t 
                        return t;
                    }else{  //Si no, buscamos en el nodo izquierdo
                        Nodo* ni = t->getIzq();
                        return es_padre(x, ni);
                    }
                }
            }else{  //Si el dato es mayor al nodo, buscamos a la derecha
                if(t->hasDer()){  //Revisamos que exista el nodo derecho
                    if(t->getDer()->getDato() == x){  //Si el nodo derecho es el dato, retornamos el nodo t
                        return t;
                    }else{  //Si no, buscamos en el nodo derecho
                        Nodo* nd = t->getDer();
                        return es_padre(x, nd);
                    }
                }
            }
        }
        return NULL;
    }
    
    Nodo* es_padre(int x){
        return es_padre(x, root);
    }
    
    void addAVL(int d, Nodo* t, Nodo* pt){
        //Add
        if(t == NULL){  //Caso base: Si el hijo de pt no existe, se coloca el dato nuevo dependiendo de si es mayor o menor que pt
            Nodo* n = new Nodo(d);
            if(d < pt->getDato()){
                pt->setIzq(n);
            }else{
                pt->setDer(n);
            }
        }else{  //Si no, se evalua si revisamos al lado izquierdo o derecho de t 
            if(d < t->getDato()){
                addAVL(d, t->getIzq(), t);
            }else{
                addAVL(d, t->getDer(), t);
            }
            
            //Balanceo
            if(!isBalanced(t)){
                
                bool p = isHijo_Izq(t->getDato());  //Revisamos si t es hijo izquierdo o derecho
                pt = es_padre(t->getDato());  //Obtenemos el padre de t
                
                if(isIzq_Heavy(t)){  //Si el lado izquierdo es el desbalanceado
                    Nodo* z = t->getIzq();
                    if(isHijo_Izq(d)){
                        //Rotación todo izquierda
                        t->setIzq(z->getDer());
                        z->setDer(t);
                        if(pt == NULL){
                            root = z;
                        }else{
                            t_izqOder(p, pt, z);
                        }
                    //Rotación desbalance en la izquierda pero dato insertado en la derecha
                    }else{
                        Nodo* ZD = z->getDer();
                        z->setDer(ZD->getIzq());
                        ZD->setIzq(z);
                        t->setIzq(ZD->getDer());
                        ZD->setDer(t);
                        t_izqOder(p, pt, ZD);
                    }
                }else{  //Si el lado derecho está desbalanceado
                    Nodo* z = t->getDer();
                    if(!isHijo_Izq(d)){
                        //Rotación todo derecha
                        t->setDer(z->getIzq());
                        z->setIzq(t);
                        if(pt == NULL){
                            root = z;
                        }else{
                            t_izqOder(p, pt, z);
                        }
                    //Rotación desbalance en la derecha pero dato insertado en la izquierda
                    }else{
                        Nodo* ZI = z->getIzq();
                        z->setIzq(ZI->getDer());
                        ZI->setDer(z);
                        t->setDer(ZI->getIzq());
                        ZI->setIzq(t);
                        t_izqOder(p, pt, ZI);
                    }
                }
            }
        }
    }
    
    void addAVL(int d){
        if(root == NULL){  //Caso base: El dato agregado es la raiz
            root =  new Nodo(d);
        }else{
            addAVL(d, root, root);  //Si no, se hace recursividad desde la raiz   
        }
    }
    
    void Inorder(Nodo* r){
        if( r!= NULL){
            Inorder(r->getIzq());  //Mostrar el nodo izquierdo
            cout<<r->getDato()<<"\t";  //Mostrar al padre    
            Inorder(r->getDer());  //Mostrar el nodo derecho
        }                   
    }
    
    void Inorder(){
        Inorder(root);
    }
    
    void print2D(Nodo * r, int space) {  //Mostrar el arbol por niveles
    if (r == NULL) // Caso base
      return;
    space += SPACE; // Aumenta la distancia entre niveles
    print2D(r -> getDer(), space); // Se procesa el hijo derecho
    cout << endl;
    for (int i = SPACE; i < space; i++) 
      cout << " "; 
    cout << r -> getDato() << "\n"; 
    print2D(r -> getIzq() , space); // Se procesa el hijo izquierdo
    }
    
    void print2D(int space){
        print2D(root, space);
    }
};

int main(){
    cout<<"--------------------------------------------------ARBOL AVL DE PRUEBA----------------------------------------------------"<<endl;
    Tree t = Tree();
    t.addAVL(2);
    t.addAVL(3);
    t.addAVL(5);
    t.addAVL(7);
    t.addAVL(9);
    t.addAVL(11);
    t.addAVL(13);
    t.addAVL(17);
    t.addAVL(19);
    t.addAVL(21);
    t.addAVL(6);
    t.addAVL(10);
    t.addAVL(12);
    t.addAVL(15);
    t.addAVL(18);
    t.addAVL(-1);
    t.addAVL(-4);
    t.addAVL(-6);
    t.addAVL(-8);
    t.addAVL(-10);
    t.addAVL(-12);
    t.addAVL(-3);
    t.addAVL(-5);
    t.addAVL(-7);
    t.addAVL(-70);
    t.addAVL(-58);
    t.addAVL(-43);
    t.addAVL(-23);
    t.addAVL(-68);
    t.addAVL(-15);
    t.addAVL(-20);
    t.Inorder();
    cout<<endl;
    cout<<"-------------------------------------------------------------------------------------------------------------------------"<<endl;
    return 0;
}
