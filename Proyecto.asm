    ldi R31,0b00000000		    ;R31 se va a usar para el pseudo
    ldi r16,0b00011111		    ;R16 carga los pines 0 y 1 como entrada y los demás como salida en el puerto D
    out ddrd,r16 
    ldi r16,0xff		    ;R16 carga todos los pines como salida
    out ddrb,r16
    
    ldi r16,0b00000100		    ;r16 es para mandar voltaje a los pines 2,3,4
    out pind,r16
boton_inicio:
    call pseudo
    sbic pind,0			    ;Salta la sig. instrucción si el bit de la pos. 0 está apagado (0), osea, el botón no se aprieta
    rjmp suelta_inicio		    ;Si se presionó el botón, salta a suelta_1
    rjmp boton_inicio		    ;Si no se presionó el botón, se cicla
    
suelta_inicio:
    call pseudo
    sbis pind,0			    ;Salta la sig. instrucción si el bit de la pos. 0 está encendido (1), osea, se dejó de presionar
    rjmp led_inicio		    ;Al dejar de presionar el botón, salta a led_inicio
    rjmp suelta_inicio		    ;Si no se suelta el botón, se cicla
    
led_inicio:
    ldi r16,0b00000000		    ;Reinicia el registro r16
    out pind,r16		    ;Apaga el puerto D
    out pin
    call delay
    ldi r16,0b00010000		    ;Enciende el 5to bit del octeto
    out portb,r16		    ;Manda la señal encendida del 5to bit
    ldi r16,0x00		    ;Reinicia el registro r16
    call delay
    call delay
    
random:
    cpi r31,0b00000000
    breq azul
    
    cpi r31,0b00000001
    breq verde
    
    cpi r31,0b00000010
    breq rojo
    
    cpi r31,0b00000100
    breq amarillo

azul:
    ldi r16,0b00000001
    out portb,r16
    call memoria
    call delay
    call delay
    ldi r16,0b00000000
    out portb,r16
    rjmp start
    
verde:
    ldi r16,0b00000010
    out portb,r16
    call memoria
    call delay
    call delay
    ldi r16,0b00000000
    out portb,r16
    rjmp start
    
rojo:
    ldi r16,0b00000100
    out portb,r16
    call memoria
    call delay
    call delay
    ldi r16,0b00000000
    out portb,r16
    rjmp start
    
amarillo:
    ldi r16,0b00001000
    out portb,r16
    call memoria
    call delay
    call delay
    ldi r16,0b00000000
    out portb,r16
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
    
guarda_1:   ;Función para guardar el primer puntaje, se usará el registro r29
    
    ret
    
guarda_2:   ;Función para guardar el segundo puntaje, se usará el registro r28
    
    ret
    
guarda_3:   ;Función para guardar el tercer puntaje, se usará el registro r27
    
    ret
    
guarda_4:   ;Función para guardar el cuarto puntaje, se usará el registro r26
    
    ret
    
guarda_5:   ;Función para guardar el quinto y último puntaje, se usará el registro r25
    
    ret
    
    
start:
    in r16,pind ;Recibe todo el puerto D
    
    ;cpi r16,0b00001001	;compara lo que vale r16 con el botón azul
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
    ldi r17,0x02	;Carga a R18 con la cantidad de veces que se repetirán los ciclos 
eti0: ldi r18,250	;Carga a R19 con el valor 250
eti1: ldi r19,250	;Carga a R20 con el valor 250
eti2: nop		;NOP = No Operación (4 uS por iteración)
    dec r19		;Decrementa en 1 a R20
    brne eti2	;Mientras ZF=0, brinca a ETI2
    dec r18		;Decrementa en 1 a R19
    brne eti1	;Mientras ZF=0, brinca a ETI1
    dec r17		;Decrementa en 1 a R18
    brne eti0	;Mientras ZF=0, brinca a ETI0
    ret		;Retorna el control