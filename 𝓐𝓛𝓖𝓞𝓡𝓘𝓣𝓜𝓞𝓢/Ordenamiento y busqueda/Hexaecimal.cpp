#include <iostream>
#include <string>
#include <vector>
using namespace std;

//-----------------------------------FUNCIÓN PARTICIÓN----------------------------------//
int particion(vector<string> &v, int ini, int fin){
    string pivote=v[fin]; //Ultimo elemento del vector con el que se comparan los demás elementos
    int i=ini-1;  //Marcador qe aumenta cuando encuentra un elemento menor que el pivote
    int j=ini;  //Marcador que recorre el vector
    for(j; j<fin+1; j++){
        if(v[j].length()<=pivote.length()){  //Si encuentra un elemento menor que el pivote
            i++;
            string aux=v[i];
            v[i]=v[j];
            v[j]=aux;  //hace el intercambio del elemento del indice i con el elemento que este en el indice j
        }
    }
    return i;
}

//---------------------------------------QUICKSORT--------------------------------------//
void quicksort(vector<string> &v, int ini, int fin){
    if(ini>=fin){
         cout<<"";
    }else{
        int i=particion(v, ini, fin); 
        quicksort(v, ini, i-1);
        quicksort(v, i+1, fin);  //Hace la partición y despues organiza lo que queda en ambos lados
    }   
}

//---------------------------------------------------------------------//
int main(){
    vector <string> v;

    v.push_back("1");
    v.push_back("22");
    v.push_back("334");
    v.push_back("424");
    v.push_back("534");
    v.push_back("61");
    v.push_back("7");
    v.push_back("83");
    v.push_back("29");
    v.push_back("ABCD");
    v.push_back("CB");
    v.push_back("DC");
    v.push_back("ABD");
    v.push_back("E");
    v.push_back("F");
    
    quicksort(v, 0, v.size()-1);
    
    for(int i = 0; i<v.size(); i++){
        cout<<v[i]<<"\t";
    }
    cout<<endl;

    for(int j = 0; j<=v.size(); j++){
        for(int i = 0; i<=v.size(); i++){
            if(v[i].length()==v[i+1].length()){
                if(v[i]>v[i+1]){
                    string aux = v[i+1];
                    v[i+1] = v[i];
                    v[i] = aux;
                } 
            }
        }
    }

    for(int i = 0; i<v.size(); i++){
        cout<<v[i]<<"\t";
    }
    cout<<endl;

    return 0;
}
