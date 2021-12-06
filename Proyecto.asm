    ldi R31,0b00000000		    ;R31 se va a usar para comparar con el pseudo
    ldi r16,0b00011100		    ;R16 carga los pines 0 y 1 como entrada y los demás como salida en el puerto D
    out ddrd,r16 
    ldi r16,0xff		    ;R16 carga todos los pines como salida
    out ddrb,r16
    
inicio:
    ldi r20,0
    ldi r21,0
    ldi r16,0b00011100
    out ddrd,r16
    ldi r16,0
    out portb,r16
    out portc,r16
    sts 0x100,r16
    sts 0x101,r16
    sts 0x102,r16
    sts 0x103,r16
    sts 0x104,r16
    out pind,r16
    ldi r16,0b00000100
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
    ldi r16,0b00000000
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
    call delay
    call apagaB
    call delay
    call memoria
    
verde:
    ldi r16,0b00000010
    out portb,r16
    call delay
    call delay
    call apagaB
    call delay
    call memoria
    
rojo:
    ldi r16,0b00000100
    out portb,r16
    call delay
    call delay
    call apagaB
    call delay
    call memoria
    
amarillo:
    ldi r16,0b00001000
    out portb,r16
    call delay
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
    /*in r25,portc
    ldi r17,9
    out portc,r17
    call delay
    out portc,r25*/
    mov r16,r31
    inc r16
    sts 0x100,r16
    rjmp start
    
memDos:
    /*in r25,portc
    ldi r17,8
    out portc,r17
    call delay
    out portc,r25*/
    mov r16,r31
    inc r16
    sts 0x101,r16
    rjmp start
    
memTres:
    /*in r25,portc
    ldi r17,7
    out portc,r17
    call delay
    out portc,r25*/
    mov r16,r31
    inc r16
    sts 0x102,r16
    rjmp start
    
memCuatro:
    /*in r25,portc
    ldi r17,6
    out portc,r17
    call delay
    out portc,r25*/
    mov r16,r31
    inc r16
    sts 0x103,r16
    rjmp start
    
memCinco:
    /*in r25,portc
    ldi r17,0
    out portc,r17
    call delay
    out portc,r25*/
    mov r16,r31
    inc r16
    sts 0x104,r16
    rjmp start
    
convertidor:
    cpi r22,1
    breq conAzul
    
    cpi r22,2
    breq conVerde
    
    cpi r22,3
    breq conRojo
    
    cpi r22,4
    breq conAmarillo

    ret
    
conAzul:
    ldi r22,0b00000001
    ret
    
conVerde:
    ldi r22,0b00000010
    ret
    
conRojo:
    ldi r22,0b00000100
    ret
    
conAmarillo:
    ldi r22,0b00001000
    ret    
    
atajoRan:
    rjmp random
    
recuerda:
    // Prender lo que salió la 1ra vez
    lds r22,0x100
    cpi r22,0
    breq atajoRan
    call convertidor
    out portb,r22
    call delay
    out portb,r22
    call delay
    ldi r22,0
    out portb,r22
    call delay
    
    // Prender lo que salió la 2da vez
    lds r22,0x101
    cpi r22,0
    breq atajoRan
    call convertidor
    out portb,r22
    call delay
    ldi r22,0
    out portb,r22
    call delay
    
    // Prender lo que salió la 3ra vez
    lds r22,0x102
    cpi r22,0
    breq atajoRan
    call convertidor
    out portb,r22
    call delay
    out portb,r22
    call delay
    ldi r22,0
    out portb,r22
    call delay
    
    //Prender lo que salió la 4ta vez
    lds r22,0x103
    cpi r22,0
    breq atajoRan
    call convertidor
    out portb,r22
    call delay
    out portb,r22
    call delay
    ldi r22,0
    out portb,r22
    call delay
    
    //Prender lo que salió la 5ta vez
    lds r22,0x104
    cpi r22,0
    breq atajoRand
    call convertidor
    out portb,r22
    call delay
    out portb,r22
    call delay
    ldi r22,0
    out portb,r22
    call delay
    
    ret
    
atajoRand:
    rjmp random
    
start:
    call pseudo
    in r19,pind ;pin 0
    // TERCER PIN
    call pseudo
    ldi r16,0b00000100
    out portd,r16
    ;call kiloDelay
    
    in r19,pind
    cpi r19,0b00000110
    breq reinicio
    
    call miniDelay
    call apagaD
    
    // CUARTO PIN
    call pseudo
    ldi r16,0b00001000
    out portd,r16
    ;call kiloDelay
    
    ldi r20,1
    in r19,pind
    cpi r19,0b00001001
    breq cuatroUno
    ldi r20,2
    in r19,pind
    cpi r19,0b00001010
    breq cuatroDos
    
    call miniDelay
    call apagaD
    
    // QUINTO PIN
    call pseudo
    ldi r16,0b00010000
    out portd,r16
    ;call kiloDelay
    
    ldi r20,3
    in r19,pind
    cpi r19,0b00010001
    breq cincoUno
    ldi r20,4
    in r19,pind
    cpi r19,0b00010010
    breq cincoDos
    
    call miniDelay
    call apagaD
    
    rjmp start
 
