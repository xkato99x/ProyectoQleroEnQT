    ldi R31,0b00000000		    ;R31 se va a usar para el pseudo
    ldi r16,0b00011100		    ;R16 carga los pines 0 y 1 como entrada y los dem�s como salida en el puerto D
    out ddrd,r16		    ;Mandamos las se�ales al puerto D
    ldi r16,0xff		    ;R16 carga todos los pines como salida
    out ddrb,r16
    
    ldi r16,0b00000100		    ;r16 es para mandar voltaje a los pines 2,3,4
    out pind,r16
boton_inicio:
    call pseudo
    sbic pind,0			    ;Salta la sig. instrucci�n si el bit de la pos. 0 est� apagado (0), osea, el bot�n no se aprieta
    rjmp suelta_inicio		    ;Si se presion� el bot�n, salta a suelta_1
    rjmp boton_inicio		    ;Si no se presion� el bot�n, se cicla
    
suelta_inicio:
    call pseudo
    sbis pind,0			    ;Salta la sig. instrucci�n si el bit de la pos. 0 est� encendido (1), osea, se dej� de presionar
    rjmp led_inicio		    ;Al dejar de presionar el bot�n, salta a led_inicio
    rjmp suelta_inicio		    ;Si no se suelta el bot�n, se cicla
    
led_inicio:
    call delay
    ldi r16,0b00000000		    ;Reinicia el registro r16
    out pind,r16		    ;Apaga el puerto D
    ldi r16,0b00010000		    ;Enciende el 5to bit del octeto
    out pinb,r16		    ;Manda la se�al encendida del 5to bit
    call delay
    call delay
    ldi r16,0x00		    ;Reinicia el registro r16
    out portb,r16
    call delay
    
random:
    cpi r31,0b00000000
    breq azul
    
    cpi r31,0b00000001
    breq verde
    
    cpi r31,0b00000010
    breq rojo
    
    cpi r31,0b00000011
    breq amarillo

azul:
    ldi r16,0b00000001
    out portb,r16
    call delay
    call delay
    call memoria
    rjmp start
    
verde:
    ldi r16,0b00000010
    out portb,r16
    call delay
    call delay
    call memoria
    rjmp start
    
rojo:
    ldi r16,0b00000100
    out portb,r16
    call delay
    call delay
    call memoria
    rjmp start
    
amarillo:
    ldi r16,0b00001000
    out portb,r16
    call delay
    call delay
    call memoria
    rjmp start    
    
memoria:
    cpi r29,0
    breq guarda_1
    
    cpi r28,0
    breq guarda_2
    
    cpi r27,0
    breq guarda_3
    
    cpi r26,0
    breq guarda_4
    
    cpi r25,0
    breq guarda_5
    
    ret
    
guarda_1:   ;Funci�n para guardar el primer puntaje, se usar� el registro r29
    sbic pinb,1
    ldi r29,0b00000001		    ;Memoria = Azul
    
    sbic pinb,2
    ldi r29,0b00000010		    ;Memoria = Verde
    
    sbic pinb,3
    ldi r29,0b00000011		    ;Memoria = Rojo
    
    sbic pinb,4
    ldi r29,0b00000100		    ;Memoria = Amarillo
    
    rjmp apagar_PuertoB
    
guarda_2:   ;Funci�n para guardar el segundo puntaje, se usar� el registro r28
    sbic pinb,1
    ldi r28,0b00000001		    ;Memoria = Azul
    
    sbic pinb,2
    ldi r28,0b00000010		    ;Memoria = Verde
    
    sbic pinb,3
    ldi r28,0b00000011		    ;Memoria = Rojo
    
    sbic pinb,4
    ldi r28,0b00000100		    ;Memoria = Amarillo
    
    rjmp apagar_PuertoB
    
guarda_3:   ;Funci�n para guardar el tercer puntaje, se usar� el registro r27
    sbic pinb,1
    ldi r27,0b00000001		    ;Memoria = Azul
    
    sbic pinb,2
    ldi r27,0b00000010		    ;Memoria = Verde
    
    sbic pinb,3
    ldi r27,0b00000011		    ;Memoria = Rojo
    
    sbic pinb,4
    ldi r27,0b00000100		    ;Memoria = Amarillo
    
    rjmp apagar_PuertoB
    
guarda_4:   ;Funci�n para guardar el cuarto puntaje, se usar� el registro r26
    sbic pinb,1
    ldi r26,0b00000001		    ;Memoria = Azul
    
    sbic pinb,2
    ldi r26,0b00000010		    ;Memoria = Verde
    
    sbic pinb,3
    ldi r26,0b00000011		    ;Memoria = Rojo
    
    sbic pinb,4
    ldi r26,0b00000100		    ;Memoria = Amarillo
    
    rjmp apagar_PuertoB
    
guarda_5:   ;Funci�n para guardar el quinto y �ltimo puntaje, se usar� el registro r25
    sbic pinb,1
    ldi r25,0b00000001		    ;Memoria = Azul
    
    sbic pinb,2
    ldi r25,0b00000010		    ;Memoria = Verde
    
    sbic pinb,3
    ldi r25,0b00000011		    ;Memoria = Rojo
    
    sbic pinb,4
    ldi r25,0b00000100		    ;Memoria = Amarillo
    
    rjmp apagar_PuertoB
    
apagar_PuertoB:
    ldi r16,0b00000000
    out portb,r16
    
start:
    in r16,pind ;Recibe todo el puerto D
    
    ;cpi r16,0b00001001	;compara lo que vale r16 con el bot�n azul
    ;breq azul
    
    ;cpi r16,0b00001010	;compara lo que vale r16 con 1
    ;breq verde
    
    ;cpi r16,0b00010000	;compara lo que vale r16 con 2
    ;breq rojo
    
    ;cpi r16,0b00010010	;compara lo que vale r16 con 3
    ;breq amarillo
    
    ;call pseudo
    rjmp start
    

pseudo:
    inc r31
    cpi r31,4
    breq pseu2
    ret
    
pseu2:
    ldi r31,00
    ret

delay:			;Inicio de la subrutina DELAY
    ldi r17,0x02	;Carga a R18 con la cantidad de veces que se repetir�n los ciclos 
eti0: ldi r18,250	;Carga a R19 con el valor 250
eti1: ldi r19,250	;Carga a R20 con el valor 250
eti2: nop		;NOP = No Operaci�n (4 uS por iteraci�n)
    dec r19		;Decrementa en 1 a R20
    brne eti2	;Mientras ZF=0, brinca a ETI2
    dec r18		;Decrementa en 1 a R19
    brne eti1	;Mientras ZF=0, brinca a ETI1
    dec r17		;Decrementa en 1 a R18
    brne eti0	;Mientras ZF=0, brinca a ETI0
    ret		;Retorna el control