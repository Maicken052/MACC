-------------------------------------------------------------------------------LISTAS CIRCULARES----------------------------------------------------------------------	    
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
  Nodo* pointernxt;
  Nodo* pointerprev;
  
public:
  
  Nodo(){
      dato = NULL;
      pointernxt = NULL;
      pointerprev= NULL;
  }
  
  ~Nodo(){
      delete dato;
  }
  
  Nodo(Point* d){
      dato = d;
      pointernxt = NULL;
      pointerprev= NULL;
  }
    
  Point* getDato(){
      return dato;
  }
  
  void setDato(Point* d){
      dato = d;
  }
  
  Nodo* getNext(){
      return pointernxt;
  }
  
  Nodo* getPrev(){
      return pointerprev;
  }

  void setNext(Nodo* p){
      pointernxt = p;
  }

  void setPrev(Nodo* p){
      pointerprev = p;
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
    
    ~Lista(){
        Nodo* t = ptr;
        Nodo* n;
        while(t->getNext() != ptr){
            n = t;
            t = t->getNext();    
            delete n;
        }
        delete t;
    }
    
    void push_back(Point* d){
        
        if(size == 0){
            Nodo* n;
            n = new Nodo(d);
            ptr=n;
            n->setNext(ptr);
            n->setPrev(ptr);
            size++;
        }else{
            Nodo* last;
            Nodo* nw = new Nodo(d);
            last=ptr->getPrev();
            last->setNext(nw);
            nw->setNext(ptr);
            nw->setPrev(last);
            ptr->setPrev(nw);
            size++;
        }
        
    }
    
    int getSize(){
        return size;
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
                
            }while(t != ptr);
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
                if(pos!=0){
                    Nodo* m=get(pos);
                    n->setNext(m);
                    n->setPrev(m->getPrev());
                    m->setPrev(n);
                    n->getPrev()->setPrev(n);
                }else{
                    ptr = n;
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

//Lista fusion(Lista l1,Lista l2,int tipo_de_fusion){
    //if (tipo_de_fusion==1){
        //Lista f=Lista();
        //if(l1.getSize() > l2.getSize()){
            //f.setPtr(l1.getPtr());
            //Nodo* n=f.getPtr();
            //int i=0;
            //while(i<l2.getSize()){
                //n->setNext(l2.get(i));
                //n=n->getNext();
                //n->setNext(l1.get(i+1));
                //n=n->getNext();
                //i++;
            //}
            //n->setNext(NULL);
            //int aa;
            //aa=l1.getSize()+l2.getSize()-2;
            //f.setSize(aa);
            //f.print();
            //f.atributos();
            //return f;
        //}else{
            //f.setPtr(l1.getPtr());
            //Nodo* n=f.getPtr();
            //for(int i = 0; i<l1.getSize(); i++){
                //n->setNext(l2.get(i));
                //n=n->getNext();
                //n->setNext(l1.get(i+1));
                //n=n->getNext();
            //}
            //int aa;
            //aa=l1.getSize()+l2.getSize();
            //f.setSize(aa);
            //f.print();
            //return f;
            //}

    //}else if(tipo_de_fusion==0){
        //Lista f=Lista();
        //int a, aa;
        //a=l1.getSize();
        //Nodo* n=l1.get(a-1);
        //n->setNext(l2.getPtr());
        //f.setPtr(l1.getPtr());
        //aa=l1.getSize()+l2.getSize();
        //f.setSize(aa);
        //f.print();
        //return f;
    //}else{
        //cout<<"El tipo de fusión no es valido"<<endl;
        //return l1;
    //}
//}



int main(){
   
    Lista l = Lista();
    
    l.push_back(new Point(1,1));
   
    l.print();
   
    l.push_back(new Point(2,2));
   
    l.print();
   
    l.push_back(new Point(3,3));
   
    l.print();
    
    l.insert(new Point(0,0), 3 );
    
    l.print();

    l.insert(new Point(4,4), 1 );
    
    l.print();
    cout<<"-----------------------------------------"<<endl;
    return 0;
}