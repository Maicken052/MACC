//----------------------Librerias----------------------//
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27,20,4);
#include <Servo.h>
#include <Keypad.h>
//-------------------Notas musicales-------------------//
#define NOTE_C5  523
#define NOTE_D5  587
#define NOTE_E5  659
#define NOTE_F5  698
#define NOTE_G5  784
#define NOTE_A5  880
#define NOTE_AS5 932
#define NOTE_B5  988
//----------------------Variables----------------------//
int Ang_servoCerrado = 0;   //Ángulo cerrado del servo (0 grados)
int Ang_servoAbierto = 90; //Ángulo abierto del servo (90 grados)   
int estado = 0;  //guarda en que ciclo va
int activar = 0;  //Corre el código ingresado y determina si esta bien o no, además reinicia al estado inicial
String clave;  //Variable para guardar los datos que se van ingresando

//Especificas de la música
int tempo = 200;
int melody[] = {
  NOTE_C5,4, 
  NOTE_F5,4, NOTE_F5,8, NOTE_G5,8, NOTE_F5,8, NOTE_E5,8,
  NOTE_D5,4, NOTE_D5,4, NOTE_D5,4,
  NOTE_G5,4, NOTE_G5,8, NOTE_A5,8, NOTE_G5,8, NOTE_F5,8,
  NOTE_E5,4, NOTE_C5,4, NOTE_C5,4,
  NOTE_A5,4, NOTE_A5,8, NOTE_AS5,8, NOTE_A5,8, NOTE_G5,8,
  NOTE_F5,4, NOTE_D5,4, NOTE_C5,8, NOTE_C5,8,
  NOTE_D5,4, NOTE_G5,4, NOTE_E5,4,
  NOTE_F5,2, 
};
int notes = sizeof(melody) / sizeof(melody[0]) / 2;
int wholenote = (60000 * 4) / tempo;
int divider = 0, noteDuration = 0;
//-------------------------Pins-------------------------//
Servo myservo;
int bocina = 11;  //Pin para la bocina

//----------Definir funcionamiento del teclado----------//
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

//-------------------Pantalla Inicial-------------------//
void Pantalla_inicial(){
  lcd.clear(); 
  lcd.setCursor(0,0);
  lcd.print("INGRESE SU CLAVE");
  lcd.setCursor(6,1);
  lcd.print("-***");
}

//------------------Desbloqueo de cofre------------------//
void unlocked(){
  for(int thisNote = 0; thisNote < notes * 2; thisNote = thisNote + 2){
      divider = melody[thisNote + 1];
      if(divider > 0){
        noteDuration = (wholenote) / divider;
      }else if(divider < 0){
        noteDuration = (wholenote) / abs(divider);
        noteDuration *= 1.5; 
      }
      tone(bocina, melody[thisNote], noteDuration * 0.9);
      delay(noteDuration);
      noTone(bocina);
      
      if(thisNote == 0){
        lcd.clear();
        lcd.setCursor(1,0);
        lcd.print("Clave Correcta");
      }
      
      if(thisNote == 16){
        lcd.clear();    
        lcd.setCursor(0,0);
        lcd.print("Acceso Permitido");
      }

      if(thisNote == 30){
        lcd.clear();   
        lcd.setCursor(1,0);
        lcd.print("Cofre Abierto!");
        lcd.setCursor(6,1);
        lcd.print(":D");
      }
  }
}

//----------------------Estados----------------------//
void estado_0(){
  lcd.clear(); 
  lcd.setCursor(0,0);
  lcd.print("INGRESE SU CLAVE");
  lcd.setCursor(6,1);
  lcd.print(clave);
  lcd.setCursor(7,1);
  lcd.print("-**");
  analogWrite(bocina,50);
  delay(150);
  analogWrite(bocina,LOW);
}

void estado_1(){
  lcd.clear(); 
  lcd.setCursor(0,0);
  lcd.print("INGRESE SU CLAVE");
  lcd.setCursor(6,1);
  lcd.print(clave);
  lcd.setCursor(8,1);
  lcd.print("-*");
  analogWrite(bocina,50);
  delay(150);
  analogWrite(bocina,LOW);
}

