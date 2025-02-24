#include<iostream>
#include<string>
using namespace std;

//--------------------------------------------CLASE TOKENS------------------------------------------//
template <typename T, typename T2>
class Tokens{
    T Nft;
    T2 Token;

public:
    Tokens(T n, T2 t) {
        Nft = n;
        Token = t;
    }
    
    Tokens(){
    }
    
    void setNft(T n){
        Nft = n;
    }
    
    void setToken(T2 t){
        Token = t;
    }
    
    T getNft(){
        return Nft;
    }
    
    T2 getToken(){
        return Token;
    }
    
    Tokens& operator=(const Tokens& f) { 
		setNft(f.Nft);
		setToken(f.Token);
		return *this; 
	}
};

//---------------------------------------------CLASE HASH--------------------------------------------//
template <typename T, typename T2>
class Hash{
    int size;
    int capacity;
    Tokens<T, T2>* v;

public:
    Hash(){
        size = 0;
        capacity = 10;
        v = new Tokens<T, T2>[capacity];
    }
    
    Hash(int cap){
        size = 0;
        capacity = cap;
        v = new Tokens<T, T2>[capacity];
    }

    bool HasToken(Tokens<T, T2> t){
        for(int i = 0; i<size; i++){
            if (v[i].getToken() == t.getToken()){
                return true;
            }
        }
        return false;
    }
    
    string reedem(T2 t){
        for(int i = 0; i<size; i++){
            if (v[i].getToken() == t){
                return v[i].getNft();
            }
        }
        return "El-token-ingresado-no-coincide-con-ningun-nft-existente-😞";
    }
    
    void corrimiento_der(int i){
        for(int j = size; j>i; j--){
            v[j] = v[j-1];
        }
    }
    
    T2 hash(T nft){
        char c = 0;
        int result = 0;
        string f;
        for(int i = 0; i<nft.length(); i++){
            c = nft[i];
            result+=c;
        }
        string result2 = to_string(result);
        c = 17;
        for(int i = 0; i<result2.length(); i++){
            c += result2[i];
            f += c;
            f+= result2[i];
            c=17;
        }
        return f;
    }
    
    T2 reHash(T nft){
        T2 Token = hash(nft);
        Tokens<T, T2> m = Tokens<T, T2>(nft, Token);
        while(HasToken(m) == true){
            if(Token.length()%2 != 0){
                Token += to_string(3*(Token.length()) + 1);
                m.setToken(Token);
            }else if(Token.length()%2 == 0){
                Token += to_string(Token.length()/2);
                m.setToken(Token);
            }
        }
        return Token;
    }
    
    void increase_capacity(){
        Tokens<T, T2>* v1 = new Tokens<T, T2>[2*capacity];
        for (int i = 0; i < size; i++){
            v1[i] = v[i];
        }
        delete[] v; //Borra el vector antiguo
        v = v1;
    }
    
