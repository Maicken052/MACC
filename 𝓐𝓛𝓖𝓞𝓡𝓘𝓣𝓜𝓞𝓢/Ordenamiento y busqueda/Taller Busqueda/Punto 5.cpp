/******************************************************************************
Implemente el algoritmo de busqueda por interpolacion y utilıcelo en un programa
para buscar un entero en un arreglo de enteros ordenados
*******************************************************************************/

#include<iostream>
#include<vector>
using namespace std;

int busqueda_interpolacion(vector<int> &arr, int x){
        int left = 0;
        int right = arr.size()-1;
        while(left <= right){
            int mid = left+((x-arr[left])*(right-left)/(arr[right]-arr[left]));
            if(arr[mid] == x){
                return mid;
            }
            else{
                if(arr[mid]>x){
                    right = mid-1;
                }
                else{
                    left = mid+1;
                }
            }    
        }
        return -1;
    }

int main(){
    vector<int> v;
    v.push_back(1);
    v.push_back(3);
    v.push_back(7);
    v.push_back(8);
    v.push_back(11);
    v.push_back(15);
    v.push_back(17);
    v.push_back(18);
    v.push_back(21);
    
    cout<<busqueda_interpolacion(v, 21)<<endl;
    return 0;
}   