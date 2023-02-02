#include<iostream>
#include<string>
using namespace std;

//------------------------------CLASE NODO---------------------------------//
class Nodo{
    //Atributos
    string dato;
    Nodo* pointer;
  
public:
    //Constructores
    Nodo(){
        dato = "";
        pointer = NULL;
    }
  
    Nodo(string d){
        dato = d;
        pointer = NULL;
    }
  
    //Destructor
    ~Nodo(){
    }
  
    //Getters
    string getDato(){
        return dato;
    }
  
    Nodo* getNext(){
        return pointer;
    }
  
    //Setters
    void setDato(string d){
        dato = d;
    }
  
    void setNext(Nodo* p){
        pointer = p;
    }
    
    //Sobrecargas
    string to_string() {
		return dato;
	}


	friend std::ostream& operator<<(std::ostream& os, Nodo& b) {
		return os << b.to_string();
	}
    
};

//------------------------------CLASE CONTROL Z---------------------------------//
class control_z{
    //Atributos
    Nodo* ptr;
    Nodo* tail;
    int limite;
    int size;

public:  
    //Constructor
    control_z(int lim){
        ptr = NULL;
        tail = NULL;
        size = 0;
        limite = lim;
    }
    
    //Destructor
    ~control_z(){
        Nodo* t = ptr;
        Nodo* n;
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
    
    Nodo* getPtr(){
        return ptr;
    }
    
    //Metodos
    void z(){
        Nodo* t = ptr;
        while(t->getNext() != tail){
            t = t->getNext();    
        }
        t->setNext(NULL);
        tail = t;
        size--;
    }
    
    void push(string d){
        tail = new Nodo(d);
        if(size == 0){
            ptr = tail;
            size++;
        }else if(size == limite){
            Nodo* t = ptr;
            while(t->getNext() != NULL){
                t = t->getNext();    
            }
            t->setNext(tail);
            pop_cola();  
            size++;
        }else{
            Nodo* t = ptr;
            while(t->getNext() != NULL){
                t = t->getNext();    
            }
            t->setNext(tail);
            size++;
        }
    }
    
   
    void pop_cola(){
        if(size == 0){
            cout<<"esta vacio"<<endl;
        }else{
            Nodo* n = ptr;
            ptr = n->getNext();
            delete n;
            size--;
        }
    }
    
    void print(){
        if(size == 0){
            cout<<"esta vacio"<<endl;
        }else{
            Nodo* t = ptr;
            do{
                cout<<(*t);
                t = t->getNext();   
            }while(t != NULL);
            cout<<endl;
        }
    }
    
    
};

int main(){
    control_z p = control_z(7);
    cout<<"---------------PRUEBA PUSH LIMITADO A 7 STRINGS-----------------"<<endl;
    p.push("H");
    p.print();
    
    p.push("o");
    p.print();
    
    p.push("l");
    p.print();
    
    p.push("a");
    p.print();
    
    p.push(" ");
    
    p.push("m");
    p.print();
    
    p.push("u");
    p.print();
    
    p.push("n");
    p.print();
    
    p.push("d");
    p.print();
    
    p.push("o");
    p.print();
    cout<<"---------------------------------------------------------------"<<endl;
    
    cout<<"----------------------CONTROL Z 4 VECES------------------------"<<endl;
    p.z();
    p.z();
    p.z();
    p.z();
    p.print();
    cout<<"---------------------------------------------------------------"<<endl;
    
    cout<<"----------------------AGREGAR NUEVAS LETRAS--------------------"<<endl;
    p.push("a");
    p.print();
    
    p.push("m");
    p.print();
    
    p.push("a");
    p.print();
    cout<<"---------------------------------------------------------------"<<endl;
    return 0;
}
