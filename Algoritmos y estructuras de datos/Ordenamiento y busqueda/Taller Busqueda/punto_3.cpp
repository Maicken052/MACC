/******************************************************************************
Dado un vector de enteros que inicialmente aumenta y luego disminuye, encuentre
el valor maximo en el vector.
*******************************************************************************/

#include <iostream>
#include <vector>
using namespace std;

int findMaximum (vector <int > & arr ){
    int max;
    max = arr[0];
    for(int i = 1; i < arr.size(); i++){
        if(arr[i] > max){
            max = arr[i];
        }
    }
    return max;
}

int main(){
    vector <int> v;

    v.push_back(4);
    v.push_back(6);
    v.push_back(12);
    v.push_back(16);

    cout<<"El valor maximo del vector es: "<<findMaximum(v)<<endl;

    v.push_back(20);
    v.push_back(22);

    cout<<"El valor maximo del vector es: "<<findMaximum(v)<<endl;

    v.erase(v.begin() + 2, v.begin() + v.size());

    cout<<"El valor maximo del vector es: "<<findMaximum(v)<<endl;
    return 0;
}