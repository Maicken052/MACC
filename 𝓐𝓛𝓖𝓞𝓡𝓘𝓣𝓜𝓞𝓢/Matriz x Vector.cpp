-----------------------------------------------------------------------------------MATRIZ*VECTOR------------------------------------------------------------------------
    
#include <iostream>
#include <stdlib.h>
using namespace std;

void matriz_por_vector(int** m, int* v, int* r, int filas, int columnas){ //Función matriz * vector
    for(int i=0; i<filas; i++){
        int cont=0;
        for(int j=0; j<columnas; j++){
            cont+=m[i][j]*v[j];
        }
    r[i]=cont;    
    }
}

int main(){
    int **matriz, nFilas=3, nCol=3;
    int vector[3]={1,2,3};
    int resultado[3];
   
    matriz= new int*[nFilas];        //Matriz dinamica
    for(int i=0; i<nFilas; i++){
        matriz[i]=new int[nCol];
    }

    cout<<"Digite los elementos de la matriz: ";  //Agregar valores a la matriz
    for(int i=0;i<nFilas;i++){
        for(int j=0;j<nCol;j++){
            cout<<"Digite el numero "<<"["<<i<<"]"<<"["<<j<<"]: ";
            cin>>*(*(matriz+i)+j);
        }
    }


    matriz_por_vector(matriz, vector, resultado, nFilas, nCol);
   
    cout<<"El producto matriz por vector es: "<<resultado[0]<<","<<resultado[1]<<","<<resultado[2];

    for(int i=0;i<nFilas;i++){  //Borrar matriz dinamica
        delete[] matriz[i];
    }

    delete[] matriz;

    return 0;
}