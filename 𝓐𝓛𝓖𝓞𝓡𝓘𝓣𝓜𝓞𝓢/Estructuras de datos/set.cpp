#include<iostream>
using namespace std;

class set{
//---------------------------------------------ATRIBUTOS------------------------------------------//
    int size;
    int capacity;
    int *v;

public:
 //-------------------------------------------CONSTRUCTOR-----------------------------------------//
    set(int capacity1) {
        capacity = capacity1;
        size = 0;
        v = new int[capacity];
    }
    
//------------------------------------------------METODOS-----------------------------------------//
    bool contains(int x){
        for(int i = 0; i<size; i++){
            if (x == v[i]){
                return true;
            }
        }
        return false;
    }
    
    bool Empty(){
        if(size == 0){
            return true;
        }else{
            return false;
        }
    }
    void increase_capacity(){
        capacity*=2;
        int *v1 = new int[capacity];
        for (int i = 0; i < size; i++) {
            v1[i] = v[i];
        }
        delete[] v; //Borra el vector antiguo
        v = v1;
    }
    
    void corrimiento_der(int i){
        for(int j = size; j>i; j--){
            v[j] = v[j-1];
        }
    }
    
    void push(int x){
        if(contains(x) == false){
            if(size >= capacity){  ////si esta lleno, crea un nuevo vector, pasa los valores e inserta 
                increase_capacity();
            }
            
            if(size==0){
            v[size] = x;
            size++;
            
            }else{
                int flag = 0;
                for(int i = 0; i<size; i++){
                    if(x<v[i]){
                        corrimiento_der(i);
                        v[i] = x;
                        flag = 1;
                        break;
                    }
                }
                if(flag == 0){
                    v[size] = x;
                }
                size++;
            }  
        }
    }

    
    set unionn(set c){
        set u = c;
        for(int i = 0; i<size; i++){
            u.push(v[i]);    
        }
        return u; 
    }
    
    set interseccion(set c){
        set n = new set();
        for(int i = 0; i<size; i++){
            if(c.contains(v[i])){
               n. 
            }
        }
    }
    void print() {
        for (int i = 0; i <size; i++) {
            cout << v[i] << "\t";
        }
        cout<<endl;
    }
    
    set& operator=(const set& s) { 
        capacity = s.capacity;
        size = s.size;
        for(int i = 0; i<size; i++){
            v[i] = s.v[i];
        }
		return *this; 
	}
};
int main(){
    set prueba = set(10);
    set un = set(10);
    prueba.push(6);
    prueba.push(5);
    prueba.push(4);
    prueba.push(4);
    un.push(9);
    un.push(8);
    un.push(7);
    cout<<"-----------------------------------------"<<endl;
    cout<<"La union de el conjunto 1: "<<endl;
    prueba.print();
    cout<<"y el conjunto 2: "<<endl;
    un.print();
    cout<<"es: "<<endl;
    prueba.unionn(un).print();
    cout<<"------------------------------------------"<<endl;
}
