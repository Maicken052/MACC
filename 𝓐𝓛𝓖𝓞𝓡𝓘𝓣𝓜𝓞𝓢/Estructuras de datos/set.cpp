#include<iostream>
using namespace std;

class set{
//---------------------------------------------ATRIBUTOS------------------------------------------//
    int length;
    int capacity;
    int *v;

public:
 //-------------------------------------------CONSTRUCTOR-----------------------------------------//
    set(int capacity1) {
        capacity = capacity1;
        length = 0;
        v = new int[capacity];
    }
    
//------------------------------------------------METODOS-----------------------------------------//
    bool contains(int x){
        for(int i = 0; i<length; i++){
            if (x == v[i]){
                return true;
            }
        }
        return false;
    }
    
    void push(int x){
        if(contains(x) == false){
            if (length >= capacity){  ////si esta lleno, crea un nuevo vector, pasa los valores e inserta 
                capacity*=2;
                int *v1 = new int[capacity];
                for (int i = 0; i < length; i++) {
                    v1[i] = v[i];
                }
                delete[] v; //Borra el vector antiguo
                v = v1;
            }
            v[length] = x;
            length++;
        }
    }
    
    set unionn(set c){
        set u = c;
        for(int i = 0; i<length; i++){
            u.push(v[i]);    
        }
        return u; 
    }
    
    void print() {
        for (int i = 0; i <length; i++) {
            cout << v[i] << "\t";
        }
        cout<<endl;
    }
    
    set& operator=(const set& s) { 
        capacity = s.capacity;
        length = s.length;
        for(int i = 0; i<length; i++){
            v[i] = s.v[i];
        }
		return *this; 
	}
};
int main(){
    set prueba = set(10);
    set un = set(10);
    prueba.push(4);
    prueba.push(5);
    prueba.push(6);
    un.push(7);
    un.push(8);
    un.push(9);
    prueba.unionn(un).print();
    
}
