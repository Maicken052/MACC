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
    
    void add(int d){
        Nodo* n = new Nodo(d);
        if(root == NULL){
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
    
    bool isIzq_Heavy(){
        return isIzq_Heavy(root);
    }
    
    bool isHijo_Izq(Nodo* t){
        Nodo* p = es_padre(t->getDato());
        if(p->getIzq() == t){
            return true;
        }else{
            return false;
        }
    }
    
    bool isBalanced(){
        int i = getHeight(root->getIzq());
        int d = getHeight(root->getDer());
        if(abs(i-d)>1){
            return true;
        }else{
            return false;
        }
    }
    
    void insertAVL(int d){
        if(isBalanced()){
            
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
    t.add(45);
    t.add(23);
    t.add(65);
    t.add(2);
    t.add(38);
    t.add(52);
    t.add(96);
    t.add(7);
    t.add(48);
    t.add(47);
    t.add(46);
    
    t.preorder();
    cout<<endl;
    cout<<t.isIzq_Heavy()<<endl;
    return 0;
}
