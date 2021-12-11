    ldi R31,0b00000000		    ;R31 se va a usar para comparar con el pseudo
    ldi r16,0b00011100		    ;R16 carga los pines 0 y 1 como entrada y los demás como salida en el puerto D
    out ddrd,r16 
    ldi r16,0xff		    ;R16 carga todos los pines como salida
    out ddrb,r16
    ldi r23,0
    
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
    call memoria
    
verde:
    ldi r16,0b00000010
    out portb,r16
    call delay
    call delay
    call apagaB
    call memoria
    
rojo:
    ldi r16,0b00000100
    out portb,r16
    call delay
    call delay
    call apagaB
    call memoria
    
amarillo:
    ldi r16,0b00001000
    out portb,r16
    call delay
    call delay
    call apagaB
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
    
convertidor:
    call pseudo
    cpi r22,1
    breq conAzul
    
    call pseudo
    cpi r22,2
    breq conVerde
    
    call pseudo
    cpi r22,3
    breq conRojo
    
    call pseudo
    cpi r22,4
    breq conAmarillo

    ret
    
conAzul:
    call pseudo
    ldi r22,0b00000001
    ret
    
conVerde:
    call pseudo
    ldi r22,0b00000010
    ret
    
conRojo:
    call pseudo
    ldi r22,0b00000100
    ret
    
conAmarillo:
    call pseudo
    ldi r22,0b00001000
    ret    
    
atajoRan:
    rjmp random
    
recuerda:
    call pseudo
    // Prender lo que salió la 1ra vez
    lds r22,0x100
    cpi r22,0
    breq atajoRan
    call convertidor
    out portb,r22
    call delay
    ldi r22,0
    out portb,r22
    call delay
    
    call pseudo
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
    
    call pseudo
    // Prender lo que salió la 3ra vez
    lds r22,0x102
    cpi r22,0
    breq atajoRan
    call convertidor
    out portb,r22
    call delay
    ldi r22,0
    out portb,r22
    call delay
    
    call pseudo
    //Prender lo que salió la 4ta vez
    lds r22,0x103
    cpi r22,0
    breq atajoRan
    call convertidor
    out portb,r22
    call delay
    ldi r22,0
    out portb,r22
    call delay
    
    call pseudo
    //Prender lo que salió la 5ta vez
    lds r22,0x104
    cpi r22,0
    breq atajoRand
    call convertidor
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
    breq cuartoUno
    call pseudo
    
    ldi r20,2
    in r19,pind
    cpi r19,0b00001010
    breq cuartoDos
    
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
    breq quintoUno
    call pseudo
    
    ldi r20,4
    in r19,pind
    cpi r19,0b00010010
    breq quintoDos
    
    call miniDelay
    call apagaD
    
    rjmp start
 
reinicio:
    call pseudo
    sbis pind,1
    rjmp sueltaReinicio
    rjmp reinicio
    
cuartoUno:	    ;Prendemos el led AZUL
    call pseudo
    ldi r16,0b00000001
    out portb,r16
    rjmp pressCuartoUno
    
cuartoDos:	    ;Prendemos el led VERDE
    call pseudo
    ldi r16,0b00000010
    out portb,r16
    rjmp pressCuartoDos

quintoUno:		    ;Prendemos el led ROJO
    call pseudo
    ldi r16,0b00000100
    out portb,r16
    rjmp pressQuintoUno
    
quintoDos:	    	    ;Prendemos el led AMARILLO
    call pseudo
    ldi r16,0b00001000
    out portb,r16
    rjmp pressQuintoDos
    
pressCuartoUno:	    ;Presionamos el botón del led AZUL
    call pseudo
    sbis pind,0
    rjmp compara
    rjmp cuartoUno
    
pressCuartoDos:	    ;Presionamos el botón del led VERDE
    call pseudo
    sbis pind,1
    rjmp compara
    rjmp cuartoDos

pressQuintoUno:		    ;Presionamos el botón del led ROJO
    call pseudo
    sbis pind,0
    rjmp compara
    rjmp quintoUno
    
pressQuintoDos:	    	    ;Presionamos el botón del led AMARILLO
    call pseudo
    sbis pind,1
    rjmp compara
    rjmp quintoDos
    
