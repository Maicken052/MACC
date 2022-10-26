#include<iostream>
#include<iostream>
using namespace std;

class Nodo{
  
  int dato;
  Nodo* pointer;
  
public:
  
  Nodo(){
      dato = 0;
      pointer = NULL;
  }
  
  ~Nodo(){
  }
  
  Nodo(int d){
      dato = d;
      pointer = NULL;
  }
    
  int getDato(){
      return dato;
  }
  
  void setDato(int d){
      dato = d;
  }
  
  Nodo* getNext(){
      return pointer;
  }
  
  void setNext(Nodo* p){
      pointer = p;
  }
    
    string to_string() {
		return std::to_string(dato);
	}


	friend std::ostream& operator<<(std::ostream& os, Nodo& b) {
		return os << b.to_string();
	}
    
};

class Stack{
    
    Nodo* ptr;
    int size;

public:  

    Stack(){
        ptr = NULL;
        size = 0;
    }
    
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
    
    int getSize(){
        return size;
    }
    
    Nodo* getPtr(){
        return ptr;
    }
    
    void push(int d){
        Nodo* front = ptr;
        Nodo* top = new Nodo(d);
        ptr = top;
        ptr->setNext(front);
        size++;
    }
   
    int pop(){
        int n2 = ptr->getDato();
        Nodo* n = ptr;
        ptr = n->getNext();
        delete n;
        size--;
        return n2;
    }
    
    int peek(){
        return ptr->getDato();
    }
       
    Nodo* get(int i){
        if(i < size && i>=0){
            Nodo* n = ptr;
            for(int x = 0; x<i;x++){
                n = n->getNext();
            }
            return n;
        }else{
            if(size == 0){
                cout<<"La lista está vacía";
            }else{
                cout<<"La posicion no existe";
            }
            return NULL;
        }
    }
    
    void print(){
        if(size == 0){
            cout<<"La lista está vacía"<<endl;
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


string jugar(Stack x){
    do{
        string r, r_str;
        bool f = true;
        int r_int;
            
        while(f){
            try{
                f = false;
                cout<<"Ingrese una potencia de dos: "<<endl;
                getline(cin, r);
                r_int = stoi(r);
                string r_str = to_string(r_int);
                if(r != r_str){
                    throw "error";
                }
            }catch(...){
                cout<<"𝐈𝐧𝐠𝐫𝐞𝐬𝐞 𝐮𝐧 𝐧𝐮𝐦𝐞𝐫𝐨 𝐯𝐚𝐥𝐢𝐝𝐨"<<endl;
                f = true;
            }
        }
        x.push(r_int);
        
        if(x.getSize() > 1){
            while(x.getPtr()->getNext()->getDato() == x.peek()){
                int nn = x.getPtr()->getNext()->getDato() + x.peek();
                x.pop();
                x.pop();
                x.push(nn);
                
                if(x.getSize() == 1){
                    break;
                }
            }
        }
        
        cout<<"Tu juego es: "<<endl;
        x.print();
    
        if(x.peek() == 128){
            x.pop();
            cout<<"Lograste un 128!, tu juego es: "<<endl;
            x.print();
        }    
    }while(x.getSize() != 0);
    
    return "Felicidades profe :)";
}    


int main(){
    Stack dmco = Stack();
    cout<<jugar(dmco)<<endl;
    return 0;
}
