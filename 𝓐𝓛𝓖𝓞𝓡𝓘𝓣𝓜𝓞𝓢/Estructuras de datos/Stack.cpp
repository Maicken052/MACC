#include<iostream>
#include <math.h> 
using namespace std;

class Point{

//Atributos
    int x;
    int y;

    const int rmax = 1;

public:
    
    //Constructores
    Point(int xc, int yc) {
        x = xc;
        y = yc;

    }

    Point() {
        x = 0;
        y = 0;
    }

    //Metodos
   
    double dist(int xc, int yc) {
        return sqrt(pow(x-xc, 2) + pow(y-yc, 2));
    }

    double dist(Point p) {
        return dist(p.x, p.y);
    }

    //Getters
    int getX() {
        return x;
    }

    int getY() {
        return y;
    }


    //Setters
    void setX(int xc) {
        x = xc;
    }

    void setY(int yc) {
        y = yc;
    }
    
    Point& operator=(const Point& f) { 
		setX(f.x);
		setY(f.y);
		return *this; 
	}
	
	string to_string() {
		return "("+std::to_string(x) + "," + std::to_string(y)+")";
	}


	friend std::ostream& operator<<(std::ostream& os, Point& b) {
		return os << b.to_string();
	}

};

class Nodo{
  
  Point* dato;
  Nodo* pointer;
  
public:
  
  Nodo(){
      dato = NULL;
      pointer = NULL;
  }
  
  ~Nodo(){
      delete dato;
  }
  
  Nodo(Point* d){
      dato = d;
      pointer = NULL;
  }
    
  Point* getDato(){
      return dato;
  }
  
  void setDato(Point* d){
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

class Stack{
    
    Nodo* ptr;
    int size;

public:  

    Stack(){
        ptr = NULL;
        size = 0;
    }
    
    ~Stack(){
        Nodo* t = ptr;
        Nodo* n;
        while(t->getNext() != NULL){
            n = t;
            t = t->getNext();    
            delete n;
        }
        delete t;
    }
    
    void push(Point* d){
        Nodo* front = ptr;
        Nodo* top = new Nodo(d);
        ptr = top;
        ptr->setNext(front);
        size++;
    }
   
    Point* pop(){
        Point* n2 = new Point(ptr->getDato()->getX(), ptr->getDato()->getY());
        Nodo* n = ptr;
        ptr = n->getNext();
        delete n;
        return n2;
    }
       
    Nodo* get(int i){
        if(i < size && i>=0){
            Nodo* n = ptr;
            for(int x = 0; x<i;x++){
                n = n->getNext();
            }
            return n;
        }else{
            if(size == 0){
                cout<<"La lista está vacía";
            }else{
                cout<<"La posicion no existe";
            }
            return NULL;
        }
    }
    
    void print(){
        if(size == 0){
            cout<<"La lista está vacía"<<endl;
        }else{
            Nodo* t = ptr;
            do{
                cout<<(*t)<<", ";
                t = t->getNext();   
            }while(t != NULL);
            cout<<endl;
        }
    }
};



int main(){
   
    Stack l = Stack();

    cout<<"-----------------------------------------"<<endl;
    cout<<"LISTA 1"<<endl;
    for(int i = 3; i<10; i++){
        l.push(new Point(i,i));
    }
    l.print();
    cout<<(*l.pop())<<endl;
    l.print();
    cout<<"-----------------------------------------"<<endl;


    return 0;
}
