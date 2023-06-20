#include<iostream>
using namespace std;

//------------------------------CLASE NODO---------------------------------//
class Nodo{
    //Atributos
    int dato;
    Nodo* izq;
    Nodo* mid;
    Nodo* der;
    
public:   
    //Constructores
    Nodo(int i){
        dato = i;
        izq = NULL;
        mid = NULL;
        der = NULL;
    }
    
    //Getters
    int getDato(){
        return dato;
    }
    
    Nodo* getIzq(){
    return izq;
    }
    
    Nodo* getMid(){
    return mid;
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
    
    void setMid(Nodo* i){
        mid = i;
    }
    
    void setDer(Nodo* i){
        der = i;
    }
    
    //Metodos
    bool isHoja(){
        if(izq == NULL && mid == NULL && der == NULL)
            return true;
        return false;
    }
    
    bool hasIzq(){
        return izq!=NULL;
    }
    
    bool hasMid(){
        return mid!=NULL;    
    }
    
    bool hasDer(){
        return der!=NULL;    
    }
};

//------------------------------CLASE TREE---------------------------------//
class Tree{
    //Atributos
    Nodo* root;
    
public:
    //Constructor
    Tree(int max){
        root = new Nodo(max);
    }
    
    //Metodos
    void add(int d){
        Nodo* n = new Nodo(d);
        Nodo* t = root;
        bool found = true;
        while(found == true){
            if(((t->getDato()*2)/3) <= n->getDato()){
                if(t->hasDer() == true){
                    t = t->getDer();
                }else{
                    t->setDer(n);
                    found = false;
                }
            }else if(((t->getDato()*2)/3) > n->getDato() && t->getDato()/3 < n->getDato()){
                if(t->hasMid() == true){
                    t = t->getMid();
                }else{
                    t->setMid(n);
                    found = false;
                }
            }else if(t->getDato()/3 > n->getDato()){
                if(t->hasIzq()){
                    t = t->getIzq();
                }else{
                    t->setIzq(n);
                    found = false;
                }
            }
        }
    }
    
    void preorder(){
        preorder(root);
    }
    void preorder(Nodo* r){
        if( r!= NULL){
            cout<<r->getDato()<<"\t";
            preorder(r->getIzq());
            preorder(r->getMid());
            preorder(r->getDer());
        }
    }
    
};

int main(){
    cout<<"--------------------------------------ARBOL EJEMPLO----------------------------------------"<<endl;
    Tree t = Tree(100);
    t.add(95);
    t.add(92);
    t.add(81);
    t.add(70);
    t.add(68);
    t.add(51);
    t.add(49);
    t.add(31);
    t.add(21);
    t.add(11);
    t.add(7);
    
    t.preorder();
    cout<<endl;
    cout<<"-------------------------------------------------------------------------------------------"<<endl;
    return 0;
}
