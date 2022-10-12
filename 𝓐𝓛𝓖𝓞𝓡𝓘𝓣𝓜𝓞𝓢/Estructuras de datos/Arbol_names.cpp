#include<iostream>
#include<string>
using namespace std;

class Nodo{
  
  NodoT* dato;
  Nodo* pointer;
  
public:
  
  Nodo(){
      dato = NULL;
      pointer = NULL;
  }
  
  ~Nodo(){
      delete dato;
  }
  
  Nodo(NodoT* d){
      dato = d;
      pointer = NULL;
  }
    
  NodoT* getDato(){
      return dato;
  }
  
  void setDato(NodoT* d){
      dato = d;
  }
  
  Nodo* getNext(){
      return pointer;
  }
  
  void setNext(Nodo* p){
      pointer = p;
  }
    
    string to_string() {
		return getDato()->to_string();
	}


	friend std::ostream& operator<<(std::ostream& os, Nodo& b) {
		return os << b.to_string();
	}
    
};

class Lista{
    
    Nodo* ptr;
    int size;

public:  

    Lista(){
        ptr = NULL;
        size = 0;
    }
    

    void push_back(NodoT* d){
        
        if(size == 0){
            ptr = new Nodo(d);
            size++;
        }else{
            Nodo* t = ptr;
            while(t->getNext() != NULL){
                t = t->getNext();    
            }
            t->setNext(new Nodo(d));
            size++;
        }
        
    }
    
    int getSize(){
        return size;
    }
    
    void setSize(int i){
        size=i;
    }
    
    Nodo* getPtr(){
        return ptr;
    }
    
    void setPtr(Nodo* n){
        ptr= n;
    }

    void print(){
        if(size == 0){
            cout<<"La lista está vacía"<<endl;
        }else{
            Nodo* t = ptr;
            do{
                cout<<t->getDato()<<", ";
                t = t->getNext();
                
            }while(t != NULL);
            cout<<endl;
        }
    }
    
    Nodo* get(int i){
        if(i < size && i>=0){
            Nodo* n = ptr;
            for(int x = 0; x<i;x++){
                n = n->getNext();
            }
            return n;
        }else{
            //throw invalid_argument("La posicion no existe");
            if(size == 0){
                cout<<"La lista está vacía";
            }else{
                cout<<"La posicion no existe";
            }
            return NULL;
        }
        
    }
    
    void insert(NodoT* p, int pos){
        if(pos >= 0 && pos <= size){
            //Si la lista está vacía o si se quiere insertar el nodo al final
            //se usa el método push_back
            if(size == 0 || pos == size){ 
                push_back(p);
            }else{
                Nodo* n = new Nodo(p);
                //Si se quiere insertar el nodo de primero en la lista
                if(pos == 0){
                    n->setNext(ptr);
                    ptr = n;
                }else{
                    Nodo* t = get(pos-1);
                    n->setNext(t->getNext());
                    t->setNext(n);
                }
                size++;
            }
        }else{
            throw invalid_argument("La posicion no existe");
        }
        
    }
    
    void remove(int pos){
        if(pos >= 0 && pos <size){
            if(size == 0){
                cout<<"La lista no tiene elementos";
            }else{
                if(pos==0){
                    Nodo* n=ptr;
                    ptr=ptr->getNext();
                    delete n;
                    size--;
                }else{
                    Nodo* n=get(pos-1);
                    Nodo* t=get(pos);
                    n->setNext(t->getNext());
                    delete t;
                    size--;
                }
            }
        }else{
            cout<<"La posición no existe";
        }
    }
    
    void invertir(){
        Nodo* nNext;
        Nodo* ptr2=NULL;
        Nodo* n=ptr;
        while(n!=NULL){
            nNext=n->getNext();
            n->setNext(ptr2);
            ptr2=n;
            n=nNext;
        }
        ptr=ptr2;
    }

    void atributos(){
        cout <<"la cantidad de elementos es: " <<size<<endl;
    } 
    
};

class NodoT{
    char dato;
    Lista* letras;

public:   
    NodoT(char i){
        dato = i;
        letras = NULL;
    }
    
    NodoT(){
      dato = 0;
      letras = NULL;
    }
    
    char getDato(){
        return dato;
    }
    
    NodoT* get_in_Letras(int i){
        return letras->get(i)->getDato();
    }
    
    void setDato(char i){
        dato = i;
    }
    
    void set_in_Letras(int i, NodoT* l){
        letras->get(i)->setDato(l);
    }
    
    bool isHoja(){
        if(letras->getSize() == 0)
            return true;
        return false;
    }
};

class Tree{
    NodoT* root;
    
public:
    Tree(){
        NodoT* t = new NodoT(0);
        root = t;
    }
    
    /*
    void add(int d){
        NodoT* n = new NodoT(d);
        NodoT* t = root;
        bool found = true;
        while(found){
            if(t->getDato() < n->getDato()){
                if(t->hasDer()){
                    t = t->getDer();
                }else{
                    t->setDer(n);
                    found = false;
                }
            }else{
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
    void preorder(NodoT* r){
        if( r!= NULL){
            cout<<r->getDato()<<"\t";
            preorder(r->getIzq());
            preorder(r->getDer());
        }
    }
    */
};



int main(){
    Lista l = Lista();
    NodoT r = NodoT("d");
    NodoT ra = NodoT("e");
    NodoT ran = NodoT("f");
    l.push_back(r);
    l.push_back(ra);
    l.push_back(ran);
    l.print();
    cout<<endl;
    return 0;
}
