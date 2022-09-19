#include <iostream>
using namespace std;

int main() {
    int suma1, suma2;
    suma2=0;

    int vector[10];
    
    for(int i=0; i<10; i++){
        vector[i]=i;
    }
    
    for(int i=0; i<10; i++){
        if(vector[i]%2==0){
            suma1=vector[i];
            suma2+=suma1;
        }
    }
    
    cout<<"la sumatoria es:"<<suma2;
    return 0;
}
