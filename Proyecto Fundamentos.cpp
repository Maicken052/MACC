//----------------------LCD configuración----------------------//
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27,20,4);
#include <Servo.h>
#include <Keypad.h>
//----------------------Variables----------------------//
int Ang_servoCerrado = 0;   //Ángulo cerrado del servo (0 grados)
int Ang_servoAbierto = 90; //Ángulo abierto del servo (90 grados)   
int estado = 0;  //guarda en que ciclo va
int activar = 0;  //Corre el código ingresado y determina si esta bien o no, además reinicia al estado inicial
String clave;  //Variable para guardar los datos que se van ingresando
//----------------------Pins----------------------//
Servo myservo;
int bocina = 11;  //Pin para la bocina

//----------------------Definir funcionamiento del teclado----------------------//
const byte FIL = 4; //cuatro filas
const byte COL = 4; //cuatro columnas

char hexaKeys[FIL][COL] = {
 {'1','4','7','*'},
 {'2','5','8','0'},
 {'3','6','9','#'},
 {'A','B','C','D'}
 };
 
byte Pins_filas[FIL] = {5, 4, 3, 2}; //Conectar a los pines de las filas del teclado
byte Pins_columnas[COL] = {9, 8, 7, 6}; //Conectar a los pines de las columnas del teclado

Keypad Teclado = Keypad( makeKeymap(hexaKeys), Pins_filas, Pins_columnas, FIL, COL);  //Clase teclado
 
void setup(){
  myservo.attach(10); //ponemos el servo al pin D10
  pinMode(bocina,OUTPUT); 
  
  //Inicializar el LCD y escribir el texto de inicio
  lcd.init();
  lcd.backlight();
  lcd.setCursor(1,0);
  lcd.print("INGRESE CODIGO");
  lcd.setCursor(6,1);
  lcd.print("-***");
  
  //Ponemos el servo en la posición de cerrado al inicio
  myservo.write(Ang_servoCerrado);  
}

void loop(){ 
  /*
  Como funciona el Cofre:
  el usuario ingresa dígito por dígito su clave hasta completar los 4 espacios, si sigue agregando dígitos,
  el código será erroneo y lo devolverá a la pantallla inicial.
  Después de ingresar los dígitos solicitados, deberá presionar el botón "A" y se le mostrará si la clave es correcta,
  o en el caso contrario, será regresado a la pantalla inicial.
  Después de abrir el cofre, si quiere volver a bloquearlo, deberá presionar el botón "B".
  */
  char Tecla_presionada = Teclado.getKey(); //Esta función lee qué tecla hemos pulsado
  
  if(Tecla_presionada){  //En cada estado se muestra el número ingresado, y al final detecta si es correcto o no
    clave += String(Tecla_presionada);  //Se agrega la clave
    
    if(estado == 0){  
      lcd.clear(); 
      lcd.setCursor(1,0);
      lcd.print("INGRESE CODIGO");
      lcd.setCursor(6,1);
      lcd.print(clave);
      lcd.setCursor(7,1);
      lcd.print("-**");
    }
   
    if(estado == 1){  
      lcd.clear(); 
      lcd.setCursor(1,0);
      lcd.print("INGRESE CODIGO");
      lcd.setCursor(6,1);
      lcd.print(clave);
      lcd.setCursor(8,1);
      lcd.print("-*");
    }
   
    if(estado == 2){  
      lcd.clear(); 
      lcd.setCursor(1,0);
      lcd.print("INGRESE CODIGO");
      lcd.setCursor(6,1);
      lcd.print(clave);
      lcd.setCursor(9,1);
      lcd.print("-");
    }
   
    if(estado == 3){  
      lcd.clear(); 
      lcd.setCursor(1,0);
      lcd.print("INGRESE CODIGO");
      lcd.setCursor(6,1);
      lcd.print(clave);
    }
   
    if(estado == 4){
      activar = 1;
    }
    
    estado = estado+1;
  }
  
  if(activar == 1){
    //Si se quiere cambiar la clave, se deben cambiar los 4 números.
    if(clave == "1207A"){  //Si la clave esta bien, muestra el mensaje de bienvenida, y queda el cofre abierto
      myservo.write(Ang_servoAbierto);
      activar = 2;
      
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("CODIGO  CORRECTO");
      
      analogWrite(bocina,240);
      delay(250);
      analogWrite(bocina,200);
      delay(250);
      analogWrite(bocina,180);
      delay(250);
      analogWrite(bocina,250);
      delay(250);
      analogWrite(bocina,LOW);
      delay(1500);
      
      lcd.clear();    
      lcd.setCursor(3,0);
      lcd.print("BIENVENIDO");
      delay(1500); 
      
      lcd.clear();   
      lcd.setCursor(1,0);
      lcd.print("COFRE  ABIERTO");
    }else{  //Si no, se deja el cofre cerrado, se indica que el código esta mal y se reinicia a la pantalla inicial
      lcd.clear();    
      lcd.setCursor(1,0);
      lcd.print("CODIGO ERRONEO");
      lcd.setCursor(1,1);
      lcd.print("COFRE  CERRADO");
      analogWrite(bocina,150);
      delay(2500);
      analogWrite(bocina,LOW);
      
      estado = 0;
      activar = 0;
      clave = "";
      
      lcd.clear();    
      lcd.setCursor(1,0);
      lcd.print("INGRESE CODIGO");
      lcd.setCursor(6,1);
      lcd.print("-***");  
    }
  }
 
  if(activar == 2){
    if(Tecla_presionada == 'B'){  //Si se quiere bloquear el cofre y reiniciar a la pantalla inicial
      myservo.write(Ang_servoCerrado);
      
      activar = 0;
      estado = 0;
      clave = ""; 
        
      lcd.clear();    
      lcd.setCursor(4,0);
      lcd.print("BLOQUEADO");
      analogWrite(bocina,150);
      delay(1000);
      analogWrite(bocina,LOW);
      
      lcd.clear();
      lcd.setCursor(1,0);
      lcd.print("INGRESE CODIGO");
      lcd.setCursor(6,1);
      lcd.print("-***");
    }
  } 
}
