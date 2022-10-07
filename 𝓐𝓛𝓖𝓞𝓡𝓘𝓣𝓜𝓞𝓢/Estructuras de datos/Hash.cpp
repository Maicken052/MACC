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
    int size;
    int capacity;
    Tupla<T, T2>* v;

public:
 //-------------------------------------------CONSTRUCTOR-----------------------------------------//
    Mapa(){
        size = 0;
        capacity = 10;
        v = new Tupla<T, T2>[capacity];
    }
    
    Mapa(int cap){
        size = 0;
        capacity = cap;
        v = new Tupla<T, T2>[capacity];
    }
//------------------------------------------------METODOS-----------------------------------------//
    bool Haskey(Tupla<T, T2> t){
        for(int i = 0; i<size; i++){
            if (v[i].getKey() == t.getKey()){
                return true;
            }
        }
        return false;
    }
    
    void corrimiento_der(int i){
        for(int j = size; j>i; j--){
            v[j] = v[j-1];
        }
    }
    
    T hash(T2 s){
        char c = 0;
        int result = 0;
        for(int i = 0; i<s.length(); i++){
            c = s[i];
            result+=c;
        }
        return result%18;
    }
    
    T reHash(T2 s){
        T code = hash(s);
        Tupla<T, T2> m = Tupla<T, T2>(code, s);
        while(Haskey(m) == true){
            if(code%2 != 0){
                code = 3*(code) + 1;
                m.setKey(code);
            }else if(code%2 == 0){
                code = code/2;
                m.setKey(code);
            }
        }
        return code;
    }
    
    void increase_capacity(){
        Tupla<T, T2>* v1 = new Tupla<T, T2>[2*capacity];
        for (int i = 0; i < size; i++){
            v1[i] = v[i];
        }
        delete[] v; //Borra el vector antiguo
        v = v1;
    }
    
    void push(T2 d){
        T k = hash(d);
        Tupla<T, T2> ph = Tupla<T, T2>(k, d);
        if(Haskey(ph) == true){
            k = reHash(d);
            ph.setKey(k);
        }
        
        if (size >= capacity){  ////si esta lleno, crea un nuevo vector, pasa los valores e inserta 
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

    T2 find(T key){
        int left = 0;
        int right = size-1;
        while(left <= right){
            int mid = (right+left)/2;;
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
    
    void print() {
        for (int i = 0; i <size; i++) {
            cout << "(" << v[i].getKey() << ", " << v[i].getDato() << ")" << "\n";
        }
        cout<<endl;
    }
};

int main(){
    Mapa<int, string> p = Mapa<int, string>();
    p.push("H");
    p.push("O");
    p.push("L");
    p.push("A");
    p.push("hola");
    p.push("halo");
    p.print();
    return 0;
}
