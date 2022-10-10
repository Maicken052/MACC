#include<iostream>
using namespace std;

class Nodo{
    int dato;
    Nodo* izq;
    Nodo* der;

public:   
    Nodo(int i){
        dato = i;
        izq = NULL;
        der = NULL;
    }
    
    int getDato(){
        return dato;
    }
    
    Nodo* getIzq(){
    return izq;
    }
    
    Nodo* getDer(){
    return der;
    }
    
    void setDato(int i){
        dato = i;
    }
    
    void setIzq(Nodo* i){
        izq = i;
    }
    
    void setDer(Nodo* i){
        der = i;
    }
    
    bool isHoja(){
        if(izq == NULL && der == NULL)
            return true;
        return false;
    }
    
    bool hasIzq(){
        return izq!=NULL;
    }
    
    bool hasDer(){
        return der!=NULL;    
    }
};

class Tree{
    Nodo* root;
    
public:
    Tree(){
        root = NULL;
    }
    
    void add(int d){
        Nodo* n = new Nodo(d);
        if(root = NULL){
            root = n;
        }else{
            Nodo* t = root;
            bool found = true;
            while(found == true){
                if(t->getDato() < n->getDato()){
                    if(t->hasDer() == true){
                        t = t->getDer();
                    }else{
                        t->setDer(n);
                        found = false;
                    }
                }else if(t->getDato() > n->getDato()){
                    if(t->hasIzq()){
                        t = t->getIzq();
                    }else{
                        t->setIzq(n);
                        found = false;
                    }
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
            preorder(r->getDer());
        }
    }
    
};

int main(){
    Tree t = Tree();
    t.add(18);
    t.add(12);
    t.add(15);
    t.add(24);
    t.add(21);
    t.add(41);
    
    t.preorder();
    return 0;
}
