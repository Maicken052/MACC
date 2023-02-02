#include <iostream>

using namespace std;

//-----------------------------------FUNCIÓN PARTICIÓN----------------------------------//
int particion(int* v, int ini, int fin){
    int pivote=v[fin]; //Ultimo elemento del vector con el que se comparan los demás elementos
    int i=ini-1;  //Marcador qe aumenta cuando encuentra un elemento menor que el pivote
    int j=ini;  //Marcador que recorre el vector
    for(j; j<fin+1; j++){
        if(v[j]<=pivote){  //Si encuentra un elemento menor que el pivote
            i++;
            int aux=v[i];
            v[i]=v[j];
            v[j]=aux;  //hace el intercambio del elemento del indice i con el elemento que este en el indice j
        }
    }
    return i;
}

//---------------------------------------QUICKSORT--------------------------------------//
void quicksort(int* v, int ini, int fin){
    if(ini>=fin){
         cout<<"";
    }else{
        int i=particion(v, ini, fin); 
        quicksort(v, ini, i-1);
        quicksort(v, i+1, fin);  //Hace la partición y despues organiza lo que queda en ambos lados
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
    quicksort(v, 0, 9);
    print(v, 10);
    cout<<"---------------------------------------------------------------------------"<<endl;
    return 0;
}