void estado_2(){
  lcd.clear(); 
  lcd.setCursor(0,0);
  lcd.print("INGRESE SU CLAVE");
  lcd.setCursor(6,1);
  lcd.print(clave);
  lcd.setCursor(9,1);
  lcd.print("-");
  analogWrite(bocina,50);
  delay(150);
  analogWrite(bocina,LOW);
}

void estado_3(){
  lcd.clear(); 
  lcd.setCursor(0,0);
  lcd.print("INGRESE SU CLAVE");
  lcd.setCursor(6,1);
  lcd.print(clave);
  analogWrite(bocina,50);
  delay(150);
  analogWrite(bocina,LOW);
}

void setup(){
  myservo.attach(10); //ponemos el servo al pin D10
  pinMode(bocina,OUTPUT); 
  
  //Inicializar el LCD y escribe el texto de inicio
  lcd.init();
  lcd.backlight();
  Pantalla_inicial();
  
  //Ponemos el servo en la posición de cerrado al inicio
  myservo.write(Ang_servoCerrado);  
}

void loop(){ 
  /*
  Como funciona el Cofre:
  el usuario ingresa dígito por dígito su clave hasta completar los 4 espacios(si colocó algo mal, puede corregir 
  con la letra reservada "C". Si sigue agregando dígitos,
  el código será erroneo y lo devolverá a la pantallla inicial.
  Después de ingresar los dígitos solicitados, deberá presionar el botón "A" y se le mostrará si la clave es correcta,
  o en el caso contrario, será regresado a la pantalla inicial.
  Después de abrir el cofre, si quiere volver a bloquearlo, deberá presionar el botón "B".
  */
  
  char Tecla_presionada = Teclado.getKey(); //Esta función lee qué tecla hemos pulsado
  
  if(Tecla_presionada){  //En cada estado se muestra el número ingresado, y al final detecta si es correcto o no
    
    if(estado == 0){ 
      if(Tecla_presionada == 'C'){
        estado = estado - 1;
      }else{
         clave += String(Tecla_presionada);
         estado_0();
      }
    }
   
    if(estado == 1){  
      if(Tecla_presionada == 'C'){
        estado = estado - 2;
        clave = "";
        Pantalla_inicial();
        analogWrite(bocina,50);
        delay(150);
        analogWrite(bocina,LOW);
      }else{
        clave += String(Tecla_presionada);
        estado_1();
      }
    }
   
    if(estado == 2){  
      if(Tecla_presionada == 'C'){
        estado = estado -2;
        clave.remove(1);
        estado_0();
      }else{
        clave += String(Tecla_presionada);
        estado_2();
      }
    }
   
   
    if(estado == 3){  
      if(Tecla_presionada == 'C'){
        estado = estado - 2;
        clave.remove(2);
        estado_1();
      }else{
        clave += String(Tecla_presionada);
        estado_3();
      }
    }
   
    if(estado == 4){
       if(Tecla_presionada == 'C'){
        estado = estado - 2;
        clave.remove(3);
        estado_2();
      }else{
        clave += String(Tecla_presionada);
        activar = 1;
      }
    }
    
    estado = estado+1;
  }
  
  if(activar == 1){
    //Si se quiere cambiar la clave, se deben cambiar los 4 números. 
            
    if(clave == "1207A"){  //Si la clave esta bien, muestra el mensaje de bienvenida, y queda el cofre abierto
      myservo.write(Ang_servoAbierto);
      activar = 2;
      unlocked();
      
    }else{  //Si no, se deja el cofre cerrado, se indica que el código esta mal y se reinicia a la pantalla inicial
      lcd.clear();    
      lcd.setCursor(0,0);
      lcd.print("Clave Incorrecta");
      
      for(int i = 100; i < 250; i++){
        analogWrite(bocina,i);
        delay(10);
      }
      analogWrite(bocina,LOW);
      
      estado = 0;
      activar = 0;
      clave = "";
      Pantalla_inicial();  
    }
  }
 
  if(activar == 2){
    if(Tecla_presionada == 'B'){  //Si se quiere bloquear el cofre y reiniciar a la pantalla inicial
      myservo.write(Ang_servoCerrado);
      
      activar = 0;
      estado = 0;
      clave = ""; 
        
      lcd.clear();    
      lcd.setCursor(3,0);
      lcd.print("BLOQUEADO");
      analogWrite(bocina,150);
      delay(1500);
      analogWrite(bocina,LOW);
      
      Pantalla_inicial();
    }
  } 
}