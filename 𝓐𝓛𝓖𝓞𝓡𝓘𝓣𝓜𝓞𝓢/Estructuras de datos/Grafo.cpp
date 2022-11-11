#include<iostream>
#include<string>
using namespace std;

class Grafo{
    int **matriz;
    int nFilas;
    int nCol;
public:
    Grafo(int nFilass, int nColl){
        nFilas = nFilass;
        nCol = nColl;
        matriz= new int*[nFilas];          
        for(int i=0; i<nFilas; i++){
            matriz[i]=new int[nCol];
        }
            
        for(int i=0;i<nFilas;i++){
            for(int j=0;j<nCol;j++){
                *(*(matriz+i)+j) = 0;
            }
        }
    }
        
    //Getters
    int getPeso(int n1, int n2){
        return matriz[n1][n2];
    }
    
    void addEnlace(int n1, int n2, int p, string d){
        if(d == "unidireccional")
            matriz[n1-1][n2-1] = p;
        else if(d == "bidireccional"){
            matriz[n1-1][n2-1] = p;
            matriz[n2-1][n1-1] = p;
        }else
            cout<<"Ingrese una direccion valida";
    }
    
    void addNodo(){
        int **n_matriz;
        int old_nFilas = nFilas;
        int old_nCol = nCol;
        nFilas +=1;
        nCol +=1;
        n_matriz= new int*[nFilas];          
            for(int i=0; i<nFilas; i++){
                n_matriz[i]=new int[nCol];
            }
            
        for(int i=0;i<nFilas;i++){
            for(int j=0;j<nCol;j++){
                if(i>=old_nFilas || j>=old_nCol){
                    *(*(n_matriz+i)+j) = 0;
                }else{
                *(*(n_matriz+i)+j) = *(*(matriz+i)+j);
                }
            }
        }
        
        for(int i=0;i<old_nFilas;i++){  
            delete[] matriz[i];
        }
        
        matriz = n_matriz;
    }
    
    void print(){
        cout<<"La matriz que representa el grafo es: "<<endl<<endl;
        cout<<"        ";
        for(int m = 1; m < nFilas+1; m++){
            if(m>9){
                cout<<m<<" |  ";
            }else{
                cout<<m<<"  |  ";
            }
        }
        string stuff(nCol*6, '_');
        cout<<endl<<"       ";
        cout<<stuff<<endl;
        cout<<"    1"<<"  |";
        for(int i=0; i<nFilas; i++){
            for(int j=0; j<nCol; j++){
                cout<<matriz[i][j]<<"  |  ";
            }
            cout<<endl<<"       "<<stuff<<endl;
            if(i+2>nFilas){
                break;
            }else if(i+2>9){
                cout<<"   "<<i+2<<"  |";
            }else{
                cout<<"    "<<i+2<<"  |";
            }
        }
        cout<<endl;
    }
};

int main(){
    Grafo g = Grafo(8, 8);
    g.addEnlace(1, 2, 2, "bidireccional");
    g.addEnlace(3, 2, 2, "bidireccional");
    g.addEnlace(4, 2, 3, "bidireccional");
    g.addEnlace(4, 3, 5, "bidireccional");
    g.addEnlace(5, 2, 3, "bidireccional");
    g.addEnlace(1, 5, 1, "bidireccional");
    g.addEnlace(6, 2, 3, "bidireccional");
    g.addEnlace(6, 5, 1, "bidireccional");
    g.addEnlace(5, 7, 2, "bidireccional");
    g.addEnlace(6, 7, 1, "bidireccional");
    g.addEnlace(8, 5, 4, "bidireccional");
    g.print();
    return 0;
}
