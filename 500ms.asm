#include "p16F628a.inc"
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

RES_VECT CODE 0x0000 ; processor reset vector
 GOTO START ; go to beginning of program
 ; TODO ADD INTERRUPTS HERE IF USED
 MAIN_PROG CODE ; let linker place main program

i equ 0x30
j equ 0x31
k equ 0x32
 
START
    MOVLW 0x07
    MOVWF CMCON
    BCF STATUS, RP1
    BSF STATUS, RP0
    MOVLW b'00000000'
    MOVWF TRISB
    BCF STATUS, RP0
    
EncenderApagar
    bcf PORTB,0
    call tiempo
    nop
    nop
    nop
    bsf PORTB,0
    call tiempo
    nop
    GOTO EncenderApagar
    

tiempo:
	MOVLW d'30'
	MOVWF i
	DECFSZ i
	GOTO $-1
	MOVLW d'50'
	MOVWF i
loopj:	MOVLW d'54'
	nop
	nop
	nop
	nop
	MOVWF j
loopk:  MOVLW d'60'
	nop
	MOVWF k
	DECFSZ k	    ;al llegar al 0 se salta al linea de justo abajo y continua con a que sigue
	GOTO $-1	    ;de la señal donde estas, regresa 1 linea
	DECFSZ j
	GOTO loopk
	DECFSZ i
	GOTO loopj
	Return
    

END