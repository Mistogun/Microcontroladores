#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

    BCF PORTC,0		;reset
    MOVLW 0x01
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
  
    GOTO    START

MAIN_PROG CODE                      ; let linker place main program

START

i equ 0x30
j equ 0x31

R0 equ 0x40	;Arreglo de respuesta de 8 bits y su indice
R1 equ 0x41
R2 equ 0x42
R3 equ 0x43
R4 equ 0x44
R5 equ 0x45
R6 equ 0x46
R7 equ 0x47
indx equ 0x48
Mindx equ 0x49	;Master Index
 
START

    BANKSEL PORTA ;
    CLRF PORTA ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISA ;
    MOVLW d'0'
    MOVWF TRISA 
    CLRF TRISB
    CLRF TRISC
    CLRF TRISD
    MOVLW d'11111100'
    MOVWF TRISE
    BCF STATUS,RP1
    BCF STATUS,RP0
    BCF PORTC,1
    BCF PORTC,0
    
INITLCD
    
    MOVLW 0x3F
    MOVWF indx
    
    MOVLW 0xD8
    MOVWF Mindx
    
    BCF PORTC,0		;reset
    MOVLW 0x01
    MOVWF PORTD
    
    CALL exec
    
    MOVLW 0x0C		;first line
    MOVWF PORTD
    
    CALL exec
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTD
    
    CALL exec
    
INICIO	
    BCF PORTE,0
    BCF PORTE,1
    
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    
    ;MENSAJE DE CONTRASEÑA
    MOVLW 'C'
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    MOVLW 'N'
    MOVWF PORTD
    CALL exec
    MOVLW 'T'
    MOVWF PORTD
    CALL exec
    MOVLW 'R'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    MOVLW 'N'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    MOVLW ':'
    MOVWF PORTD
    CALL exec
    MOVLW ' '
    MOVWF PORTD
    CALL exec
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0xC8		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;PARTE ASTERISCO/CONTRASEÑA
    MOVLW '3'
    MOVWF PORTD
    CALL exec
    MOVLW '2'
    MOVWF PORTD
    CALL exec
    MOVLW '2'
    MOVWF PORTD
    CALL exec
    MOVLW '3'
    MOVWF PORTD
    CALL exec
    MOVLW '0'
    MOVWF PORTD
    CALL exec
    MOVLW '3'
    MOVWF PORTD
    CALL exec
    MOVLW '9'
    MOVWF PORTD
    CALL exec
    MOVLW '1'
    MOVWF PORTD
    CALL exec
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x90		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;MENSAJE PARA INGRESAR
    MOVLW 'I'
    MOVWF PORTD
    CALL exec
    MOVLW 'N'
    MOVWF PORTD
    CALL exec
    MOVLW 'G'
    MOVWF PORTD
    CALL exec
    MOVLW 'R'
    MOVWF PORTD
    CALL exec
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    MOVLW ' '
    MOVWF PORTD
    CALL exec
    MOVLW 'C'
    MOVWF PORTD
    CALL exec
    MOVLW 'L'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    MOVLW 'V'
    MOVWF PORTD
    CALL exec
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    MOVLW ':'
    MOVWF PORTD
    CALL exec
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0xD8		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    CALL Ingresar

Ingresar
    BSF PORTA,6
    BSF PORTA,5
    BSF PORTA,4
    BSF PORTA,3
    BSF PORTA,2
    BSF PORTA,1
    BSF PORTA,0
    
    BCF PORTA,3
    CALL AA
    CALL time2
    BSF PORTA,3
    
    BCF PORTA,2
    CALL BB
    CALL time2
    BSF PORTA,2
    
    BCF PORTA,1
    CALL CC
    CALL time2
    BSF PORTA,1
    
    BCF PORTA,0
    CALL DD
    CALL time2
    BCF PORTA,0
    
    GOTO Ingresar
    
AA
    BTFSS PORTA,4
    CALL Imp1
    BTFSS PORTA,5
    CALL Imp2
    BTFSS PORTA,6
    CALL Imp3
    RETURN
    
BB
    BTFSS PORTA,4
    CALL Imp4
    BTFSS PORTA,5
    CALL Imp5
    BTFSS PORTA,6
    CALL Imp6
    RETURN
    
CC
    BTFSS PORTA,4
    CALL Imp7
    BTFSS PORTA,5
    CALL Imp8
    BTFSS PORTA,6
    CALL Imp9
    RETURN
    
DD
    BTFSS PORTA,4
    CALL Regresar
    BTFSS PORTA,5
    CALL Imp0
    BTFSS PORTA,6
    CALL Enter
    RETURN
    
