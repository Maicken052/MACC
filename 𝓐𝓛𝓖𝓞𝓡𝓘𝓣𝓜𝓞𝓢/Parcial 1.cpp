//-----------------------------------------------------------------------------PARCIAL-----------------------------------------------------------------------------//
#include <iostream>
#include <math.h> 
#include <stdlib.h>
#include <string>

using namespace std;

//-----------------------------------CLASE TRANSACCION----------------------------------//
class Transaccion{
  //Atributos
    int emp_origen;
    int emp_destino;
    int monto;

public:

    //Constructores
    Transaccion(int emp__o, int emp__d, int m){
        emp_origen=emp__o;
        emp_destino=emp__d;
        monto=m;
    }

    Transaccion() {
        emp_origen=0;
        emp_destino=0;
        monto=0;
    }
    
    //metodos
     
    int get_emp_origen(){
        return emp_origen;
    }
    
    int get_emp_destino(){
        return emp_destino;
    }

    int get_monto(){
        return monto;
    }

    void set_emp_origen(int a){
        emp_origen = a;
    }
    
    void set_emp_destino(int a){
        emp_destino = a;
    }
    
    void set_monto(int a){
        monto = a;
    }
    
    Transaccion& operator=(const Transaccion& f) { 
        set_emp_origen(f.emp_origen);
		set_emp_destino(f.emp_destino);
        set_monto(f.monto);
		return *this;
    }
  
    
    string to_string() {
        return "("+std::to_string(emp_origen) + "," + std::to_string(emp_destino)+ "," + std::to_string(monto)+")";
    }
    
    friend std::ostream& operator<<(std::ostream& os, Transaccion& b) {
        return os << b.to_string();
    }
    
};
 //------------------------------------------------CLASE NODO------------------------------------------//
class Nodo{

    //Atributos
    Transaccion* dato;
    Nodo* pointer;
  
public:
  
    Nodo(){
        dato = NULL;
        pointer = NULL;
    }
  
    ~Nodo(){
        delete dato;
    }
  
    Nodo(Transaccion* d){
        dato = d;
        pointer = NULL;
    }
    
    Transaccion* getDato(){
        return dato;
    }
  
    void setDato(Transaccion* d){
        dato = d;
    }
  
    Nodo* getNext(){
        return pointer;
    }
  
    void setNext(Nodo* p){
        pointer = p;
    }
    
    string to_string() {
		return getDato()->to_string();
	}


	friend std::ostream& operator<<(std::ostream& os, Nodo& b) {
		return os << b.to_string();
	}
    
}; 

//-------------------------------------CLASE LISTA-----------------------------//
class Lista{
    Nodo* ptr;
    int size;

public:  

    Lista(){
        ptr = NULL;
        size = 0;
    }

    void push_back(Transaccion* e){
        
        if(size == 0){
            ptr = new Nodo(e);
            size++;
        }else{
            Nodo* x = ptr;
            while(x->getNext() != NULL){
                x = x->getNext();    
            }
            x->setNext(new Nodo(e));
            size++;
        }
        
    }
    
