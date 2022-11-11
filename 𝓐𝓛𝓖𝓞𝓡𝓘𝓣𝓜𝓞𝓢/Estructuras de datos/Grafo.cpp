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
        
    void print(){
        cout<<"-------------------------------------------------------------- "<<endl;
        cout<<"La matriz que representa el grafo es: "<<endl<<endl;
        cout<<"        ";
        for(int m = 1; m < nFilas+1; m++){
            cout<<m<<"    ";
        }
        cout<<endl<<"       ";
        cout<<"———————————————————————————————————————"<<endl;
        cout<<"    1"<<"  |";
        for(int i=0; i<nFilas; i++){
            for(int j=0; j<nCol; j++){
                cout<<matriz[i][j]<<" |  ";
            }
            cout<<endl<<"       "<<"———————————————————————————————————————"<<endl;
            if(i+2==9){
                break;
            }else{
                cout<<"    "<<i+2<<"  |";
            }
        }
        cout<<endl;
        cout<<"------------------------------------------------------------- "<<endl;
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
