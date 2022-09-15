#include <iostream>

using namespace std;

int particion(int* v, int ini, int fin){
    int pivote=v[fin];
    int i=ini-1;
    int j=ini;
    for(j; j<fin+1; j++){
        if(v[j]<=pivote){
            i++;
            int aux=v[i];
            v[i]=v[j];
            v[j]=aux;
        }
    }
    return i;
}

void quicksort(int* v, int ini, int fin){
    if(ini==fin){
         cout<<""<<endl;
    }else{
        int i=particion(v, ini, fin);
        if(i-1>ini){
            quicksort(v, ini, i-1);
        }
        if(i+1<fin){
            quicksort(v, i+1, fin);  
        }
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
    v[0]= 23;
    v[1]= 33;
    v[2]= 584;
    v[3]= 9300;
    v[4]= 1;
    v[5]= 2;
    v[6]= 3;
    v[7]= 454;
    v[8]= -314;
    v[9]= -314;
    
    print(v, 10);
    quicksort(v, 0, 9);
    print(v, 10);
    return 0;
}
