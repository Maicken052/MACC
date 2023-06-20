/******************************************************************************
Implemente un algoritmo para encontrar e imprimir el elemento mas pequeño y
el segundo mas pequeño en un vector de cadenas de caracteres (string).
*******************************************************************************/

#include <iostream>
#include <string>
#include <vector>
using namespace std;

int indice_min(vector<int> & arr){
    int min, ind_min;
    min = arr[0];
    ind_min = 0;

    for(int i = 1; i<arr.size();i++){
        if(arr[i] < min){
            ind_min = i;
            min = arr[i];
        }
    }

    return ind_min;
}

void two_smallest_cant (vector<string> & arr){
    vector<int> len;
    int first_ind, second_ind;
    string first_smallest, second_smallest;

    for(int i = 0; i<arr.size(); i++){
        len.push_back(arr[i].length());
    }

    first_ind = indice_min(len);
    first_smallest = arr[first_ind];

    len.erase(len.begin() + first_ind);
    arr.erase(arr.begin() + first_ind);

    second_ind = indice_min(len);
    second_smallest = arr[second_ind];

    cout<<"El primer elementos mas chico es: "<<first_smallest<<" y el segundo es: "<<second_smallest<<endl;
}

void two_smallest_lex (vector<string> & arr){
    string min_01, min_02;
    int ind_01, ind_02;
    min_01 = arr[0];
    ind_01 = 0;
    for(int i = 1; i<arr.size();i++){
        if(arr[i] < min_01){
            min_01 = arr[i];
            ind_01 = i;
        }
    }
    
    arr.erase(arr.begin() + ind_01);
    
    min_02 = arr[0];
    ind_02 = 0;
    
    for(int i = 1; i<arr.size();i++){
        if(arr[i] < min_02){
            min_02 = arr[i];
            ind_02 = i;
        }
    }
    
    cout<<"El primer elementos mas chico es: "<<min_01<<" y el segundo es: "<<min_02<<endl;
}

int main(){
    vector <string> v;

    v.push_back("andes");
    v.push_back("besos");
    v.push_back("primal");
    v.push_back("agalas");

    two_smallest_lex(v);
    return 0;
}
