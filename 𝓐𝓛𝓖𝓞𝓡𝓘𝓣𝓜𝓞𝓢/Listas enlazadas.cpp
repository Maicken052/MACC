-----------------------------------------------------------------LISTAS ENLAZADAS (CLASE PUNTO)------------------------------------------------------------------------
#include<iostream>
#include <math.h> 

using namespace std;

class Point {

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

    //M�todos
    
    Point ofuscacion() {
        return Point(x + 2 * (rand() % rmax) - rmax, y + 2 * (rand() % rmax) - rmax);
    }
    
    double dist() {
        return dist(0,0);
    }

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

class Lista{
    
    Nodo* ptr;
    int size;

public:  

    Lista(){
        ptr = NULL;
        size = 0;
    }
    

    void push_back(Point* d){
        
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
                //cout<<"("<<(*t).getDato()->getX()<<", "<<t->getDato()->getY()<<"), ";
                cout<<(*t)<<", ";
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
    
    void insert(Point* p, int pos){
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


static Lista fusion(Lista l1,Lista l2,int tipo_de_fusion){
    Lista f=Lista();
    if (tipo_de_fusion==1){
        Nodo* n;
        Nodo* m;
        n=l1.getPtr();
        m=l2.getPtr();
        
        if(n==NULL){
          while(m!=NULL){
              f.push_back(m->getDato());
              m=m->getNext();
          }  
        }else{
            while(n!=NULL){
                f.push_back(n->getDato());
                n=n->getNext();
            }
        }
        if(l1.getSize() > l2.getSize()){
            while(m!=NULL){
                f.push_back(n->getDato());
                f.push_back(m->getDato());
                n=n->getNext();
                m=m->getNext();
            }
        }else{
            while(n!=NULL){
                f.push_back(n->getDato());
                f.push_back(m->getDato());
                n=n->getNext();
                m=m->getNext();
            }
        }
        f.print();
        return f;
        
    }else if(tipo_de_fusion==0){
        int l1_size, f_size;
        l1_size=l1.getSize();
        Nodo* n=l1.get(l1_size-1);
        n->setNext(l2.getPtr());
        f.setPtr(l1.getPtr());
        f_size=l1.getSize()+l2.getSize();
        f.setSize(f_size);
        return f;
    }else{
        cout<<"El tipo de fusión no es valido"<<endl;
        return l1;
    }
}


int main(){
   
    Lista l = Lista();

    cout<<"PRUEBA PUSH BACK"<<endl;
    l.push_back(new Point(1,1));
   
    l.print();
   
    l.push_back(new Point(2,2));
   
    l.print();
   
    for(int i = 3; i<10; i++){
        l.push_back(new Point(i,i));
    }
   
    l.print();
    cout<<(*l.get(2))<<endl;
    cout<<"-----------------------------------------"<<endl;
    cout<<"LISTA 1"<<endl;
    l.print();
    cout<<"-----------------------------------------"<<endl;
    Lista l2 = Lista();
   
    l2.insert(new Point(20,20),0);
    l2.insert(new Point(21,21),1);
    l2.insert(new Point(22,22),2);
    l2.insert(new Point(23,23),3);
    l2.insert(new Point(24,24),4);
    l2.insert(new Point(25,25),5);
   
    cout<<"LISTA 2"<<endl;
    l2.print();
    l2.atributos();
    cout<<"-----------------------------------------"<<endl;
    cout<<"LISTA 2 INVERTIDA"<<endl;
    l2.invertir();
    l2.print();
    l2.atributos();
    cout<<"-----------------------------------------"<<endl;
    
    fusion(l, l2, 0).print();


    return 0;
}