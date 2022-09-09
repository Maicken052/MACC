----------------------------------------------------------------------------------PREPA------------------------------------------------------------------------
#include <iostream>
#include <math.h> 
#include <stdlib.h>
#include <string>


using namespace std;

string names[10] = {"Esteban", "Dario", "Mireya", "Nubia", "Gustavo Adolfo", "Julio", "Carlos", "Helena", "Sebastian", "Nicolai"};
string etapas_[5] = {"Pardo Rubio", "Bosque Calderon", "La Salle", "Nueva Granada"};
//------------------------------------------------CLASE CARRERA--------------------------------------------//
class Carrera{
    //Atributos
    string origen;
    string destino;
    int etapa_num_1;
    int etapa_num_2;

public:

    //Constructores
    Carrera(string origen_, string destino_){
        origen = origen_;
        destino = destino_;
        etapa_num_1 = 0;
        etapa_num_2 = 0;
    }

    Carrera() {
        origen = "";
        destino = "";
    }
    
    //metodos
    
    //Setters
    void setOrigen(string i) {
        origen = i;
    }

    void setDestino(string i) {
        destino = i;
    }

     void setEtapa_num_1(int i) {
        etapa_num_1 = i;
    }

    void setEtapa_num_2(int i) {
        etapa_num_2 = i;
    }

    //getters
     int getEtapa_num_1() {
        return etapa_num_1;
    }

    int getEtapa_num_2() {
        return etapa_num_2;
    }


    Carrera& operator=(const Carrera& f) { 
		setOrigen(f.origen);
		setDestino(f.destino);
		return *this; 
	}
	
	string to_string() {
		return "("+ origen + "," + destino +")";
	}


	friend std::ostream& operator<<(std::ostream& os, Carrera& b) {
		return os << b.to_string();
	}

};
 //-------------------------------------------CLASE POSICION------------------------------------------------//
 class Posicion{
    
    //Atributos
    string ciclista;
    int tiempo_total;

public:

    //Constructores
    Posicion(string ciclista_, int tiempo_total_){
        ciclista = ciclista_;
        tiempo_total = tiempo_total_;
    }

    Posicion() {
        ciclista = "";
        tiempo_total = 0;
    }
    
    //metodos
    
    //Setters
    void setCiclista(string i) {
        ciclista = i;
    }

    void setTiempo_total(int i) {
        tiempo_total = i;
    }

    //Getters
    string getCiclista(){
        return ciclista;
    }

    int getTiempo_total(){
        return tiempo_total;
    }

    Posicion& operator=(const Posicion& f) { 
		setCiclista(f.ciclista);
		setTiempo_total(f.tiempo_total);
		return *this; 
	}
	
	string to_string() {
		return ciclista + ": " + std::to_string(tiempo_total) + '\n';
	}


	friend std::ostream& operator<<(std::ostream& os, Posicion& b) {
		return os << b.to_string();
	}

};
//--------------------------------------------FUNCION ETAPAS------------------------------------------------//
void carreras_random(Carrera* v) {
    do{
        for(int i=0; i<5; i++){
            int a, b;
            a = rand()%4;
            b = rand()%4;
            if(a==b){
                if(a>=0){
                    a+=1;
                }else if(a<=4){
                    a-=1;
                }
                v[i]=Carrera(etapas_[a], etapas_[b]);    
                v[i].setEtapa_num_1(a);
                v[i].setEtapa_num_2(b);
            }else{
                v[i]=Carrera(etapas_[a], etapas_[b]);
                v[i].setEtapa_num_1(a);
                v[i].setEtapa_num_2(b);    
            }
        }
    }while(v[0].to_string()==v[1].to_string() and v[3].to_string()==v[4].to_string());
}

//------------------------------------------------LISTA CICLISTAS------------------------------------------//
class Nodo{

    //Atributos
    string Ciclista;
    Carrera* etapa;
    int tiempo;
    Nodo* pointer;
  
public:
  
    //Constructores
    Nodo(){
        etapa = NULL;
        tiempo = 0;
        Ciclista = " ";
        pointer = NULL;
    }
  
    Nodo(Carrera* e, int t, string c){
        etapa = e;
        tiempo = t;
        Ciclista = c;
        pointer = NULL;
    }
  
    //getters
    Carrera* getEtapa(){
        return etapa;
    }
  
    int getTiempo(){
      return tiempo;
    }

    string getCiclista(){
      return Ciclista;
    }


    Nodo* getNext(){
        return pointer;
    }
  
    void setNext(Nodo* p){
        pointer = p;
    }
    
    string to_string() {
        string final, a, c;
        int b;
		a = getEtapa()->to_string();
        b = getTiempo();
        c = getCiclista();
        final = a + '\n' + std::to_string(b)  + '\n' + c;
        return final;
	}


	friend std::ostream& operator<<(std::ostream& os, Nodo& b) {
		return os << b.to_string();
	}   
    
};

class Lista{
    
    Nodo* ptr;
    int size;

public:  

    Lista(){
        ptr = NULL;
        size = 0;
    }
    
    ~Lista(){
        Nodo* t = ptr;
        Nodo* n;
        while(t->getNext() != NULL){
            n = t;
            t = t->getNext();    
            delete n;
        }
        delete t;
    }

    void push_back(Carrera* e, int t, string c){
        
        if(size == 0){
            ptr = new Nodo(e, t, c);
            size++;
        }else{
            Nodo* x = ptr;
            while(x->getNext() != NULL){
                x = x->getNext();    
            }
            x->setNext(new Nodo(e, t, c));
            size++;
        }
        
    }
    
