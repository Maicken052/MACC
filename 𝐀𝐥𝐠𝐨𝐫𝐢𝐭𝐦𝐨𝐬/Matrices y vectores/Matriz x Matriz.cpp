#include <iostream>
#include <stdlib.h>
using namespace std;

void matriz_por_matriz(int** m1, int** m2, int** mf, int filas, int columnas){ //Función matriz * matriz
    for(int i=0; i<filas; i++){
        for(int j=0; j<columnas; j++){
            *(*(mf+i)+j)=(m1[i][0]*m2[0][j])+(m1[i][1]*m2[1][j])+(m1[i][2]*m2[2][j]);
        }
    }
}

int main(){
    int **matriz1, **matriz2, **matriz_final, nFilas=3, nCol=3;

    matriz1= new int*[nFilas];          //Matriz dinamica 1
    for(int i=0; i<nFilas; i++){
        matriz1[i]=new int[nCol];
    }

    matriz2= new int*[nFilas];          //Matriz dinamica 2
    for(int i=0; i<nFilas; i++){
        matriz2[i]=new int[nCol];
    }

    matriz_final= new int*[nFilas];    //Matriz dinamica final
    for(int i=0; i<nFilas; i++){
        matriz_final[i]=new int[nCol];
    }

    cout<<"Digite los elementos de la matriz 1: "<<endl;  //Agregar valores a la matriz 1
    for(int i=0;i<nFilas;i++){
        for(int j=0;j<nCol;j++){
            cout<<"Digite el numero "<<"["<<i<<"]"<<"["<<j<<"]: ";
            cin>>*(*(matriz1+i)+j);
        }
    }

    cout<<"Digite los elementos de la matriz 2: "<<endl;  //Agregar valores a la matriz 2
    for(int i=0;i<nFilas;i++){
        for(int j=0;j<nCol;j++){
            cout<<"Digite el numero "<<"["<<i<<"]"<<"["<<j<<"]: ";
            cin>>*(*(matriz2+i)+j);
        }
    }

    matriz_por_matriz(matriz1, matriz2, matriz_final, nFilas, nCol);
   
    cout<<"El producto de matrices es: "<<endl<<endl;
    for(int i=0; i<nFilas; i++){
        for(int j=0; j<nCol; j++){
            cout<<matriz_final[i][j]<<"\t";
        }
        cout<<endl;
    }

    for(int i=0;i<nFilas;i++){  //Borrar matriz dinamica 1
        delete[] matriz1[i];
    }

    for(int i=0;i<nFilas;i++){  //Borrar matriz dinamica 2
        delete[] matriz2[i];
    }

    for(int i=0;i<nFilas;i++){  //Borrar matriz dinamica final
        delete[] matriz_final[i];
    }

    delete[] matriz1;
    delete[] matriz2;
    delete[] matriz_final;

    return 0;
}
