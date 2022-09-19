#include <iostream>

using namespace std;

void swap(int* v, int a, int b){
    int aux;
    aux=v[a];
    v[a]=v[b];
    v[b]=aux;
}

void heapify(int* v, int size){
    int mxheap, mxheap_son;
    mxheap=(size/2)-1;
    for(mxheap; mxheap>=0; mxheap--){
        if(2*(mxheap+1)!=size){
        mxheap_son=max(v[(2*mxheap)+1], v[2*(mxheap+1)]);
        }else{
            mxheap_son=v[(2*mxheap)+1];
        }
        if(v[mxheap]<mxheap_son){
            if(mxheap_son==v[(2*mxheap)+1]){
                swap(v, mxheap, (2*mxheap)+1);
            }else{
                swap(v, mxheap, 2*(mxheap+1));
            }
        }
    }
    swap(v, 0, size-1);
}

void heapsort(int* v, int size){
    if(size==1){
        cout<<"";
    }else{
        heapify(v, size);
        heapsort(v, size-1);
    }
}

void print(int* v, int size){
    for(int i=0; i<size; i++){
        cout<<v[i]<<"\t";
    }
    cout<<endl;
}

int main(){
    int v[6]={-2321, 0, 23123, 6756756, 1213, -1};
    print(v, 6);
    heapsort(v, 6);
    print(v, 6);
    return 0;
}
