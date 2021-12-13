from tkinter import *
import time as tm
import threading as th
import serial

arduino = serial.Serial('/dev/ttyS1', 9600)
tm.sleep(1)

global con
con = 0

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
    
    if sem == 'v1':
        
        verde1.config(text="Semaforo1")
        verde2.config(text="Semaforo2")
        
        rojo1.config(text="Semaforo3")
        rojo2.config(text="")
        
    elif sem == "vuelta":
        
        verde1.config(text="Semaforo1")
        verde2.config(text="")
        
        rojo1.config(text="Semaforo2")
        rojo2.config(text="Semaforo3")
        
    elif sem == "v2":
        verde1.config(text="Semaforo3")
        verde2.config(text="")
        
        rojo1.config(text="Semaforo1")
        rojo2.config(text="Semaforo2")
        
    else:
        carros1.config(text=str(sem))
        
        

raiz = Tk()
raiz.title("Control de tráfico")
raiz.resizable(True, False)
raiz.geometry("650x200")

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

lab1 = Label(raiz, text="Carros", border=1)
lab1.place(x=145, y=120)

carros1 = Label(raiz, text="")
carros1.place(x=160, y=135)


#Etiquetas de los semaforos que cambian
verde1 = Label(raiz, text="")
verde1.place(x=120, y=73)
verde2 = Label(raiz, text="")
verde2.place(x=120, y=88)

ama1 = Label(raiz, text="")
ama1.place(x=265, y=73)
ama2 = Label(raiz, text="")
ama2.place(x=265, y=88)

rojo1 = Label(raiz, text="")
rojo1.place(x=420, y=73)
rojo2 = Label(raiz, text="")
rojo2.place(x=420, y=88)
raiz.mainloop()