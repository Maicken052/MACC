#include <iostream>
#include <math.h> 
using namespace std;

//-----------------------------------CLASE PUNTO----------------------------------//
class Point{
    
    int x;
    int y;
    double dist;

public:
    //Constructores
    Point(int xc, int yc, double distc) {
        x = xc;
        y = yc;
        dist = distc;
    }

    Point() {
        x = 0;
        y = 0;
        dist = 0;
    }

    //Metodos
    
    double dista(int xc, int yc) {
        return sqrt(pow(x-xc, 2) + pow(y-yc, 2));
    }

    //Getters
    int getX() {
        return x;
    }

    int getY() {
        return y;
    }

    double getDist(){
        return dist;
    }
    
    //Setters
    void setX(int xc) {
        x = xc;
    }

    void setY(int yc) {
        y = yc;
    }
    
    void setDist(double distc) {
        dist = distc;
    }
    
    Point& operator=(const Point& f) { 
		setX(f.x);
		setY(f.y);
		setDist(f.dist);
		return *this; 
	}
	
	string to_string() {
		return "("+std::to_string(x) + "," + std::to_string(y) + "," + std::to_string(dist)+ ")";
	}


	friend std::ostream& operator<<(std::ostream& os, Point& b) {
		return os << b.to_string();
	}
};

//-----------------------------------CLASE NODO----------------------------------//
class Nodo{
  
  Point* dato;
  Nodo* pointer;
  
public:
    Nodo(){
        dato = NULL;
        pointer = NULL;
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

//-----------------------------------CLASE LISTA----------------------------------//
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
};

//-----------------------------------FUNCIÓN SWAP----------------------------------//
void swapp(Lista &l, int a, int b){  //cambia el punto de una posición a otra
    Point* aux;
    aux=l.get(a)->getDato();
    l.get(a)->setDato(l.get(b)->getDato());
    l.get(b)->setDato(aux);
}

//-----------------------------------FUNCIÓN HEAPIFY----------------------------------//
void heapify(Lista &l, int size){  //Evalua ramas del arbol binario, e intercambia su valor con los hijos si son menores
    double mxheap, mxheap_son;
    mxheap=(size/2)-1;  //La ultima rama del arbol
    for(mxheap; mxheap>=0; mxheap--){
        if(2*(mxheap+1)<size){  //Si la rama tiene dos hojas, saca el menor valor de entre las dos
        mxheap_son=min(l.get((2*mxheap)+1)->getDato()->getDist(), l.get(2*(mxheap+1))->getDato()->getDist());
        }else{
            mxheap_son=l.get((2*mxheap)+1)->getDato()->getDist();  //Sino, el menor valor será la hoja izquierda
        }
        if(l.get(mxheap)->getDato()->getDist()>mxheap_son){  //Si la hoja es menor que la rama, intercambian valores
            if(mxheap_son==l.get((2*mxheap)+1)->getDato()->getDist()){  //Si el valor es la hoja izquierda
                swapp(l, mxheap, (2*mxheap)+1);
            }else{
                swapp(l, mxheap, 2*(mxheap+1)); //Si el valor es la hoja derecha
            }
        }
    }
    swapp(l, 0, size-1);  //Manda el menor valor al final de la lista
}

//-----------------------------------FUNCIÓN HEAPSORT----------------------------------//
void heapsort(Lista &l, int size){  //Llama a heapify restando uno al tamaño, hasta que el tamaño sea igual a 1
    if(size==1){
        cout<<"";
    }else{
        heapify(l, size);
        heapsort(l, size-1);
    }
}

//---------------------------------------------------------------------------------//
int main(){
    srand(1234);
    Lista l = Lista();  //Lista para almacenar cada punto con su respectiva distancia a un punto
    int size, punto_x, punto_y;
    size = 10;  //cantidad de puntos
    punto_x = rand()%100;  //valor x del punto
    punto_y = rand()%100;  //valor y del punto
    
    //----------------Llenar la lista con valores random-----------------------//
    for(int i = 0; i<size; i++){
        int x, y, dist;
        x = rand()%100;
        y = rand()%100;
        dist = 0;
        l.push_back(new Point(x, y, dist));
    }
    
    //----------------Calcular distancia-----------------------//
    for(int i = 0; i<size; i++){  //Saca la distacia de cada punto en la lista con el punto especifico elegido
        l.get(i)->getDato()->setDist(l.get(i)->getDato()->dista(punto_x, punto_y));
    }
    
    //----------------Prueba-----------------------//
    cout<<"Punto especifico: "<<"("<<punto_x<<", "<<punto_y<<")"<<endl;
    cout<<"LISTA DE PUNTOS SIN ORDENAR:"<<endl;
    l.print();
    
    heapsort(l, size);
    cout<<endl;

    cout<<"LISTA DE PUNTOS ORDENADA:"<<endl;
    l.print();
    
    return 0;
}
