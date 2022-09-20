#include <iostream>
#include <string>
#include <vector>
using namespace std;

/******************************************************************************
Dado un arreglo de n−1 enteros, estos estan en el rango de 1 a n. No hay duplicados
en el arreglo ası que falta uno de los enteros en la lista. Diseñe e implemente un
algoritmo para encontrar el entero faltante
*******************************************************************************/

int faltante(int* v, int n){
    for(int i=1; i<n; i++){
        if(i!=v[i-1]){
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

/******************************************************************************
Implemente un algoritmo para encontrar e imprimir el elemento mas pequeño y
el segundo mas pequeño en un vector de cadenas de caracteres (string). En su
implementacion use el siguiente prototipo
*******************************************************************************/

void two_smallest (vector<string> & arr){
    vector<int> len;
    for(int i=0, i<vector.size(), i++){
        len.push_back(vector[i].lenght());
    }
    
    return -1;
}

int main(){
    int v[]={"hola", "como", "estas", "bien", "y", "tu?"};
    cout<<two_smallest(v)<<endl;
    return 0;
}
