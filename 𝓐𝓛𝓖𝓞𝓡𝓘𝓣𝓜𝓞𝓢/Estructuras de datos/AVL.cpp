#include<iostream>
#include<cmath>
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
    
    int getHeight(Nodo* t){
        if(t != NULL){
            if(t->isHoja()){
                return 1;
            }else{
                int i = getHeight(t->getIzq());
                int d = getHeight(t->getDer());
                int m = max(i, d);
                return m+1;
            }
        }else{
            return 0;
        }
    }
    
    int getHeight(){
        return getHeight(root);
    }
    
    Nodo* es_padre(int x, Nodo* t){
        if(t->getDato() == x){
            return NULL;
        }
        if(t->hasIzq()){
            if(t->getIzq()->getDato() == x){
                return t;
            }else{
                Nodo* ri = t->getIzq();
                Nodo* m = es_padre(x, ri);
                if(m != NULL){
                    if(m->hasIzq()){
                        if(m->getIzq()->getDato() == x){
                            return m;;   
                        }
                    }if(m->hasDer()){
                        if(m->getDer()->getDato() == x){
                            return m;
                        } 
                    }
                }
            }
        }if(t->hasDer()){
            if(t->getDer()->getDato() == x){
                return t;
            }else{
                Nodo* rd = t->getDer();
                Nodo* l = es_padre(x, rd);
                if(l != NULL){
                    if(l->hasIzq()){
                        if(l->getIzq()->getDato() == x){
                            return l;
                        }
                    }if(l->hasDer()){
                        if(l->getDer()->getDato() == x){
                            return l;
                        } 
                    }
                }
            }
        }
        return NULL;
    }
    
    Nodo* es_padre(int x){
        return es_padre(x, root);
    }
    
    bool isIzq_Heavy(Nodo* t){
        int i = getHeight(t->getIzq());
        int d = getHeight(t->getDer());
        if(i>d){
            return true;
        }else{
            return false;
        }
    }
    
    bool isHijo_Izq(int d){
        Nodo* p = es_padre(d);
        if(p->getIzq()->getDato() == d){
            return true;
        }else{
            return false;
        }
    }
    
    bool isHijo_Der(int d){
        Nodo* p = es_padre(d);
        if(p->getDer()->getDato() == d){
            return true;
        }else{
            return false;
        }
    }
    
    bool isBalanced(Nodo* t){
        int i = getHeight(t->getIzq());
        int d = getHeight(t->getDer());
        if(abs(i-d)>1){
            return false;
        }else{
            return true;
        }
    }
    
    void addAVL(int d, Nodo* t, Nodo* pt){
        //Add
        if(t == NULL){
            Nodo* n = new Nodo(d);
            if(d < pt->getDato()){
                pt->setIzq(n);
            }else{
                pt->setDer(n);
            }
        }else{
            if(d < t->getDato()){
                addAVL(d, t->getIzq(), t);
            }else{
                addAVL(d, t->getDer(), t);
            }
            //Balanceo
            if(!isBalanced(t)){
                
                //Rotacion todo izquierda
                if(isIzq_Heavy(t)){
                    if(isHijo_Izq(d)){
                        Nodo* z = t->getIzq();
                        pt = es_padre(t->getDato());
                        t->setIzq(z->getDer());
                        z->setDer(t);
                        if(pt == NULL){
                            root = z;
                        }else{
                            pt->setIzq(z);
                        }
                    }
                    
                //Rotacion todo derecha
                }else{
                    if(isHijo_Der(d)){
                        Nodo* z = t->getDer();
                        pt = es_padre(t->getDato());
                        t->setDer(z->getIzq());
                        z->setIzq(t);
                        if(pt == NULL){
                            root = z;
                        }else{
                            pt->setDer(z);
                        }
                    }
                }
            }
        }
    }
    
    void addAVL(int d){
      if(root != NULL)
        addAVL(d, root, root);
      else
        root =  new Nodo(d);
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
    t.addAVL(2);
    t.addAVL(1);
    t.addAVL(3);
    t.addAVL(5);
    t.addAVL(6);
    
    t.preorder();
    cout<<endl;

    return 0;
}
