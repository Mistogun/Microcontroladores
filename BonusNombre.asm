#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)     

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program

i equ 0x50        ;variable i en la localidad 0x30
j equ 0x51
k equ 0x52
r equ 0x53


START              ;inicio global del programa


    MOVLW 0x07         ;Apagar comparadores para trabajar en modo digital
    MOVWF CMCON    
    BCF STATUS, RP1    ;Cambiar al banco 1 apagando el RP1
    BSF STATUS, RP0    ;Y encendiendo el RP0
    MOVLW b'00000000'  ;Establecer puerto B como salida (los 8 bits del puerto)
    MOVWF TRISB 
    BCF STATUS, RP0    ;Regresar al banco 0 apagando el RP0

INICIO
    
    MOVLW 'A'
    MOVWF 0x20
    MOVLW 'A'
    MOVWF 0x21
    MOVLW 'R'
    MOVWF 0x22
    MOVLW 'O'
    MOVWF 0x23
    MOVLW 'N'
    MOVWF 0x24
    
    MOVLW 'G'
    MOVWF 0x30
    MOVLW 'O'
    MOVWF 0x31
    MOVLW 'M'
    MOVWF 0x32
    MOVLW 'E'
    MOVWF 0x33
    MOVLW 'Z'
    MOVWF 0x34
    MOVLW ' '
    MOVWF 0x35
    MOVLW 'D'
    MOVWF 0x36
    MOVLW 'E'
    MOVWF 0x37
    MOVLW ' '
    MOVWF 0x38
    MOVLW 'S'
    MOVWF 0x39
    MOVLW 'E'
    MOVWF 0x3A
    MOVLW 'G'
    MOVWF 0x3B
    MOVLW 'U'
    MOVWF 0x3C
    MOVLW 'R'
    MOVWF 0x3D
    MOVLW 'A'
    MOVWF 0x3E
    
    MOVLW 'G'
    MOVWF 0x40
    MOVLW 'O'
    MOVWF 0x41
    MOVLW 'N'
    MOVWF 0x42
    MOVLW 'Z'
    MOVWF 0x43
    MOVLW 'A'
    MOVWF 0x44
    MOVLW 'L'
    MOVWF 0x45
    MOVLW 'E'
    MOVWF 0x46
    MOVLW 'Z'
    MOVWF 0x47
    
    MOVLW 5 ;AARON
    MOVWF i
    MOVLW 0x0F ;GOMEZ DE SEGURA
    MOVWF j
    MOVLW 8  ;GONZALEZ
    MOVWF k
    
    CLRF r
    MOVFW i
    ADDWF r,f
    MOVFW j
    ADDWF r,f
    MOVFW k
    ADDWF r,f
    
    GOTO INICIO        ;loop inicio			
END