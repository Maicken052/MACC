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

void two_smallest (vector<string> & arr){
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

int main(){
    vector <string> v;

    v.push_back("ti amo");
    v.push_back("pq eres");
    v.push_back("muy linda");
    v.push_back("ola");

    two_smallest(v);
    return 0;
}