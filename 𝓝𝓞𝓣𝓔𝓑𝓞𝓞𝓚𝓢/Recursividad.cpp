//----------------------------------------------------------RECURSIVIDAD------------------------------------------------------//
#include <iostream>

using namespace std;

int fact(int n){  //Factorial recursivo
    if(n==0){
        return 1;
    }else{
        return n*fact(n-1);
    }
}

int fib(int n){  //Fibonnaci recursivo
    if(n==0){
        return 0;
    }
    if(n==1){
        return 1;
    }else{
        return fib(n-1)+fib(n-2);
    }
}

int main(){
    cout<<fact(4);
    cout<<fib(4);
}
