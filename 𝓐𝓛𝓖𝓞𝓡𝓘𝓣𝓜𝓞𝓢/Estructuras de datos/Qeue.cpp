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

class Qeue{
    
    Nodo* ptr;
    int size;

public:  

    Qeue(){
        ptr = NULL;
        size = 0;
    }
    
    ~Qeue(){
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
    
   
    Point* pop(){
        Point* n2 = new Point(ptr->getDato()->getX(), ptr->getDato()->getY());
        Nodo* n = ptr;
        ptr = n->getNext();
        delete n;
        return n2;
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
    Qeue l = Qeue();

    cout<<"-----------------------------------------"<<endl;
    cout<<"COLA ANTES:"<<endl;
    for(int i = 1; i<10; i++){
        l.push(new Point(i,i));
    }
    l.print();
    cout<<"El elemento que sale de la cola es: "<<(*l.pop())<<endl;
    cout<<"COLA DESPUES:"<<endl;
    l.print();
    cout<<"-----------------------------------------"<<endl;


    return 0;
}
