/******************************************************************************
Dado un arreglo a[] de N enteros distintos (positivos o negativos) en orden
ascendente. Diseñe un algoritmo para encontrar un ındice i tal que a[i] = i, si tal
ındice existe.
*******************************************************************************/

#include <iostream>
#include <string>
#include <vector>
using namespace std;

int findEq (vector <int> & arr){
    for(int i = 0; i<arr.size(); i++){
        if(arr[i] == i){
            return i;
        }
    }
    return -1;
}

int main(){
    vector <int> v;

    v.push_back(-3);
    v.push_back(1);
    v.push_back(3);
    v.push_back(4);
    v.push_back(5);
    v.push_back(6);

    cout<<"El indice del vector tal que v[i]=i es: "<<findEq(v)<<endl;
    return 0;
}