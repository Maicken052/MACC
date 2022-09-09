-------------------------------------------------------------------------------ORDENAMIENTO-------------------------------------------------------------------------
#include<iostream>

using namespace std;

class Vector{
    
    int* v;
    int size;
    int capacity;
    
public:

    Vector(){
        v = new int[10];
        size = 0;
        capacity = 10;
    }
    
    Vector(int cap){
        v = new int[cap];
        size = 0;
        capacity = cap;
    }
    
    ~Vector(){
        delete[] v;
    }
    
    int get(int i){
        if(i < size){
            return v[i];
        }else{
            cout<<"Error en la posición - get"<<endl;
        }
        return -999;
    }
    
    void set(int i, int x){
        if(i < size){
            v[i] = x;
        }else{
            cout<<"Error en la posición - set"<<endl;
        }
    }
    
    void push_back(int x){
        if(size == capacity){
            //Aumentar el vector
            increase_capacity();
        }
        v[size] = x;
        size++;
    }
    
    void increase_capacity(){
        int* old_v = v;
        v = new int(2*capacity);
        for(int i=0; i<capacity; i++){
            v[i] = old_v[i];
        }
        delete[] old_v;
        capacity = capacity * 2;
    }
    
    void print(){
        for(int i=0; i<size; i++){
            cout<<v[i]<<"\t";
        }
        cout<<endl;
    }
    
    void getStats(){
        cout<<"Size: "<<size<<" Capacity: "<<capacity<<endl;
    }
    
    /*Se corren a la derecha los elementos a partir del elemento i, para crear espacio en esa ubicación. 
       Se asume que hay espacio en el vector.*/
    void corrimiento_der(int i){
        for(int j = size; j>i; j--){
            v[j] = v[j-1];
        }
    }
    
    /*Se corren a la izquierda los elementos sobre el elemento i, para eliminar el espacio en esa ubicación. 
       Se asume que hay espacio en el vector.*/
    void corrimiento_izq(int i){
        for(int j = i; j<size-1; j++){
            v[j] = v[j+1];
        }
    }
    
    void insert(int i, int x){
        if(i < size){
            if(size == capacity){
                //Aumentar el vector
                increase_capacity();
            }
            corrimiento_der(i);
            size++;
            v[i] = x;
        }else{
            cout<<"Error en la posición - insert"<<endl;
        }
    }
    
    void remove(int i){
        if(i < size){
            corrimiento_izq(i);
            size--;
        }else{
            cout<<"Error en la posición - remove"<<endl;
        }
    }
    
    void select_sort(){
        int minimo;
        int* v1  = new int(size);
        int x;
        for (int j = 0; j<size;j++){
            minimo = 1000;
            for(int i=0; i<size; i++){
                if (v[i] <= minimo ){
                    minimo = v[i];
                    x = i;
                }
            }
            v1[j] = minimo;
            v[x] = 1000;
        }
        v = v1;
        cout<<endl;        
    }     
    
    void insert_sort(){
        int aux;
        for (int i=0; i<size-1;i++){
            if(v[i+1]<v[i]){
                aux=v[i+1];
                v[i+1]=v[i];
                v[i]=aux;
                while(v[i]<v[i-1] && i>=0){
                    aux=v[i];
                    v[i]=v[i-1];
                    v[i-1]=aux;
                    i--;
                }
            }
        }
    }
    
    void shell_sort(){
        int gap=size/2;
        int gapaux=gap;
        int aux;
        while(gap!=0){
            if(gap==1){
                insert_sort();
                gap=0;
            }
            for(int j=0; j<gap; j++){
                if(v[j]>v[gapaux]){
                    aux=v[gapaux];
                    v[gapaux]=v[j];
                    v[j]=aux;
                    gapaux++;
                }
            gap=gap/2;
            }
        }
    }
    
};

int main()
{
    
    Vector v = Vector(10);
    
    for(int i=0; i<10; i++){
        int a=rand()%50;
        v.push_back(a);
    }


    v.print();
    v.shell_sort();
    v.print();
    
    
    
    return 0;
}