reinicio:
    call pseudo
    sbis pind,1
    rjmp sueltaReinicio
    rjmp reinicio
    
cuatroUno:	    ;Presionamos el botón del led AZUL
    call pseudo
    sbis pind,0
    rjmp compara
    rjmp cuatroUno
    
cuatroDos:	    ;Presionamos el botón del led VERDE
    call pseudo
    sbis pind,1
    rjmp compara
    rjmp cuatroDos

cincoUno:		    ;Presionamos el botón del led ROJO
    call pseudo
    sbis pind,0
    rjmp compara
    rjmp cincoUno
    
cincoDos:	    	    ;Presionamos el botón del led AMARILLO
    call pseudo
    sbis pind,1
    rjmp compara
    rjmp cincoDos
    
sueltaReinicio:
    call pseudo
    ldi r16,0
    out portb,r16
    ldi r16,0b00000001
    out portb,r16
    call microDelay
    ldi r16,0
    out portb,r16
    ldi r16,0b00000010
    out portb,r16
    call microDelay
    ldi r16,0
    out portb,r16
    ldi r16,0b00000100
    out portb,r16
    call microDelay
    ldi r16,0
    out portb,r16
    ldi r16,0b00001000
    out portb,r16
    call microDelay
    ldi r16,0
    out portb,r16
    ldi r16,0b00111111
    out portb,r16
    call kiloDelay
    ldi r16,0
    out portb,r16
    call delay
    ldi r16,0b00000100
    out pind,r16
    rjmp inicio

compara:
    cpi r21,0
    breq unPunto
    
    cpi r21,1
    breq dosPuntos
    
    cpi r21,2
    breq tresPuntos
    
    cpi r21,3
    breq cuatroPuntos
    
    cpi r21,4
    breq cincoPuntos
    
    rjmp start
    
unPunto:
    call pseudo
    ldi r21,1
    lds r16,0x100
    cp r16,r20
    brne erroneo
    call correcto
    ret
    
dosPuntos:
    call pseudo
    ldi r21,2
    lds r16,0x101
    cp r16,r20
    brne erroneo
    call correcto
    ret
    
tresPuntos:
    call pseudo
    ldi r21,3
    lds r16,0x102
    cp r16,r20
    brne erroneo
    call correcto
    ret
    
cuatroPuntos:
    call pseudo
    ldi r21,4
    lds r16,0x103
    cp r16,r20
    brne erroneo
    call correcto
    ret
    
cincoPuntos:		;5 Puntos, fin del juego :DDDD
    call pseudo
    in r16,portc
    inc r16
    out portc,r16
    lds r16,0x104
    cp r16,r20
    brne erroneo
    call fin
    ret
    
correcto:
    call pseudo
    in r16,portc
    inc r16
    out portc,r16
    ldi r16,0b00010000
    out portb,r16
    call delay
    call delay
    ldi r16,0
    out portb,r16
    call delay
    call recuerda
    //rjmp random
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
    rjmp inicio
    
atajoReinicio:
    rjmp reinicio
    
apagaD:
    ldi r16,0x00
    out portd,r16
    ret
    
pseudo:
    inc r31
    cpi r31,4
    breq pseu2
    ret
    
pseu2:
    ldi r31,00
    ret

delay:
    ldi r16,0x02
    eti0: ldi r17,250
    eti1: ldi r18,250
    eti2: nop
	dec r18
	brne eti2
	dec r17
	brne eti1
	dec r16
	brne eti0
	ret
    
miniDelay:
    ldi r16,0x1
    eti3: ldi r17,150
    eti4: ldi r18,100
    eti5: nop
	dec r18
	brne eti5
	dec r17
	brne eti4
	dec r16
	brne eti3
	ret
    
microDelay:
    ldi r16,0x4
    eti6: ldi r17,200
    eti7: ldi r18,100
    eti8: nop
	dec r18
	brne eti8
	dec r17
	brne eti7
	dec r16
	brne eti6
	ret

kiloDelay:
    ldi r16,0x4
    eti9: ldi r17,250
    eti10: ldi r18,250
    eti11: nop
	dec r18
	brne eti11
	dec r17
	brne eti10
	dec r16
	brne eti9
	ret
    
fin:
    ldi r16,0
    out portb,r16
    out portd,r16
    ldi r16,0b00010000
    out portb,r16
    ldi r16,0b00000100
    out pind,r16
    in r19,pind
    cpi r19,0b00000110
    breq atajoReinicio
    call delay
    rjmp fin