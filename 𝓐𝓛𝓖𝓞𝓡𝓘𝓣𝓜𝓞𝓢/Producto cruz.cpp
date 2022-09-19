#include <iostream>
using namespace std;

void producto_cruz(int* v1,int* v2, int* v3){
    int a=0;
    int b=0;
    int c=0;
    
    a=(v1[1]*v2[2])-(v1[2]*v2[1]);
    b=(v1[2]*v2[0])-(v1[0]*v2[2]);
    c=(v1[0]*v2[1])-(v1[1]*v2[0]);
    
    v3[0]=a;
    v3[1]=b;
    v3[2]=c;
}

int main(){
   int vectora[3];
   int vectorb[3];
   int vect_final[3];

    vectora[0]=3;
    vectora[1]=0;
    vectora[2]=2;
    
    vectorb[0]=-1;
    vectorb[1]=4;
    vectorb[2]=2;
    
    producto_cruz(vectora, vectorb, vect_final);
   
   cout<<"El producto cruz es: "<<vect_final[0]<<","<<vect_final[1]<<","<<vect_final[2];
   
   return 0;
   
}
