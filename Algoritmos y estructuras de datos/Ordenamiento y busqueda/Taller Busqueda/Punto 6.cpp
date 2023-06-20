/******************************************************************************
Diseñe un algoritmo para encontrar un mınimo local en vec. Un mınimo local de
un vector A = {A1, . . . , AN } se define como la posición o ındice i ∈ [0, N − 1] tal
que tanto Ai−1 > Asi como Ai < Ai+1 son expresiones verdaderas.
*******************************************************************************/

#include <iostream>
#include <string>
#include <vector>
using namespace std;

int anti_peak (const vector <int> & vec ){
    int min, ind_min;
    min = vec[1];
    ind_min = 1;
    for( int i = 0; i<vec.size(); i++){
        if(min<=vec[i] && min<=vec[i+2]){
            return ind_min;
        }else{
            min = vec[i+2];
            ind_min = i+2;
        }
    }
    return -1;
}

void print(vector <int> & v){
    for(int i = 0; i<v.size(); i++){
            cout<<v[i]<<"\t";
        }
        cout<<endl;
    }
//---------------------------------------------------------------------//
int main(){
    vector <int> v;

    v.push_back(7);  
    v.push_back(2);
    v.push_back(5);
    v.push_back(6);
    v.push_back(5);
    v.push_back(1);
    
    print(v);
    cout<<anti_peak(v)<<endl;

    return 0;
}
