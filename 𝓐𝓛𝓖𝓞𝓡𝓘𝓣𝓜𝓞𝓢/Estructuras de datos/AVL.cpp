#include<iostream>
#include<cmath>
#define SPACE 10
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
        if(p != NULL){
            if(p->getIzq() == NULL){
                return false;
            }else{
                if(p->getIzq()->getDato() == d){
                    return true;
                }else{
                    return false;
                }    
            }
        }
        return false;
    }
    
    bool isHijo_Der(int d){
        Nodo* p = es_padre(d);
        if(p != NULL){
            if(p->getDer() == NULL){
                return false;
            }else{
                if(p->getDer()->getDato() == d){
                    return true;
                }else{
                    return false;
                }    
            }
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
                    Nodo* z = t->getIzq();
                    pt = es_padre(t->getDato());
                    if(isHijo_Izq(d)){
                        bool p = isHijo_Izq(t->getDato());
                        t->setIzq(z->getDer());
                        z->setDer(t);
                        if(pt == NULL){
                            root = z;
                        }else{
                            if(p){
                                pt->setIzq(z);
                            }else{
                                pt->setDer(z);
                            }
                        }
                    //Rotación desbalance en la izquierda pero dato insertado en la derecha
                    }else{
                        bool p = isHijo_Izq(t->getDato());
                        Nodo* ZD = z->getDer();
                        z->setDer(ZD->getIzq());
                        ZD->setIzq(z);
                        t->setIzq(ZD->getDer());
                        ZD->setDer(t);
                        if(p){
                            pt->setIzq(ZD);
                        }else{
                            pt->setDer(ZD);
                        }
                    }
                    
                //Rotacion todo derecha
                }else{
                    Nodo* z = t->getDer();
                    pt = es_padre(t->getDato());
                    if(isHijo_Der(d)){
                        bool p = isHijo_Der(t->getDato());
                        t->setDer(z->getIzq());
                        z->setIzq(t);
                        if(pt == NULL){
                            root = z;
                        }else{
                            if(p){
                                pt->setDer(z);
                            }else{
                                pt->setIzq(z);
                            }
                        }
                    //Rotación desbalance en la derecha pero dato insertado en la izquierda
                    }else{
                        bool p = isHijo_Izq(t->getDato());
                        Nodo* ZI = z->getIzq();
                        z->setIzq(ZI->getDer());
                        ZI->setDer(z);
                        t->setDer(ZI->getIzq());
                        ZI->setIzq(t);
                        if(p){
                            pt->setIzq(ZI);
                        }else{
                            pt->setDer(ZI);
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
    
    void Inorder(){
        Inorder(root);
    }
    
    void Inorder(Nodo* r){
        if( r!= NULL){
            Inorder(r->getIzq());
            cout<<r->getDato()<<"\t";    
            Inorder(r->getDer());
        }                   
    }
    
    void print2D(Nodo * r, int space) {
    if (r == NULL) // Base case  1
      return;
    space += SPACE; // Increase distance between levels   2
    print2D(r -> getDer(), space); // Process right child first 3 
    cout << endl;
    for (int i = SPACE; i < space; i++) // 5 
      cout << " "; // 5.1  
    cout << r -> getDato() << "\n"; // 6
    print2D(r -> getIzq() , space); // Process left child  7
    }
    
    void print2D(int space){
        print2D(root, space);
    }
};

int main(){
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
    return 0;
}
