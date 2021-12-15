from tkinter import *
import time as tm
import threading as th
import serial
import random

arduino = serial.Serial('/dev/ttyS1', 9600)
tm.sleep(1)

#global con
con1 = 0
con2 = 0
con3 = 0

def recibe():
    while True:
        if arduino.inWaiting == 0:
            continue
        else:
            if arduino.read() == b'y':
                print("Cerrando comunicacion, termine el programa...")
                arduino.close()
                break
            else:
                cad = arduino.readline().decode()
                esp = cad.index("\r") #posicion del enter
                print("Cadena:", cad[:esp])
                print("Long:", len(cad[:esp]))
                imprime(cad[:esp])
            tm.sleep(0.5)
            
def envia():
    arduino.write('e'.encode())

def inicia():
    print("Iniciando...")
    t = th.Thread(target=recibe)
    t.start()

def imprime(sem):
    global con1, con2, con3
    if sem == 'v1':
        
        verde1.config(text="Semaforo1")
        verde2.config(text="Semaforo2")
        
        rojo1.config(text="Semaforo3")
        rojo2.config(text="")
        
        con = random.randint(0,con1)
        con1 -= con
        print(" Pasaron ",con," carros de los que habia en con1")
        carros1.config(text=str(con1))
        
        con = random.randint(0,con2)
        con2 -= con
        print(" Pasaron ",con," carros de los que habia en con2")
        carros2.config(text=str(con2))
        
    elif sem == "vuel":
        
        verde1.config(text="Semaforo1")
        verde2.config(text="")
        
        rojo1.config(text="Semaforo2")
        rojo2.config(text="Semaforo3")
        
    elif sem == "v2":
        verde1.config(text="Semaforo3")
        verde2.config(text="")
        
        rojo1.config(text="Semaforo1")
        rojo2.config(text="Semaforo2")
        
        con = random.randint(0,con3)
        con3 -= con
        print(" Pasaron ",con," carros de los que habia en con3")
        carros3.config(text=str(con3))
        
    elif sem == "c1":
        con = random.randint(1,5)
        con1 += con
        print(" Random:",con)
        carros1.config(text=str(con1))
    elif sem == "c2":
        con = random.randint(1,5)
        con2 += con
        print("  Random:",con2)
        carros2.config(text=str(con2))
    elif sem == "c3":
        con = random.randint(1,5)
        con3 += con
        print("   Random:",con3)
        carros3.config(text=str(con3))
    
def cierra():
    arduino.close()
    print("Adios!")
    raiz.destroy()
    
    
raiz = Tk()
raiz.title("Control de tráfico")
raiz.resizable(True, False)
raiz.geometry("650x200")

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

lab1 = Label(raiz, text="Carros transcurriendo", border=1)
lab1.place(x=233, y=120)

lab1 = Label(raiz, text="Semaforo 1", border=1)
lab1.place(x=145, y=145)

lab1 = Label(raiz, text="Semaforo 2", border=1)
lab1.place(x=265, y=145)

lab1 = Label(raiz, text="Semaforo 3", border=1)
lab1.place(x=385, y=145)

carros1 = Label(raiz, text="5")
carros1.place(x=180, y=165)

carros2 = Label(raiz, text="5")
carros2.place(x=305, y=165)

carros3 = Label(raiz, text="5")
carros3.place(x=420, y=165)


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