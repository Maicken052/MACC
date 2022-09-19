#include <iostream>

using namespace std;

//-----------------------------------FUNCIÓN SWAP----------------------------------//
void swap(int* v, int a, int b){  //cambia los valores de una posición a otra
    int aux;
    aux=v[a];
    v[a]=v[b];
    v[b]=aux;
}

//-----------------------------------FUNCIÓN HEAPIFY----------------------------------//
void heapify(int* v, int size){  //Evalua ramas del arbol binario, e intercambia su valor con los hijos si son mayores
    int mxheap, mxheap_son;
    mxheap=(size/2)-1;  //La ultima rama del arbol
    for(mxheap; mxheap>=0; mxheap--){
        if(2*(mxheap+1)<size){  //Si la rama tiene dos hojas, saca el mayor valor de entre las dos
        mxheap_son=max(v[(2*mxheap)+1], v[2*(mxheap+1)]);
        }else{
            mxheap_son=v[(2*mxheap)+1];  //Sino, el mayor valor será la hoja izquierda
        }
        if(v[mxheap]<mxheap_son){  //Si la hoja es mayor que la rama, intercambian valores
            if(mxheap_son==v[(2*mxheap)+1]){  //Si el valor es la hoja izquierda
                swap(v, mxheap, (2*mxheap)+1);
            }else{
                swap(v, mxheap, 2*(mxheap+1)); //Si el valor es la hoja derecha
            }
        }
    }
    swap(v, 0, size-1);  //Intercambia el ultimo valor con el primero
}

//-----------------------------------FUNCIÓN HEAPSORT----------------------------------//
void heapsort(int* v, int size){  //Llama a heapify restando uno al tamaño, hasta que el tamaño sea igual a 1
    if(size==1){
        cout<<"";
    }else{
        heapify(v, size);
        heapsort(v, size-1);
    }
}

//-----------------------------------FUNCIÓN PRINT----------------------------------//
void print(int* v, int size){
    for(int i=0; i<size; i++){
        cout<<v[i]<<"\t";
    }
    cout<<endl;
}

int main(){
    int v[10]={8, 3, 5, 1, 4, 9, 10, 2, 6, 7};
    
    cout<<"---------------------------------------------------------------------------"<<endl;
    cout<<"ORIGINAL: "<<endl;
    print(v, 10);
    cout<<"---------------------------------------------------------------------------"<<endl;
    cout<<"ORDENADO: "<<endl;
    heapsort(v, 10);
    print(v, 10);
    cout<<"---------------------------------------------------------------------------"<<endl;
    return 0;
}
