-----------------------------------------------------------------------------------CLASE VECTOR------------------------------------------------------------------------
#include <iostream>
using namespace std;

class Vector1 {
    
private:
//---------------------------------------------ATRIBUTOS------------------------------------------//
    int size;
    int capacity;
    int *v;
//------------------------------------------------------------------------------------------------//

public:
 //-------------------------------------------CONSTRUCTOR-----------------------------------------//
    Vector1(int capacity1) {
        size = 0;
        capacity = capacity1;
        v = new int[capacity];
    }
//------------------------------------------------------------------------------------------------//

//------------------------------------------------METODOS-----------------------------------------//
    
    //PUSH BACK: Agrega un elemento x al final del vector. Si esta lleno, crea uno nuevo con los mismos valores y duplica el tamaño//
    
    void push_back(int x) {     
        if (size < capacity) {  //si el vector no esta lleno, inserta en el ultimo espacio
            v[size] = x;
            size++ ;
        } 
        else{                   //si esta lleno, crea un nuevo vector, pasa los valores e inserta 
            capacity*=2;
            int *v1 = new int[capacity];
            for (int i = 0; i < size; i++) {
                v1[i] = v[i];
            }
            v1[size] = x;
            size++;
            delete[] v; //Borra el vector antiguo
            v = v1;
        }
    }

    //INSERT: Agrega un elemento x en una posición i, corriendo los elementos desde la posición i hacia la derecha//
    
    bool insert_(int x, int i) {
        if (i < capacity && i >= 0){    //Si la posición es valida, inserta
            
            if(size==capacity){        //Si el vector esta lleno, crea un nuevo vector
                
                capacity*=2;
                int *v1 = new int[capacity];
                for (int i = 0; i < size; i++){    //Pasa los valores del viejo al nuevo
                    v1[i] = v[i];
                }
    
                delete[] v; //Borra el vector antiguo
                v = v1;
                
                for (int j = size; j > i; j--) {    //Inserta realizando el corrimiento
                    v[j] = v[j - 1];
                }
                v[i] = x;
                size++; //Aumentamos el tamaño 
                return true;
            }
            
            else{                               //Si no esta lleno, inserta realizando corrimiento
                for (int j = size; j > i; j--) {
                    v[j] = v[j - 1];
                }
                v[i] = x;
                size++; //Aumentamos el tamaño 
                return true;
            }
        }
        else{               //Si la posición no es valida, no hace nada
            return false;
        }
    }

    //REMOVE: Elimina el valor que este en la posición i, corriendo los demás valores a la izquierda para no dejar huecos//
    
    bool remove_(int i) {
        if (i < capacity && i >= 0) {   //Pone el valor de la derecha del que queremos eliminar 
            for (int j = i; j < size-1; j++) {
                v[j] = v[j + 1];
            }
            size--; //Quitamos del tamaño al elemento eliminado
            return true;
        }
        else {           //Si la posición no es valida, no hace nada
            return false;
        }
    }

    //GET: Retorna el valor de la posición i en el vector//
    
    int get(int i) {
        if(i<capacity && i >= 0){
        return v[i];
        }
        else{
            cout<<"Posición erronea";
        }
    }

    //SET: Inserta el valor x en la posición i sin realizar corrimiento//
    
    void set(int x, int i) {
        if (i < capacity && i >= 0) {
            v[i] = x;
        }
        else{
            cout<<"Posición erronea";
        }
    }
    
    //PRINT: Muestra los valores del vector//
    
    void print() {
        for (int i = 0; i <size; i++) {
            cout << v[i] << "\t";
        }
        cout<<endl;
    }
    
    //ATRIBUTOS: Muestra los atributos del vector//
    
    void atributos(){
        cout <<"La capacidad del vector es: " <<capacity<<endl;
        cout <<"la cantidad de elementos es: " <<size<<endl;
    } 
//------------------------------------------------------------------------------------------------//
};

int main(){
    Vector1 p = Vector1(1);
    p.atributos();
    
//------------------------------------------PRUEBA PUSH BACK--------------------------------------//
    
    cout<<"---------------------------------------------"<<endl;
    p.push_back(5);
    p.print();
    cout<<"---------------------------------------------"<<endl;
    p.atributos();
    cout<<"---------------------------------------------"<<endl;

    p.push_back(13);
    p.print();
    cout<<"---------------------------------------------"<<endl;
    p.atributos();
    cout<<"---------------------------------------------"<<endl;
    
//------------------------------------------------------------------------------------------------//

//-------------------------------------------PRUEBA INSERT----------------------------------------//
    
    p.insert_(7, 1);
    p.print();
    cout<<"---------------------------------------------"<<endl;
    p.atributos();
    cout<<"---------------------------------------------"<<endl;
    
    p.insert_(9, 2);
    p.print();
    cout<<"---------------------------------------------"<<endl;
    p.atributos();
    cout<<"---------------------------------------------"<<endl;
    
    p.insert_(11, 3);
    p.print();
    cout<<"---------------------------------------------"<<endl;
    p.atributos();
    cout<<"---------------------------------------------"<<endl;
    
    p.insert_(2, 2);
    p.print();
    cout<<"---------------------------------------------"<<endl;
    p.atributos();
    cout<<"---------------------------------------------"<<endl;

//------------------------------------------------------------------------------------------------//

//------------------------------------------PRUEBA REMOVE-----------------------------------------//
    
    p.remove_(2);
    p.print();
    cout<<"---------------------------------------------"<<endl;
    p.atributos();
    cout<<"---------------------------------------------"<<endl;

//------------------------------------------------------------------------------------------------//

//--------------------------------------------PRUEBA GET------------------------------------------//

    cout<<"La posición 2 tiene el valor: "<<p.get(2)<<endl;
    cout<<"---------------------------------------------"<<endl;
    
//------------------------------------------------------------------------------------------------//

//--------------------------------------------PRUEBA SET------------------------------------------//
    
    p.set(15, 0);
    p.print();
    cout<<"---------------------------------------------"<<endl;
    p.atributos();
    cout<<"---------------------------------------------"<<endl;

//------------------------------------------------------------------------------------------------//
    return 0;
}