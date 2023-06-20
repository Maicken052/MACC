#include <iostream>
using namespace std;

//-----------------------------------FUNCIÓN HEAP----------------------------------//
void heap(int* v, int size, int ind){
    if((2*ind)+1<size){  //Revisa si tiene hijo izquierdo, si tiene, entra a revisar
        heap(v, size, (2*ind)+1);
    }if((2*ind)+2<size){  //Revisa si tiene hijo derecho, si tiene, entra a revisar
        heap(v, size, (2*ind)+2);
    }
    cout<<v[ind]<<"\t";  //Despues de revisar ambos, imprime su valor
}
//-----------------------------------FUNCIÓN PRINT----------------------------------//
void print(int* v, int size){
    for(int i=0; i<size; i++){
        cout<<v[i]<<"\t";
    }
    cout<<endl;
}

int main(){
    int v[9]={7, 2, 4, 9, 8, 3, 1, 5, 6};
    cout<<"---------------------------------------------------------------------------"<<endl;
    cout<<"ORIGINAL: "<<endl;
    print(v, 9);
    cout<<"---------------------------------------------------------------------------"<<endl;
    cout<<"HEAP RARO: "<<endl;
    heap(v, 9, 0);
    return 0;
}
