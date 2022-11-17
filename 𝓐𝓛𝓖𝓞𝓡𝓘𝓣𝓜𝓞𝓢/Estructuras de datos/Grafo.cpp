#include<iostream>
#include<string>
#include<vector>
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
        for(int i = 0;i < nodos;i++){
            for(int j = 0;j < nodos;j++){
                if(matriz[i][j] != matriz[j][i]){
                    return false;
                }
            }
        }    
        return true;
    }
    
    int get_min(vector<int> &arr){
        int min = arr[0];
        for(int i = 1; i<arr.size(); i++){
            if(arr[i]<min)
                min = arr[i];
        }
        return min;
    }
    bool found(int a, vector<int> arr){
        for(int i = 0; i <arr.size(); i++){
            if(arr[i] == a)
                return true;
        }
        return false;
    }
    
    int saltos(int a, int b, vector<int> rev){
        vector<int> conexiones;
        if(a == b)
            return 0;
        else{
            rev.push_back(a);
            for(int i = 0; i < nodos; i++){
                if(matriz[a-1][i]!=0 && !found(i+1, rev)){
                    conexiones.push_back(saltos(i+1, b, rev));
                }
            }
        }
        if(conexiones.size() == 0)
            return 235233256;
        else
            return get_min(conexiones)+1;
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
    vector<int> v;
    g.addEnlace(1, 2, 3, "unidireccional");
    g.addEnlace(1, 3, 2, "unidireccional");
    g.addEnlace(1, 5, 3, "unidireccional");
    g.addEnlace(3, 4, 2, "unidireccional");
    g.addEnlace(4, 6, 2, "unidireccional");
    g.addEnlace(5, 6, 5, "unidireccional");
    g.addEnlace(2, 6, 5, "bidireccional");
    g.addEnlace(2, 4, 5, "bidireccional");
    
    g.print();
    cout<<"el num de saltos es: "<<g.saltos(5, 1, v)<<endl;
    return 0;
}
