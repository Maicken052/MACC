/******************************************************************************
Dado un arreglo de n−1 enteros, estos estan en el rango de 1 a n. No hay duplicados
en el arreglo ası que falta uno de los enteros en la lista. Diseñe e implemente un
algoritmo para encontrar el entero faltante
*******************************************************************************/

#include <iostream>
using namespace std;

int faltante(int* v, int n){
    for(int i = 1; i<n; i++){
        if(i != v[i-1]){
            return i;
        }
    }
    return -1;
}

int main(){
    int v[]={1, 2, 4, 5, 6, 7, 8, 9, 10};
    int n=10;
    cout<<faltante(v, n)<<endl;
    return 0;
}