#include<iostream>
#include<vector>
using namespace std;

bool es_bidireccional(){
  for(int i = 0;i < nodos;i++){
      for(int j = 0;j < nodos;j++){
          if(matriz[i][j] != matriz[j][i])
              return false;
      }
   }    
   return true;
}
    
int saltos(int** matriz, int a, int b, vector<int> rev){
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
      return 2147483647;
  else
      return get_min(conexiones)+1;
  }
    
  bool is_k_saltos(int** matriz, int a, int b, int k){
      vector<int> v;
      if(saltos(matriz, a, b, v) < k)
          return true;
      return false;
  }

int main(){
  //Se prueba con la clase grafo
  return 0;
 }
