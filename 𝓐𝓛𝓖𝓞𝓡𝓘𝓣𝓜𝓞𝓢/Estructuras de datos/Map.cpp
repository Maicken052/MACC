#include<iostream>
#include<string>
using namespace std;

template <typename T, typename T2>
class Tupla{
//---------------------------------------------ATRIBUTOS------------------------------------------//
    T key;
    T2 dato;

public:
 //-------------------------------------------CONSTRUCTOR-----------------------------------------//
    Tupla(T k, T2 d) {
        key = k;
        dato = d;
    }
    
//------------------------------------------------METODOS-----------------------------------------//
    Tupla(){
    }
    
    void setKey(T k){
        key = k;
    }
    
    void setDato(T2 d){
        dato = d;
    }
    
    T getKey(){
        return key;
    }
    
    T2 getDato(){
        return dato;
    }
    
    Tupla& operator=(const Tupla& f) { 
		setKey(f.key);
		setDato(f.dato);
		return *this; 
	}
};

template <typename T, typename T2>
class Mapa{
    //---------------------------------------------ATRIBUTOS------------------------------------------//
    int len;
    int capacity;
    Tupla<T, T2>* v;

public:
 //-------------------------------------------CONSTRUCTOR-----------------------------------------//
    Mapa(){
        len = 0;
        capacity = 10;
        v = new Tupla<T, T2>[capacity];
    }
    
//------------------------------------------------METODOS-----------------------------------------//
     bool contains(Tupla<T, T2> t){
        for(int i = 0; i<len; i++){
            if (v[i].getKey() == t.getKey()){
                return true;
            }
        }
        return false;
    }
    
    void push(Tupla<T, T2> t){
        if(contains(t) == false){
            if (len >= capacity){  ////si esta lleno, crea un nuevo vector, pasa los valores e inserta 
                capacity*=2;
                Tupla<T, T2>* v1 = new Tupla<T, T2>[capacity];
                for (int i = 0; i < len; i++) {
                    v1[i] = v[i];
                }
                delete[] v; //Borra el vector antiguo
                v = v1;
            }
            v[len] = t;
            len++;
        }
    }
    
    T2 find(int key){
        int left = 0;
        int right = len-1;
        while(left <= right){
            int mid = left+((key-v[left].getKey())*(right-left)/(v[right].getKey()-v[left].getKey()));
            if(v[mid].getKey() == key){
                return v[mid].getDato();
            }
            else{
                if(v[mid].getKey()>key){
                    right = mid-1;
                }
                else{
                    left = mid+1;
                }
            }    
        }
        return NULL;
    }
    
    int particion(int ini, int fin){
        int pivote=v[fin].getKey(); //Ultimo elemento del vector con el que se comparan los demás elementos
        int i=ini-1;  //Marcador qe aumenta cuando encuentra un elemento menor que el pivote
        int j=ini;  //Marcador que recorre el vector
        for(j; j<fin+1; j++){
            if(v[j].getKey()<=pivote){  //Si encuentra un elemento menor que el pivote
                i++;
                int aux = v[i].getKey();
                v[i].setKey(v[j].getKey());
                v[j].setKey(aux);  //hace el intercambio del elemento del indice i con el elemento que este en el indice j
            }
        }
        return i;
    }
    
    void quicksort(int ini, int fin){
        if(ini>=fin){
             cout<<"";
        }else{
            int i=particion(ini, fin); 
            quicksort(ini, i-1);
            quicksort(i+1, fin);  //Hace la partición y despues organiza lo que queda en ambos lados
        }   
    }
    
    void print() {
        for (int i = 0; i <len; i++) {
            cout << "(" << v[i].getKey() << ", " << v[i].getDato() << ")" << "\t";
        }
        cout<<endl;
    }
};

int main(){
    Mapa<int, string> p = Mapa<int, string>();
    Tupla<int,string> p1 = Tupla<int, string>(0, "H");
    Tupla<int,string> p2 = Tupla<int, string>(1, "O");
    Tupla<int,string> p3 = Tupla<int, string>(2, "L");
    Tupla<int,string> p4 = Tupla<int, string>(3, "A");
    p.push(p1);
    p.push(p2);
    p.push(p3);
    p.push(p4);
    p.print();
    cout<<p.find(2)<<endl;
}
