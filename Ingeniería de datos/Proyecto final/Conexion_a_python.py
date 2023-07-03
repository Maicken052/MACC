'''
Consultas de las tablas de la base de datos.
PD: Se coloca el import psycopg2 en cada bloque de còdigo para que sea màs facil 
solo ejecutar una tabla a la vez y se puedan apreciar todos los datos.
'''

#PRODUCT
import psycopg2
try:
    connection = psycopg2.connect(
        host = 'localhost',
        user = 'postgres',
        password = '123456789',
        database = 'IOWA'
    )
    
    print("\n-------------------------------------------TABLA PRODUCT-------------------------------------------")
    cursor = connection.cursor()
    cursor.execute("select * from product")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
except Exception as ex:
    print(ex)
    
finally:
    connection.close()

#SELLS
import psycopg2
try:
    connection = psycopg2.connect(
        host = 'localhost',
        user = 'postgres',
        password = '123456789',
        database = 'IOWA'
    )
    
    print("\n-------------------------------------------TABLA SELLS-------------------------------------------")
    cursor = connection.cursor()
    cursor.execute("select * from sells")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
except Exception as ex:
    print(ex)
    
finally:
    connection.close()
    
#STORE
import psycopg2
try:
    connection = psycopg2.connect(
        host = 'localhost',
        user = 'postgres',
        password = '123456789',
        database = 'IOWA'
    )
    
    print("\n-------------------------------------------TABLA STORE-------------------------------------------")
    cursor = connection.cursor()
    cursor.execute("select * from store")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
except Exception as ex:
    print(ex)

finally:
    connection.close()
    
#VENDOR
import psycopg2
try:
    connection = psycopg2.connect(
        host = 'localhost',
        user = 'postgres',
        password = '123456789',
        database = 'IOWA'
    )
    
    print("\n-------------------------------------------TABLA VENDOR-------------------------------------------")
    cursor = connection.cursor()
    cursor.execute("select * from vendor")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
except Exception as ex:
    print(ex)

finally:
    connection.close()
    
#CATEGORY
import psycopg2
try:
    connection = psycopg2.connect(
        host = 'localhost',
        user = 'postgres',
        password = '123456789',
        database = 'IOWA'
    )
    
    print("\n------------------------------------------TABLA CATEGORY------------------------------------------")
    cursor = connection.cursor()
    cursor.execute("select * from category")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
except Exception as ex:
    print(ex)

finally:
    connection.close()
    
#CITY
import psycopg2
try:
    connection = psycopg2.connect(
        host = 'localhost',
        user = 'postgres',
        password = '123456789',
        database = 'IOWA'
    )
    
    print("\n--------------------------------------------TABLA CITY--------------------------------------------")
    cursor = connection.cursor()
    cursor.execute("select * from city")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
except Exception as ex:
    print(ex)

finally:
    connection.close()
    
#COUNTY
import psycopg2
try:
    connection = psycopg2.connect(
        host = 'localhost',
        user = 'postgres',
        password = '123456789',
        database = 'IOWA'
    )
    
    print("\n-------------------------------------------TABLA COUNTY-------------------------------------------")
    cursor = connection.cursor()
    cursor.execute("select * from county")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
except Exception as ex:
    print(ex)

finally:
    connection.close()
    
#PROVIDES
import psycopg2
try:
    connection = psycopg2.connect(
        host = 'localhost',
        user = 'postgres',
        password = '123456789',
        database = 'IOWA'
    )
    
    print("\n------------------------------------------TABLA PROVIDES------------------------------------------")
    cursor = connection.cursor()
    cursor.execute("select * from provides")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
except Exception as ex:
    print(ex)
    
finally:
    connection.close()
    
#ZIP_CODE
import psycopg2
try:
    connection = psycopg2.connect(
        host = 'localhost',
        user = 'postgres',
        password = '123456789',
        database = 'IOWA'
    )
    
    print("\n------------------------------------------TABLA ZIP_CODE------------------------------------------")
    cursor = connection.cursor()
    cursor.execute("select * from zip_code")
    rows = cursor.fetchall()
    for row in rows:
        print(row)
except Exception as ex:
    print(ex)
    
finally:
    connection.close()