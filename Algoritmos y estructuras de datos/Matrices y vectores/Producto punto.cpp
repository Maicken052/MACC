#include <iostream>
using namespace std;

int producto_punto(int* v1,int* v2,int tam){
    int cont=0;
    int mult=0;
    for(int i=0; i<tam; i++){
        mult=v1[i]*v2[i];
        cont+=mult;
   }
   return cont;
}

int main(){
   int vectora[3];
   int vectorb[3];
   int result=0;
   
   for(int i=0; i<3; i++){
       vectora[i]=i;
       vectorb[i]=i+1;
   }
   
   result=producto_punto(vectora, vectorb, 3);
   
   cout<<"el producto punto es: "<<result;
   
   return 0;
}
