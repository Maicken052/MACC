#include<iostream>
#include<string>
using namespace std;

class Grafo{
    int **matriz;
    int nodos;
    
public:
    Grafo(int Nodos_){
        nodos = Nodos_;
        matriz = new int*[nodos];          
        for(int i = 0; i < nodos; i++){
            matriz[i] = new int[nodos];
        }
            
        for(int i = 0;i < nodos;i++){
            for(int j = 0;j < nodos;j++){
                matriz[i][j] = 0;
            }
        }
    }
        
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
        int old_nodos = nodos;
        nodos +=1;
        n_matriz = new int*[nodos];          
            for(int i = 0; i < nodos; i++){
                n_matriz[i] = new int[nodos];
            }
            
        for(int i = 0;i < nodos;i++){
            for(int j = 0;j < nodos;j++){
                if(i >= old_nodos || j >= old_nodos){
                    *(*(n_matriz+i)+j) = 0;
                }else{
                *(*(n_matriz+i)+j) = *(*(matriz+i)+j);
                }
            }
        }
        
        for(int i = 0;i < old_nodos;i++){  
            delete[] matriz[i];
        }
        
        matriz = n_matriz;
    }
    
    bool es_bidireccional(){
        bool flag = true;
        for(int i = 0;i < nodos;i++){
            for(int j = 0;j < nodos;j++){
                if(matriz[i][j] != matriz[j][i]){
                    flag = false;
                    return flag;
                }
            }
        }
        return flag;
    }
    
    bool is_k_saltos(int a, int b, int k){
        
    }
    
    void print(){
        cout<<"La matriz que representa el grafo es: "<<endl<<endl;
        cout<<"        ";
        
        for(int m = 1; m < nodos+1; m++){  //Numero de las columnas
            if(m>9)
                cout<<m<<" |  ";
            else
                cout<<m<<"  |  ";
        }
        
        string stuff(nodos*6, '=');
        cout<<endl<<"       ";  //Primera separación
        cout<<stuff<<endl;
        
        cout<<"    1"<<"  |";
        for(int i = 0; i < nodos; i++){
            for(int j = 0; j < nodos; j++){
                if(i == j)
                    cout<<" "<<"  |  ";
                else
                    cout<<matriz[i][j]<<"  |  ";
            }
            
            cout<<endl<<"       "<<stuff<<endl;
            if(i+2>nodos){
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
    Grafo g = Grafo(6);
    g.addEnlace(1, 3, 2, "unidireccional");
    g.addEnlace(3, 4, 2, "unidireccional");
    g.addEnlace(3, 6, 2, "unidireccional");
    g.addEnlace(4, 6, 2, "unidireccional");
    g.addEnlace(1, 2, 3, "unidireccional");
    g.addEnlace(1, 5, 3, "unidireccional");
    g.addEnlace(6, 2, 3, "unidireccional");
    g.addEnlace(5, 6, 5, "unidireccional");
    
    g.print();

    return 0;
}
