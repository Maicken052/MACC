//----------------------LCD configuración----------------------//
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27,20,4);
#include <Servo.h>
#include <Keypad.h>
//----------------------Variables----------------------//
int mot_min = 0;   //Ángulo mínimo del servo
int mot_max = 90; //Ángulo máximo del servo   
int character = 0;
int activated = 0;
String clave; 
//----------------------Pins----------------------//
Servo myservo;
int buzzer = 11;  //Pin para la bocina

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

Keypad Teclado = Keypad( makeKeymap(hexaKeys), Pins_filas, Pins_columnas, FIL, COL);
 
void setup(){
  myservo.attach(10); //ponemos el servo al pin D10
  pinMode(buzzer,OUTPUT); 
  
  //Inicializar el LCD y escribir el texto de inicio
  lcd.init();
  lcd.backlight();
  lcd.setCursor(1,0);
  lcd.print("INGRESE CODIGO");
  lcd.setCursor(6,1);
  lcd.print("-***");
  
  //Ponemos el servo en la posición de cerrado al inicio
  myservo.write(mot_min);  
}

void loop(){ 
  char Tecla_presionada = Teclado.getKey(); //Esta función lee qué tecla hemos pulsado
  
  if(Tecla_presionada){
    clave += String(Tecla_presionada);
    
    if(character == 0){  
      lcd.clear(); 
      lcd.setCursor(1,0);
      lcd.print("INGRESE CODIGO");
      lcd.setCursor(6,1);
      lcd.print(clave);
      lcd.setCursor(7,1);
      lcd.print("-**");
    }
   
    if(character == 1){  
      lcd.clear(); 
      lcd.setCursor(1,0);
      lcd.print("INGRESE CODIGO");
      lcd.setCursor(6,1);
      lcd.print(clave);
      lcd.setCursor(8,1);
      lcd.print("-*");
    }
   
    if(character == 2){  
      lcd.clear(); 
      lcd.setCursor(1,0);
      lcd.print("INGRESE CODIGO");
      lcd.setCursor(6,1);
      lcd.print(clave);
      lcd.setCursor(9,1);
      lcd.print("-");
    }
   
    if(character == 3){  
      lcd.clear(); 
      lcd.setCursor(1,0);
      lcd.print("INGRESE CODIGO");
      lcd.setCursor(6,1);
      lcd.print(clave);
    }
   
    if(character == 4){
      activated = 1;
    }
    character = character+1;
  }
  
  if(activated == 1){
    if(clave == "1207A" && character == 5){
      myservo.write(mot_max);
      activated = 2;
      
      lcd.clear();
      lcd.setCursor(0,0);
      lcd.print("CODIGO  CORRECTO");
      
      analogWrite(buzzer,240);
      delay(250);
      analogWrite(buzzer,200);
      delay(250);
      analogWrite(buzzer,180);
      delay(250);
      analogWrite(buzzer,250);
      delay(250);
      analogWrite(buzzer,LOW);
      delay(2000);
      
      lcd.clear();    
      lcd.setCursor(3,0);
      lcd.print("BIENVENIDO");
      delay(2000); 
      
      lcd.clear();   
      lcd.setCursor(1,0);
      lcd.print("COFRE  ABIERTO");
    }else{
      lcd.clear();    
      lcd.setCursor(1,0);
      lcd.print("CODIGO ERRONEO");
      lcd.setCursor(1,1);
      lcd.print("COFRE  CERRADO");
      analogWrite(buzzer,150);
      delay(3000);
      analogWrite(buzzer,LOW);
      
      character = 0;
      activated = 0;
      
      lcd.clear();    
      lcd.setCursor(1,0);
      lcd.print("INGRESE CODIGO");
      lcd.setCursor(6,1);
      lcd.print("-***");
      clave = "";  
    }
  }
 
  if(activated == 2){
    if(Tecla_presionada == 'B'){
      myservo.write(mot_min);
      activated = 0;
      character = 0;
      clave = "";   
      lcd.clear();    
      lcd.setCursor(1,0);
      lcd.print("INGRESE CODIGO");
      lcd.setCursor(6,1);
      lcd.print("-***");
    }
  } 
}