    void print(){
        if(size == 0){
            cout<<"La lista está vacía"<<endl;
        }else{
            Nodo* t = ptr;
            do{
                //cout<<"("<<(*t).getDato()->getX()<<", "<<t->getDato()->getY()<<"), ";
                cout<<(*t)<<endl<<endl;
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
            //throw invalid_argument("La posicion no existe");
            if(size == 0){
                cout<<"La lista está vacía";
            }else{
                cout<<"La posicion no existe";
            }
            return NULL;
        }
        
    }
    
};

int main(){

    cout<<"-----------------------------MATRIZ TIEMPOS----------------------------------"<<endl;    
    int **tiempos;
    tiempos = new int*[4];        //Matriz dinamica
    for(int i=0; i<4; i++){
        tiempos[i]=new int[4];
    }
    
    for(int i=0;i<4;i++){
        for(int j=0;j<4;j++){
            if (i==j){
                *(*(tiempos+i)+j)=-1;
            }else{
            *(*(tiempos+i)+j)=rand()%100;  
           }
        }
    }
    
    cout<<"TIEMPOS RECORD DE LA CARRERA: "<<endl;
     for(int i=0; i<4; i++){
        for(int j=0; j<4; j++){
            cout<<tiempos[i][j]<<"\t";
        }
        cout<<endl;
    }
    
    
    cout<<"------------------------------------ETAPAS--------------------------------------"<<endl;
    Carrera *etapas;
    etapas = new Carrera[5];
    carreras_random(etapas);

    for(int i=0; i<5; i++){
        cout<< etapas[i]<<endl;
    }
    cout<<"-----------------------RESULTADOS EN CADA ETAPA---------------------------"<<endl;
    Lista tabla = Lista();
    
    
    int time;
    string name;
    Carrera* tape ;
    for (int i=0; i<10; i++){
        name = names[i];
        for (int j=0; j<5; j++){
            tape = &(etapas[j]);
            time = rand()%301;
            tabla.push_back(tape, time, name);
        }
    }

    tabla.print();

    cout<<"-------------------------------------------TABLA GENERAL----------------------------------"<<endl;
    Posicion *resultados;
    resultados = new Posicion[10];
    int aux=0;
    int suma_t, r_;
    string ciclista;
    for (int i=0; i<10; i++){
        suma_t=0;
        for(int j=0; j<5;j++){
            Nodo* n=tabla.get(aux);
            r_=n->getTiempo();
            suma_t+=r_;
            aux+=1;
        }
        ciclista=names[i];
        resultados[i] = Posicion(ciclista, suma_t);
    }
    
    int aux_ant;
    string auxn_ant, auxn_post;
    for(int i=0; i<9; i++){
        for(int j=0; j<9; j++){
            if(resultados[j].getTiempo_total()>resultados[j+1].getTiempo_total()){
                aux_ant=resultados[j].getTiempo_total();
                auxn_ant=resultados[j].getCiclista();
                auxn_post=resultados[j+1].getCiclista();
                resultados[j].setTiempo_total(resultados[j+1].getTiempo_total());
                resultados[j].setCiclista(auxn_post);
                resultados[j+1].setTiempo_total(aux_ant);
                resultados[j+1].setCiclista(auxn_ant);
            }
        }
    }

    for(int i=0; i<10; i++){
        cout<<resultados[i];
    }

    cout<<endl;

    cout<<"------------------------------------------GANADOR-----------------------------------"<<endl;
    string ganador;
    ganador=resultados[0].getCiclista();
    
    cout<<"EL GANADOR ES: "<<ganador<<endl;

    cout<<"------------------------------------------RECORD-----------------------------------"<<endl;
        int record=0;
        for(int i=0; i<4; i++){
            for(int j=0; j<4; j++){
                Nodo* records[4];
                Nodo* nodo_record;
                int aux3=0, record_real;
                string name_record;
                for(int s=0; s<50; s++){
                    if(tabla.get(s)->getEtapa()->getEtapa_num_1()==i and tabla.get(s)->getEtapa()->getEtapa_num_2()==j){
                        if(tabla.get(s)->getTiempo()<tiempos[i][j]){
                            records[aux3]=tabla.get(s);
                            aux3+=1;
                            record+=1;
                        }
                    }
                }
                if(aux3!=0){
                    record_real=records[0]->getTiempo();
                    name_record=records[0]->getCiclista();
                    nodo_record=records[0];
                    for(int m=0; m<aux3; m++){
                        if(records[m]->getTiempo()<record_real){
                            record_real=records[m]->getTiempo();
                            name_record=records[m]->getCiclista();
                            nodo_record=records[m];
                        }
                    }
                    cout<<name_record<<" Ha roto el record en "<<nodo_record->getEtapa()->to_string()<<"!"<<endl;
                    tiempos[i][j]=record_real;
                }
            }
        }
        if(record==0){
            cout<<"Ningun record fue roto :c"<<endl;
        }
        
        cout<<"------------------------NUEVA TABLA DE RECORDS---------------------------"<<endl;
        for(int i=0; i<4; i++){
            for(int j=0; j<4; j++){
                cout<<tiempos[i][j]<<"\t";
            }
        cout<<endl;
    }

    //----------------------------------------DESTRUCTORES--------------------------------//
    for(int i=0;i<4;i++){  //Borrar matriz dinamica 
        delete[] tiempos[i];
    }

    delete[] etapas;
    delete[] resultados;

    return 0;
}