    void print(){
        if(size == 0){
            cout<<"La lista está vacía"<<endl;
        }else{
            Nodo* t = ptr;
            do{
                cout<<(*t)<<endl;
                t = t->getNext();
                
            }while(t != NULL);
            cout<<endl;
        }
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
};


int main()
{
    srand(1234);
    int num_emp = 4; //Número de empresas
    int num_trans = 100; //Número de transacciones
    int error = 16; //Variable para incluir errores en las transacciones
    int monto_max = 100000; //Variable para definir el máximo valor de un monto
    
    int** mat_bank; //Declaración de la matriz con información reportada por el banco, calculada con las transacciones originales
    int** mat_alt; //Declaración de la matriz con información alterada, reportada por la empresa, calculada con las transacciones alteradas
    
    Lista* t_apuntador;
    Lista t = Lista();  //Lista para guardar las transacciones
    t_apuntador=&(t);  //Apuntador a lista t, para poder usarlo en t_random
	
    //Creación de transacciones. Valide que no haya transacciones con un mismo origen y destino, y que el monto no pase del máximo establecido: monto = rand()%100000;
    int monto, a, b;
    for(int i=0; i<num_trans; i++){
        monto = rand()%monto_max;  
        a = rand()%num_emp;
        do{
            b = rand()%num_emp;   
        }while(a==b);  //Para que las empresas sean diferentes (una empresa no puede tener transacciones con si misma)
        t.push_back(new Transaccion(a, b, monto));
    }

    //Imprimir lista de transacciones originales
    cout<<"LISTA DE TRANSACCIONES ORIGINALES:"<<endl;
    t.print();
    cout<<"-----------------------------------------------------------"<<endl;
	
    //Calcular monto total de transacciones entre empresas en mat_bank
    mat_bank = new int*[num_emp];        //Matriz dinamica
    for(int i=0; i<num_emp; i++){
        mat_bank[i]=new int[num_emp];
    }
    
    for(int s=0; s<num_trans; s++){
        mat_bank[t.get(s)->getDato()->get_emp_origen()][t.get(s)->getDato()->get_emp_destino()]+=t.get(s)->getDato()->get_monto();  //Coloca en los indices de la matriz las empresas de origen y destino del indice s de la lista, y le suma el monto que tenga dicho dato
    }
	
    //Imprimir la matriz mat_bank
    cout<<"MATRIZ SIN MANIPULAR: "<<endl;
     for(int i=0; i<num_emp; i++){
        for(int j=0; j<num_emp; j++){
            cout<<mat_bank[i][j]<<"\t";
        }
        cout<<endl;
    }
    cout<<"-----------------------------------------------------------"<<endl;

    //Alterar las transacciones cuyo indice%error == 0, disminuyendo su valor en 25% (monto*0.75)   
    Lista t_alt=Lista();  //Lista con los valores del monto alterados
	
    for(int s=0; s<num_trans; s++){
        t_alt.push_back(t.get(s)->getDato());
    }

    for(int s=0; s<num_trans; s++){
        if(s%error==0){
            t_alt.get(s)->getDato()->set_monto(t.get(s)->getDato()->get_monto()*0.75);  //Si el indice de la lista coincide con error, disminuye el valor en 25%
        }
    }

    //Imprimir lista de transacciones alteradas
    cout<<"LISTA DE TRANSACCIONES ALTERADAS:"<<endl;
    t_alt.print();
    cout<<"-----------------------------------------------------------"<<endl;
	
    //Calcular monto total de transacciones alteradas entre empresas en mat_alt
    mat_alt = new int*[num_emp];        //Matriz dinamica
    for(int i=0; i<num_emp; i++){
        mat_alt[i]=new int[num_emp];
    }
    
    for(int s=0; s<num_trans; s++){
        mat_alt[t_alt.get(s)->getDato()->get_emp_origen()][t_alt.get(s)->getDato()->get_emp_destino()]+=t_alt.get(s)->getDato()->get_monto();
    }
   
    //Imprimir la matriz mat_alt
    cout<<"MATRIZ MANIPULADA: "<<endl;
     for(int i=0; i<4; i++){
        for(int j=0; j<4; j++){
            cout<<mat_alt[i][j]<<"\t";
        }
        cout<<endl;
    }
    cout<<"-----------------------------------------------------------"<<endl;
	
    //Imprimir las diferencias encontradas entre ls matrices
    for(int i=0; i<num_emp; i++){
        for(int j=0; j<num_emp; j++){
            if(mat_bank[i][j]!=mat_alt[i][j]){
                cout<<"Error en total de transacciones entre empresas "<<i<<" y "<<j<<" por "<<mat_alt[i][j]-mat_bank[i][j]<<endl;
            }
        }
    }
    
    return 0;
}
