import hashlib
import time

'''PUNTO 1, ALFABETO 2'''
alfabeto1 = 'abcdefghijkmlnopqrstuvwxyzABCDEFGHIJKMLNOPQRSTUVWXYZ'
clave_cifrada = '7340bc20b836b0f58950f3f283ca1095'

inicio = time.time()
for i in alfabeto1:
    for j in alfabeto1:
        for k in alfabeto1:
            posible_clave = i+j+k
            posible_clave_cifrada = hashlib.md5(posible_clave.encode())
            if(posible_clave_cifrada.hexdigest() == clave_cifrada):
                fin = time.time()
                tiempo_transcurrido = fin - inicio
                print(f'La clave descifrada para el alfabeto 1 es: {posible_clave}\nEl tiempo necesario para hallarla fue: {tiempo_transcurrido} segundos,\ny la plataforma usada fue windows 11.\n')
                break

'''PUNTO 1, ALFABETO 3'''
alfabeto2 = 'abcdefghijkmlnopqrstuvwxyzABCDEFGHIJKMLNOPQRSTUVWXYZ:.;,_+<>¡!?¿=()/#%'
clave_cifrada = 'e669bbc82ac143ca1e65bbb6efbfafcd'

inicio = time.time()
for i in alfabeto2:
    for j in alfabeto2:
        for k in alfabeto2:
            posible_clave = i+j+k
            posible_clave_cifrada = hashlib.md5(posible_clave.encode())
            if(posible_clave_cifrada.hexdigest() == clave_cifrada):
                fin = time.time()
                tiempo_transcurrido = fin - inicio
                print(f'La clave descifrada para el alfabeto 2 es: {posible_clave}\nEl tiempo necesario para hallarla fue: {tiempo_transcurrido} segundos,\ny la plataforma usada fue windows 11.\n')
                break

'''PUNTO 1, ALFABETO 4'''
alfabeto3 = 'abcdefghijkmlnopqrstuvwxyzABCDEFGHIJKMLNOPQRSTUVWXYZ:.;,_+<>¡!?¿=()/#%0123456789'
clave_cifrada = 'c5a98bd3852e48cfd5ee80e6dd430fef'

inicio = time.time()
for i in alfabeto3:
    for j in alfabeto3:
        for k in alfabeto3:
            posible_clave = i+j+k
            posible_clave_cifrada = hashlib.md5(posible_clave.encode())
            if(posible_clave_cifrada.hexdigest() == clave_cifrada):
                fin = time.time()
                tiempo_transcurrido = fin - inicio
                print(f'La clave descifrada para el alfabeto 3 es: {posible_clave}\nEl tiempo necesario para hallarla fue: {tiempo_transcurrido} segundos,\ny la plataforma usada fue windows 11.\n')
                break

'''PUNTO 2: Ataque de diccionario'''
#Abrimos el archivo passwords.txt y lo leemos linea por linea, luego cerramos el archivo.
passwords_txt = open('D:/UNIVERSIDAD/passwords2.txt', 'r')
passwords = passwords_txt.readlines()
passwords_txt.close()
clave_cifrada = '7725514963d53fef995456238363195a'

for password in passwords:
    password = password.strip()
    password_hashed = hashlib.md5(password.encode())
    if(password_hashed.hexdigest() == clave_cifrada):
        print(f'La clave descifrada es: {password}, por tanto decimos que el ataque de diccionario fue exitoso.')
        break