Imp1
    INCF indx
    MOVFW indx
    MOVWF FSR
    MOVLW '1'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,4
    CALL time3
    RETURN

Imp2
    INCF indx
    MOVFW indx
    MOVWF FSR
    MOVLW '2'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,5
    CALL time3
    RETURN

Imp3
    INCF indx
    MOVFW indx
    MOVWF FSR
    MOVLW '3'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,6
    CALL time3
    RETURN
    
Imp4
    INCF indx
    MOVFW indx
    MOVWF FSR
    MOVLW '4'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,4
    CALL time3
    RETURN

Imp5
    INCF indx
    MOVFW indx
    MOVWF FSR
    MOVLW '5'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,5
    CALL time3
    RETURN

Imp6
    INCF indx
    MOVFW indx
    MOVWF FSR
    MOVLW '6'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,6
    CALL time3
    RETURN
    
Imp7
    INCF indx
    MOVFW indx
    MOVWF FSR
    MOVLW '7'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,4
    CALL time3
    RETURN

Imp8
    INCF indx
    MOVFW indx
    MOVWF FSR
    MOVLW '8'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,5
    CALL time3
    RETURN

Imp9
    INCF indx
    MOVFW indx
    MOVWF FSR
    MOVLW '9'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,6
    CALL time3
    RETURN
    
Imp0
    INCF indx
    MOVFW indx
    MOVWF FSR
    MOVLW '0'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,5
    CALL time3
    RETURN
    
Regresar
    MOVLW 0x40
    SUBWF indx,0
    ADDWF Mindx,1
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL time
    
    MOVFW Mindx		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MOVLW '_'
    MOVWF PORTD
    CALL exec
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL time
    
    MOVFW Mindx		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    MOVLW 0xD8
    MOVWF Mindx
    DECF indx,1
    
    BSF PORTA,4
    CALL time3
    RETURN
    
Enter
    MOVLW '3'
    XORWF R0,1
    INCF R0,1
    DECFSZ R0
    GOTO Incorrecto
    
    MOVLW '2'
    XORWF R1,1
    INCF R1,1
    DECFSZ R1
    GOTO Incorrecto
    
    MOVLW '2'
    XORWF R2,1
    INCF R2,1
    DECFSZ R2
    GOTO Incorrecto
    
    MOVLW '3'
    XORWF R3,1
    INCF R3,1
    DECFSZ R3
    GOTO Incorrecto
    
    MOVLW '0'
    XORWF R4,1
    INCF R4,1
    DECFSZ R4
    GOTO Incorrecto
    
    MOVLW '3'
    XORWF R5,1
    INCF R5,1
    DECFSZ R5
    GOTO Incorrecto
    
    MOVLW '9'
    XORWF R6,1
    INCF R6,1
    DECFSZ R6
    GOTO Incorrecto
    
    MOVLW '1'
    XORWF R7,1
    INCF R7,1
    DECFSZ R7
    GOTO Incorrecto
    GOTO Correcto
    
    BSF PORTA,6
    CALL time3
    RETURN
    
exec

    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    RETURN
    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN
    
time2
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo2    
    MOVLW d'10'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo2
    RETURN
    
time3
    CLRF i
    MOVLW d'255'
    MOVWF j
ciclo3    
    MOVLW d'255'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo3
    RETURN
    
Incorrecto
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;reset
    MOVLW 0x01
    MOVWF PORTD
    CALL exec
    
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0xC4		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
    MOVLW 'K'
    MOVWF PORTD
    CALL exec
    MOVLW 'B'
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    MOVLW 'M'
    MOVWF PORTD
    CALL exec
    MOVLW '!'
    MOVWF PORTD
    CALL exec
    MOVLW '!'
    MOVWF PORTD
    CALL exec

IncorrectoLED
    BCF PORTE,0
    BSF PORTE,1
    GOTO IncorrectoLED

Correcto
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;reset
    MOVLW 0x01
    MOVWF PORTD
    CALL exec
    
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x86		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    MOVLW 'B'
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    MOVLW 'M'
    MOVWF PORTD
    CALL exec
    MOVLW 'B'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x93		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    MOVLW 'D'
    MOVWF PORTD
    CALL exec
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    MOVLW 'C'
    MOVWF PORTD
    CALL exec
    MOVLW 'T'
    MOVWF PORTD
    CALL exec
    MOVLW 'I'
    MOVWF PORTD
    CALL exec
    MOVLW 'V'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    MOVLW 'D'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    
CorrectoLED
    BSF PORTE,0
    BCF PORTE,1
    GOTO CorrectoLED
    
END