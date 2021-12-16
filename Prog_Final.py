from tkinter import *
import time as tm
import threading as th
import serial
import random

arduino = serial.Serial('/dev/ttyS2', 9600)
tm.sleep(2)

#global con
con = 0
con1 = 0
con2 = 0
con3 = 0
conr = 0
conr1 = 0
conr2 = 0
tot = 0

def recibe():
    global tot
    while True:
        
        if arduino.inWaiting == 0:
            continue
        
        else:
            
            if arduino.read() == b'y':
                print("Cerrando comunicacion, termine el programa...")
                total()
                arduino.close()
                break
            
            else:
                cad = arduino.readline().decode()
                esp = cad.index("\r") #posicion del enter
                print("Cadena:", cad[:esp])
                #print("Long:", len(cad[:esp]))
                imprime(cad[:esp])
                
            tm.sleep(0.5)
       
       
def envia():
    arduino.write('e'.encode())
    print("Entrando en estado de error")
    for i in range(5):
        tm.sleep(0.5)


def total():
    global tot
    tot_pas.config(text=str(tot))
    

def inicia():
    print("Iniciando...")
    t = th.Thread(target=recibe)
    t.start()


def imprime(sem):
    global con, conr, conr1, conr2, con1, con2, con3, tot
    if sem == 'v1':
        
        verde1.config(text="Semaforo1")
        conr1 = random.randint(0,con1)
        tot += conr1
        print("TOTALLL: ", tot)
        con1 -= conr1
        
        verde2.config(text="Semaforo2")
        conr2 = random.randint(0,con2)
        tot += conr2
        print("TOTALLL: ", tot)
        con2 -= conr2
        
        rojo1.config(text="Semaforo3")
        rojo2.config(text="")
        
        ama1.config(text="")
        ama2.config(text="")
        
        
        """print(" Pasaron ",con," carros de los que habia en sem3")
        carros3.config(text=str(con3))
        carros_pas3.config(text=str(con))"""
        
        
    elif sem == "vuel":
        
        verde1.config(text="Semaforo1")
        conr1 = random.randint(0,con1)
        tot += conr1
        con1 -= con
        
        verde2.config(text="")
        
        rojo1.config(text="Semaforo2")
        rojo2.config(text="Semaforo3")

        ama1.config(text="")
        ama2.config(text="")
        
        print(" Pasaron ",conr," carros de los que habia en sem3")
        carros3.config(text=str(con3))
        carros_pas3.config(text=str(conr))
        total()
        print("Total:", conr)
        
    elif sem == "v2":
        total()
        verde1.config(text="Semaforo3")
        verde2.config(text="")
        
        conr = 0;
        conr = random.randint(0,con3) #Variable aleatoria
        tot += conr
        print("TOTALLL: ", tot)
        con3 -= conr
        
        rojo1.config(text="Semaforo1")
        rojo2.config(text="Semaforo2")
        
        ama1.config(text="")
        ama2.config(text="")
        
        
        print(" Pasaron ",conr1," carros de los que habia en sem1")
        carros1.config(text=str(con1))
        carros_pas1.config(text=str(conr1))
        
        
        print(" Pasaron ",conr2," carros de los que habia en sem2")
        carros2.config(text=str(con2))
        carros_pas2.config(text=str(conr2))
    
    elif sem == "a2":
        verde1.config(text="")
        verde2.config(text="")
        
        ama1.config(text="Semaforo1")
        ama2.config(text="Semaforo2")
    
    elif sem == "a3":
        verde1.config(text="")
        verde2.config(text="")
        
        ama1.config(text="Semaforo3")
        ama2.config(text="")
        
    elif sem == "c1":
        
        #con = random.randint(1,5)
        con1 += 1
        #print(" Random:",con1)
        carros1.config(text=str(con1))
        
    elif sem == "c2":
        
        #con = random.randint(1,5)
        con2 += 1
        #print("  Random:",con2)
        carros2.config(text=str(con2))
        
    elif sem == "c3":
        
        #con = random.randint(1,5)
        con3 += 1
        #print("   Random:",con3)
        carros3.config(text=str(con3))
    
    #total()
    
def cierra():
    arduino.close()
    print("Adios!")
    raiz.destroy()
    
 
#Creacion de la interfaz grafica de usuario 
raiz = Tk()
raiz.title("Control de tráfico")
raiz.resizable(True, False)
raiz.geometry("650x240")

cerrar = Button(raiz, text="Cierra", command=cierra)
cerrar.place(x=0, y=0)

bot = Button(raiz, text="Inicia", command=inicia)
bot.place(x=30, y=50)

bot2 = Button(raiz, text="Error", command=envia)
bot2.place(x=30, y=80)

#Colores de los semaforos
lab1 = Label(raiz, text="Semaforos en verde", background='lightgreen',
            border=1)
lab1.place(x=110, y=50)

lab1 = Label(raiz, text="Semaforos en amarillo", background='lightyellow',
            border=1)
lab1.place(x=250, y=50)

lab1 = Label(raiz, text="Semaforos en rojo", background='red',
            border=1)
lab1.place(x=406, y=50)

lab1 = Label(raiz, text="Carros esperando", border=1)
lab1.place(x=20, y=120)

lab1 = Label(raiz, text="Semaforo 1:", border=1)
lab1.place(x=30, y=145)

lab1 = Label(raiz, text="Semaforo 2:", border=1)
lab1.place(x=30, y=165)

lab1 = Label(raiz, text="Semaforo 3:", border=1)
lab1.place(x=30, y=185)


lab1 = Label(raiz, text="Carros que pasaron", border=1)
lab1.place(x=235, y=120)

lab1 = Label(raiz, text="Semaforo 1:", border=1)
lab1.place(x=250, y=145)

lab1 = Label(raiz, text="Semaforo 2:", border=1)
lab1.place(x=250, y=165)

lab1 = Label(raiz, text="Semaforo 3:", border=1)
lab1.place(x=250, y=185)


carros1 = Label(raiz, text=str(con1))
carros1.place(x=120, y=145)

carros2 = Label(raiz, text=str(con2))
carros2.place(x=120, y=165)

carros3 = Label(raiz, text=str(con3))
carros3.place(x=120, y=185)


carros_pas1 = Label(raiz, text="0")
carros_pas1.place(x=340, y=145)

carros_pas2 = Label(raiz, text="0")
carros_pas2.place(x=340, y=165)

carros_pas3 = Label(raiz, text="0")
carros_pas3.place(x=340, y=185)


lab1 = Label(raiz, text="Total de carros:", border=1)
lab1.place(x=415, y=185)

tot_pas = Label(raiz, text="0")
tot_pas.place(x=530, y=185)


#Etiquetas de los semaforos que cambian
verde1 = Label(raiz, text="")
verde1.place(x=125, y=73)
verde2 = Label(raiz, text="")
verde2.place(x=125, y=88)

ama1 = Label(raiz, text="")
ama1.place(x=270, y=73)
ama2 = Label(raiz, text="")
ama2.place(x=270, y=88)

rojo1 = Label(raiz, text="")
rojo1.place(x=425, y=73)
rojo2 = Label(raiz, text="")
rojo2.place(x=425, y=88)
raiz.mainloop()