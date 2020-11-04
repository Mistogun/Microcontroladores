#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)     

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program

i equ 0x30
cont equ 0x35
j equ 0x31
k equ 0x32
x equ 0x33
y equ 0x34
 
START              ;inicio global del programa
 
    MOVLW 0x07         ;Apagar comparadores para trabajar en modo digital
    MOVWF CMCON
    BCF STATUS, RP1
    BSF STATUS, RP0    ;Y encendiendo el RP0
    MOVLW b'11111111'	;Establecer puerto A como entrada (los 8 bits)
    MOVWF TRISA
    MOVLW b'00000000'	;Establecer puerto B como salida (los 8 bits)
    MOVWF TRISB 
    BCF STATUS, RP0    ;Regresar al banco 0 apagando el RP0
 
Inicio 
    CLRW
    MOVFW PORTA
    MOVWF i
    MOVWF y
    
    MOVLW b'10000000'
    MOVWF x
    MOVWF j
    MOVWF cont
    DECFSZ cont
    

cuadrado 
    BCF STATUS, C
    ADDWF j,0
    ;Si es overflow esta mal
    BTFSC STATUS,C
    GOTO corrimiento
    
    DECFSZ cont
    GOTO cuadrado
    
    ;HACER RESTA DE W con i
    SUBWF y,1
    ;Si es 0 ya encontro el resultado
    BTFSC STATUS,Z
    GOTO display
    ;Si es negativo, se tiene que recorrer el bit
    BTFSS STATUS,C
    GOTO corrimiento
    ;Si es positivo, se guarda y se recorrer
    GOTO guardar
    
    ;Para guardar es
guardar
    MOVFW x
    ADDWF k,1
    goto corrimiento
    
corrimiento
    BCF STATUS, C
    RRF x,1
    
    ; Si x es 00000000 entonces ir a INICIO
    MOVLW d'0'
    SUBWF x,0
    BTFSC STATUS,Z
    GOTO Inicio
    
    CLRW
    MOVFW i
    MOVWF y
    
    MOVFW x
    ADDWF k,0
    MOVWF j
    MOVWF cont
    DECFSZ cont
    goto cuadrado
    

display
    MOVFW x
    ADDWF k,1
    MOVFW k
    MOVWF PORTB
    GOTO Inicio

END