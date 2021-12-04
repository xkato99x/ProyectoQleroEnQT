    ldi R31,0b00000000		    ;R31 se va a usar para comparar con el pseudo
    ldi r16,0b00011100		    ;R16 carga los pines 0 y 1 como entrada y los demás como salida en el puerto D
    out ddrd,r16 
    ldi r16,0xff		    ;R16 carga todos los pines como salida
    out ddrb,r16
    
    ldi r16,0b00000100		    ;R22 es para mandar voltaje a los pines 2,3,4
    out pind,r16
    
inicio:
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
    mov r16,r31
    inc r16
    sts 0x100,r16
    rjmp start
    
memDos:
    mov r16,r31
    inc r16
    sts 0x101,r16
    rjmp start
    
memTres:
    mov r16,r31
    inc r16
    sts 0x102,r16
    rjmp start
    
memCuatro:
    mov r16,r31
    inc r16
    sts 0x103,r16
    rjmp start
    
memCinco:
    mov r16,r31
    inc r16
    sts 0x104,r16
    rjmp start
    
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
    ldi r16,0
    out portb,r16
    call miniDelay
    ldi r16,1
    out portb,r16
    call miniDelay
    ldi r16,2
    out portb,r16
    call miniDelay
    ldi r16,3
    out portb,r16
    call miniDelay
    ldi r16,4
    out portb,r16
    call miniDelay
    ldi r16,5
    out portb,r16
    call miniDelay
    call miniDelay
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
    ldi r21,1
    lds r16,0x100
    cp r16,r20
    brne erroneo
    call correcto
    ret
    
dosPuntos:
    ldi r21,2
    lds r16,0x101
    cp r16,r20
    brne erroneo
    call correcto
    ret
    
tresPuntos:
    ldi r21,3
    lds r16,0x102
    cp r16,r20
    brne erroneo
    call correcto
    ret
    
cuatroPuntos:
    ldi r21,4
    lds r16,0x103
    cp r16,r20
    brne erroneo
    call correcto
    ret
    
cincoPuntos:		;5 Puntos, fin del juego :DDDD
    lds r16,0x104
    cp r16,r20
    brne erroneo
    call fin
    ret
     
correcto:
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
    rjmp random
    
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
    eti3: ldi r17,200
    eti4: ldi r18,200
    eti5: nop
	dec r18
	brne eti5
	dec r17
	brne eti4
	dec r16
	brne eti3
	ret
    
microDelay:
    ldi r16,0x1
    eti6: ldi r17,100
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
    ldi r16,0b00010000
    out portb,r16