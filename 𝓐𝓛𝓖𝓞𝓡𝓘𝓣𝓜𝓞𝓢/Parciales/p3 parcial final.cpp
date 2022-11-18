#include<iostream>
#include<string>
#include<vector>
using namespace std;

template <typename T, typename T2>
class Tupla{
//---------------------------------------------ATRIBUTOS------------------------------------------//
    T key;
    T2 dato;

public:
 //-------------------------------------------CONSTRUCTOR-----------------------------------------//
    Tupla(T k, T2 d) {
        key = k;
        dato = d;
    }
    
//------------------------------------------------METODOS-----------------------------------------//
    Tupla(){
    }
    
    void setKey(T k){
        key = k;
    }
    
    void setDato(T2 d){
        dato = d;
    }
    
    T getKey(){
        return key;
    }
    
    T2 getDato(){
        return dato;
    }
    
    Tupla& operator=(const Tupla& f) { 
		setKey(f.key);
		setDato(f.dato);
		return *this; 
	}
};

template <typename T, typename T2>
class Mapa{
    //---------------------------------------------ATRIBUTOS------------------------------------------//
    int size;
    int capacity;
    Tupla<T, T2>* v;

public:
 //-------------------------------------------CONSTRUCTOR-----------------------------------------//
    Mapa(){
        size = 0;
        capacity = 10;
        v = new Tupla<T, T2>[capacity];
    }
    
//------------------------------------------------METODOS-----------------------------------------//
     bool Haskey(Tupla<T, T2> t){
        for(int i = 0; i<size; i++){
            if (v[i].getKey() == t.getKey()){
                return true;
            }
        }
        return false;
    }
    
    void corrimiento_der(int i){
        for(int j = size; j>i; j--){
            v[j] = v[j-1];
        }
    }
    
    int get_size(){
        return size;
    }
    
    T get_last_dato(){
        return v[size-1].getDato();
    }
    
    T2 get_last_key(){
        return v[size-1].getKey();
    }
    
    T get_first_dato(){
        return v[0].getDato();
    }
    
    T2 get_first_key(){
        return v[0].getKey();
    }
    
    T2 maxs(){
        T2 first_max;
        bool found = false;
        for(int i = 0; i<size; i++){
            if(v[i].getKey() == get_last_key()){
                if(!found){
                    first_max = v[i].getDato();
                    found = true;
                }
                cout<<"Nodo "<<v[i].getDato()<<" con "<<v[i].getKey()<<" enlaces"<<endl;
            }
        }
        return first_max;
    }
    
    T2 mins(){
        for(int i = 0; i<size; i++){
            if(v[i].getKey() == get_first_key())
                if(v[i].getKey() == 1)
                    cout<<"Nodo "<<v[i].getDato()<<" con "<<v[i].getKey()<<" enlace"<<endl;
                else
                    cout<<"Nodo "<<v[i].getDato()<<" con "<<v[i].getKey()<<" enlaces"<<endl;
        }
        return get_first_dato();
    }
    
    void push(Tupla<T, T2> t){
        if (size >= capacity){  ////si esta lleno, crea un nuevo vector, pasa los valores e inserta 
            capacity*=2;
            Tupla<T, T2>* v1 = new Tupla<T, T2>[capacity];
            for (int i = 0; i < size; i++){
                v1[i] = v[i];
            }
            delete[] v; //Borra el vector antiguo
            v = v1;
        }
        if(size==0){
            v[size] = t;
            size++;
        }else{
            int flag = 0;
            for(int i = 0; i<size; i++){
                if(t.getKey()<v[i].getKey()){
                    corrimiento_der(i);
                    v[i] = t;
                    flag = 1;
                    break;
                }
            }
            if(flag == 0){
                v[size] = t;
            }
            size++;
        }  
    }
    
    void print() {
        for (int i = 0; i <size; i++) {
            cout << "(" << v[i].getKey() << ", " << v[i].getDato() << ")" << "\t";
        }
        cout<<endl;
    }
};

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
            return 21474836;
        else
            return get_min(conexiones)+1;
    }
    
    bool is_k_saltos(int a, int b, int k){
        vector<int> v;
        if(saltos(a, b, v) < k)
            return true;
        return false;
    }
    
    void print_nodos_k(int a, int k){
        vector<int>rev;
        for(int i = 1; i<=nodos; i++){
            if(i != a){
                if(saltos(a, i, rev) <= k)
                    cout<<i<<"\t";
            }
        }
    }
    
    int mayor_grado(){
        Mapa<int, int> grados = Mapa<int, int>();
        int cont;
        for(int i = 0; i < nodos; i++){
            cont = 0;
            for(int j = 0; j < nodos; j++){
                if(matriz[i][j] != 0){
                    cont += 1;
                }
            }
            Tupla<int, int> grado = Tupla<int, int>(cont, i+1);
            grados.push(grado);
        } 
        return grados.maxs();
    }
    
    int menor_grado(){
        Mapa<int, int> grados = Mapa<int, int>();
        int cont;
        for(int i = 0; i < nodos; i++){
            cont = 0;
            for(int j = 0; j < nodos; j++){
                if(matriz[i][j] != 0){
                    cont += 1;
                }
            }
            Tupla<int, int> grado = Tupla<int, int>(cont, i+1);
            grados.push(grado);
        } 
        return grados.mins();
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
    Grafo g = Grafo(10);
    vector<int> v;
    g.addEnlace(7, 1, 1, "bidireccional");
    g.addEnlace(1, 2, 1, "bidireccional");
    g.addEnlace(1, 3, 1, "bidireccional");
    g.addEnlace(2, 5, 1, "bidireccional");
    g.addEnlace(5, 10, 1, "bidireccional");
    g.addEnlace(2, 10, 1, "bidireccional");
    g.addEnlace(2, 6, 1, "bidireccional");
    g.addEnlace(2, 4, 1, "bidireccional");
    g.addEnlace(3, 4, 1, "bidireccional");
    g.addEnlace(3, 9, 1, "bidireccional");
    g.addEnlace(4, 6, 1, "bidireccional");
    g.addEnlace(4, 8, 1, "bidireccional");
    g.addEnlace(8, 9, 1, "bidireccional");
    g.addEnlace(6, 8, 1, "bidireccional");
    
    g.print();
    vector<int>rev;
    cout<<"-----------------NODO CON MAYOR GRADO----------------"<<endl;
    g.mayor_grado();
    cout<<"-----------------NODO CON MENOR GRADO----------------"<<endl;
    g.menor_grado();
    cout<<"-----------------NODOS A K O MENOS SALTOS----------------"<<endl;
    int k = 2;
    int a = 1;
    g.print_nodos_k(a, k);
    return 0;
}