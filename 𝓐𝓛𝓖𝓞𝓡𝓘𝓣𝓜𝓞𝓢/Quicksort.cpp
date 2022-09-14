#include <iostream>

using namespace std;

int particion(int* v, int ini, int fin){
    int pivote=v[fin];
    int i=ini-1;
    int j=ini;
    for(ini; ini<fin+1; ini++){
        if(v[j]<=pivote){
            i++;
            int aux=v[i];
            v[i]=v[j];
            v[j]=aux;
            j++;
        }else{
            j++;
        }
    }
    return i;
}

int quicksort(int* v, int ini, int fin){
    if(ini==fin){
        return 0;
    }else{
        int i=particion(v, ini, fin);
        quicksort(v, ini, i-1);
        quicksort(v, i+1, fin);  
    }
}

void print(int* v, int size){
    for(int i=0; i<size; i++){
        cout<<v[i]<<"\t";
    }
    cout<<endl;
}

int main(){
    int v[10];
    v[0]= 8;
    v[1]= 3;
    v[2]= 5;
    v[3]= 1;
    v[4]= 4;
    v[5]= 9;
    v[6]= 10;
    v[7]= 2;
    v[8]= 6;
    v[9]= 7;
    
    print(v, 10);
    quicksort(v, 0, 9);
    print(v, 10);
    return 0;
}
