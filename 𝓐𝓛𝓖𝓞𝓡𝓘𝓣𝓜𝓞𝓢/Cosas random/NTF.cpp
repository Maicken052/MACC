#include<iostream>
#include<string>
using namespace std;

//--------------------------------------------CLASE TUPLA------------------------------------------//
template <typename T, typename T2>
class Tupla{
    T key;
    T2 dato;

public:
    Tupla(T k, T2 d) {
        key = k;
        dato = d;
    }
    
    Tupla(){
    }
    
    void setKey(T k){
        key = k;
    }
    
    void setDato(T2 d){
        dato = d;
    }
    
    T getKey(){
        return key;
    }
    
    T2 getDato(){
        return dato;
    }
    
    Tupla& operator=(const Tupla& f) { 
		setKey(f.key);
		setDato(f.dato);
		return *this; 
	}
};

//---------------------------------------------CLASE MAPA--------------------------------------------//
template <typename T, typename T2>
class Mapa{
    int size;
    int capacity;
    Tupla<T, T2>* v;

public:
    Mapa(){
        size = 0;
        capacity = 10;
        v = new Tupla<T, T2>[capacity];
    }
    
    Mapa(int cap){
        size = 0;
        capacity = cap;
        v = new Tupla<T, T2>[capacity];
    }

    bool Haskey(Tupla<T, T2> t){
        for(int i = 0; i<size; i++){
            if (v[i].getKey() == t.getKey()){
                return true;
            }
        }
        return false;
    }
    
    void corrimiento_der(int i){
        for(int j = size; j>i; j--){
            v[j] = v[j-1];
        }
    }
    
    T hash(T2 s){
        char c = 0;
        int result = 0;
        for(int i = 0; i<s.length(); i++){
            c = s[i];
            result+=c;
        }
        return result%18;
    }
    
    T reHash(T2 s){
        T code = hash(s);
        Tupla<T, T2> m = Tupla<T, T2>(code, s);
        while(Haskey(m) == true){
            if(code%2 != 0){
                code = 3*(code) + 1;
                m.setKey(code);
            }else if(code%2 == 0){
                code = code/2;
                m.setKey(code);
            }
        }
        return code;
    }
    
    void increase_capacity(){
        Tupla<T, T2>* v1 = new Tupla<T, T2>[2*capacity];
        for (int i = 0; i < size; i++){
            v1[i] = v[i];
        }
        delete[] v; //Borra el vector antiguo
        v = v1;
    }
    
    void push(T2 d){
        T k = hash(d);
        Tupla<T, T2> ph = Tupla<T, T2>(k, d);
        
        if(Haskey(ph) == true){
            k = reHash(d);
            ph.setKey(k);
        }
        if (size >= capacity){ 
            increase_capacity();
        }
    
        if(size==0){
            v[size] = ph;
            size++;
        }else{
            int flag = 0;
            for(int i = 0; i<size; i++){
                if(ph.getKey()<v[i].getKey()){
                    corrimiento_der(i);
                    v[i] = ph;
                    flag = 1;
                    break;
                }
            }
            if(flag == 0){
                v[size] = ph;
            }
            size++;
        }  
    }

    T2 find(T key){
        int left = 0;
        int right = size-1;
        while(left <= right){
            int mid = (right+left)/2;;
            if(v[mid].getKey() == key){
                return v[mid].getDato();
            }
            else{
                if(v[mid].getKey()>key){
                    right = mid-1;
                }
                else{
                    left = mid+1;
                }
            }    
        }
        return NULL;
    }
    
    void print() {
        for (int i = 0; i <size; i++) {
            cout << "(" << v[i].getKey() << ", " << v[i].getDato() << ")" << "\n";
        }
        cout<<endl;
    }
};

class NFT{
    string nft1;
    int NFT1_precio;
    string nft2;
    int NFT2_precio;
    string nft3;
    int NFT3_precio;
    
public:
 //-------------------------------------------CONSTRUCTOR-----------------------------------------//
    NFT() {
        nft1 = "_____8888888888____________________v____888888888888888_________________v__888888822222228888________________v_88888822222222288888_______________v888888222222222228888822228888______v888882222222222222288222222222888___v8888822222222222222222222222222288__v_8888822222222222222222222222222_88_v__88888222222222222222222222222__888v___888822222222222222222222222___888v____8888222222222222222222222____888v_____8888222222222222222222_____888_v______8882222222222222222_____8888__v_______888822222222222______888888__v________8888882222______88888888____v_________888888_____888888888_______v__________88888888888888____________v___________8888888888_______________v____________8888888_________________v_____________88888__________________v______________888___________________v_______________8____________________";
        NFT1_precio = 450;
        nft2 = "$$$_____$$$$$$$_$$$$$$$_$$$_______$$$_$$$$$$$$$$v$$$____$$$____$$$____$$$_$$$_____$$$__$$$_______v$$$____$$$_____$_____$$$_$$$_____$$$__$$$_______v$$$_____$$$_________$$$___$$$___$$$___$$$$$$$$__v$$$______$$$_______$$$_____$$$_$$$____$$$_______v$$$_______$$$_____$$$______$$$_$$$____$$$_______v$$$$$$$$$___$$$$$$$_________$$$$$_____$$$$$$$$$$";
        NFT2_precio = 1000;
        nft3 = "__xxxxxxxxxxx______xxxxxxxxxxv_xxxxxxxxxxxxxx___xxxxxxxxxxxxxvxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxvxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxv_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxv__xxxxxxxxxxxxxxxxxxxxxxxxxxxv____xxxxxxxxxxxxxxxxxxxxxxv_______xxxxxxxxxxxxxxxxxv________xxxxxxxxxxxxv__________xxxxxxxxxv____________xxxxxv_____________xxxv_____________xxv_____________*";
        NFT3_precio = 2500;
    }    
//------------------------------------------------METODOS-----------------------------------------//
    void exhibicion(string i){
        if(i == "nft1"){
            for(int j = 0; j<nft1.length(); j++){
                if(nft1[j] == "v"){
                    cout<<endl;
                }else{
                    cout<<nft1[j];
                }
            }
            cout<<endl<<endl<<NFT1_precio<<endl;
        }else if(i == "nft2"){
            for(int j = 0; j<nft2.length(); j++){
                if(nft2[j] == "v"){
                    cout<<endl;
                }else{
                    cout<<nft2[j];
                }
            }
            cout<<endl<<endl<<NFT2_precio<<endl;
        }else if(i == "nft3"){
            for(int j = 0; j<nft3.length(); j++){
                if(nft3[j] == "v"){
                    cout<<endl;
                }else{
                    cout<<nft3[j];
                }
            }
            cout<<endl<<endl<<NFT3_precio<<endl;
        }
    }
};

int main(){
    NFT t = NFT();
    t.exhibicion("nft1");
    return 0;
}
