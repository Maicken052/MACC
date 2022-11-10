#include<iostream>
#include<string>
using namespace std;

//--------------------------------------------CLASE TUPLA------------------------------------------//
template <typename T, typename T2>
class Tupla{
    //Atributos
    T key;
    T2 dato;

public:
    //Constructores
    Tupla(T n, T2 t) {
        key = n;
        dato = t;
    }
    
    Tupla(){
    }
    
    //Setters
    void setKey(T n){
        key = n;
    }
    
    void setDato(T2 t){
        dato = t;
    }
    
    //Getters
    T getKey(){
        return key;
    }
    
    T2 getDato(){
        return dato;
    }
    
    //Sobrecargas
    Tupla& operator=(const Tupla& f) { 
		setKey(f.key);
		setDato(f.dato);
		return *this; 
	}
};

//---------------------------------------------CLASE HASH--------------------------------------------//
template <typename T, typename T2>
class Hash{
    //Atributos
    int size;
    int capacity;
    Tupla<T, T2>* v;

public:
    //Constructores
    Hash(){
        size = 0;
        capacity = 10;
        v = new Tupla<T, T2>[capacity];
    }
    
    Hash(int cap){
        size = 0;
        capacity = cap;
        v = new Tupla<T, T2>[capacity];
    }
    
    //Metodos
    void corrimiento_der(int i){
        for(int j = size; j>i; j--){
            v[j] = v[j-1];
        }
    }
    
     bool HasKey(Tupla<T, T2> t){
        for(int i = 0; i<size; i++){
            if (v[i].getKey() == t.getKey()){
                return true;
            }
        }
        return false;
    }
    
    T hash(T2 dato){
        int f = dato.length();
        f = f*6174;
        if(f%45 == 0){
            f = f/12;    
        }else{
            f = (5*f)+6;
        }
        
        while(f >= 10000000){
            f = f/13;
        }

        return f;
    }
    
    T reHash(T2 d){
        T k = hash(d);
        Tupla<T, T2> m = Tupla<T, T2>(k, d);
        while(HasKey(m) == true){
            if(d.length()%2 != 0){
                k += 3*(d.length()) + 1;
                m.setKey(k);
            }else{
                k += d.length()/2;
                m.setKey(k);
            }
        }
        
        while(k >= 10000000){
            k = k/31;
        }
        return k;
    }
    
    void increase_capacity(){
        Tupla<T, T2>* v1 = new Tupla<T, T2>[2*capacity];
        for (int i = 0; i < size; i++){
            v1[i] = v[i];
        }
        delete[] v; 
        v = v1;
    }
    
    void push(T2 d){
        T k = hash(d);
        Tupla<T, T2> ph = Tupla<T, T2>(k, d);
    
        if(HasKey(ph) == true){
            int k2 = reHash(d);
            ph.setKey(k2);
        }
        
        if (size >= capacity){ 
            increase_capacity();
        }
    
        if(size==0){
            v[size] = ph;
            size++;
        }else{
            int flag = 0;
            for(int i = 0; i<size; i++){
                if(ph.getKey()<v[i].getKey()){
                    corrimiento_der(i);
                    v[i] = ph;
                    flag = 1;
                    break;
                }
            }
            if(flag == 0){
                v[size] = ph;
            }
            size++;
        }  
    }
    
    void print() {
        for (int i = 0; i <size; i++) {
            cout << "(" << v[i].getKey() << ", " << v[i].getDato() << ")" << "\n";
        }
    }
};

int main(){
    cout<<"----------------------PRUEBA HASH------------------------"<<endl;
    Hash<int, string> p = Hash<int, string>();
    p.push("hola");
    p.push("mundo");
    p.push("cruel");
    p.push("ya no se que colocar para que probar lo de 10 millones :c");
    p.print();
    cout<<"----------------------------------------------------------"<<endl;
}
