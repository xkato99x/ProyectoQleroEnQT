    ldi R31,0b00000000		    ;R31 se va a usar para comparar con el pseudo
    ldi r16,0b00011100		    ;R16 carga los pines 0 y 1 como entrada y los demás como salida en el puerto D
    out ddrd,r16 
    ldi r16,0xff		    ;R16 carga todos los pines como salida
    out ddrb,r16
    ldi r19,0			    ;R19 será para el display
    
    ldi r16,0b00000100		    ;R22 es para mandar voltaje a los pines 2,3,4
    out pind,r16
boton_inicio:
    call pseudo
    sbic pind,0			    ;Salta la sig. instrucción si el bit de la pos. 0 está apagado (0), osea, el botón no se aprieta
    rjmp suelta_1		    ;Si se presionó el botón, salta a suelta_1
    rjmp boton_inicio		    ;Si no se presionó el botón, se cicla
    
suelta_1:
    call pseudo
    sbis pind,0			    ;Salta la sig. instrucción si el bit de la pos. 0 está encendido (1), osea, se dehjó de presionar
    rjmp led_inicio		    ;Al dejar de presionar el botón, salta a led_inicio
    rjmp suelta_1		    ;Si no se suelta el botón, se cicla
    
led_inicio:
    ldi r16,0b00000000		    ;Reinicia el registro R22
    out pind,r16		    ;Apaga el 
    call delay
    ldi r16,0b00010000
    out portb,r16
    call delay
    call delay
    call apagaB
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
    call apagaB
    call delay
    call memoria
    
verde:
    ldi r16,0b00000010
    out portb,r16
    call delay
    call apagaB
    call delay
    call memoria
    
rojo:
    ldi r16,0b00000100
    out portb,r16
    call delay
    call apagaB
    call delay
    call memoria
    
amarillo:
    ldi r16,0b00001000
    out portb,r16
    call delay
    call apagaB
    call delay
    call memoria
  
apagaB:
    ldi r16,0
    out portb,r16
    ret
    
memoria:
    lds r16,0x100
    cpi r16,0
    breq memUno
    
    lds r16,0x101
    cpi r16,0
    breq memDos
    
    lds r16,0x102
    cpi r16,0
    breq memTres
    
    lds r16,0x103
    cpi r16,0
    breq memCuatro
    
    lds r16,0x104
    cpi r16,0
    breq memCinco
    
    ret
    
memUno:
    sts 0x100,r31
    rjmp start
    
memDos:
    sts 0x101,r31
    rjmp start
    
memTres:
    sts 0x102,r31
    rjmp start
    
memCuatro:
    sts 0x103,r31
    rjmp start
    
memCinco:
    sts 0x104,r31
    rjmp start
    
start:
    call pseudo
    in r16,pind ;pin 0
    // TERCER PIN
    ldi r16,0b00000100
    out portd,r16
    sbic portd,1
    call reinicio
    
    call miniDelay
    call apagaD
    
    // CUARTO PIN
    ldi r16,0b00001000
    out portd,r16
    
    sbic portd,0
    call cuatroUno
    sbic portd,1
    call cuatroDos
    
    call miniDelay
    call apagaD
    
    // QUINTO PIN
    ldi r16,0b00010000
    out portd,r16
    
    sbic portd,0
    call cincoUno
    sbic portd,1
    call cincoDos
    
    call miniDelay
    call apagaD
    
    rjmp start
 
compara:
    
    ret
    
apagaD:
    ldi r16,0
    out portd,r16
    ret
    
correcto:
    in r16,portc
    inc r16
    out portc,r16
    ret
    
erroneo:
    ldi r16,0b00100000
    out portb,r16
    call delay
    call delay
    call delay
    ldi r16,0
    out portb,r16
    out portc,r16
    ret

reinicio:
    ldi r16,0
    out portc,r16
    sts 0x100,r16
    sts 0x101,r16
    sts 0x102,r16
    sts 0x103,r16
    sts 0x104,r16
    sbis pind,1
    ret
    rjmp reinicio
    
cuatroUno:	    ;Presionamos el botón del led AZUL
    call compara
    ret
    
cuatroDos:	    ;Presionamos el botón del led VERDE
    call compara
    ret

cincoUno:		    ;Presionamos el botón del led ROJO
    call compara
    ret
    
cincoDos:	    	    ;Presionamos el botón del led AMARILLO
    call compara
    ret
    
pseudo:
    inc r31
    cpi r31,4
    breq pseu2
    ret
    
pseu2:
    ldi r31,00
    ret

delay:			;Inicio de la subrutina DELAY
    ldi r16,0x02	;Carga a R18 con la cantidad de veces que se repetirán los ciclos 
eti0: ldi r17,250	;Carga a R19 con el valor 250
eti1: ldi r18,250	;Carga a R20 con el valor 250
eti2: nop		;NOP = No Operación (4 uS por iteración)
    dec r18		;Decrementa en 1 a R20
    brne eti2	;Mientras ZF=0, brinca a ETI2
    dec r17		;Decrementa en 1 a R19
    brne eti1	;Mientras ZF=0, brinca a ETI1
    dec r16		;Decrementa en 1 a R18
    brne eti0	;Mientras ZF=0, brinca a ETI0
    ret		;Retorna el control
    
miniDelay:
    ldi r16,0x1
eti3: ldi r17,200	;Carga a R19 con el valor 250
eti4: ldi r18,150	;Carga a R20 con el valor 250
eti5: nop		;NOP = No Operación (4 uS por iteración)
    dec r18		;Decrementa en 1 a R20
    brne eti5	;Mientras ZF=0, brinca a ETI2
    dec r17		;Decrementa en 1 a R19
    brne eti4	;Mientras ZF=0, brinca a ETI1
    dec r16		;Decrementa en 1 a R18
    brne eti3	;Mientras ZF=0, brinca a ETI0
    ret		;Retorna el control
    
microDelay:
    ldi r16,0x1
eti6: ldi r17,100	;Carga a R19 con el valor 250
eti7: ldi r18,100	;Carga a R20 con el valor 250
eti8: nop		;NOP = No Operación (4 uS por iteración)
    dec r18		;Decrementa en 1 a R20
    brne eti8	;Mientras ZF=0, brinca a ETI2
    dec r17		;Decrementa en 1 a R19
    brne eti7	;Mientras ZF=0, brinca a ETI1
    dec r16		;Decrementa en 1 a R18
    brne eti6	;Mientras ZF=0, brinca a ETI0
    ret		;Retorna el control
    
