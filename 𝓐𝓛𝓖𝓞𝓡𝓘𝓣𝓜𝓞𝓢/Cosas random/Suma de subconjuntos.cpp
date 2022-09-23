/******************************************************************************
Diseñe un algoritmo para encontrar un mınimo local en vec. Un mınimo local de
un vector A = {A1, . . . , AN } se define como la posición o ındice i ∈ [0, N − 1] tal
que tanto Ai−1 > Asi como Ai < Ai+1 son expresiones verdaderas.
*******************************************************************************/

#include <iostream>
#include <string>
#include <vector>
using namespace std;

void print(const vector <int> & v){
    for(int i = 0; i<v.size(); i++){
            cout<<v[i]<<"\t";
        }
        cout<<endl;
    }

void recursion (const vector <int> &v, const int z, const vector<int> res){ 
    if(z==0){
        cout<<"El siguiente subconjunto cumple con la sumatoria: "<<endl;
        print(res);
    }
    else if(z<0){
        cout<<"";
    }
    else if(v.size()==0 && z!=0){
        cout<<"";
    }
    else if(v.size()>0){
        vector<int> v2 = v;
        int z2 = z;
        vector<int> res2 = res;
        v2.erase(v2.begin());
        recursion(v2, z2, res2);
        vector<int> v3 = v;
        int z3 = z;
        vector<int> res3 = res;
        int el = v3[0];
        res3.push_back(el);
        z3 = z-el;
        v3.erase(v3.begin());
        recursion(v3, z3, res3);
    }
}

//---------------------------------------------------------------------//
int main(){
    vector <int> v, res;

    v.push_back(-7);  
    v.push_back(-3);
    v.push_back(-2);
    v.push_back(5);
    v.push_back(8);

    recursion(v, 1, res);

    return 0;
}