sueltaReinicio:
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
    call pseudo
    call miniDelay
    call miniDelay
    ldi r16,0
    out portb,r16
    
    cpi r21,0
    breq unPunto
    
    cpi r21,1
    breq dosPuntos
    
    cpi r21,2
    breq tresPuntos
    
    cpi r21,3
    breq atajoCuatroPuntos
    
    cpi r21,4
    breq atajoCincoPuntos
    
    rjmp start
 
atajoCuatroPuntos:
    call pseudo
    rjmp cuatroPuntos
    
atajoCincoPuntos:
    call pseudo
    rjmp cincoPuntos
    
atajoErroneo:
    call pseudo
    rjmp erroneo
    
atajoStart:
    call pseudo
    rjmp start
    
unPunto:
    call pseudo
    ldi r21,1
    lds r16,0x100
    cp r16,r20
    brne atajoErroneo
    call correcto
    ret
    
dosPuntos:
    call pseudo
    cpi r23,0
    breq dosUno
    cpi r23,1
    breq dosDos
    dosUno:
	call pseudo
	ldi r23,1
	lds r16,0x100
	cp r16,r20
	breq atajoStart
	rjmp erroneo
    
    dosDos:
	call pseudo
	ldi r21,2
	lds r16,0x101
	cp r16,r20
	brne atajoErroneo
	call correcto
	
    ret
    
tresPuntos:
    call pseudo
    cpi r23,0
    breq tresUno
    cpi r23,1
    breq tresDos
    cpi r23,2
    breq tresTres
    
    tresUno:
	call pseudo
	ldi r23,1
	lds r16,0x100
	cp r16,r20
	breq atajoStart
	rjmp erroneo

    tresDos:
	call pseudo
	ldi r23,2
	lds r16,0x101
	cp r16,r20
	breq atajoStart
	rjmp erroneo
	
    tresTres:
	call pseudo
	ldi r21,3
	lds r16,0x102
	cp r16,r20
	brne atajoErroneooo
	call correcto
	
    ret
    
cuatroPuntos:
    call pseudo
    cpi r23,0
    breq cuatroUno
    cpi r23,1
    breq cuatroDos
    cpi r23,2
    breq cuatroTres
    cpi r23,3
    breq cuatroCuatro
    
    cuatroUno:
	call pseudo
	ldi r23,1
	lds r16,0x100
	cp r16,r20
	breq atajoStartt
	rjmp erroneo

    cuatroDos:
	call pseudo
	ldi r23,2
	lds r16,0x101
	cp r16,r20
	breq atajoStartt
	rjmp erroneo
	
    cuatroTres:
	call pseudo
	ldi r23,3
	lds r16,0x102
	cp r16,r20
	breq atajoStartt
	rjmp erroneo
    
    cuatroCuatro:
	call pseudo
	ldi r21,4
	lds r16,0x103
	cp r16,r20
	brne atajoErroneooo
	call correcto
	
    ret
    
atajoStartt:
    call pseudo
    rjmp start

atajoErroneooo:
    call pseudo
    rjmp erroneo
    
cincoPuntos:		;5 Puntos, fin del juego :DDDD
    call pseudo
    cpi r23,0
    breq cincoUno
    cpi r23,1
    breq cincoDos
    cpi r23,2
    breq cincoTres
    cpi r23,3
    breq cincoCuatro
    cpi r23,4
    breq cincoCinco
    
    cincoUno:
	call pseudo
	ldi r23,1
	lds r16,0x100
	cp r16,r20
	breq atajoStartt
	rjmp erroneo

    cincoDos:
	call pseudo
	ldi r23,2
	lds r16,0x101
	cp r16,r20
	breq atajoStartt
	rjmp erroneo
	
    cincoTres:
	call pseudo
	ldi r23,3
	lds r16,0x102
	cp r16,r20
	breq atajoStartt
	rjmp erroneo
    
    cincoCuatro:
	call pseudo
	ldi r23,4
	lds r16,0x103
	cp r16,r20
	breq atajoStartt
	rjmp erroneo
    
    cincoCinco:
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
    ldi r23,0
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