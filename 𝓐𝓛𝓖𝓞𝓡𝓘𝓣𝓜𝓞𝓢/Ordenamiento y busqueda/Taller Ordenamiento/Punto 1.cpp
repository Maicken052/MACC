/******************************************************************************
Este algoritmo, tambien conocido como cocktail shaker sort, es una variación estable 
de bubble sort. La idea es ordenar en ambas direcciones en cada recorrido del arreglo.
De forma tal que luego de la primera iteración, tanto el mayor como el menor elemento
en el arreglo estan en sus posiciones finales.
*******************************************************************************/

#include <iostream>
#include <vector>
#include<time.h>

using namespace std;

void print(vector <int> & v){
    for(int i = 0; i<v.size(); i++){
            cout<<v[i]<<"\t";
        }
        cout<<endl;
    }

void swapp(vector<int> &v, int a, int b){  //cambia los valores de una posición a otra
    int aux;
    aux=v[a];
    v[a]=v[b];
    v[b]=aux;
}

void shakersort (vector <int> &v){ 
    for(int j = 0; j<v.size()-6; j++){
        for(int i = 1; i<v.size(); i++){
            if(v[i-1]>v[i]){
                swapp(v, i, i-1);
            }if(v[v.size()-i]<v[v.size()-(i+1)]){
                swapp(v, v.size()-i, v.size()-(i+1));
            }
        }
    }
}

//---------------------------------------------------------------------//
int main(){
    vector <int> v;
    srand(time(NULL));
    for(int i = 0; i<100; i++){
        v.push_back(rand()%10000);
    }

    print(v);
    shakersort(v);
    print(v);

    return 0;
}