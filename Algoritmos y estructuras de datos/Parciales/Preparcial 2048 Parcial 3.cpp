#include<iostream>
#include<iostream>
using namespace std;

//------------------------------CLASE NODO---------------------------------//
class Nodo{
    //Atributos
    int dato;
    Nodo* pointer;
  
public:
    //Constructores
    Nodo(){
        dato = 0;
        pointer = NULL;
    }
  
    Nodo(int d){
        dato = d;
        pointer = NULL;
    }
  
    //Destructor
    ~Nodo(){
    }
  
    //Getters
    int getDato(){
        return dato;
    }
  
    Nodo* getNext(){
        return pointer;
    }
  
    //Setters
    void setDato(int d){
        dato = d;
    }
  
    void setNext(Nodo* p){
        pointer = p;
    }
    
    //Sobrecargas
    string to_string() {
		return std::to_string(dato);
	}


	friend std::ostream& operator<<(std::ostream& os, Nodo& b) {
		return os << b.to_string();
	}
    
};

//------------------------------CLASE STACK---------------------------------//
class Stack{
    //Atributos
    Nodo* ptr;
    int size;

public:  
    //Constructor
    Stack(){
        ptr = NULL;
        size = 0;
    }
    
    //Destructor
    ~Stack(){
        Nodo* t = ptr;
        Nodo* n;
        while(t->getNext() != NULL){
            n = t;
            t = t->getNext();    
            delete n;
        }
        delete t;
    }
    
    //Getters
    int getSize(){
        return size;
    }
    
    Nodo* getPtr(){
        return ptr;
    }
    
    //Metodos
    void push(int d){
        Nodo* front = ptr;
        Nodo* top = new Nodo(d);
        ptr = top;
        ptr->setNext(front);
        size++;
    }
   
    void pop(){
        if(size == 0){
            cout<<"El stack esta vacio"<<endl;
        }else{
            Nodo* n = ptr;
            ptr = n->getNext();
            delete n;
            size--;
        }
    }
    
    int peek(){
        return ptr->getDato();
    }
    
    void print(){
        if(size == 0){
            cout<<"El stack esta vacio"<<endl;
        }else{
            Nodo* t = ptr;
            do{
                cout<<(*t)<<"  ";
                t = t->getNext();   
            }while(t != NULL);
            cout<<endl;
        }
    }
};

//------------------------------FUNCION POTENCIA DE DOS---------------------------------//
int es_potencia_dos(int x){
    while(x%2 == 0){
        x = x/2;
    }
    return x;
}

//------------------------------FUNCION 2048---------------------------------//
void jugar(){
    Stack x = Stack();
    bool fin = false;
    
    do{
        /************************************************************************************
        Revisa que el número ingresado sea valido, de lo contrario pide de nuevo el dato al
        usuario.
        ************************************************************************************/
        string r, r_str;
        bool f = true;
        int r_int;
            
        while(f){
            try{
                f = false;
                cout<<"𝗜𝗻𝗴𝗿𝗲𝘀𝗲 𝘂𝗻𝗮 𝗽𝗼𝘁𝗲𝗻𝗰𝗶𝗮 𝗱𝗲 𝗱𝗼𝘀 𝗺𝗲𝗻𝗼𝗿 𝗾𝘂𝗲 𝟭𝟮𝟴: "<<endl;
                getline(cin, r);
                r_int = stoi(r);
                string r_str = to_string(r_int);
                if(r != r_str){
                    throw "error";
                }else if(r_int > 64 || r_int == 1 || r_int == 0){
                    throw "error";    
                }else if(es_potencia_dos(r_int) != 1){
                    throw "error";    
                }
                
            }catch(...){
                cout<<"---------------------------------"<<endl;
                cout<<"𝗜𝗻𝗴𝗿𝗲𝘀𝗲 𝘂𝗻 𝗻𝘂𝗺𝗲𝗿𝗼 𝘃𝗮𝗹𝗶𝗱𝗼"<<endl;
                cout<<"---------------------------------"<<endl;
                f = true;
            }
        }
        
        x.push(r_int);
        
        /************************************************************************************
        Si el número agregado es igual al que estaba en el tope, se suman. Si el nuevo numero
        resultante es igual a de abajo suyo, ocurre lo mismo hasta que el número de abajo sea
        diferente.
        ************************************************************************************/
        if(x.getSize() > 1){
            while(x.getPtr()->getNext()->getDato() == x.peek()){
                int equal = x.peek()*2;
                x.pop();
                x.pop();
                x.push(equal);
                
                if(x.getSize() == 1){
                    break;
                }
            }
        }
        
        cout<<"---------------------------------"<<endl;
        cout<<"𝗧𝘂 𝗷𝘂𝗲𝗴𝗼 𝗲𝘀: "<<endl;
        x.print();
        cout<<"---------------------------------"<<endl;
    
        if(x.peek() == 128){
            if(x.getSize() == 1){
                cout<<"𝗚𝗔𝗡𝗔𝗦𝗧𝗘𝗘𝗘 🥳"<<endl;
                fin = true;
            }else{
                x.pop();
                cout<<"𝗟𝗼𝗴𝗿𝗮𝘀𝘁𝗲 𝘂𝗻 𝟭𝟮𝟴!, 𝘁𝘂 𝗷𝘂𝗲𝗴𝗼 𝗻𝘂𝗲𝘃𝗼 𝗲𝘀: "<<endl;
                x.print();
            }
            cout<<"---------------------------------"<<endl;
        }
        
    }while(!fin);
}    


int main(){
    jugar();
    return 0;
}
