#include<iostream>
using namespace std;

//------------------------------CLASE NODO---------------------------------//
class Nodo_S{
    //Atributos
    int dato;
    Nodo_S* pointer;
  
public:
    //Constructores
    Nodo_S(){
        dato = 0;
        pointer = NULL;
    }
  
    Nodo_S(int d){
        dato = d;
        pointer = NULL;
    }
  
    //Destructor
    ~Nodo_S(){
    }
  
    //Getters
    int getDato(){
        return dato;
    }
  
    Nodo_S* getNext(){
        return pointer;
    }
  
    //Setters
    void setDato(int d){
        dato = d;
    }
  
    void setNext(Nodo_S* p){
        pointer = p;
    }
    
    //Sobrecargas
    string to_string() {
		return std::to_string(dato);
	}


	friend std::ostream& operator<<(std::ostream& os, Nodo_S& b) {
		return os << b.to_string();
	}
    
};

//------------------------------CLASE STACK---------------------------------//
class Stack{
    //Atributos
    Nodo_S* ptr;
    int size;

public:  
    //Constructor
    Stack(){
        ptr = NULL;
        size = 0;
    }
    
    //Destructor
    ~Stack(){
        Nodo_S* t = ptr;
        Nodo_S* n;
        while(t->getNext() != NULL){
            n = t;
            t = t->getNext();    
            delete n;
        }
        delete t;
    }
    
    //Getters
    int getSize(){
        return size;
    }
    
    Nodo_S* getPtr(){
        return ptr;
    }
    
    //Metodos
    void push(int d){
        Nodo_S* front = ptr;
        Nodo_S* top = new Nodo_S(d);
        ptr = top;
        ptr->setNext(front);
        size++;
    }
   
    void pop(){
        if(size == 0){
            cout<<"El stack esta vacio"<<endl;
        }else{
            Nodo_S* n = ptr;
            ptr = n->getNext();
            delete n;
            size--;
        }
    }
    
    int peek(){
        return ptr->getDato();
    }
    
    void print(){
        if(size == 0){
            cout<<"No tiene primos"<<endl;
        }else{
            Nodo_S* t = ptr;
            do{
                cout<<(*t)<<"  ";
                t = t->getNext();   
            }while(t != NULL);
            cout<<endl;
        }
    }
};

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
    
    Nodo(){
        dato = 0;
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
            while(found){
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
    
    Nodo* getRoot(){
        return root;
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
    
    int es_primo(int x){
        Stack primos = Stack();
        
        Nodo* padre = es_padre(x);
        if(padre == NULL){
            cout<<"No tiene primos"<<endl;
            return 0;
        }
        
        Nodo* abuelo = es_padre(padre->getDato());
        if(abuelo == NULL){
            cout<<"No tiene primos"<<endl;
            return 0;
        }
        
        if(abuelo->hasIzq()){
            Nodo* tio = abuelo->getIzq();
            
            if(tio != padre){
                if(tio->hasIzq()){
                    Nodo* primo = tio->getIzq();
                    primos.push(primo->getDato());
                }
                if(tio->hasDer()){
                    Nodo* primo2 = tio->getDer();
                    primos.push(primo2->getDato());
                }
            }
        }
        
        if(abuelo->hasDer()){
            Nodo* tio2 = abuelo->getDer();
            if(tio2 != padre){
                if(tio2->hasIzq()){
                    Nodo* primo3 = tio2->getIzq();
                    primos.push(primo3->getDato());
                }
                if(tio2->hasDer()){
                    Nodo* primo4 = tio2->getDer();
                    primos.push(primo4->getDato());
                }
            }
        }
        
        if(primos.getSize() == 0){
            cout<<"No tiene primos"<<endl;
        }else{
            cout<<"Los primos de "<<x<<" son: "<<endl;
            primos.print();
        }
        
        return 0;
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
    
    t.preorder();
    cout<<endl;
    
    t.es_primo(48);
    return 0;
}
