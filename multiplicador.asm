#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)     

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program

i equ 0x30
j equ 0x31
 
START              ;inicio global del programa
 
    MOVLW 0x07         ;Apagar comparadores para trabajar en modo digital
    MOVWF CMCON
    BCF STATUS, RP1
    BSF STATUS, RP0    ;Y encendiendo el RP0
    MOVLW b'11111111'
    MOVWF TRISA
    MOVLW b'00000000'	;Establecer puerto B como salida (los 8 bits)
    MOVWF TRISB 
    BCF STATUS, RP0    ;Regresar al banco 0 apagando el RP0
 
Inicio 
    CLRW
    MOVLW b'00001111'
    ANDWF PORTA,0
    MOVWF i
    MOVLW b'11110000'
    ANDWF PORTA,0
    MOVWF j
    SWAPF j,1
    CLRW

ciclo 
    ADDWF i,0
    DECFSZ j
    GOTO ciclo

    MOVWF PORTB
    GOTO Inicio

END