    void push(T nft){
        T2 Token = hash(nft);
        Tokens<T, T2> ph = Tokens<T, T2>(nft, Token);
        
        if(HasToken(ph) == true){
            Token = reHash(nft);
            ph.setToken(Token);
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
                if(ph.getNft()<v[i].getNft()){
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

    T2 find(T nft){
        int left = 0;
        int right = size-1;
        while(left <= right){
            int mid = (right+left)/2;;
            if(v[mid].getNft() == nft){
                return v[mid].getToken();
            }
            else{
                if(v[mid].getNft()>nft){
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
            cout << "(" << v[i].getNft() << ", " << v[i].getToken() << ")" << "\n";
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
    
    int wallet;
public:
 //-------------------------------------------CONSTRUCTOR-----------------------------------------//
    NFT(int w) {
        nft1 = "8888888888888888888888888888888888888888888888888888888 8888888888__________________888888888888888888888888888 88888888___8888888888888888______8888888888888888888888 88888888__88_____________888888____88888888888888888888 888888__888___________________8888____88888888888888888 88888__888_______________________8888___888888888888888 8888__88____________________________888___8888888888888 888__8_________________________________88__888888888888 88__8____________________________________88__8888888888 8__88_____________________________________88___88888888 8__88______________________888888___________88___888888 8__88________8888_________88___88____________88___88888 8__88_______88_8888_______888_888_____________888__8888 8__88______88___888________88888________________88__888 8_888______8888888_______________________________8__888 8_88_____________________________________________88__88 8_88______________________________________________88_88 8_88______________________________________________88__8 8_88______________________________________________88__8 8_88_______________________________________________8__8 8_88_______________________________________________8__8 8_88_______________________________________________8__8 8_88_______________________________________________8_88 88_88____________________________________88________8_88 88__8_______________88888888888888888888888________8_88 88__88______________8888888888888888888____________8_88 888__88______________88888888______________________8_88 8888__88___________________________________________8_88 88888__888________________________________________88_88 888888___88_______________________________________8_888 8888888___88_____________________________________88_888 888888888__8888________________________________88___888 8888888888____8888___________________________888__88888 888888888888_____8888_____________________8888___888888 888888888888888_____88888888888____88888888____88888888 8888888888888888888_________________________88888888888 888888888888888888888888888888____888888888888888888888 888888888888888888888888888888____888888888888888888888";
        NFT1_precio = 450;
        nft2 = "$$$_____$$$$$$$_$$$$$$$_$$$_______$$$_$$$$$$$$$$ $$$____$$$____$$$____$$$_$$$_____$$$__$$$_______ $$$____$$$_____$_____$$$_$$$_____$$$__$$$_______ $$$_____$$$_________$$$___$$$___$$$___$$$$$$$$__ $$$______$$$_______$$$_____$$$_$$$____$$$_______ $$$_______$$$_____$$$______$$$_$$$____$$$_______ $$$$$$$$$___$$$$$$$_________$$$$$_____$$$$$$$$$$";
        NFT2_precio = 1000;
        nft3 = "____________$_______________$___________ __________$$_________________$$_________ _________$$___________________$$________ ________$$_____________________$$_______ ________$$_____________________$$_______ ________$$_____________________$$_______ _________$$___________________$$________ _____$$__$$___________________$$__$$____ ____$$___$$___________________$$___$$___ ___$$_____$$_________________$$_____$$__ ___$_______$$$_____________$$$_______$__ ___$$_______$$$___________$$$_______$$__ ___$$$_______$$$__$$$$$__$$$_______$$$__ ____$$$$$$____$$$$$$$$$$$$$___$$$$$$$___ _________$$$$$$$$$$$$$$$$$$$$$$_________ ____$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$____ ___$$$_$$$$$$$$$$$$$$$$$$$$$$$$$$_$$$___ __$$$_________$$$$$$$$$$$$_________$$$__ _$$_________$$$$$$$$$$$$$$$$$________$$_ _$$_____$$$$$$$$$$$$$$$$$$$$$$$$_____$$_ $$_____$$$__$$$$$$$$$$$$$$$$__$$$_____$$ _$$____$$___$$$$$$$__$$$$$$$___$$____$$_ __$____$$___$$$$$$$__$$$$$$$___$$____$__ ___$___$$___$$$$$$$$$$$$$$$$___$$___$___ ____$__$$____$$$$$$$$$$$$$$____$$__$____ _______$$_____$$$$$$$$$$$$_____$$_______ _______$$_______$$$$$$$$_______$$_______ ________$$____________________$$________";
        NFT3_precio = 2500;
        
        wallet = w;
    }    
//------------------------------------------------METODOS-----------------------------------------//
    void print_nft(string n){
        for(int j = 0; j<n.length(); j++){
            if(n[j] == 32){
                cout<<endl;
            }else{
                cout<<n[j];
            }
        }
    }
    
    void exhibicion(){
        cout<<"☆:::::::::::::::::::::::::::::::::::::::☆GALERIA☆:::::::::::::::::::::::::::::::::::::::☆"<<endl<<endl;
        cout<<"💎NFT 1💎"<<endl;
        print_nft(nft1);
        cout<<endl<<endl<<"¡El precio es de: "<<NFT1_precio<<" BTC!"<<endl<<endl;
        cout<<"💎NFT 2💎"<<endl;
        print_nft(nft2);
        cout<<endl<<endl<<"¡El precio es de: "<<NFT2_precio<<" BTC!"<<endl<<endl;
        cout<<"💎NFT 3💎"<<endl;
        print_nft(nft3);
        cout<<endl<<endl<<"¡El precio es de: "<<NFT3_precio<<" BTC!"<<endl;
        cout<<"☆:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::☆"<<endl<<endl;
    }
    
    void comprar(Hash<string, string> Tokens_){
        string c;
        cout<<"¿Que NFT desea comprar?";
        getline(cin, c);
        cout<<endl;
        
        if(c == "1"){
            if(wallet>=NFT1_precio){
                wallet -=NFT1_precio;
                cout<< "Felicidades por su compra🎉"<<endl<<"Su token es: "<<Tokens_.find(nft1)<<endl;
                cout<<"BTC restante en su wallet: "<<wallet<<endl;
            }else{
                cout<<"₿ Fondos insuficientes ₿"<<endl;
            }
        }else if(c == "2"){
            if(wallet>=NFT2_precio){
                wallet -=NFT2_precio;
                cout<< "Felicidades por su compra🎉"<<endl<<"Su token es: "<<Tokens_.find(nft2)<<endl;
                cout<<"BTC restante en su wallet: "<<wallet<<endl;
            }else{
                cout<<"₿ Fondos insuficientes ₿"<<endl;
            }
        }else if(c == "3"){
            if(wallet>=NFT3_precio){
                wallet -=NFT3_precio;
                cout<< "Felicidades por su compra🎉"<<endl<<"Su token es: "<<Tokens_.find(nft3)<<endl;
                cout<<"BTC restante en su wallet: "<<wallet<<endl;
            }else{
                cout<<"₿ Fondos insuficientes ₿"<<endl;
            }
        }else{
            cout<<"NFT invalido😞"<<endl;
        }
    }
    
    void redimir(Hash<string, string> Tokens_){
        string t;
            cout<<"Ingrese su token:";
            getline(cin, t);
            cout<<endl;
            
            string n = Tokens_.reedem(t);
            cout<< "El nft asociado a dicho token es:"<<endl;
            print_nft(n);
            cout<<endl;
    }
    
    int Jugar(){
        string a;
        Hash<string, string> Tokens_ = Hash<string, string>();
        Tokens_.push(nft1);
        Tokens_.push(nft2);
        Tokens_.push(nft3);
        cout<<"Para ver la galeria, escriba 1"<<endl<<"Para comprar un NFT, escriba 2"<<endl<<"Para redimir un NFT, escriba 3"<<endl<<"Para recargar su wallet, escriba 4"<<endl<<"Para ver su wallet, escriba 5"<<endl<<"Escriba 0 para terminar"<<endl<<endl<<"¿Que desea hacer?:";
        getline(cin, a);
        cout<<endl;
        
        if(a == "1"){
            exhibicion();
            return 0;
        }else if(a == "2"){
            comprar(Tokens_);
            cout<<"-------------------------------------------------------------------"<<endl;
            return 0;
        }else if(a == "3"){
            redimir(Tokens_);
            cout<<"-------------------------------------------------------------------"<<endl;
            return 0;
        }else if(a == "4"){
            string r, r_str;
            bool f = true;
            int r_int;
            
            while(f){
                try{
                    f = false;
                    cout<<"¿Cuantos BTC quiere recargar?"<<endl;
                    getline(cin, r);
                    r_int = stoi(r);
                    string r_str = to_string(r_int);
                    if(r != r_str){
                        throw "error";
                    }
                }catch(...){
                    cout<<"Ingrese un número valido"<<endl;
                    f = true;
                }
            }
            wallet+=r_int;
            cout<<"Su wallet ahora tiene: "<<wallet<<" BTC"<<endl;
            cout<<"-------------------------------------------------------------------"<<endl;
            return 0;
        }else if(a == "5"){
            cout<<"BTC disponible: "<<wallet<<endl;
            cout<<"-------------------------------------------------------------------"<<endl;
            return 0;
        }else if(a == "0"){
            return 1;    
        }else{
            cout<<"Acción invalida 😞"<<endl;
            cout<<"-------------------------------------------------------------------"<<endl;
            return 0;
        }
    }
};

int main(){
    string BTC;
    int a;
    bool F = true;
    long BTC_int;
    
    while(F){
        try{
            F = false;
            cout<<"¿Bienvenido a la tienda, Cuantos BTC quiere ingresar?"<<endl;
            getline(cin, BTC);
            BTC_int = stoi(BTC);
            string BTC_str = to_string(BTC_int);
            if(BTC != BTC_str){
                throw "error";
            }
        }catch(...){
            cout<<"Ingrese un número valido"<<endl;
            F = true;
        }
    }
    cout<<"-------------------------------------------------------------------"<<endl;
    NFT t = NFT(BTC_int);
    do{
    a = t.Jugar();
    }while(a == 0);
    cout<<"Fin, Gracias por jugar";
}
